abstract class Failure {
  final String message;
  Failure(this.message);
}

// All Other Failures
class UnknownAppFailure extends Failure {
  UnknownAppFailure() : super('Something Went Wrong');
}

// Category Failures
class CategoryAdditionFailure extends Failure {
  CategoryAdditionFailure(String message) : super(message);
}

class CategoryListingFailure extends Failure {
  CategoryListingFailure(String message) : super(message);
}

class CategoryDeletionFailure extends Failure {
  CategoryDeletionFailure(String message) : super(message);
}

class CategoryUpdateFailure extends Failure {
  CategoryUpdateFailure(String message) : super(message);
}

// Sub Category Failures

class SubCategoryAdditionFailure extends Failure {
  SubCategoryAdditionFailure(String message) : super(message);
}

class SubCategoryListingFailure extends Failure {
  SubCategoryListingFailure(String message) : super(message);
}

class SubCategoryDeletionFailure extends Failure {
  SubCategoryDeletionFailure(String message) : super(message);
}

class SubCategoryUpdateFailure extends Failure {
  SubCategoryUpdateFailure(String message) : super(message);
}

// Product Failures

class ProductAdditionFailure extends Failure {
  ProductAdditionFailure(String message) : super(message);
}

class ProductListingFailure extends Failure {
  ProductListingFailure(String message) : super(message);
}

class ProductDeletionFailure extends Failure {
  ProductDeletionFailure(String message) : super(message);
}

class ProductUpdateFailure extends Failure {
  ProductUpdateFailure(String message) : super(message);
}

// Staff Failures

class StaffAdditionFailure extends Failure {
  StaffAdditionFailure(String message) : super(message);
}

class StaffListingFailure extends Failure {
  StaffListingFailure(String message) : super(message);
}

class StaffUpdateFailure extends Failure {
  StaffUpdateFailure(String message) : super(message);
}

// Payroll Failures

class PayrollListingFailure extends Failure {
  PayrollListingFailure(String message) : super(message);
}

class StaffPaymentFailure extends Failure {
  StaffPaymentFailure(String message) : super(message);
}
