import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:salesafari/presentation/aboutus.dart';
import 'package:salesafari/presentation/admin/screens/admin_home.dart';
import 'package:salesafari/presentation/admin/screens/adminprofile/adminprofile.dart';
import 'package:salesafari/presentation/authentication/login.dart';
import 'package:salesafari/presentation/authentication/cust_register.dart';
import 'package:salesafari/core/colors/Colors.dart';
import 'package:salesafari/presentation/authentication/seller_register.dart';
import 'package:salesafari/presentation/chat/chat_list.dart';
import 'package:salesafari/presentation/customer/screens/cust_botton_nav.dart';
import 'package:salesafari/presentation/customer/screens/feedback/feedback_form.dart';
import 'package:salesafari/presentation/customer/screens/user%20profile/customer_profile.dart';
import 'package:salesafari/presentation/customer/screens/user%20profile/edit_profile/edit_customer_profile.dart';
import 'package:salesafari/presentation/feedback.dart';
import 'package:salesafari/presentation/seller/screens/seller_home.dart';
import 'package:salesafari/presentation/seller/screens/seller_orders/seller_pending_orders.dart';
import 'package:salesafari/presentation/seller/screens/seller_products/widgets/addproduct.dart';
import 'package:salesafari/presentation/seller/screens/seller_products/widgets/seller_product_view.dart';
import 'package:salesafari/presentation/seller/screens/seller_profile/edit_seller_profile/edit_seller_profile.dart';
import 'package:salesafari/presentation/seller/screens/seller_profile/seller_prof.dart';
import 'package:salesafari/presentation/testdetails.dart';
import 'package:salesafari/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
      title: 'DirecTrade',
      theme: ThemeData(
        primarySwatch: primaryWhite,
      ),
      home: ScreenSplash(),
      routes: {
        'custreg':(context) => CustRegisterPage(),
        'sellreg' :(context) => const SellerRegisterPage(),
        'login':(context) => LoginPage(),
        'home':(context) => const HomePage(),
        'custprofile':(context) =>  const CustProfilePage(),
        'chatlistpage':(context) =>  ChatListPage(),
        'adminhome':(context) => const AdminHomePage(),
        'sellerhome':(context) => const SellerHomePage(),
        'sellerprofile':(context) => const SellerProfilePage(),
        'editcust':(context) => CustEdit(),
        'editseller':(context) => const EditSeller(),
        'aboutus':(context) =>   AboutPage(),
        'adminprofile':(context) => const AdminProfilePage(),
        'test':(context)=> DataFetch(),
        'addProdForm':(context) => AddProductForm(),
        'feedback': (context) => FeedbackBox(),
      },
      debugShowCheckedModeBanner: false,// This trailing comma makes auto-formatting nicer for build methods.
    )
    );
}
