import 'package:admin/lib.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// auth repository provider
final authProvider = Provider(
  ((ref) => AuthRepository()),
);
