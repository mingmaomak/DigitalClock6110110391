import 'dart:io';
import 'dart:convert';
import 'dart:async';

void main() async {
  final file = File('input.txt');
  var linelist = [];
  var inputlist = [];
  var modlist = [];
  var hour = -1; //initialize hour integer
  var min = -1; //initialize minute integer

  Stream<String> lines = file
      .openRead()
      .transform(utf8.decoder) // Decode bytes to UTF-8.
      .transform(LineSplitter()); // Convert stream to individual lines.
  try {
    await for (var line in lines) {
      linelist.add(line); //add each line as an item in "linelist" list
    }
    //print('File is now closed.');
  } catch (e) {
    print('Error: $e');
  }
  for (var l in linelist) {
    FindColon:
    for (int i = 0; i < l.length; i++) {
      if (l[i] == ':') {
        modlist.add(l.substring(0, i));
        inputlist.add(l.substring(i + 1, l.length));
        break FindColon;
      }
    }
  }

  //print('line 35');
  // print ('modlist'); for (var l in modlist) { print('$l');}
  // print ('inputlist'); for (var l in inputlist) { print('$l');}
  for (int i = 0; i < modlist.length; i++) {
    //loop through all mods
    //tempo = inputlist[i];
    // print('I passed $i');
    var mod =
        modlist[i].split(','); //get list of each modification in a modlist item
    for (var m in mod) {
      //modify each item in inputlist
      if (m[0] == 'U') {
        inputlist[i] = inputlist[i].toUpperCase();
      }
      if (m[0] == 'L') {
        var ts = m.substring(1);
        var tt = int.parse(ts);
        inputlist[i] = inputlist[i].substring(0, tt);
      }
      if (m[0] == 'S') {
        inputlist[i] = inputlist[i].replaceAll(' ', '');
      }
    }
  }

  for (var l in inputlist) {
    print('$l');
  }
}
