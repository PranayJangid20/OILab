import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:oilab_task/features/home/data/home_repository.dart';
import 'package:oilab_task/features/home/model/users.dart';
import 'package:oilab_task/utils/healper.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  List<Data> allUsers = [];
  int maxPage = 99;
  int currentPage = 0;
  HomeRepository repository = HomeRepository();
  fetchUsers(int page) async {
    'maxPage'.log();
    maxPage.log();
    if(page <= maxPage){
      currentPage = page;
      emit(HomePageLoading(page));
      var response = await repository.fetchData(page.toString());
      if(response['success']){
        Users users = Users.fromJson(response["data"]);
        allUsers.addAll(users.data!);
        allUsers.log();
        maxPage = users.totalPages!;
        emit(HomePageLoaded(allUsers));
      }
      emit(HomePageLoaded(const []));
    }
  }
}
