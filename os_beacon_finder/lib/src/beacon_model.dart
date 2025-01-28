class BeaconModel {
  String namespaceId;
  String instanceId;
  double distance;
  int txPower;
  int rssi;

  BeaconModel(
      {required this.distance,
      required this.txPower,
      required this.rssi,
      required this.instanceId,
      required this.namespaceId});

  factory BeaconModel.fromJson(Map<String, dynamic> json) => BeaconModel(
      distance: json['distance'],
      txPower: json['txPower'],
      rssi: json['rssi'],
      instanceId: json['instanceId'],
      namespaceId: json['namespaceId']);
}
