import csv
import matplotlib.pyplot as plt
from datetime import datetime

# Read data from the CSV file
times = []
queue_lengths = []

with open('queue_length_data.csv', 'r') as file:
    reader = csv.DictReader(file)
    for row in reader:
        # Parse the time and queue length
        times.append(datetime.fromisoformat(row['Time']))
        queue_lengths.append(int(row['Queue Length']))

# Plot the queue length over time
plt.figure(figsize=(10, 6))
plt.plot(times, queue_lengths, label="Queue Length", color='b')
plt.xlabel("Time")
plt.ylabel("Queue Length")
plt.title("Queue Length Over Time")
plt.grid(True)
plt.legend()

# Save the plot as an SVG file
plt.savefig("queue_length_plot.svg", format="svg")

# Show the plot
plt.show()
