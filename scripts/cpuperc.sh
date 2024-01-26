#!/usr/bin/perl -w
 
# Show per core CPU utilization of the system 
# This is a part of the post https://phoxis.org/2013/09/05/finding-overall-and-per-core-cpu-utilization
 
use strict;
use warnings;
use List::Util qw(sum);
use Fcntl;
 
#Open /proc/cpuinfo and count the number of cpus in the system
#For each cpu this file will have a section of description of that cpu
#And each such file will contain a field "processor" which lists the
#processor number of that processor.
open ($CPUINFO, "/proc/cpuinfo");
my $cpu_count = 0;
while (<$CPUINFO>)
{
  next unless "$_" =~ /^processor/;
  $cpu_count++;
}
close ($CPUINFO);
 
#Initialize old states for each cpu.
my @idle_old = split ('', 0 x $cpu_count);
my @total_old = split ('', 0 x $cpu_count);
my $update_cycle = 0;
 
#Infinitely update cpu usage, press Ctrl + C to quit
while (1)
{
  #Open /proc/stat file
  open (my $STAT, "/proc/stat") or die "Cannot open /proc/stat\n";
 
  my $count = 0;
  my $total_usage = 0;
  print "[Update cycle: $update_cycle]\n";
  while (<$STAT>)
  {
    #Find the lines starting with cpu followed by a number and whitespace and parse it
    #Formula is to find the delta of total time and idle time of the cpu from the last update
    #and calcute the ratio of time in processing (not idle) to the total time this cycle.
    #check manual for /proc/status field description (man 5 proc). Also average the n number of cpus and
    #show the overall cpu usage.
     
    next unless ("$_" =~ m/^cpu[0-9]+\s+/);
 
    my @cpu_time_info = split (/\s+/, "$_");
    shift @cpu_time_info;
    my $total = sum(@cpu_time_info);
    my $idle = $cpu_time_info[3];
 
    my $del_idle = $idle - $idle_old[$count];
    my $del_total = $total - $total_old[$count];
 
    my $this_cpu_usage = 100 * (($del_total - $del_idle)/$del_total);
    $total_usage = $total_usage + $this_cpu_usage;
 
    printf ("CPU%d Usage: %0.2f%%\n", $count, $this_cpu_usage);
 
    $idle_old[$count] = $idle;
    $total_old[$count] = $total;
 
    $count++;
  }
  $update_cycle++;
  printf ("Total CPU Usage: %0.2f%%\n", $total_usage/$cpu_count); 
  print "\n";
  close ($STAT);
  sleep 1;
}
