import pandas as pd
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation
import os

# File path to the CSV
file_path = 'stats.csv'

# Initialize the figure and axes for the plot
plt.style.use('seaborn-darkgrid')
fig, ax = plt.subplots(figsize=(12, 6))

# Initialize the lines to be updated
line_dropped, = ax.plot([], [], color='red', label='Dropped Packets', marker='o')
line_passed, = ax.plot([], [], color='blue', label='Passed Packets', marker='o')
line_processing, = ax.plot([], [], color='green', label='Processing Time', linestyle='--')

# Additional labels and configurations
ax.set_title('Packet Statistics Over Time')
ax.set_xlabel('Time (seconds)')
ax.set_ylabel('Count')
ax.legend()
ax.grid()

# Data for real-time updates
def update(frame):
    # Check if the file exists and has content
    if not os.path.exists(file_path) or os.path.getsize(file_path) == 0:
        return

    # Read the latest data
    try:
        data = pd.read_csv(file_path)
    except Exception as e:
        print(f"Error reading the CSV: {e}")
        return

    # Ensure data columns are present
    required_columns = {'Time', 'Dropped', 'Passed', 'ProcessingTime'}
    if not required_columns.issubset(data.columns):
        print("CSV does not contain the required columns!")
        return

    # Calculate the differences for net dropped packets
    data['DroppedDiff'] = data['Dropped'].diff().fillna(0)  # Fill NaN for the first entry
    data['PassedDiff'] = data['Passed'].diff().fillna(0)  # Fill NaN for the first entry
    data['NetDropped'] = data['DroppedDiff'] - data['PassedDiff']

    # Update the line data
    line_dropped.set_data(data['Time'], data['Dropped'])
    line_passed.set_data(data['Time'], data['Passed'])
    line_processing.set_data(data['Time'], data['ProcessingTime'])

    # Adjust the axis limits to fit the new data
    ax.set_xlim(data['Time'].min(), data['Time'].max())
    max_y = max(data[['Dropped', 'Passed', 'ProcessingTime']].max()) * 1.1  # Add some padding
    ax.set_ylim(0, max_y)

# Animate the updates
ani = FuncAnimation(fig, update, interval=2000)  # Update every 2 seconds

# Save the animation as a GIF or display it in real time
plt.savefig('net_dropped_real_time.png')  # Optional static save
plt.show()

