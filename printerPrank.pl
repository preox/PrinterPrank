#!/usr/bin/perl
use LWP::Simple;
use IO::Socket;
my $random_number = int(rand(10));
my @lines = ( 	"WILL PRINT FOR BEER", 
				"MAYONNAISE LOW", "
				BBQ SAUCE LOW", 
				"VOICE ACTIVATED", 
				"There is no help", 
				"Insert Coin", 
				"JAM IN REAR", 
				"Insert Cheese",
				"Im Sad..",
				"Low Monkeys",
				"Insert Monkeys",
				"BOW FOR ME\\nFOR I AM ROOT", 
				"Press OK Button for Pacman",
				"Flower Power Mode",
				"Incoming Fax…",
				"Cheese Mode",
				"INSERT PAPER\\nDEEPLY");
my $lineSize = @lines;
my @hostname = (/*TODO: Instert IP of 1 or more HP printers here*/);
my $message;

/*Felt like spicing up silliness with silly lines every know and then.*/
if ($random_number> 7){
	$message = $lines[int(rand($lineSize))];
} else {

	/* URL of weather-site should ofc be altered to fit need. 
	* And if changes are done, be sure to use your impressive	
	* regex-knowledge to make sure you get tagline and temp
	*/
	my $url = "http://www.wunderground.com/weather-forecast ........ ";
	my $city = get("${url}");
	my $weather, $temp;
	if ($city =~ m/deg;\ \|\ (.*)\"/){
		$weather = $1;
	}
	if ($city =~ m/\|\ (.*)&deg/){
		$temp = $1;
	}

	/*TODO remember to alter here too, if city is changes*/
	$message = "Weather \\n$weather\\nTemp: $temp  C";
}

foreach (@hostname){
my $socket = IO::Socket::INET->new(				
    PeerAddr  => $_,
    PeerPort  => "9100",
    Proto     => "tcp",
    Type      => SOCK_STREAM
    ) or die "Could not create socket for $_ Error: $!";

my $data = <<EOJ
\e%-12345X\@PJL JOB
\@PJL RDYMSG DISPLAY="$message"
\@PJL EOJ
\e%-12345X
EOJ
;
print $socket $data;
}