import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
from matplotlib.animation import FuncAnimation

# File to read data from
csv_file = "stats.csv"

# Initialize the plot
fig, axes = plt.subplots(3, 1, figsize=(12, 10), sharex=True)
fig.suptitle("Service Rate, Passed, and NAverage Over Time with Window Change Highlights")

# Metrics to plot and their line styles
metrics = ['ServiceRate', 'Passed', 'NAverage']
line_styles = ['-', '--', ':']

# Colors for windows (initialized, updated dynamically)
colors = None
unique_times = None

# Function to update the plot
def update(frame):
    global colors, unique_times  # Allow these variables to be updated dynamically

    # Read and filter data
    data = pd.read_csv(csv_file)
    filtered_data = data.iloc[4::5].reset_index(drop=True)

    # Update colors if unique times change
    new_unique_times = filtered_data['Time'].unique()
    if unique_times is None or not np.array_equal(new_unique_times, unique_times):
        unique_times = new_unique_times
        colors = plt.cm.viridis(np.linspace(0, 1, len(unique_times)))

    # Clear axes for fresh plot
    for ax in axes:
        ax.clear()

    # Plot data for each metric
    for idx, metric in enumerate(metrics):
        ax = axes[idx]
        ax.set_ylabel(metric)

        # Plot lines with color change on each window shift
        for i in range(1, len(filtered_data)):
            color = colors[i % len(colors)]
            ax.plot(
                filtered_data['Time'][i - 1:i + 1],
                filtered_data[metric][i - 1:i + 1],
                color=color,
                linestyle=line_styles[idx]
            )

        # Mark window start with a dot
        for i, color in enumerate(colors):
            if i < len(filtered_data):
                ax.plot(
                    filtered_data['Time'].iloc[i],
                    filtered_data[metric].iloc[i],
                    'o',
                    color=color,
                    label=f"Window {i+1}" if idx == 0 else None
                )

        # Add legend only for the first subplot
        if idx == 0:
            ax.legend(loc="upper left", bbox_to_anchor=(1, 1), title="Windows")

    # Set x-axis label only on the last subplot
    axes[-1].set_xlabel("Time (s)")

# Create animation
ani = FuncAnimation(fig, update, interval=1000)  # Update every 1000 ms (1 second)

# Show plot
plt.tight_layout(rect=[0, 0, 0.9, 0.95])  # Adjust layout to fit legend
plt.show()

