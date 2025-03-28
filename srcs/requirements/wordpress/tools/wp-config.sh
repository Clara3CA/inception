#!/bin/bash
set -e  # Exit immediately if a command fails

#CONFIG_FILE="/var/www/html/wp-config.php"

#echo "📌 Generating wp-config.php..."

#cat > "$CONFIG_FILE" <<EOF
#<?php
#define( 'DB_NAME', '${WORDPRESS_DB_NAME}' );
#define( 'DB_USER', '${WORDPRESS_DB_USER}' );
#define( 'DB_PASSWORD', '${WORDPRESS_DB_PASSWORD}' );
#define( 'DB_HOST', '${WORDPRESS_DB_HOST}' );
#define( 'DB_CHARSET', 'utf8mb4' );
#define( 'DB_COLLATE', '' );

#define( 'WP_DEBUG', false );

#/* Authentication Keys */
#define( 'AUTH_KEY',         '$(openssl rand -base64 32)' );
#define( 'SECURE_AUTH_KEY',  '$(openssl rand -base64 32)' );
#define( 'LOGGED_IN_KEY',    '$(openssl rand -base64 32)' );
#define( 'NONCE_KEY',        '$(openssl rand -base64 32)' );
#define( 'AUTH_SALT',        '$(openssl rand -base64 32)' );
#define( 'SECURE_AUTH_SALT', '$(openssl rand -base64 32)' );
#define( 'LOGGED_IN_SALT',   '$(openssl rand -base64 32)' );
#define( 'NONCE_SALT',       '$(openssl rand -base64 32)' );

#/* Table prefix */
#\$table_prefix = 'wp_';

#/* Disable file editing via WP admin */
#define( 'DISALLOW_FILE_EDIT', true );

#/* Absolute path to the WordPress directory */
#if ( !defined( 'ABSPATH' ) ) {
#    define( 'ABSPATH', dirname(__FILE__) . '/' );
#}
#require_once ABSPATH . 'wp-settings.php';
#EOF

#echo "✅ wp-config.php generated successfully."

# Ensure correct ownership and permissions
#chown www-data:www-data "$CONFIG_FILE"
#chmod 644 "$CONFIG_FILE"




sleep 10

# Run WP-CLI to perform WordPress setup
echo "📌 Running WP-CLI commands..."

if [ ! -f "/var/www/html/wp-config.php" ]
then
	echo "Downloading WordPress..."
	wp core download --path="/var/www/html" --allow-root

	echo "Creation of wp-config.php..."
	wp config create --path="/var/www/html" --allow-root \
		--dbname="${MYSQL_DATABASE}" \
		--dbuser="${MYSQL_USER}" \
		--dbpass="${MYSQL_PASSWORD}" \
		--dbhost="${WORDPRESS_DB_HOST}" \
		--skip-check

	echo "WordPress' Installation..."
	wp core install --path="/var/www/html" \
		--url="${DOMAIN_NAME}" \
		--title="${WORDPRESS_SITE_TITLE}" \
		--admin_user="${WORDPRESS_ADMIN_USER}" \
		--admin_password="${WORDPRESS_ADMIN_PASSWORD}" \
		--admin_email="${WORDPRESS_ADMIN_EMAIL}" \
		--allow-root

   	echo "Creation of another user..."
   	wp user create ${WORDPRESS_USER} ${WORDPRESS_MAIL} \
		--role=subscriber \
		--user_pass="${WORDPRESS_PASSWORD}" \
		--allow-root --path="/var/www/html"

else
    echo "WordPress is already installed."
fi


echo "✅ WP-CLI setup complete."

exec /usr/sbin/php-fpm7.4 -F




# #!/bin/bash
# set -e  # Exit immediately if a command fails

# CONFIG_FILE="/var/www/html/wp-config.php"

# #echo "📌 Generating wp-config.php..."

# cat > "$CONFIG_FILE" <<EOF
# <?php
# define( 'DB_NAME', '${MYSQL_DATABASE}' );
# define( 'DB_USER', '${MYSQL_USER}' );
# define( 'DB_PASSWORD', '${MYSQL_PASSWORD}' );
# define( 'DB_HOST', '${WORDPRESS_DB_HOST}' );
# define( 'DB_CHARSET', 'utf8' );
# define( 'DB_COLLATE', '' );

# /* Authentication Keys */
# define( 'AUTH_KEY',         '$(openssl rand -base64 32)' );
# define( 'SECURE_AUTH_KEY',  '$(openssl rand -base64 32)' );
# define( 'LOGGED_IN_KEY',    '$(openssl rand -base64 32)' );
# define( 'NONCE_KEY',        '$(openssl rand -base64 32)' );
# define( 'AUTH_SALT',        '$(openssl rand -base64 32)' );
# define( 'SECURE_AUTH_SALT', '$(openssl rand -base64 32)' );
# define( 'LOGGED_IN_SALT',   '$(openssl rand -base64 32)' );
# define( 'NONCE_SALT',       '$(openssl rand -base64 32)' );

# /* Table prefix */
# \$table_prefix = 'wp_';

# define('WP_DEBUG', false);

# /* Absolute path to the WordPress directory */
# if ( !defined( 'ABSPATH' ) ) {
#    define( 'ABSPATH', dirname(__FILE__) . '/' );
# }

# if (!isset(\$_SERVER['HTTP_HOST'])) {
#     \$_SERVER['HTTP_HOST'] = '${DOMAIN_NAME}';
# }

# require_once ABSPATH . 'wp-settings.php';
# EOF

# echo "✅ wp-config.php generated successfully."

# # Ensure correct ownership and permissions
# chown www-data:www-data "$CONFIG_FILE"
# chmod 755 "$CONFIG_FILE"


# while ! mysql -h mariadb ${MYSQL_DATABASE} -u ${MYSQL_USER} -p"${MYSQL_PASSWORD}" -e "SELECT 1;" >/dev/null 2>&1; do
# 	echo "waiting for mariadb..."
# 	sleep 3
# done

# # Run WP-CLI to perform WordPress setup
# echo "📌 Running WP-CLI commands..."

# if ! wp core is-installed --path="/var/www/html" --allow-root;
# then
# 	# echo "Downloading WordPress..."
# 	# wp core download --path="/var/www/html" --allow-root

# 	echo "WordPress' Installation..."
# 	wp core install --path="/var/www/html" \
# 	  --url="${DOMAIN_NAME}" \
# 	  --title="${WORDPRESS_SITE_TITLE}" \
# 	  --admin_user="${WORDPRESS_ADMIN_USER}" \
# 	  --admin_password="${WORDPRESS_ADMIN_PASSWORD}" \
# 	  --admin_email="${WORDPRESS_ADMIN_EMAIL}" \
# 	  --allow-root

#    	echo "Creation of another user..."
# 	wp user create ${WORDPRESS_USER} ${WORDPRESS_MAIL} \
# 		--role=subscriber \
# 		--user_pass="${WORDPRESS_PASSWORD}" \
# 		--allow-root --path="/var/www/html"
# fi


# echo "✅ WP-CLI setup complete."

# exec /usr/sbin/php-fpm7.4 -F
