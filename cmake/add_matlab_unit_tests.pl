#!/usr/bin/perl -w

# Note: this must be run from the root directory of drake


$CMAKE_INSTALL_PREFIX = `cmake pod-build -L | grep CMAKE_INSTALL_PREFIX | cut -d "=" -f2 | tr -d '[:space:]'`;
$DRAKE_ROOT = `pwd | tr -d '[:space:]'`;

# write unit tests to .matlab_ctests
system("matlab -nodisplay -r \"addpath('$CMAKE_INSTALL_PREFIX/matlab'); addpath_drake; options.gui = false; options.autorun = false; options.test_list_file = 'pod-build/matlab_ctests'; unitTest(options); exit;\"");

open(my $in, 'pod-build/matlab_ctests');
open(my $ctestfile, '>>', 'pod-build/CTestTestfile.cmake');

while (<$in>) {
  ($test,$testdir) = split(' ');
  $testname = $testdir."/".$test;
  $testname =~ s/\Q$DRAKE_ROOT\///;

#  $failcondition = "1";   # missing dependency => failure
  $failcondition = "~strncmp(ex.identifier,'Drake:MissingDependency',23)";  # missing dependency => pass

  print $ctestfile "ADD_TEST($testname \"matlab\" \"-nosplash\" \"-nodisplay\" \"-r\" \"addpath('$CMAKE_INSTALL_PREFIX/matlab'); addpath_drake; rng('shuffle'); try, feval('$test'); catch ex, disp(getReport(ex,'extended')); force_close_system; exit($failcondition); end; force_close_system; exit(0)\")\n";
  print $ctestfile "SET_TESTS_PROPERTIES($testname PROPERTIES  WORKING_DIRECTORY \"$testdir\")\n";
}