import 'package:Scrap_Out/content_model.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'Login.dart';
class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}
int CurrentIndex = 0;
class _OnBoardingState extends State<OnBoarding> {
  PageController _controller = PageController(initialPage: 0);
  @override
  void initState(){
    _controller = PageController(initialPage: 0);
    super.initState();
  }
  void Dispose(){
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FadeInDown(
              child: PageView.builder(controller: _controller,onPageChanged: (int index){
                setState(() {
                  CurrentIndex = index;
                });
              },itemBuilder: (_,i){
                return FadeInUpBig(
                  child: Column(
                    children: [
                      Image.asset(contents[i].image, height: 400,),
                      Text(contents[i].title,style: const TextStyle(
                        fontSize: 44,
                        fontWeight: FontWeight.bold,
                      ),),
                      const SizedBox(
                        height: 20 ,
                      ),
                      Text( contents[i].discription,textAlign: TextAlign.center,style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.grey,
                      ),)
                    ],
                  ),
                );
              },itemCount: contents.length, ),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                List.generate(contents.length, (index) => buildDot( index, context),),
            ),
          ),
          Container(
            height: 70,
            margin: const EdgeInsets.all(20),
            width: double.infinity,
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),

              ),
              child: Text(CurrentIndex == contents.length-1 ?"Continue": "Next",style: const TextStyle
                (
                fontSize: 25,
                color: Colors.white
              ),),
              onPressed: () {
                if(CurrentIndex == contents.length -1)
                  {
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>HomePage()));
                  }
                _controller.nextPage(duration: const Duration(microseconds: 1000), curve: Curves.easeInOutBack);
              },
            ),
          ),
        ],
      ),
    );
  }
}

Container buildDot(int index, BuildContext context){return
Container(
  height: 10,
  width: CurrentIndex == index ? 30:10,
  margin: const EdgeInsets.only(right: 10),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    color: Colors.black,
  ),
);}
