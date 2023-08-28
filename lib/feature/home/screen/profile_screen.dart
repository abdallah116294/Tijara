import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tijara/feature/auth/screens/login_screen.dart';
import 'package:tijara/feature/inner_screens/loading_manager.dart';
import 'package:tijara/feature/inner_screens/view_recently_screen.dart';
import 'package:tijara/feature/inner_screens/wishlist_screen.dart';
import 'package:tijara/models/user_model.dart';
import 'package:tijara/provider/user_provider.dart';
import 'package:tijara/services/assets_manager.dart';
import 'package:tijara/widgets/subtitle.dart';
import 'package:tijara/widgets/title_text.dart';
import '../../../provider/theme_provider.dart';
import '../../../services/app_methods.dart';
import '../../../widgets/app_bar_title_widget.dart';
import '../../inner_screens/oreder/order_scree.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with AutomaticKeepAliveClientMixin {
  AppMethods appMetods = AppMethods();
  User? user = FirebaseAuth.instance.currentUser;
  bool isloading = true;
  UserModel? userModel;
  final auth = FirebaseAuth.instance;
  @override
  bool get wantKeepAlive => true;
  Future<void> fetchUserInfo() async {
    if (user == null) {
      setState(() {
        isloading = false;
      });
      return;
    }
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      userModel = await userProvider.fetchUserInfo();
    } on FirebaseException catch (error) {
      appMetods.dailogAlert(
          context: context,
          imagePathe: AssetsManager.warrning,
          title: "An Error hase been occured ${error.message}",
          fun: () {
            Navigator.pop(context);
          });
    } finally {
      setState(() {
        isloading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final themeprovider = Provider.of<ThemeProvider>(context, listen: true);
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,

          leading: Shimmer.fromColors(
            baseColor: Colors.red,
            highlightColor: Colors.purple,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                IconlyLight.bag2,
                size: 30,
              ),
            ),
          ),
          // leading:const Icon(Icons.shopping_cart,size: 40,color: Colors.grey,),
          title: AppBarNameTitle(
            title: 'Tijara',
          ),
        ),
        body: LoadingManager(
          isloadinge: isloading,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                    visible: user == null ? true : false,
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: TitlesTextWidget(
                        label: 'Pleas login to have ultimate access',
                      ),
                    )),
                const SizedBox(
                  height: 20,
                ),
                userModel == null
                    ? const SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Row(
                          children: [
                            Container(
                              height: 90,
                              width: 90,
                              decoration: BoxDecoration(
                                  image:  DecorationImage(
                                      image: NetworkImage(
                                      userModel!.userImage    )),
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).cardColor,
                                  border: Border.all(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                      width: 3)),
                            ),
                            const Spacer(
                              flex: 2,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TitlesTextWidget(label: userModel!.userName),
                                const SizedBox(
                                  height: 7,
                                ),
                                SubtitleTextWidget(
                                  label: userModel!.userEmail,
                                  fontSize: 14,
                                  
                                )
                              ],
                            ),
                            const Spacer(
                              flex: 6,
                            ),
                          ],
                        ),
                      ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TitlesTextWidget(label: 'General'),
                      user == null
                          ? const SizedBox.shrink()
                          : ProfileAction(
                              function: () {
                                Navigator.pushNamed(
                                    context, OrdersScreenFree.routeName);
                              },
                              assetsManager: AssetsManager.order,
                              icondata: IconlyLight.arrowRight2,
                              title: "All order",
                            ),
                      const Divider(),
                      user == null
                          ? const SizedBox.shrink()
                          : ProfileAction(
                              function: () {
                                Navigator.pushNamed(
                                    context, WishlistScreen.routName);
                                //Navigator.push(context, MaterialPageRoute(builder: (context)=>WishLlistScreen()));
                              },
                              assetsManager: AssetsManager.wishlist,
                              icondata: IconlyLight.arrowRight2,
                              title: "WishList",
                            ),
                      const Divider(),
                      ProfileAction(
                        function: () {
                          Navigator.pushNamed(
                              context, ViewRecentlyScrenn.routName);
                        },
                        assetsManager: AssetsManager.recent,
                        icondata: IconlyLight.arrowRight2,
                        title: "View recently",
                      ),
                      const Divider(),
                      ProfileAction(
                        function: () {},
                        assetsManager: AssetsManager.address,
                        icondata: IconlyLight.arrowRight2,
                        title: "Address",
                      )
                    ],
                  ),
                ),
                const Divider(),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TitlesTextWidget(label: 'Settings'),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        AssetsManager.theme,
                        height: 40,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        themeprovider.getIsDarkTheme
                            ? "Light mode"
                            : "dark mode",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Switch(
                          value: themeprovider.getIsDarkTheme,
                          onChanged: (value) {
                            themeprovider.setDarkTheme(themeValue: value);
                          }),
                    ],
                  ),
                ),
                const Divider(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TitlesTextWidget(label: 'Others'),
                      ProfileAction(
                        function: () {},
                        assetsManager: AssetsManager.privacy,
                        icondata: IconlyLight.arrowRight2,
                        title: "Privacy",
                      ),
                    ],
                  ),
                ),
                Center(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    onPressed: () async {
                      if (user == null) {
                        Navigator.popAndPushNamed(
                            context, LoginScreen.routeName);
                      } else {
                        appMetods.dailogAlert(
                            context: context,
                            title: "sure",
                            imagePathe: AssetsManager.warrning,
                            fun: () {
                              auth.signOut();
                              Navigator.pushNamed(
                                  context, LoginScreen.routeName);
                            });
                      }
                    },
                    icon: Icon(
                        user == null ? IconlyBold.login : IconlyBold.logout),
                    label: Text(user == null ? "Login" : "Logout"),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  // @override
  // // TODO: implement wantKeepAlive
  // bool get wantKeepAlive => throw UnimplementedError();
}

class ProfileAction extends StatelessWidget {
  ProfileAction(
      {super.key,
      required this.assetsManager,
      required this.title,
      required this.icondata,
      required this.function});
  String assetsManager;
  String title;
  IconData icondata;
  Function function;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        function();
      },
      leading: Image.asset(
        assetsManager,
        height: 30,
      ),
      title: SubtitleTextWidget(label: title),
      trailing: Icon(icondata),
    );
  }
}
