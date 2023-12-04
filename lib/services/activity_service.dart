import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deme/models/activity.dart';
import 'package:deme/models/assignment.dart';
import 'package:deme/services/cause_service.dart';
import 'package:deme/services/organization_service.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';
import '../models/cause.dart';
import '../models/organization.dart';
import '../models/post.dart';

class ActivityService {

  OrganizationService organizationService = OrganizationService();
  CauseService causeService = CauseService();

  static const baseServiceActivityUrl = "$baseUrl/service-activity";
  static const activityCollectionName = "activities";
  static const postCollectionName = "posts";
  static const assignmentCollectionName = "assignments";
  static const organizationCollectionName = "organizations";

  Future<Assignment> getAssignmentById(String assignmentId) async {
    try{
      final response = await http.get(Uri.parse(
          '$baseServiceActivityUrl/$assignmentCollectionName/$assignmentId'
      ));

      if(response.statusCode == 200) {
        final responseDate = json.decode(utf8.decode(response.bodyBytes));
        String organizationId = responseDate["organizationId"];
        String causeId = responseDate["causeId"];
        final organization = await organizationService.getOrganizationById(organizationId);
        final cause = await causeService.getCauseById(causeId);

        return Assignment.fromJson(responseDate, organization, cause);

      }
      // Gestion de l'exception
      Map<String, dynamic> errorMessage = {};
      var errorResponse = json.decode(utf8.decode(response.bodyBytes));

      if (errorResponse.containsKey('message')) {
        errorMessage['message'] = errorResponse['message'];
      }
      if (errorResponse.containsKey('error')) {
        errorMessage['error'] = errorResponse['error'];
      }
      if (errorResponse.containsKey('status')) {
        errorMessage['status'] = errorResponse['status'];
      }
      if (errorResponse.containsKey('path')) {
        errorMessage['path'] = errorResponse['path'];
      }
      if (errorResponse.containsKey('timestamp')) {
        errorMessage['timestamp'] = errorResponse['timestamp'];
      }

      print("Error get-ID-assignment: $errorMessage");
      print("Error: $errorMessage");
      throw Exception(errorResponse);
    }catch(e) {
      throw Exception(e);
    }
  }

  Future<Activity> getActivityById(String activityId) async{
    try{
      final response = await http.get(Uri.parse(
          '$baseServiceActivityUrl/$activityCollectionName/$activityId'
      ));
      if(response.statusCode == 200) {
        final responseDate = json.decode(utf8.decode(response.bodyBytes));
        String assignmentId = responseDate["assignmentId"];
        final assignment = await getAssignmentById(assignmentId);

        return Activity.fromJson(responseDate, assignment);
      }

      // Gestion de l'exception
      Map<String, dynamic> errorMessage = {};
      var errorResponse = json.decode(utf8.decode(response.bodyBytes));

      if (errorResponse.containsKey('message')) {
        errorMessage['message'] = errorResponse['message'];
      }
      if (errorResponse.containsKey('error')) {
        errorMessage['error'] = errorResponse['error'];
      }
      if (errorResponse.containsKey('status')) {
        errorMessage['status'] = errorResponse['status'];
      }
      if (errorResponse.containsKey('path')) {
        errorMessage['path'] = errorResponse['path'];
      }
      if (errorResponse.containsKey('timestamp')) {
        errorMessage['timestamp'] = errorResponse['timestamp'];
      }

      print("Error get-ID-activity: $errorMessage");
      print("Error: $errorMessage");
      throw Exception(errorResponse);
    }catch(e) {
      throw Exception(e);
    }
  }

  Future<List<Post>> getAllPost() async {
    try{
      final response = await http.get(Uri.parse('$baseServiceActivityUrl/$postCollectionName/'));
      if(response.statusCode == 200){
        final responseData = json.decode(utf8.decode(response.bodyBytes));
        List<Post> posts = [];
        for(var post in responseData) {
          if(post["activityId"] != null && post["activityId"] !='') {
            final activity = await getActivityById(post["activityId"]);
            posts.add(Post.fromJson(post, activity));
          }
          else{
            continue;
          }
        }
        return posts;
      }
      // Gestion de l'exception
      Map<String, dynamic> errorMessage = {};
      var errorResponse = json.decode(utf8.decode(response.bodyBytes));

      if (errorResponse.containsKey('message')) {
        errorMessage['message'] = errorResponse['message'];
      }
      if (errorResponse.containsKey('error')) {
        errorMessage['error'] = errorResponse['error'];
      }
      if (errorResponse.containsKey('status')) {
        errorMessage['status'] = errorResponse['status'];
      }
      if (errorResponse.containsKey('path')) {
        errorMessage['path'] = errorResponse['path'];
      }
      if (errorResponse.containsKey('timestamp')) {
        errorMessage['timestamp'] = errorResponse['timestamp'];
      }

      throw Exception(errorResponse);
    }catch(e) {
      throw Exception(e);
    }
  }

  Future<List<Post>> getAllPostsForOrganization(String organizationId) async {
    try{
      final response = await http.get(Uri.parse('$baseServiceActivityUrl/$postCollectionName/$organizationCollectionName/$organizationId/$postCollectionName'));
      if(response.statusCode == 200){
        final responseData = json.decode(utf8.decode(response.bodyBytes));
        List<Post> posts = [];
        for(var post in responseData) {
          if(post["activityId"] != null && post["activityId"] !='') {
            final activity = await getActivityById(post["activityId"]);
            posts.add(Post.fromJson(post, activity));
          }
          else{
            continue;
          }
        }
        print(posts);
        return posts;
      }
      // Gestion de l'exception
      Map<String, dynamic> errorMessage = {};
      var errorResponse = json.decode(utf8.decode(response.bodyBytes));

      if (errorResponse.containsKey('message')) {
        errorMessage['message'] = errorResponse['message'];
      }
      if (errorResponse.containsKey('error')) {
        errorMessage['error'] = errorResponse['error'];
      }
      if (errorResponse.containsKey('status')) {
        errorMessage['status'] = errorResponse['status'];
      }
      if (errorResponse.containsKey('path')) {
        errorMessage['path'] = errorResponse['path'];
      }
      if (errorResponse.containsKey('timestamp')) {
        errorMessage['timestamp'] = errorResponse['timestamp'];
      }

      throw Exception(errorResponse);
    }catch(e) {
      throw Exception(e);
    }
  }

  Future<Post> getPostById(String postId) async{
    try{
      final response = await http.get(Uri.parse('$baseServiceActivityUrl/$postCollectionName/$postId'));

      if(response.statusCode == 200) {
        final responseData = json.decode(utf8.decode(response.bodyBytes));
        String activityId = responseData["activityId"];
        final activity = await getActivityById(activityId);

        return Post.fromJson(responseData, activity);
      }

      // Gestion de l'exception
      Map<String, dynamic> errorMessage = {};
      var errorResponse = json.decode(utf8.decode(response.bodyBytes));

      if (errorResponse.containsKey('message')) {
        errorMessage['message'] = errorResponse['message'];
      }
      if (errorResponse.containsKey('error')) {
        errorMessage['error'] = errorResponse['error'];
      }
      if (errorResponse.containsKey('status')) {
        errorMessage['status'] = errorResponse['status'];
      }
      if (errorResponse.containsKey('path')) {
        errorMessage['path'] = errorResponse['path'];
      }
      if (errorResponse.containsKey('timestamp')) {
        errorMessage['timestamp'] = errorResponse['timestamp'];
      }

      print("Error get-ID-posts: $errorMessage");
      print("Error: $errorMessage");
      throw Exception(errorResponse);
    }catch(e){
      throw Exception(e);
    }
  }

  /*Future<List<Post>> getSnapshotPost() async{
    QuerySnapshot querySnapshot = await db.collection('posts').get();
    List<Post> posts = [];
    for (var docSnapshot in querySnapshot.docs) {
      final postMap = docSnapshot as Map<String, dynamic>;
      Post post = await fromSnapshot(postMap);
      posts.add(post);
    }
    return posts;
  }*/

  Future<String> createAssignment(String organizationId, String causeId, Map<String, dynamic> assignmentMap) async{
    try{
      final response = await http.post(Uri.parse(
          '$baseServiceActivityUrl/$assignmentCollectionName/organizations/$organizationId?causeId=$causeId'),
        body: json.encode(assignmentMap),
        headers: {
          // Je m'assure que le type de média est défini sur JSON
          'Content-Type':'application/json'
        },
      );

      if(response.statusCode == 201){
        final responseData = json.decode(utf8.decode(response.bodyBytes));
        return responseData["assignmentId"];
      }

      Map<String, dynamic> errorMessage = {};
      var errorResponse = json.decode(utf8.decode(response.bodyBytes));

      if (errorResponse.containsKey('message')) {
        errorMessage['message'] = errorResponse['message'];
      }
      if (errorResponse.containsKey('error')) {
        errorMessage['error'] = errorResponse['error'];
      }
      if (errorResponse.containsKey('status')) {
        errorMessage['status'] = errorResponse['status'];
      }
      if (errorResponse.containsKey('path')) {
        errorMessage['path'] = errorResponse['path'];
      }
      if (errorResponse.containsKey('timestamp')) {
        errorMessage['timestamp'] = errorResponse['timestamp'];
      }

      print("Error: $errorMessage");
      throw Exception(errorResponse);
    }
    catch(e) {
      throw Exception(e);
    }
  }
}