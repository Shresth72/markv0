import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

# Load data
data = pd.read_csv("stats.csv")

# Select every fifth row for accurate data points
filtered_data = data.iloc[4::5].reset_index(drop=True)

# Unique colors for each window change
unique_times = filtered_data['Time'].unique()
colors = plt.cm.viridis(np.linspace(0, 1, len(unique_times)))

# Create subplots
fig, axes = plt.subplots(3, 1, figsize=(12, 10), sharex=True)
fig.suptitle("Service Rate, Passed, and NAverage Over Time with Window Change Highlights")

# Metrics to plot and their line styles
metrics = ['ServiceRate', 'Passed', 'NAverage']
line_styles = ['-', '--', ':']

# Plot each metric in its own subplot
for idx, metric in enumerate(metrics):
    ax = axes[idx]
    ax.set_ylabel(metric)
    
    # Plot lines with color change on each window shift
    for i in range(1, len(filtered_data)):
        color = colors[i % len(colors)]
        
        # Draw line segment between two points for each window
        ax.plot(filtered_data['Time'][i-1:i+1], filtered_data[metric][i-1:i+1], color=color, linestyle=line_styles[idx])

    # Mark window start with a dot
    for i, color in enumerate(colors):
        ax.plot(filtered_data['Time'].iloc[i], filtered_data[metric].iloc[i], 'o', color=color, label=f"Window {i+1}" if idx == 0 else None)

    # Add legend only for the first subplot
    if idx == 0:
        ax.legend(loc="upper left", bbox_to_anchor=(1, 1), title="Windows")

# Set x-axis label only on the last subplot
axes[-1].set_xlabel("Time (s)")
plt.tight_layout(rect=[0, 0, 0.9, 0.95])  # Adjust layout to fit legend
plt.show()

