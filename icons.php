<?php
$iconfilename="iconnames.txt";
$handle=fopen($iconfilename,"r") or die("Not able to open $iconfilename");
$start = <<< _EOT_
import 'package:flutter/material.dart';

class IconInfo {
  final String name;
  final Icon icon;
  IconInfo({required this.name,required this.icon});
}

List iconList = [

_EOT_;

$end = <<< _EOT_
];

_EOT_;

echo $start;
while($line = fgets($handle)) {
    $line = trim($line);
    echo "    IconInfo(name:\"$line\",icon:Icon(Icons.$line)),\n";
}
fclose($handle);
echo $end;