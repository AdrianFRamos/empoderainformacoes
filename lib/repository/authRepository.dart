import 'package:empoderainformacoes/middleware/loginErros.dart';
import 'package:empoderainformacoes/screens/homeScreen.dart';
import 'package:empoderainformacoes/screens/loginScreen.dart';
import 'package:empoderainformacoes/screens/mailScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../middleware/exceptions.dart';

class AuthRepository extends GetxController {
  static AuthRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> _firebaseUser;
  var verificationId = ''.obs;
  //late final GoogleSignInAccount _googleUser;

  User? get firebaseUser => _firebaseUser.value;
  //String get getUserID => firebaseUser?uid ?? ""; 
  //String get getUserEmail => firebaseUser?email ?? ""; 

  @override
  void onReady() {
    _firebaseUser = Rx<User?>(_auth.currentUser);
    _firebaseUser.bindStream(_auth.userChanges());
    setInitialScreen(_firebaseUser.value);
    //ever(firebaseUser, _setInitialScreen);
  }

  setInitialScreen(User? user) {
    user == null 
      ? Get.offAll(() => const LoginScreen()) 
      : user.emailVerified 
        ? Get.offAll(() => const HomeScreen()) 
        : Get.offAll(() => const MailScreen());
  }



//-----------------------CELULAR-------------------------//

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

//-----------------------EMAIL e SENHA-------------------------//

  Future<void> createUserWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      _firebaseUser.value != null ? Get.offAll(() => HomeScreen()) : Get.offAll(() => const LoginScreen()); 
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

  Future<void> sendEmailVerification() async{
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      final ex = TExceptions.fromCode(e.code);
      throw ex.message;
    } catch (_) {
      const ex = TExceptions();
      throw ex.message;
    }
  }

  //-----------------------GOOGLE E FACEBOOK-------------------------//

  Future<UserCredential?> signInWithGoogle() async{
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      final ex = TExceptions.fromCode(e.code);
      throw ex.message;
    } catch (_){
      const ex = TExceptions();
      throw ex.message;
    }
  }

  //Future<UserCredential> signInWithFacebook() async{
  //}

  Future<void> logout() async {
    try {
      //await GoogleSignIn().signOut();
      //await FacebookAuth.instance.logOut();
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw e.message!;
    } on FormatException catch (e){
      throw e.message;
    } catch (e){
      throw 'Logout não concluido. Tente novamente';
    }
  }
}
