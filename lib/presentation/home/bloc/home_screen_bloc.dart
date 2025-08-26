import 'package:bloc/bloc.dart';
import 'package:ecomm_bloc/data/api_service.dart';
import 'package:ecomm_bloc/data/model/product_model.dart';
import 'package:ecomm_bloc/presentation/cart/ui/card_manager.dart';
import 'package:ecomm_bloc/presentation/home/bloc/home_screen_event.dart';
import 'package:ecomm_bloc/presentation/home/bloc/home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc() : super(HomeScreenInitial()) {
    on<LoadProducts>(_onLoadProducts);
    on<ChangeTab>(_onChangeTab);
    on<RefreshProducts>(_onRefreshProducts);
  }

  Future<void> _onLoadProducts(
    LoadProducts event,
    Emitter<HomeScreenState> emit,
  ) async {
    emit(HomeScreenLoading());

    try {
      final List<Product> products = await ApiService.fetchProducts();

      // Load cart after products are fetched
      CartManager.loadCart(products);

      emit(HomeScreenLoaded(products: products));
    } catch (e) {
      emit(HomeScreenError('Failed to load products: $e'));
    }
  }

  void _onChangeTab(ChangeTab event, Emitter<HomeScreenState> emit) {
    if (state is HomeScreenLoaded) {
      final currentState = state as HomeScreenLoaded;
      emit(currentState.copyWith(currentTab: event.tabIndex));
    }
  }

  Future<void> _onRefreshProducts(
    RefreshProducts event,
    Emitter<HomeScreenState> emit,
  ) async {
    if (state is HomeScreenLoaded) {
      final currentState = state as HomeScreenLoaded;

      try {
        final List<Product> products = await ApiService.fetchProducts();
        CartManager.loadCart(products);

        emit(currentState.copyWith(products: products, hasError: false));
      } catch (e) {
        emit(currentState.copyWith(hasError: true));
        // Re-emit the error state to maintain the current tab
        add(ChangeTab(currentState.currentTab));
      }
    }
  }
}
