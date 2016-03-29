default['app-monolog-web']['composer']['dev'] = false

default['app-monolog-web']['conf_dir'] = '/vagrant/app/conf'
default['app-monolog-web']['log_dir'] = '/var/log/monolog'

# The double quotes and two \n\n are a hack around \n becoming \\n
# if there's just single quotes around the plain_text.format value.
default['app-monolog-web']['log_conf']['formatters'] = {
    :logstash => {
        :class => 'Monolog\Formatter\LogstashFormatter',
        :applicationName => 'myApp'
    },
    :plain_text => {
        :class => 'Monolog\Formatter\LineFormatter',
        :format => "%datetime% %level_name% - %message% - %context% - %extra%\n\n"
    }
}

default['app-monolog-web']['log_conf']['handlers'] = {
    :console => {
        :class => 'Monolog\Handler\BrowserConsoleHandler',
        :level => 'DEBUG',
        :processors => %w(introspection_processor)
    },
    :app_log => {
        :class => 'Monolog\Handler\StreamHandler',
        :level => 'DEBUG',
        :formatter => 'logstash',
        :processors => %w(uid_processor web_processor introspection_processor memory_processor),
        :stream => node['app-monolog-web']['log_dir'] + '/app.log'
    },
    :fingers_crossed => {
        :class => 'Monolog\Handler\FingersCrossedHandler',
        :handler => 'app_log',
        :activationStrategy => 'CRITICAL',
        :bufferSize => 0,
        :bubble => true,
        :stopBuffering => true,
        :passthruLevel => 'ERROR'
    }
}

default['app-monolog-web']['log_conf']['processors'] = {
    :web_processor => {
        :class => 'Monolog\Processor\WebProcessor'
    },
    :memory_processor => {
        :class => 'Monolog\Processor\MemoryUsageProcessor'
    },
    :introspection_processor => {
        :class => 'Monolog\Processor\IntrospectionProcessor'
    },
    :uid_processor => {
        :class => 'Monolog\Processor\UidProcessor'
    },
    :psr_processor => {
        :class => 'Monolog\Processor\PsrLogMessageProcessor'
    }
}

default['app-monolog-web']['log_conf']['loggers'] = {
    :myAppLog => {
        :handlers => %w(fingers_crossed)
    }
}
