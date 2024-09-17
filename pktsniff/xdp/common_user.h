#include <sys/types.h>

#ifndef __XDP_STATS_KERN_USER_H
#define __XDP_STATS_KERN_USER_H

struct datarec {
  __u64 rx_packets;
  __u64 rx_bytes;
};

#ifndef XDP_ACTION_MAX
#define XDP_ACTION_MAX (XDP_REDIRECT + 1)
#endif // !XDP_ACTION_MAX

#endif
