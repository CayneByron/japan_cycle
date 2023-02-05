import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:japan_cycling/models/last_known_location.dart';

class LastLocationProvider {
  LastLocationProvider();

  static Future<LastKnownLocation> getRecords() async {
    final Uri url = Uri.https('hlefvpbwaojxyqjuiykw.supabase.co', '/rest/v1/geolocation', {'select': '*'});
    String apikey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhsZWZ2cGJ3YW9qeHlxanVpeWt3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzAxMTQ3MTIsImV4cCI6MTk4NTY5MDcxMn0.7kxVdF45wQ8IDbMG-w13gXvfvX-VDatpArD_3Ir93m0';
    Response response = await get(url, headers: {
      'apikey': apikey,
      'Authorization': 'Bearer $apikey',
    });
    List<dynamic> data = jsonDecode(response.body);
    print(data[0]);
    return LastKnownLocation(id: data[0]['id'], latitude: data[0]['latitude'], longitude: data[0]['longitude'], lastUpdated: DateTime.parse(data[0]['updated_at']));
  }
}