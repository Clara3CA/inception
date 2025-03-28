FROM debian:bullseye

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    curl \
    mariadb-client \
    php-mysqli \
    php-fpm \
    && apt-get clean

# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Copy the PHP-FPM pool configuration
COPY ./tools/www.conf /etc/php/7.4/fpm/pool.d/www.conf
RUN chmod +x /etc/php/7.4/fpm/pool.d/www.conf

# Create required directories
RUN mkdir -p /run/php \
    && chown -R www-data:www-data /run/php

WORKDIR /var/www/html

# Create and set proper permissions for WordPress' directories
# RUN mkdir -p /var/www/html \
#    && chown -R www-data:www-data /var/www/html \
#    && chmod -R 755 /var/www/html

# Copy the wp-config generation script
COPY ./tools/wp-config.sh /usr/local/bin/wp-config.sh
RUN chmod +x /usr/local/bin/wp-config.sh

# Expose the HTTP port
EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/wp-config.sh"]
#CMD ["/bin/bash", "/usr/local/bin/wp-config.sh"]# && php-fpm7.4 -F"]





# FROM debian:bullseye

# # Install necessary dependencies
# RUN apt-get update && apt-get install -y \
#     curl \
#     mariadb-client \
#     php-mysqli \
#     php-fpm \
#     && rm -rf /var/lib/apt/lists/*

# # Install WP-CLI
# RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
#     && chmod +x wp-cli.phar \
#     && mv wp-cli.phar /usr/local/bin/wp

# # Copy the PHP-FPM pool configuration
# COPY ./tools/www.conf /etc/php/7.4/fpm/pool.d/www.conf
# RUN chmod +x /etc/php/7.4/fpm/pool.d/www.conf

# # Create required directories
# RUN mkdir -p /run/php \
#     && chown -R www-data:www-data /run/php

# WORKDIR /var/www

# # Create and set proper permissions for WordPress' directories
# RUN curl -O https://wordpress.org/latest.tar.gz \
#    && tar xvzf latest.tar.gz \
#    && mv wordpress html \
#    && chown -R www-data:www-data /var/www/html \
#    && chmod -R 755 /var/www/html

# WORKDIR /var/www/html

# # Copy the wp-config generation script
# COPY ./tools/wp-config.sh /usr/local/bin/wp-config.sh
# RUN chmod +x /usr/local/bin/wp-config.sh

# # Expose the HTTP port
# EXPOSE 9000

# ENTRYPOINT ["/usr/local/bin/wp-config.sh"]
