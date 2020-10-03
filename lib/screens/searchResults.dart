import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:helloworld_app/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paginator/flutter_paginator.dart';
import 'package:http/http.dart' as http;

class SearchResults extends StatefulWidget {
  final String skill, pincode;
  SearchResults({this.skill, this.pincode});
  @override
  _SearchResultsState createState() =>
      _SearchResultsState(this.skill, this.pincode);
}

class _SearchResultsState extends State<SearchResults> {
  _launchDialer(String number) async {
    var url = 'tel://$number';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _SearchResultsState(this.skill, this.pincode);
  String skill, pincode;
  GlobalKey<PaginatorState> paginatorGlobalKey = GlobalKey();

  Future<UsersData> sendUsersDataRequest(int page) async {
    print(pincode);
    if (pincode == '') {
      try {
        String url = Uri.encodeFull('$baseUrl/worker?page=$page&skill=$skill');
        http.Response response = await http.get(url);
        return UsersData.fromResponse(response);
      } catch (e) {
        if (e is IOException) {
          return UsersData.withError('Please check your internet connection.');
        } else {
          print(e.toString());
          return UsersData.withError('Something went wrong.');
        }
      }
    } else {
      try {
        String url = Uri.encodeFull(
            '$baseUrl/worker?page=$page&pinCode=$pincode&skill=$skill');
        http.Response response = await http.get(url);
        return UsersData.fromResponse(response);
      } catch (e) {
        if (e is IOException) {
          return UsersData.withError('Please check your internet connection.');
        } else {
          print(e.toString());
          return UsersData.withError('Something went wrong.');
        }
      }
    }
  }

  List<dynamic> listItemsGetter(UsersData UsersData) {
    List<dynamic> list = [];
    UsersData.workers.forEach((value) {
      list.add(value);
    });
    return list;
  }

  Widget listItemBuilder(value, int index) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 18),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.white,
            ),
            height: 70,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.person,
                            color: kConstBlueColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  value['skill'],
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 0),
                                child: Text(
                                  value['district'],
                                  style: TextStyle(
                                      fontSize: 9, color: Color(0xffAEB3B0)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.phone,
                            color: kConstBlueColor,
                          ),
                          onPressed: () {
                            _launchDialer(value['mobile']);
                          })
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Widget loadingWidgetMaker() {
    return Container(
      alignment: Alignment.center,
      height: 100.0,
      child: SpinKitDoubleBounce(
        color: kConstBlueColor,
      ),
    );
  }

  Widget errorWidgetMaker(UsersData UsersData, retryListener) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(UsersData.errorMessage),
        ),
        FlatButton(
          onPressed: retryListener,
          child: Text('Retry'),
        )
      ],
    );
  }

  Widget emptyListWidgetMaker(UsersData UsersData) {
    return Center(
      child: Text(
        'No workers found',
        style: kConstTextStyle,
      ),
    );
  }

  int totalPagesGetter(UsersData UsersData) {
    return UsersData.total;
  }

  bool pageErrorChecker(UsersData UsersData) {
    return UsersData.statusCode != 200;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "Search Results",
              style: kConstHeadingStyle.copyWith(fontSize: 36),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Paginator.listView(
                key: paginatorGlobalKey,
                pageLoadFuture: sendUsersDataRequest,
                pageItemsGetter: listItemsGetter,
                listItemBuilder: listItemBuilder,
                loadingWidgetBuilder: loadingWidgetMaker,
                errorWidgetBuilder: errorWidgetMaker,
                emptyListWidgetBuilder: emptyListWidgetMaker,
                totalItemsGetter: totalPagesGetter,
                pageErrorChecker: pageErrorChecker,
                scrollPhysics: BouncingScrollPhysics(),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class UsersData {
  List<dynamic> workers;
  int statusCode;
  String errorMessage;
  int total;
  int nItems;

  UsersData.fromResponse(http.Response response) {
    this.statusCode = response.statusCode;
    var jsonData = json.decode(response.body);
    workers = jsonData['documents'];
    total = jsonData['totalCount'];
    nItems = workers.length;
  }
  UsersData.withError(String errorMessage) {
    this.errorMessage = errorMessage;
  }
}
