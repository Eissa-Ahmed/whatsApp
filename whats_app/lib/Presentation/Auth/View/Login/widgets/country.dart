import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

import '../../../ViewModel/auth_cubit.dart';

void showcountries(BuildContext context, AuthCubit cubit) {
  return showCountryPicker(
    searchAutofocus: true,
    showPhoneCode: true,
    context: context,
    countryListTheme: CountryListThemeData(
      searchTextStyle: Theme.of(context).textTheme.bodySmall,
      flagSize: 25,
      backgroundColor: Theme.of(context).primaryColorLight,
      textStyle: Theme.of(context).textTheme.bodySmall,
      bottomSheetHeight: double.infinity,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
      inputDecoration: InputDecoration(
        labelText: 'Search',
        hintText: 'Start typing to search',
        prefixIcon: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.close,
            color: Theme.of(context).primaryColorDark,
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: const Color(0xFF8C98A8).withOpacity(0.2),
          ),
        ),
      ),
    ),
    onSelect: (Country country) {
      cubit.chooseCountry(country);
    },
  );
}
