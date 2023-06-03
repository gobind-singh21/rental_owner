import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rental_owner/global/current_owner_data.dart';
import 'package:rental_owner/global/dimensions.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rental_owner/screens/login_screen.dart';
import 'package:rental_owner/screens/profile_screen.dart';
import 'package:rental_owner/utils/auth.dart';
import 'package:rental_owner/global/global.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String name = OwnerData.name;
  // String profileImageURL = OwnerData.profileImageURL;
  // String? firstName;

  asyncMethod() async {
    await OwnerData.setOwnerData();
  }

  @override
  void initState() {
    super.initState();
    profileImagePath =
        'owners/${currentFirebaseUser!.uid}/profile_images/profile.jpg';
    if (!OwnerData.ownerDataSet) {
      asyncMethod();
    }
    // OwnerData.setOwnerData();
    // int index = name.indexOf(' ');
    // if (index > 0) {
    //   firstName = name.substring(0, name.indexOf(' '));
    // } else {
    //   firstName = name;
    // }
    // profileImageURL = OwnerData.profileImageURL;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Auth().signOut();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            ModalRoute.withName('name'),
          );
        },
        backgroundColor: Colors.blueAccent.shade100,
        child: const Icon(Icons.logout),
      ),
      body: Column(
        children: [
          Container(
            height: Dimensions.screenHeight / 2.5,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50)),
              gradient: LinearGradient(
                colors: [
                  Colors.blue,
                  Color.fromARGB(255, 0, 64, 255),
                ],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 60,
                left: 40,
                right: 40,
                bottom: 60,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      FutureBuilder(
                        future: asyncMethod(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Text(
                              "Hello!",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return const AlertDialog(
                              title: Text("Error occured"),
                            );
                          }
                          return Text(
                            "Hello ${OwnerData.name}!",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          );
                        },
                      ),
                      const Expanded(child: SizedBox()),
                      InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileScreen(),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: FutureBuilder<void>(
                            future: asyncMethod(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Icon(
                                  Icons.account_box_rounded,
                                  color: Colors.white,
                                );
                              } else if (snapshot.hasError) {
                                Fluttertoast.showToast(
                                    msg: '${snapshot.error}');
                                return const Icon(
                                    Icons.network_locked_outlined);
                              }
                              return Image.network(
                                OwnerData.profileImageURL,
                                height: Dimensions.screenHeight / 15,
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: Dimensions.screenHeight / 10,
                  ),
                  const Text(
                    "Today's revenue",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  const Text(
                    "\u{20B9}",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 40.0,
              left: 20,
              right: 20,
              bottom: 10,
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  height: Dimensions.screenHeight / 5,
                  width: Dimensions.screenHeight / 5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              Colors.blue,
                              Colors.blue.shade200,
                            ],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                          ),
                        ),
                        child: const CircleAvatar(
                          radius: 22,
                          backgroundColor: Colors.transparent,
                          child: Icon(
                            Icons.people_rounded,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      const Row(
                        children: [
                          Text(
                            "Customers",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(child: SizedBox()),
                          Icon(Icons.chevron_right_rounded)
                        ],
                      ),
                    ],
                  ),
                ),
                const Expanded(child: SizedBox()),
                Container(
                  padding: const EdgeInsets.all(20),
                  height: Dimensions.screenHeight / 5,
                  width: Dimensions.screenHeight / 5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              const Color.fromARGB(255, 255, 230, 0),
                              Colors.yellow.shade100,
                            ],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                          ),
                        ),
                        child: const CircleAvatar(
                          radius: 23,
                          backgroundColor: Colors.transparent,
                          child: Icon(
                            FontAwesomeIcons.box,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      const Row(
                        children: [
                          Text(
                            "Products",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(child: SizedBox()),
                          Icon(Icons.chevron_right_rounded)
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
              left: 20,
              right: 20,
              bottom: 10,
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  height: Dimensions.screenHeight / 5,
                  width: Dimensions.screenHeight / 5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              Colors.redAccent,
                              Color.fromARGB(255, 255, 205, 200),
                            ],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                          ),
                        ),
                        child: const CircleAvatar(
                          radius: 22,
                          backgroundColor: Colors.transparent,
                          child: Icon(
                            Icons.insert_chart_rounded,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      const Row(
                        children: [
                          Text(
                            "Statistics",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(child: SizedBox()),
                          Icon(Icons.chevron_right_rounded)
                        ],
                      ),
                    ],
                  ),
                ),
                const Expanded(child: SizedBox()),
                Container(
                  padding: const EdgeInsets.all(20),
                  height: Dimensions.screenHeight / 5,
                  width: Dimensions.screenHeight / 5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              Colors.green,
                              Colors.green.shade100,
                            ],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                          ),
                        ),
                        child: const CircleAvatar(
                          radius: 22,
                          backgroundColor: Colors.transparent,
                          child: Icon(
                            Icons.currency_rupee_rounded,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      const Row(
                        children: [
                          Text(
                            "Net revenue",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(child: SizedBox()),
                          Icon(Icons.chevron_right_rounded)
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
