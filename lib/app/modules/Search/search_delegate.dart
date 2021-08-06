import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/product.model.dart';
import '../../data/repositories/product_repository.dart';
import '../../../core/errors/failure.dart';
import '../../../routes/pages.dart';

class ProductSearch extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Get.back();
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<Either<ProductModel, Failure>>(
      future: ProductRepository().searchProduct(query),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _createData(snapshot.data);
        } else {
          return Center(
            child: Text('Searching'),
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (!query.isNotEmpty || query == null || query == '') {
      return Center(
        child: Text('Start Searching'),
      );
    }

    return FutureBuilder<Either<ProductModel, Failure>>(
      future: ProductRepository().searchProduct(query),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _createData(snapshot.data);
        } else {
          return Center(
            child: Text('Searching'),
          );
        }
      },
    );
  }

  Widget _createData(Either<ProductModel, Failure> data) {
    return data.fold((l) {
      return ListView.builder(
        itemCount: l.count,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Get.toNamed(Routes.ADDPRODUCT,
                  arguments: ["update", "${l.results[index].urlSlug}"]);
            },
            child: Card(
              elevation: 5,
              child: ListTile(
                leading: Icon(Icons.category),
                title: Text(l.results[index].productName),
                subtitle: Text(l.results[index].productDescription),
                trailing: l.results[index].isActive == 0
                    ? Icon(Icons.edit_off)
                    : Icon(Icons.edit),
              ),
            ),
          );
        },
      );
    }, (r) {
      return Center(
        child: Text('No Product Found'),
      );
    });
  }
}
