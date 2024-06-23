import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_home_control/models/color.dart';
import 'package:smart_home_control/models/member.dart';

import '../widgets/group_member_card.dart';

class AboutUsScreen extends StatelessWidget {
  AboutUsScreen({super.key});
  final List<Member> groupMembers = [
    Member(
      name: "Heng Kakada",
      description: "Developer",
      position: "Team Leader",
      img: "assets/images/heng_kakada.jpg",
    ),
    Member(
      name: "Houy Norin",
      description: "Som null sin",
      position: "Member",
      img: "assets/images/bro_rin.jpg",
    ),
    Member(
      name: "Veng Rocky",
      description: "null too",
      position: "Member",
      img: "assets/images/veng_rocky.jpg",
    ),
    Member(
      name: "Ho Daneng",
      description: "null too",
      position: "Member",
      img: "assets/images/ho_daneng.jpg",
    ),
    Member(
      name: "Ho Lydavid",
      description: "Bro do nothing",
      position: "Member",
      img: "assets/images/ho_lydavid.jpg",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            children: [
              const Text(
                "About Us",
                style: TextStyle(
                  fontSize: 26,
                  // fontStyle: FontStyle.italic,
                  fontFamily: "Lobster",
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 15,
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: groupMembers.length,
                itemBuilder: (context, index) => GroupMemberCard(
                  member: groupMembers[index],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
