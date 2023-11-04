import 'package:deme/models/organization.dart';

import '../models/activity.dart';
import '../models/assignment.dart';
import '../models/post.dart';

// Les organisations
List<Organization> organizations = [
  Organization(organizationId: '1', name: "UNHCR", imageUrl: 'assets/data_test/unhcr.png'),
  Organization(organizationId: '2', name: "UNICEF", imageUrl: 'assets/data_test/unicef.png'),
  Organization(organizationId: '3', name: "Sauvons les enfants", imageUrl: 'assets/data_test/savechildren.png'),
  Organization(organizationId: '4', name: "Diversity", imageUrl: 'assets/data_test/diversity.png'),
];

// Les assignments
List<Assignment> assignments = [
  Assignment(assignmentId: '1', title: "Les réfugieux", description: "", organization: organizations[0]),
  Assignment(assignmentId: '2', title: "La famille", description: "", organization: organizations[1]),
  Assignment(assignmentId: '3', title: "Les enfants", description: "", organization: organizations[2]),
  Assignment(assignmentId: '4', title: "L'union", description: "", organization: organizations[3]),
];

// Les activités
List<Activity> activities = [
  Activity(activityId: '1', title: "Aidons Gao fasse aux terroristes", description: "", assignment: assignments[0]),
  Activity(activityId: '2', title: "Le pays c’est les enfants", description: "", assignment: assignments[1]),
  Activity(activityId: '3', title: "Les enfants sont l’avenir de la nation", description: "", assignment: assignments[2]),
  Activity(activityId: '4', title: "Les soutien mutuel est le socle qui fait tenir un pays", description: "", assignment: assignments[3]),
];

// Les posts
List<Post> posts = [
  Post(postId: '1', imageUrl: 'assets/data_test/post1_unhcr.png', description: "Le pays c'est les enfants Le pays c'est les enfants Le pays c'est les enfants Le pays c'est les enfants Le pays c'est les enfants Le pays c'est les enfants Le pays c'est les enfants Le pays c'est les enfants Le pays c'est les enfants ", videoUrl: "", activity: activities[0]),
  Post(postId: '2', imageUrl: 'assets/data_test/post1_unicef.png', description: "Le pays c'est les enfants", videoUrl: "", activity: activities[1]),
  Post(postId: '3', imageUrl: 'assets/data_test/post1_sc.png', description: "Le pays c'est les enfants", videoUrl: "", activity: activities[2]),
  Post(postId: '4', imageUrl: 'assets/data_test/post1_diversity.png', description: "Le pays c'est les enfants", videoUrl: "", activity: activities[3]),
];