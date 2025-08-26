import 'package:bloc/bloc.dart';
import 'package:ecomm_bloc/data/api_service.dart';
import 'package:ecomm_bloc/data/model/product_model.dart';
import 'package:ecomm_bloc/presentation/cart/card_manager.dart';
import 'package:ecomm_bloc/presentation/home/bloc/home_screen_event.dart';
import 'package:ecomm_bloc/presentation/home/bloc/home_screen_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<LoadProducts>(_onLoadProducts);
  }

  Future<void> _onLoadProducts(
    LoadProducts event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final products = await ApiService.fetchProducts();

      // Load cart with fetched products
      CartManager.loadCart(products);

      emit(state.copyWith(status: HomeStatus.success, products: products));
    } catch (e) {
      emit(
        state.copyWith(status: HomeStatus.failure, errorMessage: e.toString()),
      );
    }
  }
}
