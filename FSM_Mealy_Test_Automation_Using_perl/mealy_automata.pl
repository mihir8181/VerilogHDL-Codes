#!/usr/bin/perl
#---------Variables----------------#
$cs = 00;
$ns = 00;
$s0 = 00;
$s1 = 01;
$s2 = 10;
$rst = 0;
$i = 0;
$x = 0;
$z = 0;
@xvector = qw(0 0 1 0 1 0 1 0 1 1 1 1 0 1 0 1 0 0 1 0 0 0 1 0 1 1 0 1 0 1 1 0 0 0 1);

#---------- File Handler ----------#
$file = 'mealy_seq_datafile.txt';
open(mealy_seq_datafile, ">$file");

#----------------------------------#
for($i=0;$i<32;++$i)
{
  $x = $xvector[$i]; 
  if ($i==0)
    {
      $rst = 0;
      $ns = $s0;
    }
  else
   {
     if($i==15)
       {
         $rst = 0;
         $ns = $s0;
       }
     else
       {
         $rst = 1; 
       }
   }
 #-------------------------  
   if ($rst == 0)
       {
         $cs = $s0;
       }
   else
       {
         $cs = $ns;
       }
 #-------------------------
  if ($rst == 1)
   {  
    if ($cs == $s0)
       {
         if ($x == 1)
           {
             $z = 0;
             $ns = $s1;
           }
      else
           {
             $z = 0;
             $ns = $s0;  
           } 
       }
      else 
           {
             if ($cs == $s1)
                {
                 if ($x == 1)
                   {
                     $z = 0;
                     $ns = $s1;
                   }
                 else
                   {
                     $z = 0;
                     $ns = $s2;  
                   }
                }
             else 
               {
                  if ($cs == $s2)
                    {
                      if ($x == 1)
                        {
                          $z = 1;
                          $ns = $s1;
                        }
                     else
                        {
                         $z = 0;
                         $ns = $s0;  
                        }
                    }
                 else
                    {
                     $ns = $s0;
                     $z = 0;
                    }
                }
            }
    }      
printf mealy_seq_datafile "%01b_%01b_%01b\n", $rst, $x, $z;
}
close(mealy_seq_datafile)