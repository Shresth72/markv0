#include <fstream>
#include <iostream>
#include <ns3/applications-module.h>
#include <ns3/core-module.h>
#include <ns3/flow-monitor-module.h>
#include <ns3/internet-module.h>
#include <ns3/network-module.h>
#include <ns3/point-to-point-module.h>
#include <ns3/tcp-header.h>
#include <ns3/udp-header.h>
#include <string>

using namespace ns3;

NS_LOG_COMPONENT_DEFINE("TCPNetworkSimulation");

int main(int argc, char *argv[]) {
  // Enable logging for TCP and UDP
  LogComponentEnable("TCPNetworkSimulation", LOG_LEVEL_INFO);

  // Set up nodes: client and server
  NodeContainer nodes;
  nodes.Create(2);

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

  // Create a TCP server on node 1 (server)
  uint16_t port = 8080;
  Address serverAddress(InetSocketAddress(interfaces.GetAddress(1), port));
  PacketSinkHelper packetSinkHelper("ns3::TcpSocketFactory", serverAddress);
  ApplicationContainer serverApp = packetSinkHelper.Install(nodes.Get(1));
  serverApp.Start(Seconds(1.0));
  serverApp.Stop(Seconds(10.0));

  // Create a TCP client on node 0 (client)
  OnOffHelper client("ns3::TcpSocketFactory", serverAddress);
  client.SetAttribute("OnTime",
                      StringValue("ns3::ConstantRandomVariable[Constant=1]"));
  client.SetAttribute("OffTime",
                      StringValue("ns3::ConstantRandomVariable[Constant=0]"));
  client.SetAttribute("DataRate", StringValue("5Mbps"));
  client.SetAttribute("PacketSize", UintegerValue(1024));

  ApplicationContainer clientApp = client.Install(nodes.Get(0));
  clientApp.Start(Seconds(2.0));
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
  logFile.open("tcp_simulation_log.txt");

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
  flowMonitor->SerializeToXmlFile("tcp_flow_monitor.xml", true, true);

  Simulator::Destroy();
  return 0;
}
