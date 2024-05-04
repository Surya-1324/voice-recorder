import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Voice Recorder',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _selectedOptionController = TextEditingController();
  String _selectedOption = '';
  bool _isRecording = false;
  bool _isPlaying = false;

  String audiopath= '';
late Record audioRecord;
late AudioPlayer audioPlayer;
  @override
  void initState(){
    audioPlayer=AudioPlayer();
    audioRecord=Record();
    super.initState();
  }
  void dispose(){
    audioPlayer.dispose();
    super.dispose();
  }
  Future<void>start()async{
    try{
if(await audioRecord.hasPermission()){
  await audioRecord.start();
  setState(() {
    _isRecording=true;
  });
}
    }
    catch(e){
      print("error in recording: $e");
    }
  }
  Future<void>stop()async{
    try{
String? path=  await audioRecord.stop();
setState(() {
  _isRecording = false;
  audiopath= path!;
});
    }
    catch(e){
      print("error in recording: $e");
    }
  }
  Future<void>play()async{
    try{
      Source urlSource =UrlSource(audiopath);
      await audioPlayer.play(urlSource);
    }
    catch(e){
      print("error in recording: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text('Voice Translator'),
          ),
          leading: Icon(Icons.translate_rounded),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(right: 157.0),
                child: Text("Your language",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.black),),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0,left: 20,right: 20),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.teal.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    children: [
                      TextField(
                        cursorColor: Colors.teal.withOpacity(0.1),
                        controller: _selectedOptionController,
                        decoration: InputDecoration(

                          contentPadding: EdgeInsets.only(left: 8.0),
hintText: "  Select your language",

                          hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                          border: InputBorder.none,
                          suffix:
                        PopupMenuButton<String>(
                        onSelected: (String result) {
                      setState(() {
                _selectedOption = result;
                _selectedOptionController.text = _selectedOption;
                });
                  print('Selected: $_selectedOption');
      },
                          icon: Icon(Icons.arrow_drop_down,color: Colors.white,size: 20,),
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            PopupMenuItem<String>(
              value: 'option_1',
              child: Text('Option 1'),
            ),
            PopupMenuItem<String>(
              value: 'option_2',
              child: Text('Option 2'),
            ),
            PopupMenuItem<String>(
              value: 'option_3',
              child: Text('Option 3'),
            ),
          ],
      ),

                        ),
                     style: TextStyle(color: Colors.white),
                      ),
                ]
                  ),
              ),
    ),

              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(right: 20.0,left: 20),
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
color: Colors.teal.withOpacity(0.05),
                    border: Border.all(color: Colors.teal,width: 2),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: TextField(
style: TextStyle(fontSize: 15),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "  Your Language Text",
                      hintStyle: TextStyle(color: Colors.teal.withOpacity(0.5),fontSize:20),
                      contentPadding: EdgeInsets.zero
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(right: 75.0),
                child: Text("Translated Language ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.black),),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0,left: 20,right: 20),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.teal.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                      children: [
                        TextField(
                          cursorColor: Colors.teal.withOpacity(0.1),
                          controller: _selectedOptionController,
                          decoration: InputDecoration(

                            contentPadding: EdgeInsets.only(left: 8.0),
                            hintText: "  Select your language",

                            hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                            border: InputBorder.none,
                            suffix:
                            PopupMenuButton<String>(
                              onSelected: (String result) {
                                setState(() {
                                  _selectedOption = result;
                                  _selectedOptionController.text = _selectedOption;
                                });
                                print('Selected: $_selectedOption');
                              },
                              icon: Icon(Icons.arrow_drop_down,color: Colors.white,size: 20,),
                              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                                PopupMenuItem<String>(
                                  value: 'option_1',
                                  child: Text('Option 1'),
                                ),
                                PopupMenuItem<String>(
                                  value: 'option_2',
                                  child: Text('Option 2'),
                                ),
                                PopupMenuItem<String>(
                                  value: 'option_3',
                                  child: Text('Option 3'),
                                ),
                              ],
                            ),

                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                      ]
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(right: 20.0,left: 20),
                child: Expanded(
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.teal.withOpacity(0.05),
                        border: Border.all(color: Colors.teal,width: 2),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: TextField(
                      style: TextStyle(fontSize: 15),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "  Translated text",
                          hintStyle: TextStyle(color: Colors.teal.withOpacity(0.5),fontSize:20),
                          contentPadding: EdgeInsets.zero
                      ),
                    ),
                  ),
                ),
              ),
SizedBox(height: 10,),
              if (_isRecording)
                Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.teal,
                    size: 50,
                  ),
                ),
              SizedBox(height: 30),
            ],

        ),
      ),
bottomNavigationBar:  Container(
  color: Colors.teal,
  height: 70,

  child:
  Stack(
    children: [
      Center(
        child: Positioned(
          left: 150,
          child: FloatingActionButton(
            onPressed: () {
              _isRecording ? stop() : start();
              setState(() {
                _isRecording = !_isRecording;
                _isPlaying = false;
              });
            },
            child: Icon(_isRecording ? Icons.stop_circle:Icons.mic, size: 50, color: Colors.teal),
            backgroundColor: Colors.white,
          ),
        ),
      ),
      if (!_isRecording && audiopath != null)
        Positioned(
          left: 290,bottom: 10,
          child: FloatingActionButton(
            onPressed: play,
            backgroundColor: Colors.teal,
            child: Icon(Icons.play_arrow_outlined, size: 50, color: Colors.white),
          ),
        ),
    ],
  ),

)
    )
    );
  }
}
