import pandas as pd
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation

# File to read data from
csv_file = 'stats.csv'

# Initialize the figure
fig, ax = plt.subplots(figsize=(12, 6))
line_dropped, = ax.plot([], [], color='red', label='Dropped Packets', marker='o')
line_passed, = ax.plot([], [], color='blue', label='Passed Packets', marker='o')
line_net_dropped, = ax.plot([], [], color='purple', label='Net Dropped Packets', linestyle='--')

# Set up plot labels
ax.set_title('Packet Statistics Over Time')
ax.set_xlabel('Time (seconds)')
ax.set_ylabel('Packet Count')
ax.legend()
ax.grid()

# Function to update the plot
def update(frame):
    # Load data
    data = pd.read_csv(csv_file)
    
    # Calculate the difference between dropped and passed packets
    data['DroppedDiff'] = data['Dropped'].diff().fillna(0)  # Fill NaN for the first entry
    data['PassedDiff'] = data['Passed'].diff().fillna(0)  # Fill NaN for the first entry
    data['NetDropped'] = data['DroppedDiff'] - data['PassedDiff']  # Calculate net dropped packets

    # Update line data
    line_dropped.set_data(data['Time'], data['Dropped'])
    line_passed.set_data(data['Time'], data['Passed'])
    line_net_dropped.set_data(data['Time'], data['NetDropped'])

    # Adjust plot limits
    ax.set_xlim(data['Time'].min(), data['Time'].max())
    max_packets = max(data['Dropped'].max(), data['Passed'].max(), data['NetDropped'].max())
    min_packets = min(data['Dropped'].min(), data['Passed'].min(), data['NetDropped'].min())
    ax.set_ylim(min_packets - 10, max_packets + 10)  # Add a small margin

# Create animation
ani = FuncAnimation(fig, update, interval=1000)  # Update every 1000 ms (1 second)

# Show plot
plt.show()

