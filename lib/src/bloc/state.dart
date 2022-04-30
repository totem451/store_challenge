part of 'bloc.dart';

abstract class StateS extends Equatable {
  const StateS();
}

class InitialState extends StateS {
  @override
  List<Object> get props => [];
}

class LoaderProductsAndCategoriesState extends StateS {
  final List<ProductModel> products;
  final List<CategoryModel> categories;
  LoaderProductsAndCategoriesState(this.products, this.categories);
  @override
  List<Object> get props => [products, categories];
}

class LoaderFavoritesState extends StateS {
  final List<FavoriteModel> favorites;
  LoaderFavoritesState(this.favorites);
  @override
  List<Object> get props => [favorites];
}
