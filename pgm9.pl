#!/usr/bin/perl
#
#	pgm9.pl - Tommy Dickerson
#	Program 9
#	cit145
#	Due 04/17/2008
#_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
#
# This Perl program uses a subroutine
# strategy and plays agianst an opponent
# in the game of Prisoner's Dilemma.
#_______________________________________________________


$mytotal = 0;
$optotal = 0;

print <<EOM;

	[1] Enter moves manualy
	[2] Play with moves from a file
	[3] Play with a subroutine from this program

EOM
print "Enter your choice [1]: ";
while ($input = <>) {
	chomp ($input);


	# 1 chooses to enter moves manually #

	if (($input =~ /^[ ]*[1][ ]*$/) or ($input =~ /^[ ]*$/) or ($input eq undef)) {
		print "\nIs the opponent going to Testify or Hold? ";
		while ($move = <>) {
			chomp ($move);
			if ($move =~ /^[tThH]$/) {
				$move =~ tr/th/TH/;
				&gamecore($move);
				}
			elsif ($move =~ /^[ ]*[qQ][ ]*$/) {
				exit;
				}
			else {
				print <<EOM;

	[T] Testify
	[H] Hold
	[q] Quit
EOM
				}
			print "\nIs the opponent going to Testify or Hold? ";
			}
		}


	# 2 choosed to load moves from a file, one per line #

	elsif ($input =~ /^[ ]*[2][ ]*$/) {
		print "\nPlease enter a file that contains your opponents moves: ";
		$playfile = <>; chomp($playfile);

		unless (-e $playfile) {
			print "\nSorry the file '$playfile' does not exist.\nExiting...\n\n";
			exit;
			}

		open MOVELIST, "$playfile" or die "\nCannot open file '$playfile': $!\n";
		print "\nYour opponents moves have been loaded from file '$playfile'.\n\n";
		print "Press [Enter] to continue.\n";
		<>;

		$line = 0;
		while (<MOVELIST>) {
			$moves[$line] = $_;
			$line++;
			}
		close MOVELIST;

		while ($opchoice = shift(@moves)) { &gamecore($opchoice); }
		exit;
		}


	# 3 chooses to generate move from a subroutine #

	elsif ($input =~ /^[ ]*[3][ ]*$/) {
		print "\nHow many turns would you like to go? ";
		while ($turns = <>) {
			chomp ($turns);
			if ($turns =~ /^\d+$/) {
				while ($turns > 0) {


					# Must add subroutine from end of program here #

					$opchoice = &myprobsub(@prevMyBlysMoves); # EX. $opchoice = &SUBNAME(@prevMyMoves);
					&gamecore($opchoice);
					$turns--;
					}
				exit;
				}
			else {print "How many turns would you like to go? ";}
			}
		}


	# tell the user if they have entered an invalid command #

	else {
		print <<EOM;


	[1] Enter moves manualy
	[2] Play with moves from a file
	[3] Play with a subroutine from this program

EOM
		print "Enter your choice [1]: ";
		}
	}

exit;


# SUBROUTINE gamecore: Run the game once and output the results to the user #

sub gamecore
	{
	my @argument = @_;
	my $opmove = $argument[0];	# get opponents move
	chomp($opmove);
	my $mymove = &bullysub(@prevOpMoves);	#get my move
	$myhist .= $mymove;			# create a history to display
	$ophist .= $opmove;			# create a history to display
	push(@prevOpMoves, $opmove);	# store the history of my opponents previous moves
	($myears, $opyears) = &years($mymove, $opmove); # determine the num of years we each recieved
	$mytotal += $myears;		# add the number of years to a running total
	$optotal += $opyears;		# add the number of years to a running total


	# Display the game results to the user #

	print "====================\n\n";
	print "My History:\n\t$myhist\nOpponents History:\n\t$ophist\n\n";
	print "I $mymove and got $myears, opponent $opmove and got $opyears.\n";
	print "My total $mytotal years, oppenents total $optotal years.\n\n";
	}


# SUBROUTINE years: Determine the score of both players in the game for current moves #

sub years
	{
	my @arguments = @_;
	my %table = (
	'TT' => '4|4',
	'TH' => '0|5',
	'HH' => '2|2',
	'HT' => '5|0',
	);
	my $result = $table{"$arguments[0]$arguments[1]"};
	my($me, $op) = split(/\|/, $result, 2);
	return($me, $op);
	}

#
# NAME: Tommy Dickerson
# DESC: Try to get the lowest score without being screwed.
#
# STRATEGY: Find copycats and Hold to get lowest score. Find near copycats and mostly Hold. Anything else mostly Testify.
#
sub bullysub
	{
	my @opsmoves = @_;
	my $lastmove = $opsmoves[$#opsmoves];
	my $notherRand = rand();
	my $size = @opsmoves;
	if ($lastmove eq undef) {$myBlyschoice = "H";}
	elsif ($size == 1) {$myBlyschoice = "T";}
	else {
		if ($lastmove eq $prevMyBlysMoves[($#prevMyBlysMoves - 1)]) {
			$copycatBlys += 1;
			}
		else {$copycatBlys -= 1;}
		my $copyprob = $copycatBlys / ($size - 1);
		# Preamble
		if ($size == 2) {$myBlyschoice = "H";}
		elsif ($size == 3) {$myBlyschoice = "H";}
		elsif ($size == 4) {$myBlyschoice = "T";}
		elsif ($size == 5) {$myBlyschoice = "H";}

		elsif ($size == 99) {$myBlyschoice = "T";}
		elsif ($size == 149) {$myBlyschoice = "T";}
		elsif ($size == 199) {$myBlyschoice = "T";}
		else {
			if ($copyprob == 1) {
				$myBlyschoice = "H";
				}
			elsif ($copyprob > 0.88) {
				if ($notherRand < 0.015) {
					$myBlyschoice = "T";
					}
				else {$myBlyschoice = "H";}
				}
			else {
				if ($notherRand < 0.015) {
					$myBlyschoice = $lastmove;
					}
				else {
					$myBlyschoice = "T";
					}
				}
			}
		}
	push(@prevMyBlysMoves, $myBlyschoice);
	return($myBlyschoice);
	}

##	 END OF PROGRAM        ##
# Add other subroutines below	#
# # # # # # # # # # # # # # # # #


sub copycat
	{
	my @argument = @_;
	$lastmove = $argument[$#argument];
	unless ($lastmove) {
		$lastmove = "T";
		}
	return($lastmove);
	}

sub rand
	{
	my $random_number = rand();
	if ($random_number < 0.5) {
		$move = "T";
		}
	else { $move = "H"; }
	return($move);
	}

sub myprobsub
	{
	my @opponentsmoves = @_;
	undef $numT;
	undef $numH;
	my $opplastmove = $opponentsmoves[$#opponentsmoves];
	if ($#opponentsmoves == -1)
		{
		$mymove = 'H';
		push(@MyMoveHist, $mymove);
		return "$mymove";
		}
	else
		{
		foreach (@opponentsmoves) {
			$element = $_;
			if ($element eq 'T')
				{
				$numT += 1;
				}
			else
				{
				$numH += 1;
				}
			}
		$oppProbT = $numT / ($#opponentsmoves + 1);
		$oppProbH = $numH / ($#opponentsmoves + 1);
		if (($oppProbT > 0.88) || ($oppProbH > 0.75))
			{
			$mymove = 'T';
			}
		else
			{
			my $random_number = rand();
			if ($random_number < 0.88) {
				$mymove = "T";
				}
			else { $mymove = "H"; }
			}
		push(@MyMoveHist, $mymove);
		return ("$mymove");
		}
	}