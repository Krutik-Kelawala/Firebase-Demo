class SendLeadModel {
  String name;
  String interest;
  String mobileNo;
  String designation;


  SendLeadModel(this.name,this.interest,  this.mobileNo,this.designation);

  factory SendLeadModel.fromJson(dynamic json) {
    return SendLeadModel("${json['name']}", "${json['interest']}","${json['mobileNo']}","${json['designation']}");
  }

  // Method to make GET parameters.
  Map toJson() => {
    'name': name,
    'interest': interest,
    'mobileNo': mobileNo,
    'designation': designation,
  };
}