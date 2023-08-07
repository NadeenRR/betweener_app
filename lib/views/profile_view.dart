import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tt9_betweener_challenge/models/follow.dart';

import '../constants.dart';
import '../controllers/delete_link_cont.dart';
import '../controllers/follow_cont.dart';
import '../controllers/link_cont.dart';
import '../controllers/user_cont.dart';
import '../models/link.dart';
import '../models/user.dart';
import 'add_link.dart';
import 'edit_link_view.dart';
import 'edit_profile_view.dart';

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
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Padding(
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
                  padding: const EdgeInsets.only(
                    bottom: 32,
                    left: 12,
                    right: 12,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: kPrimaryColor,
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconButton(
                            iconSize: 18,
                            onPressed: () async {
                              await Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const EditProfileView();
                              })).then((value) {});
                            },
                            icon: const Icon(
                              Icons.edit_outlined,
                              color: Colors.white,
                              size: 28,
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                  'https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=464&q=80'),
                            ),
                            const SizedBox(
                              width: 18,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FutureBuilder(
                                  future: user,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            snapshot.data!.user!.name!
                                                .toUpperCase(),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                          Text(
                                            '${snapshot.data!.user!.email}',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                          ),
                                          Text(
                                            "+9701234567".toUpperCase(),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                          ),
                                        ],
                                      );
                                    }
                                    return const Text('loading....');
                                  },
                                ),
                                const SizedBox(
                                  height: 12,
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
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: GestureDetector(
                                              onTap: () {
                                                int followersUser = snapshot
                                                    .data!.followers!.length;
                                                showModalBottomSheet<dynamic>(
                                                  context: context,
                                                  isScrollControlled: true,
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.vertical(
                                                      top:
                                                          Radius.circular(25.0),
                                                    ),
                                                  ),
                                                  builder:
                                                      (BuildContext context) {
                                                    return Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.75,
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  25.0),
                                                          topRight:
                                                              Radius.circular(
                                                                  25.0),
                                                        ),
                                                      ),
                                                      child: Expanded(
                                                        child:
                                                            ListView.separated(
                                                          physics:
                                                              const BouncingScrollPhysics(),
                                                          itemBuilder:
                                                              (context, index) {
                                                            return ListTile(
                                                              title: Text(
                                                                '${snapshot.data!.followers![index]['name']}',
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 18,
                                                                ),
                                                              ),
                                                              subtitle: Text(
                                                                snapshot.data!
                                                                        .followers![
                                                                    index]['email'],
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 16,
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          separatorBuilder:
                                                              (context,
                                                                      index) =>
                                                                  const Divider(
                                                            color:
                                                                Colors.black38,
                                                          ),
                                                          itemCount:
                                                              followersUser,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              child: Text(
                                                  'followers: ${snapshot.data!.followersCount}'),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              color: kSecondaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: GestureDetector(
                                              onTap: () {
                                                int followingUser = snapshot
                                                    .data!.following!.length;
                                                showModalBottomSheet<dynamic>(
                                                  context: context,
                                                  isScrollControlled: true,
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.vertical(
                                                      top:
                                                          Radius.circular(25.0),
                                                    ),
                                                  ),
                                                  builder:
                                                      (BuildContext context) {
                                                    return Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.75,
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  25.0),
                                                          topRight:
                                                              Radius.circular(
                                                                  25.0),
                                                        ),
                                                      ),
                                                      child: Expanded(
                                                        child:
                                                            ListView.separated(
                                                          physics:
                                                              const BouncingScrollPhysics(),
                                                          itemBuilder:
                                                              (context, index) {
                                                            return ListTile(
                                                              title: Text(
                                                                '${snapshot.data!.following![index]['name']}',
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 18,
                                                                ),
                                                              ),
                                                              subtitle: Text(
                                                                snapshot.data!
                                                                        .following![
                                                                    index]['email'],
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 16,
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          separatorBuilder:
                                                              (context,
                                                                      index) =>
                                                                  const Divider(
                                                            color:
                                                                Colors.black38,
                                                          ),
                                                          itemCount:
                                                              followingUser,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              child: Text(
                                                  'following: ${snapshot.data!.followingCount}'),
                                            ),
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
                FutureBuilder(
                  future: links,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.only(top: 12, bottom: 12),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            if (snapshot.hasData) {
                              return Slidable(
                                endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    SlidableAction(
                                      //   flex: 2,
                                      onPressed: (context) async {
                                        await Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return EditLinkView(
                                              idlink: snapshot.data?[index].id);
                                        }));
                                      },
                                      foregroundColor: Colors.white,
                                      autoClose: true,
                                      icon: Icons.edit,
                                      backgroundColor: const Color(0xffFFD465),
                                      borderRadius: BorderRadius.circular(15),
                                      padding: const EdgeInsets.all(0),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    SlidableAction(
                                      //    flex: 2,
                                      autoClose: true,
                                      onPressed: (context) {
                                        deleteLink(snapshot.data?[index].id)
                                            .then((value) {
                                          setState(() {
                                            links = getLinks(context);
                                          });
                                        });
                                      },
                                      icon: Icons.delete_outline_outlined,
                                      backgroundColor: const Color(0xffF56C61),
                                      borderRadius: BorderRadius.circular(15),
                                      padding: const EdgeInsets.all(0),
                                    ),
                                  ],
                                ),
                                child: Container(
                                  width: double.infinity,
                                  margin:
                                      const EdgeInsets.only(top: 8, bottom: 8),
                                  padding: const EdgeInsets.only(
                                      top: 20, bottom: 20, left: 8),
                                  decoration: BoxDecoration(
                                      color: index % 2 == 0
                                          ? const Color(0xffFEE2E7)
                                          : const Color(0xffE7E5F1),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data![index].title!
                                              .toUpperCase(),
                                          style: TextStyle(
                                            letterSpacing: 4,
                                            fontSize: 20,
                                            color: index % 2 == 0
                                                ? const Color(0xff783341)
                                                : const Color(0xff2D2B4E),
                                          ),
                                        ),
                                        Text(
                                          '${snapshot.data![index].link}',
                                          style: TextStyle(
                                            color: index % 2 == 0
                                                ? const Color(0xff9B6A73)
                                                : const Color(0xff807D99),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
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
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 96, right: 16),
            child: FloatingActionButton(
              backgroundColor: const Color(0xff2D2B4E),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const AddNewLink();
                })).then((value) {
                  setState(() {
                    links = getLinks(context);
                  });
                });
              },
              shape: const CircleBorder(),
              child: const Icon(
                Icons.add,
                size: 32,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
