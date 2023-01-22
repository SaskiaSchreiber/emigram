import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;


Future<http.Response> requestQlimatiqData () async {
  var url ='https://beta3.api.climatiq.io/estimate';
  var data = {
    "emission_factor": {
      "activity_id": "electricity-energy_source_grid_mix"
    },
    "parameters": {
      "energy": 4200,
      "energy_unit": "kWh"
    }
  };
  var body = json.encode(data);

  var response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json",
      HttpHeaders.authorizationHeader: 'Bearer  TZEBMRQEGX444NH630SSXKNRKEMM'},
      body: body
  );
  print("${response.statusCode}");
  print("${response.body}");
  return response;
}