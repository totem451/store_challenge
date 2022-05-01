// ignore_for_file: prefer_const_constructors_in_immutables

part of 'bloc.dart';

class StateS extends Equatable {
  const StateS();
  @override
  List<Object?> get props => throw UnimplementedError();
}

class InitialState extends StateS {
  @override
  List<Object> get props => [];
}

class LoadDataState extends StateS {
  final List<ProductModel> products;
  final List<CategoryModel> categories;
  final List<FavoriteModel> favorites;
  LoadDataState(this.products, this.categories, this.favorites);
  @override
  List<Object> get props => [products, categories, favorites];
}
