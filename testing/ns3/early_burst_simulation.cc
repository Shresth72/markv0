#include <fstream>
#include <iostream>
#include <ns3/applications-module.h>
#include <ns3/core-module.h>
#include <ns3/flow-monitor-module.h>
#include <ns3/internet-module.h>
#include <ns3/network-module.h>
#include <ns3/point-to-point-module.h>
#include <ns3/random-variable-stream.h>
#include <ns3/tcp-header.h>
#include <ns3/udp-header.h>
#include <string>

using namespace ns3;

NS_LOG_COMPONENT_DEFINE("BurstTrafficSimulation");

int main(int argc, char *argv[]) {
  // Enable logging for TCP and UDP
  LogComponentEnable("BurstTrafficSimulation", LOG_LEVEL_INFO);

  // Set up nodes: single interface node
  NodeContainer nodes;
  nodes.Create(2); // One source, one sink (interface node)

  // Create a point-to-point link
  PointToPointHelper pointToPoint;
  pointToPoint.SetDeviceAttribute("DataRate", StringValue("5Mbps"));
  pointToPoint.SetChannelAttribute("Delay", StringValue("2ms"));

  NetDeviceContainer devices;
  devices = pointToPoint.Install(nodes);

  // Install Internet stack (TCP/IP protocol)
  InternetStackHelper stack;
  stack.Install(nodes);

  // Assign IP addresses to the devices
  Ipv4AddressHelper address;
  address.SetBase("10.1.1.0", "255.255.255.0");
  Ipv4InterfaceContainer interfaces = address.Assign(devices);

  // Create a packet sink (acting as an interface node)
  uint16_t port = 8080;
  Address sinkAddress(InetSocketAddress(interfaces.GetAddress(1), port));
  PacketSinkHelper packetSinkHelper("ns3::TcpSocketFactory", sinkAddress);
  ApplicationContainer sinkApp = packetSinkHelper.Install(nodes.Get(1));
  sinkApp.Start(Seconds(1.0));
  sinkApp.Stop(Seconds(10.0));

  // Create burst traffic on node 0 (client)
  OnOffHelper client("ns3::TcpSocketFactory", sinkAddress);

  // Simulate bursty traffic by varying On and Off times using random variables
  client.SetAttribute("OnTime",
                      StringValue("ns3::ExponentialRandomVariable[Mean=0.5]"));
  client.SetAttribute("OffTime",
                      StringValue("ns3::ExponentialRandomVariable[Mean=0.2]"));

  // Set data rate and packet size for bursts
  client.SetAttribute("DataRate", StringValue("10Mbps")); // Simulate bursts
  client.SetAttribute("PacketSize", UintegerValue(1024));

  ApplicationContainer clientApp = client.Install(nodes.Get(0));
  clientApp.Start(Seconds(2.0)); // Client starts sending bursts at time 2s
  clientApp.Stop(Seconds(10.0));

  // Set up flow monitor to track the traffic
  FlowMonitorHelper flowHelper;
  Ptr<FlowMonitor> flowMonitor = flowHelper.InstallAll();

  // Run the simulator
  Simulator::Stop(Seconds(10.0));
  Simulator::Run();

  // Retrieve flow statistics
  flowMonitor->CheckForLostPackets();
  Ptr<Ipv4FlowClassifier> classifier =
      DynamicCast<Ipv4FlowClassifier>(flowHelper.GetClassifier());
  std::map<FlowId, FlowMonitor::FlowStats> stats = flowMonitor->GetFlowStats();

  std::ofstream logFile;
  logFile.open("burst_traffic_simulation_log.txt");

  // Log traffic details
  for (std::map<FlowId, FlowMonitor::FlowStats>::const_iterator i =
           stats.begin();
       i != stats.end(); ++i) {
    Ipv4FlowClassifier::FiveTuple t = classifier->FindFlow(i->first);
    logFile << "Flow ID: " << i->first << " (" << t.sourceAddress << " -> "
            << t.destinationAddress << ")\n";
    logFile << "Protocol: " << ((t.protocol == 6) ? "TCP" : "Unknown") << "\n";
    logFile << "Packets Sent: " << i->second.txPackets << "\n";
    logFile << "Packets Received: " << i->second.rxPackets << "\n";
    logFile << "Bytes Sent: " << i->second.txBytes << "\n";
    logFile << "Bytes Received: " << i->second.rxBytes << "\n";
    logFile << "Total Lost Packets: " << i->second.lostPackets << "\n";
    logFile << "Packet Delivery Ratio: "
            << ((i->second.rxPackets * 100.0) / i->second.txPackets) << " %\n";
    logFile << "Delay (ms): "
            << i->second.delaySum.GetMilliSeconds() / i->second.rxPackets
            << "\n";
    logFile << "-----------------------------------\n";
  }

  logFile.close();
  flowMonitor->SerializeToXmlFile("burst_flow_monitor.xml", true, true);

  Simulator::Destroy();
  return 0;
}
