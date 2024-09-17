import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

class CompleteForm extends StatefulWidget {
  const CompleteForm({super.key});

  @override
  State<CompleteForm> createState() {
    return _CompleteFormState();
  }
}

class _CompleteFormState extends State<CompleteForm> {
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final _formKey = GlobalKey<FormBuilderState>();
  final bool _ageHasError = false;
  final bool _genderHasError = false;

  List<String> languageOptions = [
    'English',
    'Mandarin',
    'Hindi',
    'Spanish',
    'Arabic',
    'French',
    'Swedish',
    'Danish',
  ];

  Map<String, String> languageOptionsMap = {
    'English': 'E',
    'Mandarin': 'M',
    'Hindi': 'H',
    'Spanish': 'S',
    'Arabic': 'A',
    'French': 'F',
    'Swedish': 'S',
    'Danish': 'D',
  };

  List<String> genderOptions = [
    'Male',
    'Female',
    'Rainbow gender',
    'Bisexual',
    'Pansexual',
    'Nonbinary',
    'Transgender',
    'Asexual',
    'Intersex',
    'Gay Man',
    'Lesbian',
    'Polysexual',
    'Agender',
    'Androgyne',
    'Genderfluid',
    'Genderqueer',
    'Neutrois',
    'Omnisexual',
    'Aromantic',
    'Demisexual',
    'Demiromantic',
    'Polyamorous',
    'Straight ally',
    'Other',
  ];

  void _onChanged(dynamic val) => debugPrint(val.toString());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          FormBuilder(
            key: _formKey,
            onChanged: () {
              _formKey.currentState!.save();
              debugPrint(_formKey.currentState!.value.toString());
            },
            autovalidateMode: AutovalidateMode.disabled,
            initialValue: {
              'age': '21',
              'gender': 'Straight ally',
              'best_language': 'French',
              'languages_filter': const ['Hindi', 'Arabic', 'Swedish'],
              'languages_choice': 'English',
              'languages': const ['Spanish', 'Mandarin', 'Danish'],
              'accept_terms_switch': true,
              'accept_terms': true,
              'range_slider': const RangeValues(40, 80),
              'date': DateTime.now(),
              //'date_range':DateTime.now(),
            },
            skipDisabled: true,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 8),
                createFormBuilderSlider(_onChanged),
                const SizedBox(height: 8),
                createFormBuilderRangeSlider(_formKey, _onChanged),
                const SizedBox(height: 8),
                createFormBuilderCheckBox(_onChanged),
                const SizedBox(height: 8),
                createFormBuilderTextField(_ageHasError, _formKey, setState),
                const SizedBox(height: 8),
                createFormBuilderSwitch(_onChanged),
                const SizedBox(height: 8),
                createFormBuilderFilterChip(_onChanged, languageOptionsMap),
                const SizedBox(height: 8),
                createFormBuilderCheckboxGroup(_onChanged, languageOptions),
                const SizedBox(height: 8),
                createFormBuilderRadioGroup(_onChanged, languageOptions),
                const SizedBox(height: 8),
                createFormBuilderChoiceChip(_onChanged, languageOptionsMap),
                const SizedBox(height: 8),
                createFormBuilderDropdown(
                    _genderHasError, genderOptions, setState, _formKey),
                const SizedBox(height: 8),
                createFormBuilderDateTimePicker(_formKey),
                const SizedBox(height: 8),
                createFormBuilderDateRangePicker(_onChanged, _formKey),
                const SizedBox(height: 8),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.saveAndValidate() ?? false) {
                        debugPrint(_formKey.currentState?.value.toString());
                      } else {
                        debugPrint(_formKey.currentState?.value.toString());
                        debugPrint('validation failed');
                      }
                    },
                    child: const Text('Submit')),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    _formKey.currentState?.reset();
                  },
                  child: const Text('Reset'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

FormBuilderDateRangePicker createFormBuilderDateRangePicker(
    onChanged, formKey) {
  return FormBuilderDateRangePicker(
    name: 'date_range',
    firstDate: DateTime(1970),
    lastDate: DateTime(2030),
    format: DateFormat('yyyy-MM-dd'),
    onChanged: onChanged,
    decoration: InputDecoration(
      labelText: 'Date Range',
      helperText: 'Helper text',
      hintText: 'Hint text',
      suffixIcon: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          formKey.currentState!.fields['date_range']?.didChange(null);
        },
      ),
    ),
  );
}

FormBuilderDateTimePicker createFormBuilderDateTimePicker(formKey) {
  return FormBuilderDateTimePicker(
    name: 'date',
    initialEntryMode: DatePickerEntryMode.calendar,
    //initialValue: DateTime.now(),
    inputType: InputType.both,
    decoration: InputDecoration(
      labelText: 'Appointment Time',
      suffixIcon: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          formKey.currentState!.fields['date']?.didChange(null);
        },
      ),
    ),
    initialTime: const TimeOfDay(hour: 8, minute: 0),
  );
}

FormBuilderSlider createFormBuilderSlider(onChanged) {
  return FormBuilderSlider(
    name: 'slider',
    validator: FormBuilderValidators.compose([
      FormBuilderValidators.min(6),
    ]),
    onChanged: onChanged,
    min: 0.0,
    max: 10.0,
    initialValue: 5,
    divisions: 20,
    activeColor: Colors.red,
    inactiveColor: Colors.pink[100],
    decoration: const InputDecoration(
      labelText: 'Number of things',
    ),
  );
}

FormBuilderRangeSlider createFormBuilderRangeSlider(formKey, onChanged) {
  return FormBuilderRangeSlider(
    name: 'range_slider',
    onChanged: onChanged,
    min: 0.0,
    max: 100.0,
    divisions: 20,
    maxValueWidget: (max) => TextButton(
      onPressed: () {
        formKey.currentState?.patchValue(
          {'range_slider': const RangeValues(4, 100)},
        );
      },
      child: Text(max),
    ),
    activeColor: Colors.red,
    inactiveColor: Colors.pink[100],
    decoration: const InputDecoration(labelText: 'Price Range'),
  );
}

FormBuilderCheckbox createFormBuilderCheckBox(onChanged) {
  return FormBuilderCheckbox(
    name: 'accept_terms',
    onChanged: onChanged,
    title: RichText(
      text: const TextSpan(
        children: [
          TextSpan(
            text: 'I have read and agree to the ',
            style: TextStyle(color: Colors.black),
          ),
          TextSpan(
            text: 'Terms and Conditions',
            style: TextStyle(color: Colors.blue),
          ),
        ],
      ),
    ),
    validator: FormBuilderValidators.equal(
      true,
      errorText: 'You must accept terms and conditions to continue',
    ),
  );
}

FormBuilderTextField createFormBuilderTextField(
    ageHasError, formKey, setState) {
  return FormBuilderTextField(
    autovalidateMode: AutovalidateMode.always,
    name: 'age',
    decoration: InputDecoration(
      labelText: 'Age',
      suffixIcon: ageHasError
          ? const Icon(Icons.error, color: Colors.red)
          : const Icon(Icons.check, color: Colors.green),
    ),
    onChanged: (val) {
      setState(() {
        ageHasError =
            !(formKey.currentState?.fields['age']?.validate() ?? false);
      });
    },
    validator: FormBuilderValidators.compose([
      FormBuilderValidators.required(),
      FormBuilderValidators.numeric(),
      FormBuilderValidators.max(21),
      FormBuilderValidators.min(18),
    ]),
    keyboardType: TextInputType.number,
    textInputAction: TextInputAction.next,
  );
}

FormBuilderSwitch createFormBuilderSwitch(onChanged) {
  return FormBuilderSwitch(
    title: const Text('I Accept the terms and conditions'),
    name: 'accept_terms_switch',
    onChanged: onChanged,
  );
}

FormBuilderChoiceChip createFormBuilderChoiceChip(
    onChanged, Map<String, String> languageOptionsMap) {
  return FormBuilderChoiceChip<String>(
    autovalidateMode: AutovalidateMode.onUserInteraction,
    decoration: const InputDecoration(
        labelText: 'Ok, if I had to choose one language, it would be:'),
    name: 'languages_choice',
    options: languageOptionsMap.entries
        .map((entry) => FormBuilderChipOption(
              value: entry.key,
              avatar: CircleAvatar(child: Text(entry.value)),
            ))
        .toList(growable: false),
    onChanged: onChanged,
  );
}

FormBuilderFilterChip createFormBuilderFilterChip(
    onChanged, Map<String, String> languageOptionsMap) {
  return FormBuilderFilterChip<String>(
    autovalidateMode: AutovalidateMode.onUserInteraction,
    decoration: const InputDecoration(labelText: 'The language of my people'),
    name: 'languages_filter',
    selectedColor: Colors.red,
    options: languageOptionsMap.entries
        .map((entry) => FormBuilderChipOption(
              value: entry.key,
              avatar: CircleAvatar(child: Text(entry.value)),
            ))
        .toList(growable: false),
    onChanged: onChanged,
    validator: FormBuilderValidators.compose([
      FormBuilderValidators.minLength(1),
      FormBuilderValidators.maxLength(3),
    ]),
  );
}

FormBuilderCheckboxGroup createFormBuilderCheckboxGroup(
    onChanged, List<String> languageOptions) {
  return FormBuilderCheckboxGroup<String>(
    autovalidateMode: AutovalidateMode.onUserInteraction,
    decoration: const InputDecoration(labelText: 'The language of my people'),
    name: 'languages',
    options: languageOptions
        .map((lang) => FormBuilderFieldOption(
              value: lang,
              child: Text(lang),
            ))
        .toList(growable: false),
    onChanged: onChanged,
    separator: const VerticalDivider(
      width: 10,
      thickness: 5,
      color: Colors.red,
    ),
    validator: FormBuilderValidators.compose([
      FormBuilderValidators.minLength(1),
      FormBuilderValidators.maxLength(3),
    ]),
  );
}

FormBuilderRadioGroup createFormBuilderRadioGroup(
    onChanged, List<String> languageOptions) {
  return FormBuilderRadioGroup<String>(
    decoration: const InputDecoration(
      labelText: 'My chosen language',
    ),
    name: 'best_language',
    onChanged: onChanged,
    validator:
        FormBuilderValidators.compose([FormBuilderValidators.required()]),
    options: languageOptions
        .map((lang) => FormBuilderFieldOption(
              value: lang,
              child: Text(lang),
            ))
        .toList(growable: false),
    controlAffinity: ControlAffinity.leading,
  );
}

FormBuilderDropdown createFormBuilderDropdown(
    genderHasError, List<String> genderOptions, setState, formKey) {
  return FormBuilderDropdown<String>(
    name: 'gender',
    decoration: InputDecoration(
      labelText: 'Gender',
      suffix:
          genderHasError ? const Icon(Icons.error) : const Icon(Icons.check),
      hintText: 'Select Gender',
    ),
    validator:
        FormBuilderValidators.compose([FormBuilderValidators.required()]),
    items: genderOptions
        .map((gender) => DropdownMenuItem(
              alignment: AlignmentDirectional.center,
              value: gender,
              child: Text(gender),
            ))
        .toList(),
    onChanged: (val) {
      setState(() {
        genderHasError =
            !(formKey.currentState?.fields['gender']?.validate() ?? false);
      });
    },
    valueTransformer: (val) => val?.toString(),
  );
}
