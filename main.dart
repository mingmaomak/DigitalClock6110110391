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
  var linenum = 1; //number of line that the command is running

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
    print('Line: $linenum input command is $l');
    if (state == -1) {
      if (l[0] == 'o') {
        temp = l.substring(3); //removes "on "
        hm = temp.split(
            ' '); //split the remaining string into a list of hour and minutes
        hour = int.parse(hm[0]);
        min = int.parse(hm[1]);
        if (hour == 0 && min == 0) {
          state = 1;
          print('''[Beep]
current hour is $hour''');
        } else {
          state = 0;
          printTime(hour, min);
        }
      }
    } else if (state == 0) {
      if (l[0] == 'o') {
        temp = l.substring(3); //removes "on "
        hm = temp.split(
            ' '); //split the remaining string into a list of hour and minutes
        hour = int.parse(hm[0]);
        min = int.parse(hm[1]);
        if (hour == 0 && min == 0) {
          state = 1;
          print('''[Beep]
current hour is $hour''');
        } else {
          state = 0;
          printTime(hour, min);
        }
      }
      if (l[0] == 's') {
        state = 1;
        print('''[Beep]
current hour is $hour''');
      }
      if (l[0] == 'i') {
        print('illegal command starting with i');
      }
    } else if (state == 1) {
      if (l[0] == 'o') {
        temp = l.substring(3); //removes "on "
        hm = temp.split(
            ' '); //split the remaining string into a list of hour and minutes
        hour = int.parse(hm[0]);
        min = int.parse(hm[1]);
        if (hour == 0 && min == 0) {
          state = 1;
          print('''[Beep]
current hour is $hour''');
        } else {
          state = 0;
          printTime(hour, min);
        }
      }
      if (l[0] == 's') {
        state = 2;
        print('''[Beep]
current minute is $min''');
      }
      if (l[0] == 'i') {
        hour++;
        print('''[Beep]
current hour is $hour''');
      }
    } else if (state == 2) {
      if (l[0] == 'o') {
        temp = l.substring(3); //removes "on "
        hm = temp.split(
            ' '); //split the remaining string into a list of hour and minutes
        hour = hm[0];
        min = hm[1];
        if (hour == 0 && min == 0) {
          state = 1;
          print('''[Beep]
current hour is $hour''');
        } else {
          state = 0;
          printTime(hour, min);
        }
      }
      if (l[0] == 's') {
        state = 0;
        printTime(hour, min);
      }
      if (l[0] == 'i') {
        min++;
        print('''[Beep]
current minute is $min''');
      }
    }
    linenum++;
  }
}

void printTime(var hour, var min) {
  //printing current time out
  var a = hour.toString();
  var b = min.toString();
  if (hour < 10) {
    a = '0' + a;
  }
  if (min < 10) {
    b = '0' + b;
  }  
  print('current time is $a:$b');
}
