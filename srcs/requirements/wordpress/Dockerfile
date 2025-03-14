FROM debian:bullseye

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    curl \
    mariadb-client \
    zip \
    unzip \
    php \
    php-mysqli \
    php-fpm \
    php-curl \
    php-zip \
    php-gd \
    php-mbstring \
    php-xml \
    php-xmlrpc \
    php-soap \
    php-intl \
    php-bcmath \
    php-imagick \
    sudo \
    && apt-get clean

# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && sudo mv wp-cli.phar /usr/local/bin/wp

# Copy the PHP-FPM pool configuration
COPY ./tools/www.conf /etc/php/7.4/fpm/pool.d/www.conf
RUN chmod +x /etc/php/7.4/fpm/pool.d/www.conf

# Create required directories
RUN mkdir -p /run/php \
    && chown -R www-data:www-data /run/php

WORKDIR /var/www/html

# Create and set proper permissions for WordPress' directories
#RUN mkdir -p /var/www/html \
#    && chown -R www-data:www-data /var/www/html \
#    && chmod -R 755 /var/www/html

# Copy the wp-config generation script
COPY ./tools/wp-config.sh /usr/local/bin/wp-config.sh
RUN chmod +x /usr/local/bin/wp-config.sh

# Expose the HTTP port
EXPOSE 9000

# Add a check to ensure WordPress is in the right folder before running wp-cli commands

ENTRYPOINT ["/usr/local/bin/wp-config.sh"]
#CMD ["/bin/bash", "/usr/local/bin/wp-config.sh"]# && php-fpm7.4 -F"]


#CMD ["/bin/bash", "-c", "/usr/local/bin/wp-config.sh && cd /var/www/html && if [ ! -f wp-config.php ]; then echo 'WordPress files not found!'; exit 1; fi && sudo -u www-data wp core install --url='${WORDPRESS_SITE_URL}' --title='${WORDPRESS_SITE_TITLE}' --admin_user='${WORDPRESS_ADMIN_USER}' --admin_password='${WORDPRESS_ADMIN_PASSWORD}' --admin_email='${WORDPRESS_ADMIN_EMAIL}' --path=/var/www/html && php-fpm7.4 -F"]
