import 'dart:io';
import 'dart:convert';
import 'dart:async';

void main() async {
  final file = File('input.txt');
  var linelist = []; //storing input as lines from input.txt
  var hour = 0; //initialize hour integer
  var min = 0; //initialize minute integer
  var temp = ''; //temp string
  var hm = []; //hour and minute in a single list
  var state = -1;

  Stream<String> lines = file
      .openRead()
      .transform(utf8.decoder) // Decode bytes to UTF-8.
      .transform(LineSplitter()); // Convert stream to individual lines.
  try {
    await for (var line in lines) {
      linelist.add(line); //add each line as an item in "linelist" list
    }
  } catch (e) {
    print('Error: $e'); //print exception if caught
  }

  print('linelist');
  for (var l in linelist) //loop for each item in "linelist"
  {
    print('input command is $l');
    if (state == -1) {
      if (l[0] == 'o') {
        temp = l.substring(3); //removes "on "
        hm = temp.split(
            ' '); //split the remaining string into a list of hour and minutes
        hour = hm[0];
        min = hm[1];
        if (hour == 0 && min == 0) {
          state = 1;
          print('''Beep
          current hour is $hour''');
        } else {
          state = 0;
          print('current time is $hour:$min');
        }
      }
    }
    if (state == 0) {
      if (l[0] == 'o') {
        temp = l.substring(3); //removes "on "
        hm = temp.split(
            ' '); //split the remaining string into a list of hour and minutes
        hour = hm[0];
        min = hm[1];
        if (hour == 0 && min == 0) {
          state = 1;
          print('''Beep
          current hour is $hour''');
        } else {
          state = 0;
          print('current time is $hour:$min');
        }
      }
      if (l[0] == 's') {
        state = 1;
        print('''Beep
        current hour is $hour''');
      }
      if (l[0] == 'i') {
        print('illegal command starting with i');
      }
    }
  }
}
