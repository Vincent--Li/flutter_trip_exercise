class ConfigModel {
  final String searchUrl;

  ConfigModel({this.searchUrl}); //可选构造方法

  factory ConfigModel.fromJson(Map<String, dynamic> json){
    return ConfigModel(
      searchUrl: json['searchUrl']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      searchUrl: searchUrl
    };
  }
}