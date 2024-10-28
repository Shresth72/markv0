import pandas as pd
import matplotlib.pyplot as plt

# Load the CSV data
data = pd.read_csv('traffic_data.csv', parse_dates=['Timestamp'])

# Plotting
plt.figure(figsize=(12, 8))

# Packet Count
plt.subplot(3, 1, 1)
plt.plot(data['Timestamp'], data['Packet Count'], label='Packet Count', color='blue')
plt.title('Packet Count Over Time')
plt.xlabel('Time')
plt.ylabel('Count')
plt.legend()
plt.grid()

# Average Count
plt.subplot(3, 1, 2)
plt.plot(data['Timestamp'], data['Average Count'], label='Average Count', color='orange')
plt.title('Average Count Over Time')
plt.xlabel('Time')
plt.ylabel('Count')
plt.legend()
plt.grid()

# Queue Size
plt.subplot(3, 1, 3)
plt.plot(data['Timestamp'], data['Queue Size'], label='Queue Size', color='green')
plt.title('Queue Size Over Time')
plt.xlabel('Time')
plt.ylabel('Size')
plt.legend()
plt.grid()

# Layout adjustment
plt.tight_layout()
plt.savefig('traffic_plot.png')  # Save plot as PNG
plt.show()  # Display the plot

