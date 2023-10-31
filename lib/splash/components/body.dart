import 'package:deme/log-pages/log-up/log_up.dart';
import 'package:deme/provider/change_splash-screenn.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../constantes.dart';
import '../../utils.dart';
import '../../widgets/next_button.dart';
import 'splash_content.dart';
class Body extends StatelessWidget{
  int currentPage = 0;

  List<Map<String, String>> splashData = [
    {
      "message": "\"On vit de ce que l’on obtient. On construit sa vie sur ce que l’on donne\" - Winston Churchill",
      "image":"assets/images/splash_1.png"
    },
    {
      "message": "\"Vaincre la pauvreté ce n'est pas un geste de charité, c'est un acte de justice.\"-Nelson Mandela",
      "image":"assets/images/splash_2.png"
    },
    {
      "message": "\"La pauvreté n'est pas une honte, mais la plus grande honte est de vivre en toute abondance tout en voyant quelqu'un dans le besoin et de ne pas lui tendre la main.\"-Mufti Ismail Menk",
      "image":"assets/images/splash_3.png"
    }
  ];

  @override
  Widget build(BuildContext context) {
    final indexSplash = Provider.of<ChangeSplashScreen>(context);
    return SafeArea(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: Container(
            key: ValueKey<int>(indexSplash.splashIndex),
            width: double.infinity,
            decoration: BoxDecoration (
              color: Colors.white,
              image: DecorationImage (
                fit: BoxFit.cover,
                image: AssetImage (
                  splashData[indexSplash.splashIndex]['image']!,
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 220),
                    padding: const EdgeInsets.fromLTRB(8.5, 44, 8.5, 50),
                    width: double.infinity,
                    decoration: BoxDecoration (
                      color: const Color(0xcc212121),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                          splashData[indexSplash.splashIndex]['message']!,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          )
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      splashData.length, (index)
                        {
                          return AnimatedContainer(
                            width: indexSplash.splashIndex == index ? 28: 14,
                            height: 14,
                            duration: kAnimationDuration,
                            margin: const EdgeInsets.only(right: 5),
                            decoration: BoxDecoration(
                              color: indexSplash.splashIndex == index ? kPrimaryColor: Colors.white,
                              borderRadius:BorderRadius.circular(20),
                            ),
                          );
                        }
                  ),
                ),
                const SizedBox(height: 20,),
                NextButton(
                    borderRadius: 5,
                    padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                    text: 'Continue',
                    press:(indexSplash.splashIndex == 2)?()=>Navigator.pushNamedAndRemoveUntil(
                        context, LogUp.routeName, (route) => false):()=>indexSplash.incrementIndex()
                ),
                const SizedBox(height: 30,)
              ],
            )
          ),
        ),
    );
  }

  AnimatedContainer buildDot({required int index})
  {
    return AnimatedContainer(
      width: currentPage == index ? 28: 14,
      height: 14,
      duration: kAnimationDuration,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor: Colors.white,
        borderRadius:BorderRadius.circular(20),
      ),
    );
  }
}



