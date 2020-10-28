import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rickandmorty_gdgfest/GQLClient.dart';
import 'package:rickandmorty_gdgfest/Queries.dart';
import 'package:rickandmorty_gdgfest/rounded_bordered_container.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GraphQLConfiguration _graphQLConfiguration = GraphQLConfiguration();
  Queries _query = Queries();
  List profileList = List();

  @override
  void initState() {
    super.initState();
    fetchProfile();
  }

//function to get details
  Future fetchProfile() async {
    GraphQLClient _client = _graphQLConfiguration.myGQLClient();

    QueryResult result = await _client
        .query(QueryOptions(documentNode: gql(_query.fetchAllProfile())));
    if (result.hasException) {
      print(result.exception);
    } else if (!result.hasException) {
      print(result.data);
      setState(() {
        profileList = result.data['characters']['results'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Rick and Morty'),
        ),
        body: profileList.isEmpty
            ? Center(child: CircularProgressIndicator())
            : Container(
                color: Color(0xffF3F6FF),
                child: Column(
                  children: <Widget>[
                    Flexible(
                      child: ListView.builder(
                        itemCount: profileList.length,
                        itemBuilder: (context, index) {
                          return buildCharacter(index);
                        },
                      ),
                    ),
                  ],
                ),
              ));
  }

  Widget buildCharacter(int index) {
    return RoundedContainer(
      padding: const EdgeInsets.all(0),
      margin: EdgeInsets.all(10),
      height: 130,
      child: Row(
        children: <Widget>[
          Container(
            width: 130,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: NetworkImage(profileList[index]['image']),
              fit: BoxFit.cover,
            )),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            profileList[index]['name'],
                            overflow: TextOverflow.fade,
                            softWrap: true,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "Status:",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          profileList[index]['status'],
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "Origin:",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          profileList[index]['origin']['name'],
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          profileList[index]['species'],
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
