import 'package:farmer_club/data/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userDataProvider = Provider<UserModel>(
  (ref) => UserModel(),
);
