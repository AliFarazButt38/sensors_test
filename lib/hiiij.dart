// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:sensors_plus/sensors_plus.dart';
//
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   SystemChrome.setPreferredOrientations(
//     [
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ],
//   );
//
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Sensors Demo',
//       theme: ThemeData(
//         useMaterial3: true,
//         colorSchemeSeed: const Color(0x9f4376f8),
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, this.title}) : super(key: key);
//
//   final String? title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   static const Duration _ignoreDuration = Duration(milliseconds: 20);
//
//   UserAccelerometerEvent? _userAccelerometerEvent;
//   List<double> _accelerationHistory = [];
//
//   final _streamSubscriptions = <StreamSubscription<dynamic>>[];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Sensors Plus Example'),
//         elevation: 4,
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Table(
//               columnWidths: const {
//                 0: FlexColumnWidth(4),
//                 4: FlexColumnWidth(2),
//               },
//               children: [
//                 const TableRow(
//                   children: [
//                     SizedBox.shrink(),
//                     Text('X'),
//                     Text('Y'),
//                     Text('Z'),
//                   ],
//                 ),
//                 TableRow(
//                   children: [
//                     const Padding(
//                       padding: EdgeInsets.symmetric(vertical: 8.0),
//                       child: Text('UserAccelerometer'),
//                     ),
//                     Text(_userAccelerometerEvent?.x.toStringAsFixed(1) ?? '?'),
//                     Text(_userAccelerometerEvent?.y.toStringAsFixed(1) ?? '?'),
//                     Text(_userAccelerometerEvent?.z.toStringAsFixed(1) ?? '?'),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     for (final subscription in _streamSubscriptions) {
//       subscription.cancel();
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _streamSubscriptions.add(
//       userAccelerometerEventStream().listen(
//             (UserAccelerometerEvent event) {
//           final now = DateTime.now();
//           final double x = event.x;
//           final double y = event.y;
//           final double z = event.z;
//
//           // Calculate the total acceleration
//           final double acceleration = x.abs() + y.abs() + z.abs();
//
//           // Add the current acceleration to the history
//           _accelerationHistory.add(acceleration);
//
//           // Consider only the recent history (e.g., last 10 samples)
//           if (_accelerationHistory.length > 10) {
//             _accelerationHistory.removeAt(0);
//           }
//
//           // Calculate the average acceleration over the history
//           final double averageAcceleration =
//               _accelerationHistory.reduce((a, b) => a + b) /
//                   _accelerationHistory.length;
//
//           // Set the fall threshold as a multiple of the average acceleration
//           final double fallThreshold = averageAcceleration * 2.5;
//
//           // Check if the total acceleration exceeds the threshold
//           if (acceleration > fallThreshold) {
//             print("Fall detected!");
//             // Fall detected
//             // showDialog(
//             //   context: context,
//             //   builder: (BuildContext context) {
//             //     return AlertDialog(
//             //       title: Text("Fall Detected"),
//             //       content: Text("Are you okay?"),
//             //       actions: <Widget>[
//             //         TextButton(
//             //           onPressed: () {
//             //             Navigator.of(context).pop();
//             //           },
//             //           child: Text('Yes'),
//             //         ),
//             //         TextButton(
//             //           onPressed: () {
//             //             Navigator.of(context).pop();
//             //           },
//             //           child: Text('No'),
//             //         ),
//             //       ],
//             //     );
//             //   },
//             // );
//           }
//
//           setState(() {
//             _userAccelerometerEvent = event;
//           });
//         },
//         onError: (e) {
//           showDialog(
//               context: context,
//               builder: (context) {
//                 return const AlertDialog(
//                   title: Text("Sensor Not Found"),
//                   content: Text(
//                       "It seems that your device doesn't support User Accelerometer Sensor"),
//                 );
//               });
//         },
//         cancelOnError: true,
//       ),
//     );
//   }
// }
//
//
