FROM php:latest

# Installation des dépendances nécessaires
RUN apt-get update && apt-get install -y \
    git \
    zip \
    unzip \
    && docker-php-ext-install pdo pdo_mysql

# Installation de Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Installation des dépendances du projet avec Composer
COPY composer.json composer.lock /var/www/html/
WORKDIR /var/www/html

# Copie du fichier php.ini
COPY php.ini /usr/local/etc/php/conf.d/php.ini

# Exécution des commandes Symfony
CMD composer dump-autoload && php-fpm \
    composer require symfony/twig-bundle