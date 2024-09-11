package ip

import (
	"fmt"
	"math"
	"net"

	"github.com/vishvananda/netlink"
	"github.com/vishvananda/netlink/nl"
)

func GetDefaultInterface() (iface *net.Interface, ifaceIP net.IP, err error) {
	var routes []netlink.Route
	if routes, err = netlink.RouteList(nil, nl.FAMILY_V4); err != nil {
		return
	}

	priority := math.MaxInt32
	for _, route := range routes {
		// found default gateway
		if route.Dst != nil && route.Src != nil && route.Priority < priority {
			priority = route.Priority
			if iface, err = net.InterfaceByIndex(route.LinkIndex); err != nil {
				return
			}
			if ifaceIP, err = GetInterfaceIP(iface); err != nil {
				return
			}
		}
	}
	return
}

func GetDefaultGatewayIP(iface *net.Interface) (gatewayIP net.IP, err error) {
	var routes []netlink.Route
	if routes, err = netlink.RouteList(nil, nl.FAMILY_V4); err != nil {
		return
	}
	priority := math.MaxInt32
	for _, route := range routes {
		// found default gateway
		if route.Dst != nil && route.Src != nil && route.LinkIndex == iface.Index && route.Priority < priority {
			priority = route.Priority
			gatewayIP = route.Gw
		}
	}
	return
}

func GetEth0Interface() (iface *net.Interface, ifaceIP net.IP, err error) {
  eth0Iface, err := net.InterfaceByName("eth0")
	if err != nil {
		return nil, nil, fmt.Errorf("could not find eth0 interface: %v", err)
	}

	var routes []netlink.Route
	if routes, err = netlink.RouteList(nil, nl.FAMILY_V4); err != nil {
		return
	}

	priority := math.MaxInt32
	for _, route := range routes {
		// found default gateway
		if route.Dst != nil && route.Src != nil && route.LinkIndex == eth0Iface.Index && route.Priority < priority {
			priority = route.Priority
			if iface, err = net.InterfaceByIndex(route.LinkIndex); err != nil {
				return
			}
			if ifaceIP, err = GetInterfaceIP(iface); err != nil {
				return
			}
		}
	}
	return
}

func GetInterfaceByName(name string) (iface *net.Interface, ifaceIP net.IP, err error) {
  eth0Iface, err := net.InterfaceByName(name)
	if err != nil {
		return nil, nil, fmt.Errorf("could not find eth0 interface: %v", err)
	}

	var routes []netlink.Route
	if routes, err = netlink.RouteList(nil, nl.FAMILY_V4); err != nil {
		return
	}

	priority := math.MaxInt32
	for _, route := range routes {
		// found default gateway
		if route.Dst != nil && route.Src != nil && route.LinkIndex == eth0Iface.Index && route.Priority < priority {
			priority = route.Priority
			if iface, err = net.InterfaceByIndex(route.LinkIndex); err != nil {
				return
			}
			if ifaceIP, err = GetInterfaceIP(iface); err != nil {
				return
			}
		}
	}
	return
}

