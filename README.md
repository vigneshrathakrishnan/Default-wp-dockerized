# 🚀 Advanced WordPress Docker Setup

A one-click, developer-ready Docker setup for WordPress with MySQL and Apache.

---

## 📁 Project Structure

```
advanced-wp-docker/
├── docker-compose.yml        # Docker setup
├── .env                      # Environment config
├── setup.sh                  # One-click startup script
├── db-dump.sql               # Optional SQL import
└── wp-content/               # Your plugins/themes
```

---

## ⚙️ Quick Start

1. **Clone the Repo**

```bash
git clone https://github.com/vigneshrathakrishnan/Default-wp-dockerized
cd Default-wp-dockerized
```

2. **Create the Project Files**

```bash
touch docker-compose.yml
touch .env
touch setup.sh
mkdir wp-content
```

3. **Add Your Configuration**

- Fill in `.env` (sample below)
- Paste the content for `docker-compose.yml` and `setup.sh`
- (Optional) Place your `db-dump.sql` if needed

---

## 🧪 .env Example

```env
MYSQL_ROOT_PASSWORD=root
MYSQL_DATABASE=wordpress
MYSQL_USER=wpuser
MYSQL_PASSWORD=wppass

WP_PORT=8180
PHPMYADMIN_PORT=8181
```

---

## 🚀 Run the Setup

```bash
chmod +x setup.sh
./setup.sh
```

- Visit WordPress → [http://localhost:8180](http://localhost:8180)  
- Visit phpMyAdmin → [http://localhost:8181](http://localhost:8181)

---

## 🔁 Reset / Cleanup

```bash
docker compose down -v
```

This removes all containers, volumes, and database data.

---

## 📘 License

MIT — Free for commercial and personal use.