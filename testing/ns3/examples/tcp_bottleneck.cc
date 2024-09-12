#include <cstdint>
#include <fstream>
#include <iostream>
#include <string>

#include "ns3/applications-module.h"
#include "ns3/core-module.h"
#include "ns3/enum.h"
#include "ns3/error-model.h"
#include "ns3/event-id.h"
#include "ns3/internet-module.h"
#include "ns3/ipv4-global-routing-helper.h"
#include "ns3/network-module.h"
#include "ns3/point-to-point-module.h"
#include "ns3/tcp-header.h"
#include "ns3/udp-header.h"

using namespace ns3;

// NS3 Simulation that models a simple TCP network with a bottleneck link.
// The goal is to evaluate the "goodput" (effective data received at the sink
// divded by the simulation time) in a scenario where a TCP flow crosses a
// bottleneck link

/* --- Overview ---
 *
 * Nodes:
 * - Node 0: TCP Source (sender)
 * - Node 1: Bottleneck Begin
 * - Node 2: Bottleneck Exit
 * - Node 3: TCP Sink (receiver)
 *
 * Links:
 * - 5Mbps, 10ms delay link between the TCP Source and Bottleneck Begin
 * - 1Mbps, 20ms delay link between Bottleneck Begin and Bottleneck Exit
 * - 5Mbps, 10ms delay link between Bottleneck Exit and TCP Sink

 * TCP Source   10ms       20ms       10ms   TCP Sink
 *          O -------- O -------- O -------- O
 *              5Mb		     1Mb        5Mb
 *
*/

/* --- Main --- */
int main(int argc, char *argv[]) {

  // Simulation uses TCP Tahoe as the transport protocol
  // (Basic TCP Variant, that uses slow start and congestion avoidance
  // but lacks fast recovery)
  std::string transport_prot = "TcpTahoe";

  /* --- Node Creation --- */
  NodeContainer source;
  source.Create(1);
  NodeContainer bottleneck;
  bottleneck.Create(2);
  NodeContainer sink;
  sink.Create(1);

  /* --- Links --- */
  PointToPointHelper sourceLink;
  sourceLink.SetDeviceAttribute("DataRate", StringValue("5Mbps"));
  sourceLink.SetChannelAttribute("Delay", StringValue("10ms"));

  PointToPointHelper bottleneckLink;
  bottleneckLink.SetDeviceAttribute("DataRate", StringValue("1Mbps"));
  bottleneckLink.SetChannelAttribute("Delay", StringValue("20ms"));

  PointToPointHelper sinkLink;
  sinkLink.SetDeviceAttribute("DataRate", StringValue("5Mbps"));
  sinkLink.SetChannelAttribute("Delay", StringValue("10ms"));

  // A DropTailQueue is assigned to the bottleneck link, with a queue mode of
  // QUEUE_MODE_PACKETS and a maximum queue size of 2000 packets
  bottleneckLink.SetQueue("ns3::DropTailQueue", "Mode",
                          StringValue("QUEUE_MODE_PACKETS"), "MaxPackets",
                          UintegerValue(2000));

  // Internet Stack
  // The InternetStackHelper installs the TCP/IP protocol stack on all nodes
  InternetStackHelper stack;
  stack.InstallAll();

  // IP Address Assignment
  // An IPv4 address range of 10.0.0.0/24 is set up, and an
  // Ipv4InterfaceContainer for the sink interface is initialized.
  Ipv4AddressHelper address;
  address.SetBase("10.0.0.0", "255.255.255.0");

  Ipv4InterfaceContainer sinkInterface;

  /* --- Connecting Nodes --- */
  devices = sourceLink.Install(source.Get(0), bottleneck.Get(0));
  address.NewNetwork();
  Ipv4InterfaceContainer interfaces = address.Assign(devices);

  devices = bottleneckLink.Install(bottleneck.Get(0), bottleneck.Get(1));
  address.NewNetwork();
  interfaces = address.Assign(devices);

  devices = sinkLink.Install(bottleneck.Get(1), sink.Get(0));
  address.NewNetwork();
  interfaces = address.Assign(devices);

  // Routing Table Population
  // This line populates the global routing tables so that the nodes
  // know how to forward packets to one another.
  Ipv4GlobalRoutingHelper::PopulateRoutingTables();

  /* --- TCP Sink and Source Configuration --- */
  // TCP Sink: The sink is listening on port 50000, using the TcpSocketFactory
  // TCP Source: BulkSendHelper application sends data to the TCP sink
  // with a segment size of 128 bytes and a limit of 100 MB of data to send.
  uint16_t sinkPort = 50000;
  Address sinkLocalAddress(InetSocketAddress(Ipv4Address::GetAny(), sinkPort));
  PacketSinkHelper sinkHelper("ns3::TcpSocketFactory", sinkLocalAddress);

  AddressValue remoteAddress(
      InetSocketAddress(sinkInterface.GetAddress(0, 0), sinkPort));
  Config::SetDefault("ns3::TcpSocket::SegmentSize", UintegerValue(128));
  BulkSendHelper ftp("ns3::TcpSocketFactory", Address());
  ftp.SetAttribute("Remote", remoteAddress);
  ftp.SetAttribute("SendSize", UintegerValue(128));
  ftp.SetAttribute("MaxBytes", UintegerValue(100000000));

  /* --- Application Start and Stop --- */
  // The source application starts at 0 seconds and stops at 0.1 seconds.
  // The sink application runs from 0 seconds to 0.2 seconds.
  ApplicationContainer sourceApp = ftp.Install(source.Get(0));
  sourceApp.Start(Seconds(0));
  sourceApp.Stop(Seconds(0.1));

  sinkHelper.SetAttribute("Protocol",
                          TypeIdValue(TcpSocketFactory::GetTypeId()));
  ApplicationContainer sinkApp = sinkHelper.Install(sink);
  sinkApp.Start(Seconds(0));
  sinkApp.Stop(Seconds(0.2));

  /* --- PCAP Tracing --- */
  // PCAP tracing is enabled on all links, and the traces are saved to files
  // with the prefix p1. PCAP files can be analyzed using tools like Wireshark
  sourceLink.EnablePcapAll("p1", true);
  bottleneckLink.EnablePcapAll("p1", true);
  sinkLink.EnablePcapAll("p1", true);

  // Run and Destroy Simulator
  Simulator::Run();
  Simulator::Destroy();

  return 0;
}
