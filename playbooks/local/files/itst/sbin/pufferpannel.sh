#!/bin/bash

# Function to install PufferPanel
install_pufferpanel() {
    echo "Installing PufferPanel..."

    # Check if the distribution is DEB or RPM based
    if [[ -f /etc/debian_version ]]; then
        # DEB-based distribution
        echo "Detected DEB-based distribution."
        curl -s https://packagecloud.io/install/repositories/pufferpanel/pufferpanel/script.deb.sh?any=true | sudo bash
        sudo apt update
        sudo apt-get install -y pufferpanel
    elif [[ -f /etc/redhat-release ]]; then
        # RPM-based distribution
        echo "Detected RPM-based distribution."
        # You can add the RPM installation command here, if needed
        echo "Please add the RPM installation commands here."
    else
        echo "Unsupported distribution. Please install manually."
        exit 1
    fi

    # Adding an admin user
    echo "Creating the first user..."
    sudo pufferpanel user add

    # Starting the panel
    echo "Starting PufferPanel..."
    sudo systemctl enable --now pufferpanel

    echo "PufferPanel installation and setup complete!"
}

# Execute the installation function
install_pufferpanel
