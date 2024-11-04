import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

# Load data
data = pd.read_csv("stats.csv")

# Select every fifth row for accurate data points
filtered_data = data.iloc[4::5].reset_index(drop=True)

# Set up the plot
fig, ax = plt.subplots(3, 1, figsize=(12, 10), sharex=True)
fig.suptitle("BPF Program Accurate Statistics Over Time (Every 5th Row)")

# Define colors for each window change
unique_times = filtered_data['Time'].unique()
colors = plt.cm.viridis(np.linspace(0, 1, len(unique_times)))

# Plot each metric and apply different colors with dots at each window
for i, unique_time in enumerate(unique_times):
    # Filter data for each unique time
    window_data = filtered_data[filtered_data['Time'] == unique_time]
    color = colors[i % len(colors)]
    
    # Plot each metric with distinct color for each window
    ax[0].plot(window_data['Time'], window_data['ServiceRate'], color=color, marker='o', label=f"Window {i+1}" if i < 10 else None)
    ax[1].plot(window_data['Time'], window_data['Passed'], color=color, marker='o')
    ax[2].plot(window_data['Time'], window_data['NAverage'], color=color, marker='o')

# Label axes
ax[0].set_ylabel("Service Rate")
ax[1].set_ylabel("Passed Packets")
ax[2].set_ylabel("NAverage")
ax[2].set_xlabel("Time (s)")

# Add grid and legends
for a in ax:
    a.grid(True)
    a.legend(loc="upper left", bbox_to_anchor=(1.05, 1))

# Show plot
plt.tight_layout(rect=[0, 0, 0.9, 0.96])
plt.show()

