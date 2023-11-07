import 'package:deme/data-test/data_test.dart';

import '../models/post.dart';

class PostService {
  Future<List<Post>> getAllPost() async {
    return posts;
  }
}