package main

import "sync"

type InterfaceHandler struct {
  // Connection
  manager 
}

type Interface struct {
  ih  
  jh sync.WaitGroup
}

type Quad struct {
  src []int{} 
  dst 
}

type ConnectionManager struct {
  terminate bool
  tcp_connections map[]
}
