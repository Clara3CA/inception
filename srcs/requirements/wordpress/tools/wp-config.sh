#!/bin/bash
set -e  # Exit immediately if a command fails

CONFIG_FILE="/var/www/html/wp-config.php"

echo "📌 Generating wp-config.php..."

cat > "$CONFIG_FILE" <<EOF
<?php
define( 'DB_NAME', '${WORDPRESS_DB_NAME}' );
define( 'DB_USER', '${WORDPRESS_DB_USER}' );
define( 'DB_PASSWORD', '${WORDPRESS_DB_PASSWORD}' );
define( 'DB_HOST', '${WORDPRESS_DB_HOST}' );
define( 'DB_CHARSET', 'utf8mb4' );
define( 'DB_COLLATE', '' );

define( 'WP_DEBUG', false );

/* Authentication Keys */
define( 'AUTH_KEY',         '$(openssl rand -base64 32)' );
define( 'SECURE_AUTH_KEY',  '$(openssl rand -base64 32)' );
define( 'LOGGED_IN_KEY',    '$(openssl rand -base64 32)' );
define( 'NONCE_KEY',        '$(openssl rand -base64 32)' );
define( 'AUTH_SALT',        '$(openssl rand -base64 32)' );
define( 'SECURE_AUTH_SALT', '$(openssl rand -base64 32)' );
define( 'LOGGED_IN_SALT',   '$(openssl rand -base64 32)' );
define( 'NONCE_SALT',       '$(openssl rand -base64 32)' );

/* Table prefix */
\$table_prefix = 'wp_';

/* Disable file editing via WP admin */
define( 'DISALLOW_FILE_EDIT', true );

/* Absolute path to the WordPress directory */
if ( !defined( 'ABSPATH' ) ) {
    define( 'ABSPATH', dirname(__FILE__) . '/' );
}
require_once ABSPATH . 'wp-settings.php';
EOF

echo "✅ wp-config.php generated successfully."

# Ensure correct ownership and permissions
chown www-data:www-data "$CONFIG_FILE"
chmod 644 "$CONFIG_FILE"

