import 'package:fleekhr/data/models/wfh_request/wfh_model.dart';

///Service class for handling WFH (Work From Home) related API calls.

class WfhApiService {
  //Submit WFH request to the API
  Future<void> submitWFHReq(WfhModel req) async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      // Here you would typically use an HTTP client to send the request
      // For example:
      // final response = await http.post(
      //   Uri.parse('https://api.example.com/wfh'),
      //   body: req.toJson(),
      // );
      // Handle response and errors accordingly
    }catch(e){
      // Handle any errors that occur during the API call
      print('Error submitting WFH request: $e');
      throw Exception('Failed to submit WFH request');
    }
  }

  //Fetch WFH requests from the API
  Future<List<String>> fetchWFHReqs() async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      // Here you would typically use an HTTP client to fetch the requests
      // For example:
      // final response = await http.get(Uri.parse('https://api.example.com/wfh'));
      // Parse the response and return a list of WfhModel objects
      return [
        //For Demo purposes, returning a static list
      "Remote work due to doctor's appointment",
      "Internet issues at home need to be fixed",
      "Construction work in my area",
      "Weather conditions making commute difficult",
      "Family emergency requires me to be at home",

      ]; // Return an empty list for now
    } catch (e) {
      // Handle any errors that occur during the API call
      print('Error fetching WFH requests: $e');
      throw Exception('Failed to fetch WFH requests');
    }
  }
}