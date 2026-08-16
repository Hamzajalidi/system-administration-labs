

<h1 align="center">🌐 Lab 01 — Apache Web Server</h1>

<p align="center">
  Virtual Apache2 server with custom VirtualHost, UFW Firewall & Vagrant automation.<br>
  <em>From zero to a working web server in minutes.</em>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Vagrant-2.4.9-blue?logo=vagrant" />
  <img src="https://img.shields.io/badge/Apache-2.4-red?logo=apache" />
  <img src="https://img.shields.io/badge/Ubuntu-22.04-orange?logo=ubuntu" />
  <img src="https://img.shields.io/badge/VMware-Workstation-grey?logo=vmware" />
  <img src="https://img.shields.io/badge/License-MIT-green" />
</p>

---

## 📑 Table of Contents

- [Overview](#-overview)
- [Prerequisites](#-prerequisites)
- [Quick Start (Vagrant)](#-quick-start-vagrant)
- [Manual Setup](#-manual-setup)
- [Project Structure](#-project-structure)
- [Verification](#-verification)
- [Troubleshooting](#-troubleshooting)
- [Lessons Learned](#-lessons-learned)

---

## 🔭 Overview

This lab provisions a fully configured Apache2 web server on Ubuntu 22.04 using Vagrant. It demonstrates:

| Feature | Description |
|---------|-------------|
| **Apache2** | Web server with custom VirtualHost |
| **VirtualHost** | Hosts `monsite.local` on a dedicated document root |
| **UFW Firewall** | Port 80 open, SSH protected |
| **Port Forwarding** | Access from host via `localhost:8080` |
| **Infrastructure as Code** | Entire environment defined in `Vagrantfile` |

---

## ⚙️ Prerequisites

- [VMware Workstation](https://www.vmware.com/products/workstation-player.html) (or VirtualBox)
- [Vagrant](https://www.vagrantup.com/) 2.4.9+
- [Vagrant VMware Utility](https://developer.hashicorp.com/vagrant/docs/providers/vmware/vagrant-vmware-utility) (if using VMware)
- Vagrant VMware plugin:
  ```bash
  vagrant plugin install vagrant-vmware-desktop
  ```

---

## 🚀 Quick Start (Vagrant)

# 1. Clone and enter the project
git clone https://github.com/Hamzajalidi/system-administration-labs.git
cd system-administration-labs/apache-project

# 2. Start the virtual machine
vagrant up --provider=vmware_desktop

# 3. SSH into the server
```
vagrant ssh
```

Then open your browser:
```
http://localhost:8080
```

### Useful Vagrant Commands

| Command | Action |
|---------|--------|
| `vagrant up` | Start the VM |
| `vagrant ssh` | SSH into the VM |
| `vagrant halt` | Stop the VM |
| `vagrant destroy` | Delete the VM |
| `vagrant reload` | Restart with re-provisioning |

---

## 🛠️ Manual Setup

If you prefer to learn step-by-step without Vagrant:

### 1. Update system & install Apache
```bash
sudo apt update
sudo apt install -y apache2
```

### 2. Configure UFW Firewall
```bash
sudo ufw allow 22/tcp   # Protect SSH FIRST
sudo ufw allow 80/tcp   # Open HTTP
sudo ufw enable
```

### 3. Create document root
```bash
sudo mkdir -p /var/www/monsite.local
sudo cp html/index.html /var/www/monsite.local/
```

### 4. Enable VirtualHost
```bash
sudo cp config/vhost.conf /etc/apache2/sites-available/monsite.local.conf
sudo a2ensite monsite.local.conf
sudo a2dissite 000-default.conf
sudo systemctl reload apache2
```

### 5. Edit hosts file (on Windows)
Add to ` code C:\Windows\System32\drivers\etc\hosts`:
```
127.0.0.1    monsite.local
```

---

## 📁 Project Structure

```
apache-project/
├── 📂 config/
│   └── vhost.conf              # Apache VirtualHost configuration
├── 📂 html/
│   └── index.html              # Custom web page
├── 📂 scripts/
│   └── setup.sh                # Automated setup script
├── 📂 screenshots/             # Full step-by-step gallery
├── 📄 Vagrantfile              # VM definition
├── 📄 README.md                # This file
└── 📄 LICENSE                  # MIT License
```

---

## ✅ Verification

### Apache Default Page
![Apache Default Page](screenshots/12-apache-default-page.png)

### Custom VirtualHost (`monsite.local`)
![VirtualHost Page](screenshots/15-virtualhost-page.png)

### UFW Firewall Active
![UFW Status](screenshots/18-ufw-status.png)

> 📁 **For the full gallery** (Vagrant install, VM setup, log files, etc.)  
> See the [`screenshots/`](screenshots/) directory.

---

## 🔧 Troubleshooting

| Issue | Solution |
|-------|----------|
| `localhost:8080` not loading | Ensure VM is running: `vagrant up` |
| `monsite.local` not resolving | Add `127.0.0.1 monsite.local` to your hosts file |
| UFW blocks SSH | Always run `ufw allow 22/tcp` **before** `ufw enable` |
| Apache fails to start | Run `sudo apachectl configtest` to check syntax |

---

## 🎓 Lessons Learned

> **Lesson 1:** Always open SSH (port 22) in UFW **before** enabling the firewall, or you will lock yourself out.

> **Lesson 2:** Apache VirtualHost allows hosting multiple websites on a single server using different domain names.

> **Lesson 3:** Vagrant turns a virtual environment into code — reproducible, versionable, and shareable.

---

## 🔗 Main Repository

📂 [system-administration-labs](https://github.com/Hamzajalidi/system-administration-labs)

---

<p align="center">
  Built with ❤️ for hands-on System Administration learning.
</p>
```
