import pandas as pd
import matplotlib.pyplot as plt

# Load the data from CSV
data = pd.read_csv('stats.csv')

# Plotting
plt.figure(figsize=(12, 6))

# Plot dropped packets
plt.plot(data['Time'], data['Dropped'], color='red', label='Dropped Packets')
# Plot passed packets
plt.plot(data['Time'], data['Passed'], color='blue', label='Passed Packets')
# Plot processing time (you can use a secondary y-axis if desired)
plt.plot(data['Time'], data['ProcessingTime'], color='green', label='Processing Time')

plt.title('Packet Statistics Over Time')
plt.xlabel('Time (seconds)')
plt.ylabel('Packet Count / Processing Time')
plt.legend()
plt.grid()

# Show the plot
plt.savefig('packet_stats_plot.png')
plt.show()

