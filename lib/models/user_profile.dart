class ProfilModel{
  late String? name;
  late String ?email ;
  late String? image;
  late String ?password;
  ProfilModel(
  {
    required this.name,
    required this.image,
    required this.email,
    required this.password,
}
      );
  factory ProfilModel.fromjson(Map<String,dynamic> json){
     return ProfilModel(
         name:json['name'] ,
         image: json['image'],
         email: json['email'],
         password: json['password']
     );

  }

  Map<String,dynamic> tojson(){
    return {
      'name':this.name,
      'image':this.image,
      'password':this.password,
      'email':this.email
    };

  }
}