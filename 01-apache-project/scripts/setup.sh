#!/bin/bash

# ═══════════════════════════════════════════════════
# CONFIGURATION - Change this to your domain
# ═══════════════════════════════════════════════════
DOMAIN="monsite.local"
# ═══════════════════════════════════════════════════

echo "🔄 Updating system and installing Apache2..."
sudo apt update
sudo apt install -y apache2

echo "🔥 Configuring UFW firewall..."
sudo ufw allow 22/tcp
sudo ufw allow 80/tcp
sudo ufw reload

echo "📂 Creating document root directory..."
sudo mkdir -p /var/www/$DOMAIN

echo "📄 Copying custom HTML page..."
sudo cp html/index.html /var/www/$DOMAIN/index.html

echo "⚙️ Configuring Virtual Host..."
sudo cp config/vhost.conf /etc/apache2/sites-available/$DOMAIN.conf

echo "🚀 Enabling the site and restarting Apache..."
sudo a2ensite $DOMAIN.conf
sudo a2dissite 000-default.conf
sudo systemctl reload apache2

echo ""
echo "✅ Done! Your Apache Web Server is ready."
echo ""
echo "🌐 Don't forget to edit your Windows hosts file:"
echo "   C:\Windows\System32\drivers\etc\hosts"
echo ""
echo "   Add this line:"
echo "   127.0.0.1    $DOMAIN"
echo ""
echo "📌 Then visit: http://$DOMAIN:8080"
