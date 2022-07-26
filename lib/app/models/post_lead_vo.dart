class PostLeadVO {
  String? uid;
  String? app_version;
  String? source;
  String? business_type;
  String? business_name;
  String? division;
  String? location;
  String? address;
  String? designation;
  String? contact_number;
  String? contact_person;
  String? email;
  String? potential;


  PostLeadVO({
      this.uid,
      this.app_version,
      this.source,
      this.business_type,
      this.business_name,
      this.division,
      this.location,
      this.address,
      this.designation,
      this.contact_number,
      this.contact_person,
      this.email,
      this.potential});

  Map<String, dynamic> toJson() {

    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['uid'] = this.uid;
    data['app_version'] = this.app_version;
    data['source'] = this.source;
    data['business_type'] = this.business_type;
    data['business_name'] = this.business_name;
    data['division'] = this.division;
    data['location'] = this.location;
    data['address'] = this.address;
    data['designation'] = this.designation;
    data['contact_number'] = this.contact_number;
    data['contact_person'] = this.contact_person;
    data['email'] = this.email;
    data['potential'] = this.potential;


    return data;
  }
}
