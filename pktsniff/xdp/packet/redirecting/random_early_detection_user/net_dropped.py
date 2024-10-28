import pandas as pd
import matplotlib.pyplot as plt

# Load the data from CSV
data = pd.read_csv('stats.csv')

# Calculate the difference between dropped and passed packets
data['DroppedDiff'] = data['Dropped'].diff().fillna(0)  # Fill NaN for the first entry
data['PassedDiff'] = data['Passed'].diff().fillna(0)  # Fill NaN for the first entry
data['NetDropped'] = data['DroppedDiff'] - data['PassedDiff']  # Calculate net dropped packets

# Plotting
plt.figure(figsize=(12, 6))

# Plot dropped packets
plt.plot(data['Time'], data['Dropped'], color='red', label='Dropped Packets', marker='o')
# Plot passed packets
plt.plot(data['Time'], data['Passed'], color='blue', label='Passed Packets', marker='o')
# Plot processing time
plt.plot(data['Time'], data['ProcessingTime'], color='green', label='Processing Time', linestyle='--')

plt.title('Packet Statistics Over Time')
plt.xlabel('Time (seconds)')
plt.ylabel('Packet Count')
plt.legend()
plt.grid()

# Show the plot
plt.savefig('net_dropped.png')
plt.show()
