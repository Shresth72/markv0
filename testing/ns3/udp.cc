#include <fstream>
#include <iostream>
#include <string>

#include "ns3/applications-module.h"
#include "ns3/core-module.h"
#include "ns3/internet-module.h"
#include "ns3/network-module.h"
#include "ns3/point-to-point-module.h"

using namespace ns3;

// Simple network simulation using the ns-3 network simulator, where two nodes
// are connected by a point to point link. The simulation sends a packet from
// one node to anothe using the UDP protocol and traces the data in both ASCII
// and pcap formats.

/* --- Log Component Declarion --- */
// Defines a logging component for logging events during the simulation
NS_LOG_COMPONENT_DEFINE("UDPNetworkScript");

/* --- Main --- */
int main(int argc, char *argv[]) {

  // Set time resolution to nanoseconds
  // Enable logging for both UDP Client and Server applications
  // Log Level - Info (important events)
  Time::SetResolution(Time::NS);
  LogComponentEnable("UdpEchoClientApplication", LOG_LEVEL_INFO);
  LogComponentEnable("UdpEchoServerApplication", LOG_LEVEL_INFO);

  /* --- Node Creation --- */
  // Holds two nodes that will communicate via a point-to-point link
  NodeContainer nodes;
  nodes.Create(2);

  // A point-to-point link between the two nodes is configured with:
  // - data rate of `8Mbps`
  // - delay of `4ms`
  PointToPointHelper p2p;
  p2p.SetDeviceAttribute("DataRate", StringValue("8Mbps"));
  p2p.SetDeviceAttribute("Delay", StringValue("4ms"));

  // The point-to-point devices are installed on both nodes
  // Allowing them to communicate over the simulated network
  NetDeviceContainer devices;
  devices = p2p.Install(nodes);

  // Internet Stack
  // Install the TCP/IP protocol stack on both nodes
  // So they can communicate using standard Internet protocols
  InternetStackHelper stack;
  stack.Install(nodes);

  // IP Address Assignment
  // IP addresses are assigned to the devices (interfaces) on the nodes
  // The address range used is `192.168.40.0/24`
  Ipv4AddressHelper address;
  address.SetBase("192.168.40.0", "255.255.255.0");
  Ipv4InterfaceContainer interfaces = address.Assign(devices);

  /* --- UDP Echo Server --- */
  // Udp Echo Server is created on the second node and listens on port 93
  // The server starts at 1 second into the simulation and stops at 10 seconds
  UdpEchoServerHelper echoServer(93);
  ApplicationContainer serverApps = echoServer.Install(nodes.Get(1));
  serverApps.Start(Seconds(1.0));
  serverApps.Stop(Seconds(10.0));

  /* --- UDP Echo Client --- */
  // Udp Echo Client is created on the first node
  // Client is configured to:
  // - Send only 1 Packet
  // - Send packets at an interval of 1 second
  // - Use a packet size of 256 bytes
  // - Start 2 seconds into the simulation and stops at 10 seconds
  UdpEchoClientHelper echoClient(interfaces.GetAddress(1), 93);
  echoClient.SetAttribute("MaxPackets", UintegerValue(1));
  echoClient.SetAttribute("Interval", TimeValue(Seconds(1.0)));
  echoClient.SetAttribute("PacketSize", UintegerValue(256));

  ApplicationContainer clientApps = echoClient.Install(nodes.Get(0));
  clientApps.Start(Seconds(2.0));
  clientApps.Stop(Seconds(10.0));

  /* --- ASCII and PCAP Tracing --- */
  // Ascii tracing is enabled and output is written to "test-trace.tr"
  // Pcap tracing is enabled
  // Generates packet capture files that can be analyzed with Wireshark
  AsciiTraceHelper ascii;
  p2p.EnableAsciiAll(ascii.CreateFileStream("test-trace.tr"));
  p2p.EnablePcapAll("UDPNetwork");

  // Run and Destroy Simulator
  Simulator::Run();
  Simulator::Destroy();

  return 0;
}
