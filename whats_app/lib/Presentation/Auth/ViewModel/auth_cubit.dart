import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_number/mobile_number.dart';
import 'package:whats_app/Data/apis.dart';
import 'package:whats_app/Domain/language_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:country_codes/country_codes.dart';

import '../../../Data/shared_preferences.dart';
import '../../Resources/routes_manager.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

  init() async {
    final CountryDetails details = CountryCodes.detailsForLocale();
    countryController = TextEditingController();
    codeController = TextEditingController();
    phoneController = TextEditingController();
    countryController.text = details.name!;
    codeController.text = details.dialCode!;
  }

  //Variables
  int timeSendCode = 30;
  bool loading = false;
  String? smsCode;
  GlobalKey<FormState> loginForm = GlobalKey<FormState>();
  Country? country;
  String groupValue = CachHelper.sharedPreferences.get("language") == null
      ? Platform.localeName.split("_").first
      : CachHelper.sharedPreferences.get("language").toString();
  late TextEditingController countryController;
  late TextEditingController codeController;
  late TextEditingController phoneController;

  //Lists
  List<LanguageModel> listOfLanguage(BuildContext context) {
    return [
      LanguageModel("ar", AppLocalizations.of(context)!.arbic,
          AppLocalizations.of(context)!.disArbic),
      LanguageModel("en", AppLocalizations.of(context)!.english,
          AppLocalizations.of(context)!.disEnglish),
    ];
  }

  //Funcations
  void incrementTimeSendCode() {
    if (timeSendCode > 0) {
      Future.delayed(const Duration(seconds: 1), () {
        timeSendCode--;
        incrementTimeSendCode();
      });
    }
    emit(IncrementTimeSendCodeState());
  }

  void chooseCountry(Country c) {
    country = c;
    codeController.text = "+${country!.phoneCode}";
    countryController.text = country!.name;
    emit(GetCountryState());
  }

  Future<List<SimCard>?> getPhoneNumber() async {
    bool phoneReqest = await MobileNumber.hasPhonePermission;
    if (phoneReqest) {
      final List<SimCard>? simCards = await MobileNumber.getSimCards;
      return simCards;
    } else {
      await MobileNumber.requestPhonePermission;
      if (phoneReqest) {
        final List<SimCard>? simCards = await MobileNumber.getSimCards;
        return simCards;
      }
    }
    return null;
  }

  ThemeMode? getTheme() {
    if (CachHelper.sharedPreferences.get("theme") == true) {
      return ThemeMode.light;
    } else if (CachHelper.sharedPreferences.get("theme") == false) {
      return ThemeMode.dark;
    }
    emit(UpdateThemeState());
    return null;
  }

  Future changeTheme() async {
    if (CachHelper.sharedPreferences.get("theme") == false) {
      await CachHelper.saveLocalData("theme", true);
    } else {
      await CachHelper.saveLocalData("theme", false);
    }
    emit(UpdateThemeState());
  }

  Locale getLocale() {
    if (CachHelper.sharedPreferences.get("language") != null) {
      return Locale(
          CachHelper.sharedPreferences.get("language").toString(), "");
    } else {
      return Locale(Platform.localeName.split("_").first, "");
    }
  }

  Future<bool> changeLanguage(String code) async {
    bool languageCode = await CachHelper.saveLocalData("language", code);
    emit(UpdateLangState());
    return languageCode;
  }

  sendOtp() async {
    await Apis().otp("${codeController.text.trim()}${phoneController.text}");
  }

  signinPhone(String sms, BuildContext context) async {
    loading = true;
    emit(SignInLoadingState());
    await Apis().signPhone(Apis.id!, sms, context).then((value) async {
      //User
      await getDataUser();
      await saveDataUser();
      //User
      loading = false;
      emit(SignInSuccessState());
      Navigator.of(context)
          .pushNamedAndRemoveUntil(Pages.info, (route) => false);
      CachHelper.saveLocalData("login", true);
    }).catchError((error) {
      loading = false;
      emit(SignInErrorgState());
    });
  }

  Future<void> saveDataUser() async {
    await Apis().saveDataUser();
  }

  Future<void> getDataUser() async {
    await Apis().getDataUser();
  }
}
