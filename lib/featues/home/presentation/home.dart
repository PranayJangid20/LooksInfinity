import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lookinfinity/common/app_constant.dart';
import 'package:lookinfinity/common/user.dart';
import 'package:lookinfinity/featues/account/presentation/my_acount_screen.dart';
import 'package:lookinfinity/featues/account/presentation/my_wishlist_screen.dart';
import 'package:lookinfinity/featues/authentication/presentation/login_screen.dart';
import 'package:lookinfinity/featues/home/widget/gems.dart';
import 'package:lookinfinity/featues/home/widget/highlighted.dart';
import 'package:lookinfinity/featues/home/widget/looking_for.dart';
import 'package:lookinfinity/featues/home/widget/treand_men.dart';
import 'package:lookinfinity/featues/home/widget/treand_women.dart';
import 'package:lookinfinity/uttils/logic_data.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var subs;

  bool intCon = false;
  @override
  initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    subs = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile) {
        // Connected
        intCon = true;
        // connected to a mobile network.
      } else if (result == ConnectivityResult.wifi) {
        // wifi Connected
        intCon = true;
        // connected to a wifi network.
      }
    });
  }

  void dispose() {
    // TODO: implement dispose
    super.dispose();
    subs.cancel();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        authUser = user;
        // User is currently signed out!
        authState = false;
      } else {
        // User is currently signed in!

        authUser = user;

        infoUser.Reg = true;
        infoUser.Reg = false;

        authState = true;
      }
    });
    return Scaffold(
        backgroundColor: AppConstant.BACKGROUND_COLOR,
        appBar: AppBar(
          elevation: 5,
          toolbarHeight: 50,
          backgroundColor: AppConstant.APPBAR_BACKGROUND_COLOR,
          leading: GestureDetector(
              onTap: () {
                if (authUser != null) {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MyAcount()));
                } else {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginScreen()));
                }
              },
              child: Image.asset(
                "Assets/images/menuSW.png",
                width: 0,
              )),
          title: Image.asset(
            'Assets/images/Infi.png',
            height: 40,
          ),
          centerTitle: true,
          /*leading: Icon(
            Icons.sort,
            size: MediaQuery.of(context).size.width/12,
            color: Colors.black,
          ),*/
          actions: [
            GestureDetector(
                onTap: () {
                  if (authUser != null) {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyWishList()));
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset(
                    'Assets/images/favBagSW.png',
                  ),
                )),
          ],
        ),
        body: FutureBuilder(
            future: FirebaseFirestore.instance.collection("Store").doc("Front").get(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              Map<String, dynamic>? home;
              try {
                home = snapshot.data.data() as Map<String, dynamic>;
                saleMap = home["saleAct"];
                print("//////////////////////// 142");
                print(saleMap);
                taC = home['_TAC'];
                careNum = home['_MNumber'];
                careMail = home['_MCare'];
              } catch (e) {
                print(e);
              }
              return snapshot.hasData && home != null
                  ? SingleChildScrollView(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              checkGender(home!['h1']['onClick'], context);
                            },
                            child: Image.network(
                              home['h1']['img'].toString(),
                              fit: BoxFit.fitWidth,
                              width: double.infinity,
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 50,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
                                child: TextField(
                                  textInputAction: TextInputAction.search,
                                  onSubmitted: (qur) => {
                                    print(qur),
                                    checkGender(qur, context),

                                    /*Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => LProd(
                                  qur: text,
                                )))*/
                                  },
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.search_rounded),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black, width: 1.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black, width: 1.0),
                                    ),
                                    hintText: "Search",
                                  ),
                                  style: GoogleFonts.robotoSlab(
                                    color: Colors.black87,
                                    fontSize: 20,
                                  ),
                                  textAlign: TextAlign.justify,
                                  textAlignVertical: TextAlignVertical.bottom,
                                ),
                              )
                              /*Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Search For Cloth",style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),
                          Image.asset("Assets/images/search50.png",width: 100,),
                        ],
                      )*/
                              ,
                            ),
                          ),
                          Looking(),

                          Highlighted(
                            imageOne: home['h2']['img'].toString(),
                            searchOne: home['h2']['onClick'].toString(),
                            imageTwo: home['h3']['img'].toString(),
                            searchTwo: home['h3']['onClick'].toString(),
                          ),
                          // Highlited(image: '',
               //           imaget: ''),
                     //Catg(),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Gems(
                              exl: home['excl'],
                            ),
                          ),
                          Highlighted(
                            imageOne: home['h4']['img'].toString(),
                            searchOne: home['h4']['onClick'].toString(),
                            imageTwo: home['h5']['img'].toString(),
                            searchTwo: home['h5']['onClick'].toString(),
                          ),
                          TreandMen(
                      trdMen: home['trdMen'],
                          ),
                     const SizedBox(height: 10,),
                     Highlighted(
                            imageOne: home['h6']['img'].toString(),
                            searchOne: home['h6']['onClick'].toString(),
                            imageTwo: home['h7']['img'].toString(),
                            searchTwo: home['h7']['onClick'].toString(),
                          ),
                          TreandWomen(
                     trdWmn: home['trdWmn'],
                          ),

                  Looking(),
                          Container(
                            height: 20,
                            width: double.infinity,
                            color: AppConstant.BOTTOM_BAR_COLOR,
                          )
                        ],
                      ),
                    )
                  : Center(
                      child: Image.asset(
                      'Assets/images/Infi.png',
                      height: 40,
                    ));
            }));
  }
}
