abstract class Failure{
  final String message;
  Failure(this.message);
}

class UnknownAppFailure extends Failure{
  UnknownAppFailure() : super('Something Went Wrong');
}


// Category Failures

class CategoryAdditionFailure extends Failure{
  CategoryAdditionFailure(String message) : super(message);
}

class CategoryListingFailure extends Failure{
  CategoryListingFailure(String message) : super(message);
}

class CategoryDeletionFailure extends Failure{
  CategoryDeletionFailure(String message) : super(message);
}

class CategoryUpdateFailure extends Failure{
  CategoryUpdateFailure(String message) : super(message);
}

// Sub Category Failures

class SubCategoryAdditionFailure extends Failure{
  SubCategoryAdditionFailure(String message) : super(message);
}

class SubCategoryListingFailure extends Failure{
  SubCategoryListingFailure(String message) : super(message);
}

class SubCategoryDeletionFailure extends Failure{
  SubCategoryDeletionFailure(String message) : super(message);
}

class SubCategoryUpdateFailure extends Failure{
  SubCategoryUpdateFailure(String message) : super(message);
}