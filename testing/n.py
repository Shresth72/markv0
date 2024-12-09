import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

class TrafficPatternAnalyzer:
    def __init__(self):
        # Configuration parameters from XDP code
        self.BURST_RPS_THRESH = 200  # Requests per second threshold
        self.RED_MIN_THRESH = 1000   # Minimum queue length threshold
        self.RED_MAX_THRESH = 5000   # Maximum queue length threshold
        self.DROP_PROB_MAX = 100     # Maximum drop probability

    def generate_traffic_data(self, is_malicious=False):
        """
        Generate traffic pattern data
        
        Args:
            is_malicious (bool): Whether to generate malicious traffic pattern
        
        Returns:
            tuple: (timestamps, requests_per_second, queue_lengths)
        """
        np.random.seed(42)
        
        # Time duration of observation
        duration = 300  # 5 minutes
        timestamps = np.linspace(0, duration, 300)
        
        if is_malicious:
            # Malicious traffic: sudden spikes and irregular patterns
            requests_per_second = (
                np.sin(timestamps/10) * 50 +  # Baseline fluctuation
                np.where(timestamps > 100, 250, 0) +  # Sudden spike
                np.random.normal(100, 50, len(timestamps))  # Random noise
            )
            queue_lengths = (
                np.cumsum(np.random.normal(200, 100, len(timestamps))) + 
                np.where(timestamps > 100, 3000, 0)  # Sudden queue buildup
            )
        else:
            # Normal traffic: more consistent, predictable pattern
            requests_per_second = (
                np.sin(timestamps/10) * 20 +  # Mild baseline variation
                np.random.normal(50, 20, len(timestamps))  # Random noise
            )
            queue_lengths = np.cumsum(np.random.normal(50, 30, len(timestamps)))
        
        return timestamps, requests_per_second, queue_lengths

    def plot_traffic_comparison(self):
        """
        Create a comprehensive visualization of normal vs malicious traffic
        """
        plt.figure(figsize=(15, 10))
        plt.suptitle('Traffic Pattern Comparison: Normal vs Malicious', fontsize=16)
        
        # Normal Traffic Subplot
        plt.subplot(2, 2, 1)
        timestamps_normal, rps_normal, queue_normal = self.generate_traffic_data(is_malicious=False)
        plt.title('Normal Traffic')
        plt.plot(timestamps_normal, rps_normal, label='Requests/Second', color='green')
        plt.axhline(y=self.BURST_RPS_THRESH, color='r', linestyle='--', label='Burst Threshold')
        plt.xlabel('Time (seconds)')
        plt.ylabel('Requests per Second')
        plt.legend()
        
        # Malicious Traffic Subplot
        plt.subplot(2, 2, 2)
        timestamps_malicious, rps_malicious, queue_malicious = self.generate_traffic_data(is_malicious=True)
        plt.title('Malicious Traffic')
        plt.plot(timestamps_malicious, rps_malicious, label='Requests/Second', color='red')
        plt.axhline(y=self.BURST_RPS_THRESH, color='r', linestyle='--', label='Burst Threshold')
        plt.xlabel('Time (seconds)')
        plt.ylabel('Requests per Second')
        plt.legend()
        
        # Queue Length Comparison
        plt.subplot(2, 2, 3)
        plt.title('Queue Length: Normal Traffic')
        plt.plot(timestamps_normal, queue_normal, color='green')
        plt.axhline(y=self.RED_MIN_THRESH, color='y', linestyle='--', label='Min Threshold')
        plt.axhline(y=self.RED_MAX_THRESH, color='r', linestyle='--', label='Max Threshold')
        plt.xlabel('Time (seconds)')
        plt.ylabel('Queue Length')
        plt.legend()
        
        plt.subplot(2, 2, 4)
        plt.title('Queue Length: Malicious Traffic')
        plt.plot(timestamps_malicious, queue_malicious, color='red')
        plt.axhline(y=self.RED_MIN_THRESH, color='y', linestyle='--', label='Min Threshold')
        plt.axhline(y=self.RED_MAX_THRESH, color='r', linestyle='--', label='Max Threshold')
        plt.xlabel('Time (seconds)')
        plt.ylabel('Queue Length')
        plt.legend()
        
        plt.tight_layout()
        plt.show()

# Run the analysis
if __name__ == "__main__":
    analyzer = TrafficPatternAnalyzer()
    analyzer.plot_traffic_comparison()
