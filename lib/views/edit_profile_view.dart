import 'package:flutter/material.dart';
import 'package:tt9_betweener_challenge/views/widgets/custom_text_form_field.dart';

import 'package:tt9_betweener_challenge/views/widgets/secondary_button_widget.dart';

class EditProfileView extends StatefulWidget {
  static const id = '/EditProfileView';

  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneContoller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 28,
            color: Color(0xff2D2B4E),
          ),
        ),
        title: const Text('Edit User Info'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextFormField(
                  controller: nameController,
                  hint: 'name',
                  label: 'Name',
                ),
                const SizedBox(height: 22),
                CustomTextFormField(
                  controller: emailController,
                  hint: 'email',
                  label: 'email',
                ),
                const SizedBox(height: 22),
                SecondaryButtonWidget(onTap: () {}, text: 'Edit'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
