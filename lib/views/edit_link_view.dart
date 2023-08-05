import 'package:flutter/material.dart';
import 'package:tt9_betweener_challenge/views/profile_view.dart';
import 'package:tt9_betweener_challenge/views/widgets/custom_text_form_field.dart';
import '../controllers/update_link_cont.dart';

class EditLinkView extends StatefulWidget {
  static const id = '/EditLinkView';
  final int? idlink;
  const EditLinkView({super.key, this.idlink});

  @override
  State<EditLinkView> createState() => _EditLinkViewState();
}

class _EditLinkViewState extends State<EditLinkView> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _linkController = TextEditingController();
  TextEditingController _userContoller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Future<Link>? new_links;
  // Link link = Link();
  @override
  void dispose() {
    _titleController.dispose();
    _linkController.dispose();
    super.dispose();
  }

  Future<bool>? saveNewLink() {
    if (_formKey.currentState!.validate()) {
      final body = {
        'title': _titleController.text,
        'link': _linkController.text,
        'user': _userContoller.text
      };

      print(body['title']);
      print(widget.idlink);
      updateLink(body, widget.idlink).then((link) async {
        print(widget.idlink);
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return const ProfileView();
          }),
        );
        return true;
        // ignore: body_might_complete_normally_catch_error
      }).catchError((err) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(err.toString()),
          backgroundColor: Colors.red,
        ));
      });
    }
    return null;
  }

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
        title: const Text('Edit Link'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                CustomTextFormField(
                  controller: _titleController,
                  hint: 'Snapchat',
                  label: 'title',
                ),
                const SizedBox(height: 28),
                CustomTextFormField(
                  controller: _linkController,
                  hint: 'http:\\www.Example.com',
                  label: 'Link',
                ),
                const SizedBox(height: 28),
                CustomTextFormField(
                  controller: _userContoller,
                  hint: '@Rawnd',
                  label: 'User Name:',
                ),
                const SizedBox(height: 28),
                ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            15,
                          ),
                        ),
                      ),
                    ),
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(
                        vertical: 18,
                        horizontal: 60,
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color(0xffFFD465),
                    ),
                  ),
                  onPressed: saveNewLink,
                  child: const Text(
                    'SAVE',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff784E00),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
