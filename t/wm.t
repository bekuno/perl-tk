#!/usr/bin/perl -w
# -*- perl -*-

#
# $Id: $
# Author: Slaven Rezic
#

use strict;

use Tk;

BEGIN {
    if (!eval q{
	use Test::More;
	1;
    }) {
	print "1..0 # skip: no Test::More module\n";
	exit;
    }
}

BEGIN { plan tests => 2 }

my $mw = MainWindow->new;
$mw->withdraw;
$mw->geometry("+10+10");
$mw->Message(-text => "Set the icon with iconimage and iconphoto")->pack;
my $icon = $mw->Photo(-format => 'gif',
		      -file => Tk->findINC('Xcamel.gif'));
$mw->iconimage($icon);
$mw->deiconify;
$mw->idletasks;
pass("Set iconimage");

tk_sleep(0.5);

my $icon2 = $mw->Photo(-file => Tk->findINC("icon.gif"));
$mw->withdraw;
$mw->iconphoto('-default', $icon2);
$mw->deiconify;

my $t = $mw->Toplevel;
$t->geometry("+100+20");
$t->Message(-text => "This toplevel should also get the same icon")->pack;

$mw->idletasks;
pass("Set iconphoto");


$mw->after(1000,[destroy => $mw]);
MainLoop;

sub tk_sleep {
    my($s) = @_;
    my $sleep_dummy = 0;
    $mw->after($s*1000,
	       sub { $sleep_dummy++ });
    $mw->waitVariable(\$sleep_dummy)
	unless $sleep_dummy;
}

__END__
