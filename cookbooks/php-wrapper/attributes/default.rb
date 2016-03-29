# Setting the TZ prevents the following warning
# PHP Warning:  date_default_timezone_get(): It is not safe to rely on the system's timezone settings.
# You are *required* to use the date.timezone setting or the date_default_timezone_set() function.
# In case you used any of those methods and you are still getting this warning, you most likely misspelled the
# timezone identifier. We selected the timezone 'UTC' for now, but please set date.timezone to select your timezone.
# in /vagrant/app/vendor/monolog/monolog/src/Monolog/Logger.php on line 311
default['php']['directives']['date.timezone'] = 'UTC'
