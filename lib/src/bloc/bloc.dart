import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:store_challenge/src/model/models.dart';
import 'package:store_challenge/src/service/services.dart';
part 'event.dart';
part 'state.dart';

class BLOC extends Bloc<EventS, StateS> {
  final productService = ProductService();
  final categoryService = CategoryService();
  final favoriteService = FavoriteService();
  BLOC() : super(InitialState()) {
    on<EventS>((event, emit) async {
      if (event is InitialEvent) {
        emit(InitialState());
      }
      if (event is LoaderProductsAndCategoriesEvent) {
        emit(InitialState());
        late List<ProductModel> products;
        late List<CategoryModel> categories;
        products = await productService.listProducts();
        categories = await categoryService.listCategories();
        emit(LoaderProductsAndCategoriesState(products, categories));
      }
      if (event is LoaderFavoritesEvent) {
        emit(InitialState());
        late List<FavoriteModel> favorites;
        favorites = await favoriteService.listFavorites();
        emit(LoaderFavoritesState(favorites));
      }
    });
  }
}
