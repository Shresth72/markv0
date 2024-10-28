import pandas as pd
import matplotlib.pyplot as plt

# Load the data from CSV
data = pd.read_csv('stats.csv')

# Calculate total dropped and passed packets
total_dropped = data['Dropped'].sum()
total_passed = data['Passed'].sum()

# Prepare data for bar graph
categories = ['Dropped Packets', 'Passed Packets']
values = [total_dropped, total_passed]

# Plotting
plt.figure(figsize=(8, 6))
plt.bar(categories, values, color=['red', 'blue'])

plt.title('Total Dropped vs. Passed Packets')
plt.xlabel('Packet Type')
plt.ylabel('Total Count')
plt.grid(axis='y')

# Show the plot
plt.savefig('total_dropped_passed_packets.png')
plt.show()

