#!/bin/bash
set -e  # Exit immediately if a command fails

echo "🟢 Initializing MariaDB..."
mkdir -p /var/run/mysqld
chown -R mysql:mysql /var/run/mysqld /var/lib/mysql

echo "⌛ Waiting for MariaDB to be ready..."
mysqld_safe --skip-networking &  # Start MariaDB in the background
sleep 5  # Give it time to initialize

echo "✅ MariaDB is ready!"

# Create database if not exists
DB_EXISTS=$(mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "SHOW DATABASES LIKE '$MYSQL_DATABASE';" | grep $MYSQL_DATABASE || true)
if [[ -z "$DB_EXISTS" ]]; then
  echo "📌 Creating database '$MYSQL_DATABASE'..."
  mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "CREATE DATABASE $MYSQL_DATABASE;"
  mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
  mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';"
  mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "FLUSH PRIVILEGES;"
else
  echo "✅ Database '$MYSQL_DATABASE' already exists. Skipping setup."
fi

echo "🚀 Starting MariaDB as the main process..."
#exec mysqld --bind-address=0.0.0.0

mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown

exec mysqld


