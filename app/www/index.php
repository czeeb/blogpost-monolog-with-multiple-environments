<?php

namespace BlogPost;

require __DIR__ . '/../vendor/autoload.php';

use Cascade\Cascade;

// Create the logger
$logger = new \Cascade\Cascade();
$logger->fileConfig(__DIR__ . '/../conf/logger.yml');
$logger->getLogger('myAppLog')->info('My logger is now set up!');

// Create myApp object and pass in logger
$myapp = new MyApp($logger->getLogger('myAppLog'));

// A simple function that outputs a debug message to the logger
$myapp->sayHello();

// Simulates random breakage
$myapp->randError();

class MyApp
{

    protected $logger;

    public function __construct(\Psr\Log\LoggerInterface $logger)
    {
        $this->logger = $logger;
    }

    public function sayHello()
    {
        $this->logger->debug('Saying hello!');
        echo "Hello World!" . PHP_EOL;
    }

    public function randError()
    {
        $rand = rand(1, 5);

        $this->logger->debug("Random number is {rand}", array('rand' => $rand));

        if ($rand == 5) {
            sleep(1);
            $this->logger->critical(
                'Oh no, random was above 4!  ',
                'This is a critical error and the application cannot continue to function.'
            );
        } elseif ($rand == 4) {
            $this->logger->error(
                'rand was 4.  This is an error but not catastrophic.  ',
                'We do not dump all the debug messages.'
            );
        } else {
            $this->logger->debug("{rand} is not higher than 3, all is well.", array('rand' => $rand));
        }
    }
}
