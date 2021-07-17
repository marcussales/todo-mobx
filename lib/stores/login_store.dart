import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  _LoginStore() {
    autorun((_) {
      print(isFormValid);
    });
  }
  @observable
  String email = '';

  @action
  void setEmail(String value) => email = value;

  @observable
  String password = '';

  @observable
  bool hidePassword = true;

  @observable
  bool loading = false;

  @observable
  bool loggedIn = false;

  @action
  showHidePassword() => hidePassword = !hidePassword;

  @action
  void setPassword(String value) => password = value;

  @computed
  bool get isEmailValid => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);

  @computed
  bool get isFormValid => isEmailValid && password.length > 6;

  @action
  Future<void> login() async {
    loading = true;
    await Future.delayed(Duration(seconds: 3));
    loading = false;
    loggedIn = true;
  }

  @action
  void logout() {
    loggedIn = false;
    email = '';
    password = '';
  }

  @computed
  Function get loginPressed => (isFormValid && !loading) ? login : null;
}
