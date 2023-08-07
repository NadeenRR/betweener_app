import 'package:flutter/material.dart';
import '../constants.dart';
import '../controllers/follow_cont.dart';
import '../models/follow.dart';
import '../models/search.dart' as search;

class FrindesView extends StatefulWidget {
  static String id = "/friendView";

  const FrindesView({super.key, required this.userInfo});
  final search.User userInfo;

  @override
  State<FrindesView> createState() => _FrindesViewState();
}

class _FrindesViewState extends State<FrindesView> {
  Future<Follow>? follow;

  String buttonText = 'Follow';
  bool isFollowing = false;
  bool isButtonDisabled = false;

  Future<void> _toggleFollow() async {
    if (isButtonDisabled) return;

    setState(() {
      isButtonDisabled = true;
    });

    try {
      if (isFollowing) {
      } else {
        addFollower({'followee_id': "${widget.userInfo.id}"}).then((value) {
          setState(() {
            follow = getFollow(context);
          });
        });
      }

      setState(() {
        isFollowing = !isFollowing;
        buttonText = isFollowing ? 'Following' : 'Follow';
      });
    } finally {
      setState(() {
        isButtonDisabled = false;
      });
    }
  }

  @override
  void initState() {
    follow = getFollow(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "${widget.userInfo.name}",
            style: const TextStyle(
              fontSize: 20,
              color: kPrimaryColor,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: kPrimaryColor,
            ),
          )),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: kPrimaryColor, borderRadius: BorderRadius.circular(24)),
            child: Row(children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80'),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.userInfo.name}".toUpperCase(),
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Text(
                    "${widget.userInfo.email}",
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isFollowing ? Colors.transparent : kSecondaryColor,
                        side: BorderSide(
                          color: isFollowing
                              ? kSecondaryColor
                              : Colors.transparent,
                          width: 2.0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: isButtonDisabled ? null : _toggleFollow,
                      child: Text(
                        buttonText,
                        style: TextStyle(
                            color: isFollowing ? Colors.white : Colors.black,
                            fontSize: 14),
                      )),
                ],
              )
            ]),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 8,
                    );
                  },
                  itemCount: widget.userInfo.links!.length,
                  itemBuilder: (context, index) {
                    if (widget.userInfo.links!.isEmpty) {
                      return const Center(
                        child: Text("No Links Belong to this user"),
                      );
                    } else {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 22),
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: index % 2 == 0
                              ? const Color(0xffFEE2E7)
                              : const Color(0xffE7E5F1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${widget.userInfo.links![index].title}"
                                      .toUpperCase(),
                                  style: TextStyle(
                                    letterSpacing: 4,
                                    fontSize: 16,
                                    color: index % 2 == 0
                                        ? const Color(0xff783341)
                                        : const Color(0xff2D2B4E),
                                  ),
                                ),
                                Text(
                                  "${widget.userInfo.links![index].link}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: index % 2 == 0
                                        ? const Color(0xff783341)
                                        : const Color(0xff2D2B4E),
                                  ),
                                )
                              ]),
                        ),
                      );
                    }
                  }),
            ),
          )
        ],
      ),
    );
  }
}
