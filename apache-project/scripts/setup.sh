#!/bin/bash

# 1. Update system and install Apache2
echo "🔄 Updating system and installing Apache2..."
sudo apt update
sudo apt install -y apache2

# 2. Open port 80 in the firewall (UFW)
echo "🔥 Configuring UFW firewall to allow port 80..."
sudo ufw allow 80
sudo ufw reload

# 3. Create the project directory (Document Root) in the correct path
echo "📂 Creating document root directory..."
sudo mkdir -p /var/www/monsite.local

# 4. Copy HTML files to the project directory
echo "📄 Copying custom HTML page..."
sudo cp html/index.html /var/www/monsite.local/index.html

# 5. Copy Virtual Host configuration to Apache's sites-available
echo "⚙️ Configuring Virtual Host..."
sudo cp config/vhost.conf /etc/apache2/sites-available/monsite.local.conf

# 6. Enable the site and restart Apache
echo "🚀 Enabling the site and restarting Apache..."
sudo a2ensite monsite.local.conf
sudo a2dissite 000-default.conf
sudo systemctl reload apache2

echo "✅ Done! Your Apache Web Server is ready."
echo "🌐 Don't forget to edit your Windows hosts file (C:\Windows\System32\drivers\etc\hosts) and add:"
echo "   127.0.0.1    monsite.local"
echo "📌 Then visit: http://monsite.local:8080"
