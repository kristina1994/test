FROM php:7.1-fpm-stretch

COPY --from=composer:1.9.1 /usr/bin/composer /usr/local/bin/composer

RUN mkdir /composer
ENV COMPOSER_HOME=/composer

RUN echo "memory_limit=-1" > $PHP_INI_DIR/conf.d/memory-limit.ini

RUN composer global require phpstan/phpstan ^0.12.2 \
    && composer global require phpstan/phpstan-doctrine \
    && composer global require phpstan/phpstan-phpunit \
    && composer global require phpstan/phpstan-nette \
    && composer global require phpstan/phpstan-symfony \
    && composer global require phpstan/phpstan-mockery \
    && composer global require phpstan/phpstan-webmozart-assert \
    && composer global show | grep phpstan

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]