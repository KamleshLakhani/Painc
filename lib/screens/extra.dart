import 'package:flutter/material.dart';
import 'package:painc/Utils/Utils.dart';

class ImageDots extends StatefulWidget {
  @override
  _ImageDotsState createState() => _ImageDotsState();
}

class _ImageDotsState extends State<ImageDots>{
  double posx = 100.0;
  double posy = 100.0;

  void onTapDown(BuildContext context, TapDownDetails details) {
    print('${details.globalPosition}');
    final RenderBox box = context.findRenderObject();
    final Offset localOffset = box.globalToLocal(details.globalPosition);
    setState(() {
      posx = localOffset.dx;
      posy = localOffset.dy;
    });
    if(posx.clamp(0.0, 100.0) == posx && posy.clamp(0.0, 100.0) == posy){
      print('head');
    }
  }


  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTapDown: (TapDownDetails details) => onTapDown(context, details),
      child: new Stack(fit: StackFit.expand, children: <Widget>[
        // Hack to expand stack to fill all the space. There must be a better
        // way to do it.
        new Container(color: Colors.white,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 10.0,mainAxisSpacing: 10.0),
            itemCount: 10,
          itemBuilder: (context, index) {
            return Container(color: Utils.yellow);
          },
        ),),
        new Positioned(
          child: Utils.reddot(context,Utils.red),
          left: posx,
          top: posy,
        )
      ]),
    );
  }
}
/*class _ImageDotsState extends State<ImageDots> {
  bool head = false;
  bool heart = false;
  bool center = false;
  bool knee = false;
  bool leftleg = false;
  bool rightleg = false;
  @override
  Widget build(BuildContext context) {
    var screenwidth = Utils.getWidth(context);
    var screenheight = Utils.getHeight(context);
    return Scaffold(
      body: Container(
        height: screenheight,
        width: screenwidth,
        child: Stack(
          children: [
            Container(
                height:screenheight,
                width: screenwidth,
                child: Image.asset('assets/bodyfront.png',fit: BoxFit.cover,)),
            Positioned(top: screenheight*.09,left: screenwidth*.45,
                child: GestureDetector(onTap: (){
              setState(() {head =! head;});},
                    child: Utils.reddot(context, head == true ? Utils.red : Colors.transparent))),
            Positioned(top: screenheight*.27,left: screenwidth*.41,
                child: GestureDetector(onTap: (){
                  setState(() {heart =! heart;});},
                    child: Utils.reddot(context, heart == true ? Utils.red : Colors.transparent))),
            Positioned(top: screenheight*.42,left: screenwidth*.46, child: GestureDetector(onTap: (){setState((){center =! center;});},child:Utils.reddot(context,center == true ? Utils.red : Colors.transparent))),
            Positioned(bottom: screenheight*.28,left: screenwidth*.32, child: GestureDetector(onTap: (){setState((){knee =! knee;});},child:Utils.reddot(context,knee == true ? Utils.red : Colors.transparent))),
            Positioned(bottom: screenheight*.17,left: screenwidth*.27, child: GestureDetector(onTap: (){setState((){leftleg =! leftleg;});},child:Utils.reddot(context,leftleg == true ? Utils.red : Colors.transparent))),
            Positioned(bottom: screenheight*.17,left: screenwidth*.50, child: GestureDetector(onTap: (){setState((){rightleg =! rightleg;});},child:Utils.reddot(context,rightleg == true ? Utils.red : Colors.transparent))),
          ],
        ),
      ),
    );
  }

}*/
