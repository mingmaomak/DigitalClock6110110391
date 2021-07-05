import 'dart:io';
import 'dart:convert';
import 'dart:async';

void main() async 
{
  final file = File('input.txt');
  var linelist = []; //storing input as lines from input.txt
  var hour = -1; //initialize hour integer
  var min = -1; //initialize minute integer

  Stream<String> lines = file
      .openRead()
      .transform(utf8.decoder) // Decode bytes to UTF-8.
      .transform(LineSplitter()); // Convert stream to individual lines.
  try 
  {
    await for (var line in lines) 
    {
      linelist.add(line); //add each line as an item in "linelist" list
    }
  } 
  catch (e) 
  {
    print('Error: $e'); //print exception if caught
  }

  print ('linelist'); 
  for (var l in linelist) //loop for each item in "linelist"
  { 
    print('$l');

  }


}
