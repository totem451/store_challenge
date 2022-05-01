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
  BLOC(StateS initialState) : super(initialState) {
    on<LoadDataEvent>(loadData);
  }
  void loadData(event, emit) async {
    emit(InitialState());
    List<FavoriteModel> favorites = await favoriteService.listFavorites();
    List<ProductModel> products = await productService.listProducts();
    List<CategoryModel> categories = await categoryService.listCategories();
    emit(LoadDataState(products, categories, favorites));
  }
}
