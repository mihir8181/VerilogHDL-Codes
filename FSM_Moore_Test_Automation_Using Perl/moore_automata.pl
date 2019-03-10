#!/usr/bin/perl
#---------Variables----------------#
$cs = 00;
$ns = 00;
$s0 = 00;
$s1 = 01;
$s2 = 10;
$s3 = 11;
$rst = 0;
$i = 0;
$x = 0;
$z = 0;
@xvector = qw(0 0 1 0 1 0 1 0 1 1 1 1 0 0 1 1 0 1 0 0 0 0 1 0 1 1 0 1 0 1 1 0 0 0 1);

#---------- File Handler ----------#
$file = 'moore_seq_datafile.txt';
open(moore_seq_datafile, ">$file");

#----------------------------------#
for($i=0;$i<32;++$i)
{
  $x = $xvector[$i]; 
  if ($i==0)
    {
      $rst = 0;
      $z = 0;
      $ns = $s0;
    }
  else
   {
     if($i==15)
       {
         $rst = 0;
         $z = 0;
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
             $ns = $s1;
           }
      else
           {
             $ns = $s0;  
           } 
       }
      else 
           {
             if ($cs == $s1)
                {
                 if ($x == 1)
                   {
                     $ns = $s1;
                   }
                 else
                   {
                     $ns = $s2;  
                   }
                }
             else 
               {
                  if ($cs == $s2)
                    {
                      if ($x == 1)
                        {
                          $ns = $s3;
                        }
                     else
                        {
                         $ns = $s0;  
                        }
                    }
                 else
                   {
                     if($cs == $s3)
                     {
                       if ($x == 1)
                       {
                         $ns = $s1;
                       }
                       else
                       {
                         $ns = $s2;
                       }
                     }
                   else
                    {
                     $ns = $s0;
                    }
                  }
    
        }
      } 
   }
    if ($cs == $s3)
    {
      $z = 1;
    }
    else
    {
      $z = 0;
    }        
printf moore_seq_datafile "%01b_%01b_%01b\n", $rst, $x, $z;
}
close(moore_seq_datafile)