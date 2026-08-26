class LoginService {
  
  Future<void> login(String email, String password) async {
    // Simulate a delay for the login process
    await Future.delayed(const Duration(seconds: 2));

    // Here you can implement your actual login logic, such as making an API call
    // For demonstration purposes, we'll just print the email and password
    print('Email: $email');
    print('Password: $password');
  }
}
