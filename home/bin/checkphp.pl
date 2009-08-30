#!/usr/bin/perl
## ---------------------------------------------------------------------------
## -checkphp- make sure extra space isn't at the end of PHP files
## Sample Usage: find . -name '*.php' | xargs ./checkphp.pl >checked_files.txt
## ---------------------------------------------------------------------------

if (@ARGV < 1)
{
	print "checkphp: need file(s) to check\n";
	exit;
}

FILE:
foreach my $filename (@ARGV)
{
	my @contents = readFile($filename);
	my $IS_SPACE = 0;

	foreach (reverse @contents)
	{
		if (/\?\>/ and $IS_SPACE)
		{
			print "Warning: check PHP file: $filename\n";
			next FILE;
		}

		if (!/^\s*$/)
		{
			print "PHP file OK: $filename\n";
			next FILE;
		}
		else
		{
			$IS_SPACE = 1;
		}
	}
}

# --------------------------------------------------------------------------
# Functions
# --------------------------------------------------------------------------
sub readFile
{
	my $filename = shift || die "readFile: need a filename";

	open FILE, $filename or die "readFile: couldn't open $filename\n";
	my @contents = <FILE>;
	close FILE;

	return @contents;
}