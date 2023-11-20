import 'package:deme/models/organization.dart';
import '../models/address.dart';
import '../models/demand.dart';
import '../models/activity.dart';
import '../models/assignment.dart';
import '../models/cause.dart';
import '../models/financial_donation.dart';
import '../models/method_payment.dart';
import '../models/post.dart';
import '../models/user.dart';

// Les users
List<User> users = [
  User(userId: '1', name: 'Ousmane Haidara', login: 'ousmato', imageUrl: 'assets/data_test/avatar2.png', email: '', numTel: '', deviceType: '', delete: false, activated: true, anonymous: false, birthDay: '', preferredPaymentMethods: [], favoriteHumanitarianCauses: [], profile: 'user'),
  User(userId: '2', name: 'Issa Toure', login: 'issa',  imageUrl: 'assets/data_test/avatar3.png', email: '', numTel: '', deviceType: '', delete: false, activated: true, anonymous: false, birthDay: '', preferredPaymentMethods: [], favoriteHumanitarianCauses: [], profile: 'user'),
  User(userId: '3', name: 'Drissa Sidiki Traore', login: 'ramsey6340',  imageUrl: 'assets/data_test/avatar4.png', email: '', numTel: '', deviceType: '', delete: false, activated: true, anonymous: false, birthDay: '', preferredPaymentMethods: [], favoriteHumanitarianCauses: [], profile: 'user')
];

// Les cause
List<Cause> causes = [
  Cause(causeId: '1', name: "Education", imageUrl: "assets/data_test/education.png", description: ""),
  Cause(causeId: '2', name: "Santé", imageUrl: "assets/data_test/sante.png", description: ""),
  Cause(causeId: '3', name: "Environnement", imageUrl: "assets/data_test/environnement.png", description: ""),
  Cause(causeId: '4', name: "Refugieux", imageUrl: "assets/data_test/refugieux.png", description: ""),
];

// Les organisations
List<Organization> organizations = [
  Organization(organizationId: '1', name: "UNHCR", imageUrl: 'assets/data_test/o1.png', valid: true, verified: true, matricule: 'HD78NLSPAIDP', type: 'ONG', startDateExercise: '21/01/1910', nbSubscription: 100, login: 'UNHCR', address: addresses[0], subscribersId: ['1', '2', '3'], email: '', numTel: '', deviceType: '', delete: false, activated: true, anonymous: false, profile: '', preferredPaymentMethods: [], favoriteHumanitarianCauses: []),
  Organization(organizationId: '2', name: "UNICEF", imageUrl: 'assets/data_test/o2.png', valid: true, verified: false, matricule: 'HD78NLSPAIDP', type: 'Fondation', startDateExercise: '21/01/1950', nbSubscription: 34, login: 'UNICEF', address: addresses[0], subscribersId: ['2', '3'], email: '', numTel: '', deviceType: '', delete: false, activated: true, anonymous: false, profile: '', preferredPaymentMethods: [], favoriteHumanitarianCauses: []),
  Organization(organizationId: '3', name: "Sauvons les enfants", imageUrl: 'assets/data_test/o3.png', valid: false, verified: true, matricule: 'HD78NLSPAIDP', type: 'Association', startDateExercise: '21/01/1810', nbSubscription: 104, login: 'Sauvons les enfants', address: addresses[0], subscribersId: ['2'], email: '', numTel: '', deviceType: '', delete: false, activated: true, anonymous: false, profile: '', preferredPaymentMethods: [], favoriteHumanitarianCauses: []),
  Organization(organizationId: '4', name: "Diversity", imageUrl: 'assets/data_test/o4.png', valid: true, verified: true, matricule: 'HD78NLSPAIDP', type: 'ONG', startDateExercise: '21/01/1990', nbSubscription: 76, login: 'Diversity', address: addresses[0], subscribersId: ['3'], email: '', numTel: '', deviceType: '', delete: false, activated: true, anonymous: false, profile: '', preferredPaymentMethods: [], favoriteHumanitarianCauses: []),
  Organization(organizationId: '5', name: "UNHCR", imageUrl: 'assets/data_test/o1.png', valid: true, verified: true, matricule: 'HD78NLSPAIDP', type: 'Association', startDateExercise: '21/01/2000', nbSubscription: 98, login: 'UNHCR', address: addresses[0], subscribersId: ['1', '2', '3'], email: '', numTel: '', deviceType: '', delete: false, activated: true, anonymous: false, profile: '', preferredPaymentMethods: [], favoriteHumanitarianCauses: []),
];

// Les assignments
List<Assignment> assignments = [
  Assignment(assignmentId: '1', title: "Les réfugieux", description: "", organization: organizations[0], cause: causes[0]),
  Assignment(assignmentId: '2', title: "La famille", description: "", organization: organizations[1], cause: causes[1]),
  Assignment(assignmentId: '3', title: "Les enfants", description: "", organization: organizations[2], cause: causes[2]),
  Assignment(assignmentId: '4', title: "L'union", description: "", organization: organizations[3], cause: causes[3]),
  Assignment(assignmentId: '5', title: "Les réfugieux", description: "", organization: organizations[0], cause: causes[1]),

];

// Les activités
List<Activity> activities = [
  Activity(activityId: '1', title: "Aidons Gao fasse aux terroristes", description: "", assignment: assignments[0]),
  Activity(activityId: '2', title: "Le pays c’est les enfants", description: "", assignment: assignments[1]),
  Activity(activityId: '3', title: "Les enfants sont l’avenir de la nation", description: "", assignment: assignments[2]),
  Activity(activityId: '4', title: "Les soutien mutuel est le socle qui fait tenir un pays", description: "", assignment: assignments[3]),
  Activity(activityId: '5', title: "Aidons Gao fasse aux terroristes", description: "", assignment: assignments[0]),

];

// Les posts
// 'assets/data_test/post1_unicef.png'
List<Post> posts = [
  Post(postId: '1', imageUrl: 'assets/data_test/post1_unhcr.png', description: "Le pays c'est les enfants Le pays c'est les enfants Le pays c'est les enfants Le pays c'est les enfants Le pays c'est les enfants Le pays c'est les enfants Le pays c'est les enfants Le pays c'est les enfants Le pays c'est les enfants ", videoUrl: "", activity: activities[0]),
  Post(postId: '2', imageUrl: null, description: "Le pays c'est les enfants Le pays c'est les enfants Le pays c'est les enfants Le pays c'est les enfants Le pays c'est les enfants Le pays c'est les enfants Le pays c'est les enfants ", videoUrl: "", activity: activities[1]),
  Post(postId: '3', imageUrl: 'assets/data_test/post1_sc.png', description: "Le pays c'est les enfants", videoUrl: "", activity: activities[2]),
  Post(postId: '4', imageUrl: 'assets/data_test/post1_diversity.png', description: "Le pays c'est les enfants", videoUrl: "", activity: activities[3]),
  Post(postId: '5', imageUrl: 'assets/data_test/post1_unhcr.png', description: "Le pays c'est les enfants Le pays c'est les enfants Le pays c'est les enfants Le pays c'est les enfants Le pays c'est les enfants Le pays c'est les enfants Le pays c'est les enfants Le pays c'est les enfants Le pays c'est les enfants ", videoUrl: "", activity: activities[0]),

];

// Les demandes de don faite par des utilisateurs
List<Demand> demands = [
  Demand(demandId: '1', description: 'Fatoumata décide de nous rencontré son histoire dans la quelle elle nous invite tous à ...', videoUrl: null, imagesUrl: ['assets/data_test/demand1.png'], inProgress: true, cause: causes[0], guarantor: organizations[0], user: users[0]),
  Demand(demandId: '2', description: 'C’est l’histoire d’Amina, vivant dans un petit village reculé. Elle avait une soif insatiable de savoir et rêvait d\'aller à l\'école pour apprendre à lire et à écrire. Cependant, dans son village, il n\'y avait pas d\'école. Les ressources étaient rares, et l\'accès à l\'éducation était limité. Amina persistait dans son désir d\'apprendre. Elle passait...', videoUrl: null, imagesUrl: null, inProgress: true, cause: causes[1], guarantor: organizations[1], user: users[1]),
  Demand(demandId: '3', description: 'Fatoumata décide de nous rencontré son histoire dans la quelle elle nous invite tous à ...', videoUrl: null, imagesUrl: ['assets/data_test/demand2.png'], inProgress: true, cause: causes[2], guarantor: organizations[2], user: users[2]),
  Demand(demandId: '4', description: 'Fatoumata décide de nous rencontré son histoire dans la quelle elle nous invite tous à ...', videoUrl: null, imagesUrl: ['assets/data_test/demand1.png'], inProgress: true, cause: causes[3], guarantor: organizations[3], user: users[0]),
  Demand(demandId: '5', description: 'Fatoumata décide de nous rencontré son histoire dans la quelle elle nous invite tous à ...', videoUrl: null, imagesUrl: null, inProgress: true, cause: causes[0], guarantor: organizations[4], user: users[1]),
  Demand(demandId: '6', description: 'Fatoumata décide de nous rencontré son histoire dans la quelle elle nous invite tous à ...', videoUrl: null, imagesUrl: null, inProgress: true, cause: causes[1], guarantor: organizations[0], user: users[2]),
  Demand(demandId: '7', description: 'Fatoumata décide de nous rencontré son histoire dans la quelle elle nous invite tous à ...', videoUrl: null, imagesUrl: null, inProgress: false, cause: causes[2], guarantor: organizations[1], user: users[0]),
  Demand(demandId: '8', description: 'Fatoumata décide de nous rencontré son histoire dans la quelle elle nous invite tous à ...', videoUrl: null, imagesUrl: null, inProgress: true, cause: causes[3], guarantor: organizations[2], user: users[1]),
];

// Les méthodes de paiement
List<MethodPayment> methodsPayment = [
  MethodPayment(methodPaymentId: '1', name: 'Orange Money', description: 'Orange Money est pour Orange', imageUrl: 'assets/data_test/om_logo.png', termsOfUse: null),
  MethodPayment(methodPaymentId: '2', name: 'Moov Money', description: 'Moov Money est pour Moov Africa', imageUrl: 'assets/data_test/mm_logo.png', termsOfUse: null),
  MethodPayment(methodPaymentId: '3', name: 'Sama Money', description: 'Sama Money est pour Sama', imageUrl: 'assets/data_test/sm_logo.png', termsOfUse: null),
  MethodPayment(methodPaymentId: '4', name: 'Pay Pal', description: 'Pay Pal est pour Pay Pal', imageUrl: 'assets/data_test/pp_logo.jpg', termsOfUse: null),

  MethodPayment(methodPaymentId: '5', name: 'Orange Money', description: 'Orange Money est pour Orange', imageUrl: 'assets/data_test/om_logo.png', termsOfUse: null),
  MethodPayment(methodPaymentId: '6', name: 'Moov Money', description: 'Moov Money est pour Moov Africa', imageUrl: 'assets/data_test/mm_logo.png', termsOfUse: null),
  MethodPayment(methodPaymentId: '7', name: 'Sama Money', description: 'Sama Money est pour Sama', imageUrl: 'assets/data_test/sm_logo.png', termsOfUse: null),
  MethodPayment(methodPaymentId: '8', name: 'Pay Pal', description: 'Pay Pal est pour Pay Pal', imageUrl: 'assets/data_test/pp_logo.jpg', termsOfUse: null),
];

// Les adresses
List<Address> addresses = [
  Address(addressId: '1', country: 'Mali', city: 'Bamako', neighborhood: 'Kalanbankoro ACI', geolocation: 'https://maps.google.com/q=1.3,3.6'),
  Address(addressId: '2', country: 'Mali', city: 'Bamako', neighborhood: 'Att bougou 759', geolocation: 'https://maps.google.com/q=1.3,3.6'),
  Address(addressId: '3', country: 'Mali', city: 'Sikasso', neighborhood: 'Faladie IJA', geolocation: 'https://maps.google.com/q=1.3,3.6'),
];

// Les donations financiers
List<FinancialDonation> financialDonations = [
  FinancialDonation(financialDonationId: '1', amount: 15000, date: 'Mardi le 12/09/2023', isUsed: false, user: users[0], beneficiaryOrga: organizations[0], beneficiaryDemand: null),
  FinancialDonation(financialDonationId: '1', amount: 1000000, date: 'Vendredi le 04/07/2023', isUsed: true, user: users[1], beneficiaryOrga: organizations[0], beneficiaryDemand: null),
  FinancialDonation(financialDonationId: '1', amount: 50000, date: 'Mardi le 12/01/2023', isUsed: false, user: users[2], beneficiaryOrga: organizations[1], beneficiaryDemand: null),
];