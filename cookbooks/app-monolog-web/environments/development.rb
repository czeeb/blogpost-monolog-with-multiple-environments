default_attributes({
   'app-monolog-web' => {
       'composer' => {
           'dev' => true
       },
       'log_conf' => {
           'handlers' => {
               :app_log => {
                   :formatter => 'plain_text'
               }
           },
           'loggers' => {
               :myAppLog => {
                   :handlers => %w(console app_log),
                   :processors => %w(psr_processor)
               }
           }
       }
   }
})
