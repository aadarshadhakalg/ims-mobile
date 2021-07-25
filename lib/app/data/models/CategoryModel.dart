class CategoryModel {
   String title;
   String urlSlug;
   String description;
   int isActive;
   int id;

  CategoryModel.fromJSON(Map<String,dynamic> data){
    this.title = data['title'];
    this.urlSlug = data['url_slug'];
    this.id = data['id'];
    this.isActive = data['is_active'];
    this.description = data['description'];
  
  }

  Map<String,dynamic> toJSON(){
    return {
      "title": title,
      "url_slug" : urlSlug,
      "id": id,
      "is_active": isActive,
      "description": description
    };
  }

}
