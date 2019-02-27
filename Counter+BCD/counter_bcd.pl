#!/usr/bin/perl
#counter_bcd_datafile

#---------------------
# Variables
#---------------------
$rst = 0;
$en = 1;
$updn = 1;
$counter = 0;
$tens = 0000;
$ones = 0000;
#--------------------------
# File handler 
#----------------------------
$file = 'counter_bcd_datafile.txt';   # File path
open(counter_bcd_datafile, ">$file");  # file handler "open file to write/replace"


#-----------------------
# Test vectors 
#-------------------------
for($i=0;$i<32;$i=$i+1)
{
    if($i == 0)  # initalize rst, en, updn to 0
    {
      $rst = 0;
      $en = 0;
      $updn = 0;
    }
    else{
    if($i >= 15 && $i <= 17)  #reset stimulus condition
    {
    $rst = 1;
    }
    else
    {
    $rst = 0;
    }

    if($i >= 18 && $i <= 19)   # enable stimulus condition 
    {
        $en = 0;
    }
    else{
        $en = 1;
    }

    if($i <= 25) # updown stimulus condition
    {
        $updn = 1;
    }
    else
    {
        $updn = 0;
    }
    }
#--------------------------------
#  Counter part
#----------------------------------
    if(!$rst)
    {
     if($en == 1)
      {
        if ($updn == 1)
         {
           $counter = $counter + 1;  
         }
        else
          {
          $counter = $counter - 1;  
          }
      }
     else
      {
        $counter = $counter;
      }
     }
    else
    {
      $counter = 0;  
    }
#-------------------------------
# BCD conversion 
#----------------------    
  $ones = $counter % 10; # is the remainder
  $tens = ($counter - $ones)/10;
#---------------------------
#  Write data to the file 
#---------------------------
printf counter_bcd_datafile "%01b_%01b_%01b_%04b_%04b\n", $rst, $en, $updn, $tens, $ones;
}
close(counter_bcd_datafile)  # flie handler "close file"

#end