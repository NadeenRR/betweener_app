import 'package:flutter/material.dart';
import 'package:tt9_betweener_challenge/views/widgets/custom_text_form_field.dart';
import 'package:tt9_betweener_challenge/views/widgets/secondary_button_widget.dart';

import '../controllers/search_cont.dart';
import '../models/search.dart';
import 'main_app_view.dart';

class SearchView extends StatefulWidget {
  static String id = '/searchView';

  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  Future<Search>? searchFuture;

  TextEditingController searchController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Future<Search>? searchItem;
  void search() {
    if (_formKey.currentState!.validate()) {
      final body = {
        'name': searchController.text,
      };

      searchUsersByName(body).then((user) async {
        if (mounted) {
          Navigator.pushNamed(context, MainAppView.id);
        }
      }).catchError((err) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(err.toString()),
          backgroundColor: Colors.red,
        ));
      });
    }
  }

  @override
  void initState() {
    searchItem = searchUsersByName({
      'name': searchController.text,
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Search",
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
              //   const Spacer(),
              CustomTextFormField(
                onChange: (query) {
                  setState(() {});
                },
                controller: searchController,
                hint: 'Search',
                keyboardType: TextInputType.text,
                autofillHints: const [AutofillHints.email],
                label: 'search',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'search by name';
                  }
                  return null;
                },
              ),

              const SizedBox(
                height: 24,
              ),

              SecondaryButtonWidget(onTap: search, text: 'search'),

              Expanded(
                child: FutureBuilder<Search>(
                  future: searchItem,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final searchResults = snapshot.data!.user;
                      return ListView.builder(
                        itemCount: searchResults!.length,
                        itemBuilder: (context, index) {
                          final user = searchResults[index];
                          return ListTile(
                            title: Text(user.name ?? ''),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: user.links!.map((link) {
                                return Text('${link.title}: ${link.link}');
                              }).toList(),
                            ),
                          );
                        },
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {}
                    return const Text('loading');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
