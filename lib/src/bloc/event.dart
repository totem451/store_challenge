part of 'bloc.dart';

abstract class EventS extends Equatable {
  const EventS();
}

class InitialEvent extends EventS {
  @override
  List<Object> get props => [];
}

class LoaderProductsAndCategoriesEvent extends EventS {
  final List<ProductModel> products;
  final List<CategoryModel> categories;
  LoaderProductsAndCategoriesEvent(this.products, this.categories);
  @override
  List<Object> get props => [products, categories];
}

class LoaderFavoritesEvent extends EventS {
  final List<FavoriteModel> favorites;
  LoaderFavoritesEvent(this.favorites);
  @override
  List<Object> get props => [favorites];
}
