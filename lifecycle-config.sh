#!/bin/bash

# Redirect output to app_container.log
exec > >(tee -a /var/log/apps/app_container.log) 2>&1

echo "=== Starting lifecycle configuration script $(date) ==="

# Set appropriate permissions
echo "Setting directory permissions..."
chmod 755 /opt/conda/etc/jupyter
chmod 755 /opt/conda/etc/jupyter/labconfig
if [ $? -eq 0 ]; then
    echo "Permissions set successfully"
else
    echo "Error: Failed to set directory permissions"
    exit 1
fi

# Remove existing file if it exists
echo "Checking for existing config file..."
if [ -f /opt/conda/etc/jupyter/labconfig/page_config.json ]; then
    echo "Removing existing config file..."
    rm -f /opt/conda/etc/jupyter/labconfig/page_config.json
fi

# Create new file with our desired configuration
echo "Creating new config file..."
cat << 'EOF' > /opt/conda/etc/jupyter/labconfig/page_config.json
{
  "disabledExtensions": {
    "@jupyter/collaboration-extension": true,
    "@jupyterlab/docmanager-extension:download": true,
    "@jupyterlab/filebrowser-extension:download": true,
    "@jupyterlab/filebrowser-extension:open-browser-tab":true
  },
  "lockedExtensions": {
    "@jupyter/collaboration-extension": true
  }
}
EOF

# Verify file was created
if [ -f /opt/conda/etc/jupyter/labconfig/page_config.json ]; then
    echo "Config file created successfully"
else
    echo "Error: Failed to create config file"
    exit 1
fi

echo "=== Lifecycle configuration completed successfully $(date) ==="