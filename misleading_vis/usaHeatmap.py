import plotly.graph_objects as go
import pandas as pd

data_2020 = pd.read_csv('april2020unemployment.csv')
data_2024 = pd.read_csv('april24unemployment.csv')

# Merge data
merged_data = pd.merge(data_2020, data_2024, on='State', suffixes=('_2020', '_2024'))

# Create the heatmap
fig = go.Figure(data=go.Heatmap(
    z=[merged_data['Unemployment Rate_2020'], merged_data['Unemployment Rate_2024']],
    x=['2020', '2024'],
    y=merged_data['State'],
    colorscale='Viridis',
    colorbar=dict(title='Unemployment Rate')
))

# Customize layout
fig.update_layout(
    title='Unemployment Rate Comparison (2020 vs 2024)',
    xaxis=dict(title='Year'),
    yaxis=dict(title='State'),
)

# Show the plot
fig.show()