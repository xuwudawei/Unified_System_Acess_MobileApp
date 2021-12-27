import 'package:flutter/material.dart';
import 'package:particles_flutter/particles_flutter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor: Colors.grey.shade100,

      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            CircularParticle(
              // key: UniqueKey(),
              awayRadius: 300,
              numberOfParticles: 70,
              speedOfParticles: 1,
              height: screenHeight,
              width: screenWidth,
              onTapAnimation: true,
              particleColor: Colors.orange.shade500,
              awayAnimationDuration: Duration(milliseconds: 8000),
              maxParticleSize: 3,
              isRandSize: true,
              isRandomColor: true,
              randColorList: [
                // Colors.red.withAlpha(210),
                Colors.white.withAlpha(210),
                // Colors.yellow.withAlpha(210),
                // Colors.green.withAlpha(210)
              ],
              awayAnimationCurve: Curves.easeInCirc,
              enableHover: false,
              hoverColor: Colors.white,
              hoverRadius: 90,
              connectDots: true, //not recommended
            ),
            Column(
              children: <Widget>[
                ProfileHeader(
                  avatar: NetworkImage(
                    "https://avatars.githubusercontent.com/u/57068034?v=4",
                  ),
                  coverImage: NetworkImage(
                      "https://img.usanetwork.com/sites/nbcunbc/files/images/2019/3/08/USA-Logo-White-450x198.png",
                      scale: 0.5),
                  title: "David Osei Opoku",
                  // subtitle: "Manager",
                  // actions: <Widget>[
                  //   MaterialButton(
                  //     color: Colors.white,
                  //     shape: CircleBorder(),
                  //     elevation: 0,
                  //     child: Icon(Icons.edit),
                  //     onPressed: () {},
                  //   )
                  // ],
                ),
                const SizedBox(height: 10.0),
                UserInfo(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
            alignment: Alignment.topLeft,
            child: Text(
              "User Information",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Card(
            child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      ...ListTile.divideTiles(
                        color: Colors.grey,
                        tiles: [
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            leading: Icon(
                              Icons.my_location,
                              color: Colors.orange.shade500,
                            ),
                            title: Text("Location"),
                            subtitle: Text("Abidjan"),
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.email,
                              color: Colors.orange.shade500,
                            ),
                            title: Text("Email"),
                            subtitle: Text("xuwudawei100@gmail.com"),
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.phone,
                              color: Colors.orange.shade500,
                            ),
                            title: Text("Phone Number"),
                            subtitle: Text("+91-7696098250"),
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.person,
                              color: Colors.orange.shade500,
                            ),
                            title: Text("About Me"),
                            subtitle: Text(
                                "This is a about me link and you can khow about me in this section."),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  final ImageProvider<dynamic> coverImage;
  final ImageProvider<dynamic> avatar;
  final String title;
  final String? subtitle;
  final List<Widget>? actions;

  const ProfileHeader(
      {Key? key,
      required this.coverImage,
      required this.avatar,
      required this.title,
      this.subtitle,
      this.actions})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Ink(
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: coverImage as ImageProvider<Object>, fit: BoxFit.cover),
          ),
        ),
        Ink(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.black38,
          ),
        ),
        if (actions != null)
          Container(
            width: double.infinity,
            height: 200,
            padding: const EdgeInsets.only(bottom: 0.0, right: 0.0),
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: actions!,
            ),
          ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 130),
          child: Column(
            children: <Widget>[
              Avatar(
                image: avatar,
                radius: 60,
                backgroundColor: Colors.white,
                borderColor: Colors.grey.shade300,
                borderWidth: 4.0,
              ),
              Text(
                title,
                // style: Theme.of(context).textTheme.title,
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 5.0),
                Text(
                  subtitle!,
                  // style: Theme.of(context).textTheme.subtitle,
                ),
              ]
            ],
          ),
        ),
      ],
    );
  }
}

class Avatar extends StatelessWidget {
  final ImageProvider<dynamic> image;
  final Color borderColor;
  final Color? backgroundColor;
  final double radius;
  final double borderWidth;

  const Avatar(
      {Key? key,
      required this.image,
      this.borderColor = Colors.grey,
      this.backgroundColor,
      this.radius = 30,
      this.borderWidth = 5})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius + borderWidth,
      backgroundColor: borderColor,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: backgroundColor != null
            ? backgroundColor
            : Theme.of(context).primaryColor,
        child: CircleAvatar(
          radius: radius - borderWidth,
          backgroundImage: image as ImageProvider<Object>?,
        ),
      ),
    );
  }
}
