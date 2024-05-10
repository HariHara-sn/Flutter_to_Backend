import 'package:delete/delete/flutt.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: DataSender()));














// this below code for AlertDialog

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Login',
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Login'),
//         ),
//         body: const LoginPage(),
//       ),
//     );
//   }
// }

// class LoginPage extends StatefulWidget {
//   const LoginPage({Key? key}) : super(key: key);

//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   void _login() async {
//     print('flutter_fuck');
//     var response = await http.post(
//       Uri.parse('http://192.168.48.39:5000/login'),
//       /*I turn on the hotsport on my mobile and i turn the wifi on my lap then connect the android_wifi then i open cmd ipconfig then I copy the ipaddress 192.168.48.39 */
//       headers: <String, String>{
//         /* Here you dont need internet because it works basedon your ip not internet */
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, String>{
//         'username': _usernameController.text,
//         'password': _passwordController.text,
//       }),
//     );

//     if (response.statusCode == 200) {
//       // ignore: use_build_context_synchronously
//       showDialog(
//         context: context,
//         builder: (ctx) => AlertDialog(
//           title: const Text('Login Success'),
//           content: Text(jsonDecode(response.body)['message']),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(ctx).pop();
//               },
//               child: const Text('Okay'),
//             )
//           ],
//         ),
//       );
//     } else {
//       var message = 'An error occurred';
//       if (response.body.isNotEmpty) {
//         try {
//           message = jsonDecode(response.body)['message'];
//         } catch (e) {
//           print('Error decoding response body: $e');
//         }
//       }

//       // ignore: use_build_context_synchronously
//       showDialog(
//         context: context,
//         builder: (ctx) => AlertDialog(
//           title: const Text('Login Failed'),
//           content: Text(message),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(ctx).pop();
//               },
//               child: const Text('Okay'),
//             )
//           ],
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         children: <Widget>[
//           TextField(
//             controller: _usernameController,
//             decoration: const InputDecoration(labelText: 'Username'),
//           ),
//           TextField(
//             controller: _passwordController,
//             decoration: const InputDecoration(labelText: 'Password'),
//             obscureText: true,
//           ),
//           ElevatedButton(
//             onPressed: _login,
//             child: const Text('Login'),
//           )
//         ],
//       ),
//     );
//   }
// }
