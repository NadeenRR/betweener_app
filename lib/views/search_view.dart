import 'package:flutter/material.dart';
import 'package:tt9_betweener_challenge/views/widgets/custom_text_form_field.dart';
import '../controllers/search_cont.dart';
import '../models/search.dart';

class SearchView extends StatefulWidget {
  static String id = '/searchView';

  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  Future<Search>? searchFuture;

  TextEditingController searchController = TextEditingController();
  late String searchQuery = '';
  Future<Search> search() async {
    Map<String, dynamic> searchParams = {'name': searchQuery};

    return searchUsersByName(searchParams);
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomTextFormField(
              onChange: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              controller: searchController,
              hint: 'Search',
              keyboardType: TextInputType.text,
              label: 'search',
            ),
          ),
          Expanded(
            child: FutureBuilder<Search>(
              future: search(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text(
                          'Error: ${snapshot.error}')); 
                } else if (!snapshot.hasData) {
                  return const Center(child: Text('No data found.'));
                } else {
                  Search searchResults = snapshot.data!;
                  return ListView.builder(
                    itemCount: searchResults.user!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text('${snapshot.data!.user![index].name}'),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
