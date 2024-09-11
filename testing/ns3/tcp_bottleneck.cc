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
 */
