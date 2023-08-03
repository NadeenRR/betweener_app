import 'package:flutter/material.dart';
import 'package:tt9_betweener_challenge/models/follow.dart';

import '../constants.dart';
import '../controllers/follow_cont.dart';
import '../controllers/link_cont.dart';
import '../controllers/user_cont.dart';
import '../models/link.dart';
import '../models/user.dart';

class ProfileView extends StatefulWidget {
  static String id = '/profileView';

  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  Future<User>? user;
  Future<List<Links>>? links;
  Future<Follow>? follow;
  @override
  void initState() {
    user = getLocalUser();
    links = getLinks(context);
    follow = getFollow(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 44),
      child: Column(
        //  crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Profile',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: kPrimaryColor,
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              const Icon(
                Icons.edit_outlined,
                color: Colors.white,
                size: 28,
              ),
              Row(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80'),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Column(
                    children: [
                      FutureBuilder(
                        future: user,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${snapshot.data!.user!.name}',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 22),
                                ),
                                Text(
                                  '${snapshot.data!.user!.email}',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 22),
                                ),
                                Text(
                                  '${snapshot.data!.user!.id}',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 22),
                                ),
                              ],
                            );
                          }
                          return const Text('loading....');
                        },
                      ),
                      FutureBuilder(
                        future: follow,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: kSecondaryColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                      'follow: ${snapshot.data!.followingCount}'),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: kSecondaryColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                      'following: ${snapshot.data!.followersCount}'),
                                ),
                              ],
                            );
                          }
                          if (snapshot.hasError) {
                            return Text(snapshot.error.toString());
                          }
                          return const Text('loading....');
                        },
                      ),
                    ],
                  )
                ],
              ),
            ]),
          ),
          const SizedBox(height: 8),
          FutureBuilder(
            future: links,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(12),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Container(
                        width: double.infinity,
                        margin: const EdgeInsets.all(8),
                        padding:
                            const EdgeInsets.only(top: 20, bottom: 20, left: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: kLightDangerColor,
                        ),
                        child: Text(
                          snapshot.data![index].title!,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        width: 8,
                      );
                    },
                    itemCount: snapshot.data!.length,
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
