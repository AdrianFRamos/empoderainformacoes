import 'package:empoderainformacoes/middleware/loginErros.dart';
import 'package:empoderainformacoes/screens/homeScreen.dart';
import 'package:empoderainformacoes/screens/loginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthRepository extends GetxController {
  static AuthRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationId = ''.obs;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  void _setInitialScreen(User? user) {
    user == null ? Get.offAll(() => const LoginScreen()) : Get.offAll(() => const HomeScreen());
  }

  loginWithCelular(String phoneNumber) async {
    try {
      await _auth.signInWithPhoneNumber(phoneNumber);
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-phone-number") {
        Get.snackbar("Erro", "Numero de telefone invalido.");
      }
    } catch (_){
      Get.snackbar("Erro", "Ocorreu algo de errado.");
    }
  }

  void phoneAuthentication(String celular) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: celular,
      verificationCompleted: (credential) async {
        await _auth.signInWithCredential(credential);
      }, 
      codeSent: (verificationId, resendToken){
        this.verificationId.value = verificationId;
      }, 
      codeAutoRetrievalTimeout: (verificationId){
        this.verificationId.value = verificationId;
      },
      verificationFailed: (e){
        if (e.code == 'invalid-phone-number') {
          Get.snackbar("Erro", "O numero disponibilizado não é valido");
        } else {
          Get.snackbar("Erro", "Algo errado ocorreu. tente novamente");
        }
      },
    );
  }

  Future<bool> verifyOTP(String otp) async {
    var credentials = await _auth.signInWithCredential(
      PhoneAuthProvider.credential(verificationId: verificationId.value, smsCode: otp));
    return credentials.user != null ? true : false;
  }

  Future<void> createUserWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      firebaseUser.value != null ? Get.offAll(() => HomeScreen()) : Get.offAll(() => const LoginScreen()); 
    } on FirebaseAuthException catch (e) {
      final ex = SignUpFailure.code(e.code);
      print('Firebase Auth Exception - ${ex.message}');
      throw ex;
    }catch (_){
      const ex = SignUpFailure();
      print('Exception - ${ex.message}');
      throw ex;
    }
  }

  Future<String?> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null; 
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        return 'Email ou senha incorretos.';
      } else {
        return 'Ocorreu um erro durante o login. Por favor, tente novamente mais tarde.';
      }
    } catch (_) {
      return 'Ocorreu um erro inesperado durante o login.';
    }
  }


  Future<void> logout() async => await _auth.signOut();
}
