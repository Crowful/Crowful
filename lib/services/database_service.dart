import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});

// Collections Reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference campaignCollection =
      FirebaseFirestore.instance.collection('admin_campaign_requests');

  final CollectionReference feedbackCollection =
      FirebaseFirestore.instance.collection('feedbacks');

  final CollectionReference suggestionCollection =
      FirebaseFirestore.instance.collection('suggestions');

  final CollectionReference verificationCollection =
      FirebaseFirestore.instance.collection('verification');

  final CollectionReference approvedCampaignCollection =
      FirebaseFirestore.instance.collection('campaigns');

  final CollectionReference messageCollection =
      FirebaseFirestore.instance.collection('message');

//methods

//User
  Future addUserData(
      String email,
      String fullname,
      String address,
      String gender,
      String phoneNumber,
      String username,
      String deviceToken) async {
    return await userCollection.doc(uid).set({
      'email': email,
      'fullname': fullname,
      'address': address,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'username': username,
      'isApplying': false,
      'isVerify': false,
      'deviceToken': deviceToken,
      'balance': 00.00,
      'campaignsJoined': 0,
      'overallDonation': 0,
    });
  }

  Future deleteUserData() async {
    return await userCollection.doc(uid).delete();
  }

  Future updateUserData(
    String address,
    String fullname,
    String phoneNumber,
  ) async {
    return await userCollection.doc(uid).update({
      'address': address,
      'fullname': fullname,
      'phoneNumber': phoneNumber,
    });
  }

//Campaign
  Future addCampaign(
      String title,
      String description,
      String campaignID,
      DateTime dateCreated,
      String dateStart,
      String dateEnded,
      String address,
      String city,
      String time,
      String userUID,
      String userName,
      double latitude,
      double longitude,
      int numSeeds,
      double currentDonations,
      double maxDonations,
      int currentVolunteers,
      int numberVolunteers,
      String deviceTokenOfOrganizer,
      double campaignRadius) async {
    return await campaignCollection.doc(campaignID).set({
      'campaignID': campaignID,
      'campaign_name': title,
      'description': description,
      'date_created': dateCreated,
      'date_start': dateStart,
      'date_ended': dateEnded,
      'address': address,
      'city': city,
      'time': time,
      'uid': userUID,
      'username': userName,
      'latitude': latitude,
      'longitude': longitude,
      'number_of_seeds': numSeeds,
      'current_donations': currentDonations,
      'max_donation': maxDonations,
      'current_volunteers': currentVolunteers,
      'number_volunteers': numberVolunteers,
      'deviceTokenofOrganizer': deviceTokenOfOrganizer,
      'radius': campaignRadius,
      'isActive': false,
      'isDone': false,
      'inProgress': false,
    });
  }

  Future saveVerification(
    String validIDUrl,
    String idNumber,
    String pictureURL,
    String reasonForApplication,
    String doHaveExperience,
    bool verified,
  ) async {
    return await verificationCollection.doc(uid).set({
      'validIDUrl': validIDUrl,
      'idNumber': idNumber,
      'pictureURL': pictureURL,
      'reasonForApplication': reasonForApplication,
      'doHaveExperience': doHaveExperience,
      'getVerified': verified
    });
  }

  Future updateApplication() async {
    return await userCollection.doc(uid).update({
      'isApplying': true,
    });
  }

  Future addAnnouncement(String uidOfCampaign, String announcement) async {
    return await approvedCampaignCollection
        .doc(uidOfCampaign)
        .collection("announcement")
        .doc('announcement')
        .set({"currentAnnouncement": announcement});
  }

//Join Campaign
  Future joinCampaign(String uidOfCampaign, String registeredUID) async {
    return await approvedCampaignCollection
        .doc(uidOfCampaign)
        .collection("volunteers")
        .doc(registeredUID)
        .set({"volunteerUID": registeredUID, "isApprove": false});
  }

  Future addVolunteerNumber(String uidOfCampaign) async {
    return await approvedCampaignCollection
        .doc(uidOfCampaign)
        .update({'current_volunteers': FieldValue.increment(1)});
  }

  Future addCampaigntoUser(String uidOfCampaign, String registeredUID) async {
    return await userCollection
        .doc(registeredUID)
        .collection("campaigns")
        .doc(uidOfCampaign)
        .set({"campaign": uidOfCampaign});
  }

//LEAVE CAMPAIGN
  Future removeCampaigntoUser(
      String uidOfCampaign, String registeredUID) async {
    return await userCollection
        .doc(registeredUID)
        .collection("campaigns")
        .doc(uidOfCampaign)
        .delete();
  }

  Future removeVolunteerNumber(String uidOfCampaign) async {
    return await approvedCampaignCollection
        .doc(uidOfCampaign)
        .update({'current_volunteers': FieldValue.increment(-1)});
  }

  Future leaveCampaign(String uidOfCampaign, String registeredUID) async {
    return await approvedCampaignCollection
        .doc(uidOfCampaign)
        .collection("volunteers")
        .doc(registeredUID)
        .delete();
  }

  Future setStartDateCampaign(String uidOfCampaign, String dateCampaign) async {
    return await approvedCampaignCollection.doc(uidOfCampaign).update({
      'date_start': dateCampaign,
    });
  }

  Future starTheCampaign(String uidOfCampaign) async {
    return await approvedCampaignCollection.doc(uidOfCampaign).update({
      'inProgress': true,
      'isActive': false,
      'isCompleted': false,
    });
  }

  Future endTheCampaign(String uidOfCampaign) async {
    return await approvedCampaignCollection.doc(uidOfCampaign).update({
      'inProgress': false,
      'isActive': false,
      'isCompleted': true,
    });
  }

  Future donatedToCampaign(
    String uidOfCampaign,
    int amount,
    String dateDonated,
    String uidUser,
  ) async {
    return await approvedCampaignCollection
        .doc(uidOfCampaign)
        .collection('donations')
        .doc(uidUser)
        .set({
      'uid': uidUser,
      'amount': amount,
      'dateDonated': dateDonated,
      'campaignUID': uidOfCampaign
    });
  }

  Future donatedToCampaignUser(
    String uidOfCampaign,
    int amount,
    String dateDonated,
    String uidUser,
  ) async {
    return await userCollection
        .doc(uid)
        .collection('recent_activities')
        .doc()
        .set({
      'uid': uidUser,
      'amount': amount,
      'dateDonated': FieldValue.serverTimestamp(),
      'campaignUID': uidOfCampaign,
      'type': 'donated'
    });
  }

  Future deleteRecentActivity(String uidOfActivity) async {
    return await userCollection
        .doc(uid)
        .collection('recent_activities')
        .doc(uidOfActivity)
        .delete();
  }

  Future deleteRecentCampaign(String uidOfActivity, String volunteerUID) async {
    return await userCollection
        .doc(volunteerUID)
        .collection('campaigns')
        .doc(uidOfActivity)
        .delete();
  }

  Future addBalanceToUser(
    String uidOfCampaign,
    int amount,
    String dateDonated,
    String uidUser,
  ) async {
    return await userCollection
        .doc(uid)
        .collection('recent_activities')
        .doc()
        .set({
      'uid': uidUser,
      'amount': amount,
      'dateDonated': FieldValue.serverTimestamp(),
      'campaignUID': uidOfCampaign,
      'addedBalance': amount,
      'type': 'addBalance'
    });
  }

  Future incrementDonation(
    String uidOfCampaign,
    int amount,
  ) async {
    return await approvedCampaignCollection.doc(uidOfCampaign).update({
      'current_donations': FieldValue.increment(amount),
    });
  }

  Future addDonationToOrganizer(
    String uidOfOrganizer,
    int amount,
  ) async {
    return await userCollection.doc(uidOfOrganizer).update({
      'balance': FieldValue.increment(amount),
    });
  }

  Future addReportScam(
      String uidOfCampaign, String registeredUID, String typeOfReport) async {
    return await approvedCampaignCollection
        .doc(uidOfCampaign)
        .update({"reportScam": FieldValue.increment(1)});
  }

  Future addReportAbuse(
      String uidOfCampaign, String registeredUID, String typeOfReport) async {
    return await approvedCampaignCollection
        .doc(uidOfCampaign)
        .update({"reportAbuse": FieldValue.increment(1)});
  }

  Future addReportUIW(
      String uidOfCampaign, String registeredUID, String typeOfReport) async {
    return await approvedCampaignCollection
        .doc(uidOfCampaign)
        .update({"reportUIW": FieldValue.increment(1)});
  }

  Future addFeedbacks(
      String feedback, String uidOfVolunteer, String date) async {
    return await feedbackCollection
        .doc()
        .set({"feedback": feedback, "uid": uidOfVolunteer, "date": date});
  }

  Future addSuggestions(
      String suggestion, String uidOfVolunteer, String date) async {
    return await suggestionCollection
        .doc()
        .set({"suggestion": suggestion, "uid": uidOfVolunteer, "date": date});
  }

  Future addMessage(
      String uidOfCampaign,
      String uidOfOrganizer,
      String uidOfVolunteer,
      String devicetokenOfOrg,
      String volunteerName,
      String phoneNumber,
      String gender,
      String address) async {
    return await approvedCampaignCollection
        .doc(uidOfCampaign)
        .collection('distress')
        .doc(uidOfVolunteer)
        .set({
      "timeStamp": FieldValue.serverTimestamp(),
      'volunteerUID': uidOfVolunteer,
      'organizerUID': uidOfOrganizer,
      'deviceToken': devicetokenOfOrg,
      'title': 'ATTENTION: DISTRESS FROM ONE OF YOUR VOLUNTEER',
      'body': '''Name: $volunteerName 
      Phone : $phoneNumber
      address: $address
      gender: $gender
      '''
    });
  }

  Future addBalance(String volunteerUID, double newBalance) async {
    return await userCollection
        .doc(volunteerUID)
        .update({"balance": FieldValue.increment(newBalance)});
  }

  Future deductBalance(String volunteerUID, double newBalance) async {
    return await userCollection
        .doc(volunteerUID)
        .update({"balance": FieldValue.increment(-newBalance)});
  }

  Future deductInitialCamapaign(String volunteerUID) async {
    return await userCollection
        .doc(volunteerUID)
        .update({"balance": FieldValue.increment(-500)});
  }

  Future declineVolunteer(String campaignUID, String volunteerUID) async {
    return await approvedCampaignCollection
        .doc(campaignUID)
        .collection('volunteers')
        .doc(volunteerUID)
        .delete();
  }

  Future approveVolunteer(String campaignUID, String volunteerUID) async {
    return await approvedCampaignCollection
        .doc(campaignUID)
        .collection('volunteers')
        .doc(volunteerUID)
        .update({"isApprove": true});
  }

  Future addDurationToCampaign(String campaignUID, String duration) async {
    return await approvedCampaignCollection
        .doc(campaignUID)
        .set({"duration": duration}, SetOptions(merge: true));
  }

  Future addJoinedLeaderBoard(String volunteerUID, int amount) async {
    return await userCollection.doc(volunteerUID).update(
      {"campaignsJoined": FieldValue.increment(amount)},
    );
  }

  Future addDonationLeaderboard(String volunteerUID, int amount) async {
    return await userCollection.doc(volunteerUID).update(
      {"overallDonation": FieldValue.increment(amount)},
    );
  }
}
