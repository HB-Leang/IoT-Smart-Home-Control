import 'package:flutter/material.dart';
import 'package:smart_home_control/models/member.dart';

import '../models/color.dart';

class GroupMemberCard extends StatelessWidget {
  final Member member;
  const GroupMemberCard({
    super.key,
    required this.member,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Card(
        color: mainColor,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage(member.img),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      // width: 200,
                      // color: Colors.red,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            member.name,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.amberAccent),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            member.description,
                            style: const TextStyle(
                                fontSize: 14, color: Colors.white),
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      member.position,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: "BabasNeue"),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
