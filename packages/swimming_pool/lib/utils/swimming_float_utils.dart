import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swimming_pool/models/coordinates.dart';
import 'package:swimming_pool/models/swimming_float.dart';

List<SwimmingFloat> listSwimmingFloat = <SwimmingFloat>[
  SwimmingFloat(imagePath: 'hippocampus.png', width: 390.h, height: 192.h),
  SwimmingFloat(imagePath: 'swan.png', width: 368.h, height: 240.h),
  SwimmingFloat(imagePath: 'water-ball-1.png', width: 280.h, height: 166.h),
  SwimmingFloat(imagePath: 'flamingoes.png', width: 368.h, height: 190.h),
  SwimmingFloat(imagePath: 'water-ball-2.png', width: 280.h, height: 166.h),
  SwimmingFloat(imagePath: 'horse.png', width: 368.h, height: 202.h),
  SwimmingFloat(imagePath: 'giraffe.png', width: 368.h, height: 194.h),
];

List<Coordinates> listCoordinates = <Coordinates>[
  Coordinates(x: 1920.w, y: 392.h, level: 2),
  Coordinates(x: 1920.w, y: 487.h, level: 3),
  Coordinates(x: 1920.w, y: 637.h, level: 4),
];

List<Coordinates> listCoordinatesFubo = <Coordinates>[
  Coordinates(x: 0.w, y: 281.h, level: 2),
  Coordinates(x: 0.w, y: 385.h, level: 3),
  Coordinates(x: 0.w, y: 525.h, level: 4),
];
