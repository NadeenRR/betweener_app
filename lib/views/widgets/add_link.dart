import 'package:flutter/material.dart';
import 'package:tt9_betweener_challenge/views/widgets/secondary_button_widget.dart';

import '../../controllers/link_cont.dart';
import 'custom_text_form_field.dart';

class AddNewLink extends StatefulWidget {
  static String id = '/newLink';
  const AddNewLink({super.key});

  @override
  State<AddNewLink> createState() => _AddNewLinkState();
}

class _AddNewLinkState extends State<AddNewLink> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController linkController = TextEditingController();

  void addlink() async {
    if (_formKey.currentState!.validate()) {
      final body = {
        "title": titleController.text,
        "link": linkController.text,
      };
      addNewlink(body).then((value) {}).catchError((err) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            err.toString(),
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Link",
          style: TextStyle(fontSize: 18),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const Spacer(),
              CustomTextFormField(
                controller: titleController,
                hint: 'Snapshat',
                keyboardType: TextInputType.text,
                autofillHints: const [AutofillHints.email],
                label: 'Title',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter the title';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 14,
              ),
              CustomTextFormField(
                controller: linkController,
                hint: 'http:\\www.Example.com',
                label: 'link',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter the link';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 24,
              ),
              SecondaryButtonWidget(
                  onTap: () {
                    addlink();
                    Navigator.pop(context);
                  },
                  text: 'ADD'),
              const Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
