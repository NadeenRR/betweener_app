import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tt9_betweener_challenge/views/search_view.dart';
import 'package:tt9_betweener_challenge/views/widgets/add_link.dart';

import '../constants.dart';
import '../controllers/link_cont.dart';
import '../controllers/user_cont.dart';
import '../models/link.dart' as linkmodel;
import '../models/user.dart';

class HomeView extends StatefulWidget {
  static String id = '/homeView';
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Future<User>? user;
  Future<List<linkmodel.Links>>? links;
  @override
  void initState() {
    user = getLocalUser();
    print('jjjjjjj');
    links = getLinks(context);
    print('sssssss');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 54),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              FutureBuilder(
                  future: user,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        'Welcome ${snapshot.data!.user!.name}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: kDefaultIconDarkColor,
                        ),
                      );
                    }
                    return const Text('loading....');
                  }),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () => Navigator.pushNamed(context, SearchView.id),
              ),
              const SizedBox(
                width: 8,
              ),
              const Icon(Icons.qr_code_scanner),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          Image.asset(
            'assets/imgs/qr_code.png',
            height: 420,
          ),
          FutureBuilder(
            future: links,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SizedBox(
                  height: 130,
                  child: Row(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.all(12),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            if (index == snapshot.data!.length) {
                              return GestureDetector(
                                onTap: () => Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const AddNewLink();
                                })).then((value) {
                                  setState(() {
                                    links = getLinks(context);
                                  });
                                }),
                                child: Container(
                                  padding: const EdgeInsets.all(24),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: kLightPrimaryColor,
                                  ),
                                  child: const Column(
                                    children: [
                                      Icon(
                                        Icons.add,
                                        color: kPrimaryColor,
                                      ),
                                      Text(
                                        'Add new link',
                                        style: TextStyle(
                                          color: kPrimaryColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }
                            if (index < snapshot.data!.length) {
                              final link = snapshot.data?[index].title;

                              return Container(
                                padding: const EdgeInsets.all(24),
                                decoration: BoxDecoration(
                                  color: kSecondaryColor,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '$link',
                                      style: const TextStyle(
                                          color: kOnSecondaryColor),
                                    ),
                                    Text(
                                      '@ ${snapshot.data?[index].username}',
                                      style: const TextStyle(
                                          color: kOnSecondaryColor),
                                    ),
                                  ],
                                ),
                              );
                            }
                            return null;
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              width: 8,
                            );
                          },
                          itemCount: snapshot.data!.length + 1,
                        ),
                      ),
                    ],
                  ),
                );
              }
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return const Text('loading');
            },
          ),
        ],
      ),
    );
  }
}