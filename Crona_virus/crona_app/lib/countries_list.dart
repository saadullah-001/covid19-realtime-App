import 'package:crona_app/countries.dart';
import 'package:flutter/material.dart';
import 'package:crona_app/Services/Utilities/state_services.dart';
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  var SearchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(11),
            child: TextFormField(
              controller: SearchController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                hintText: 'Search with Country Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: StateServices().fetchCountriesApi(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return ListView.builder(
                    itemCount: 15,
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.shade700,
                        highlightColor: Colors.grey.shade100,
                        child: Column(
                          children: [
                            ListTile(
                              title: Container(
                                height: 10,
                                width: 90,
                                color: Colors.white,
                              ),
                              subtitle: Container(
                                height: 10,
                                width: 90,
                                color: Colors.white,
                              ),
                              leading: CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.grey.shade200,
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      String name = snapshot.data![index]['country'];

                      if (SearchController.text.isEmpty) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Countries(
                                  image: snapshot
                                      .data![index]['countryInfo']['flag'],
                                  name: snapshot.data![index]['country'],
                                  totalCases:
                                      snapshot.data![index]['cases'] ?? 0,
                                  totalDeaths:
                                      snapshot.data![index]['deaths'] ?? 0,
                                  totalRecovered:
                                      snapshot.data![index]['recovered'] ?? 0,
                                  active: snapshot.data![index]['active'] ?? 0,
                                  critical:
                                      snapshot.data![index]['critical'] ?? 0,
                                  todayRecovered:
                                      snapshot.data![index]['todayrecovered'] ??
                                      0,
                                  test: snapshot.data![index]['tests'] ?? 0,
                                ),
                              ),
                            );
                          },
                          child: ListTile(
                            title: Text(snapshot.data![index]['country']),
                            subtitle: Text(
                              "Cases: ${snapshot.data![index]['cases'].toString()}",
                            ),
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.grey.shade200,
                              child: ClipOval(
                                child: Image.network(
                                  snapshot.data![index]['countryInfo']['flag'],
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        );
                      } else if (name.toLowerCase().contains(
                        SearchController.text.toLowerCase(),
                      )) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Countries(
                                  image: snapshot
                                      .data![index]['countryInfo']['flag'],
                                  name: snapshot.data![index]['country'],
                                  totalCases:
                                      snapshot.data![index]['cases'] ?? 0,
                                  totalDeaths:
                                      snapshot.data![index]['deaths'] ?? 0,
                                  totalRecovered:
                                      snapshot.data![index]['recovered'] ?? 0,
                                  active: snapshot.data![index]['active'] ?? 0,
                                  critical:
                                      snapshot.data![index]['critical'] ?? 0,
                                  todayRecovered:
                                      snapshot.data![index]['todayrecovered'] ??
                                      0,
                                  test: snapshot.data![index]['tests'] ?? 0,
                                ),
                              ),
                            );
                          },
                          child: ListTile(
                            title: Text(snapshot.data![index]['country']),
                            subtitle: Text(
                              "Cases: ${snapshot.data![index]['cases'].toString()}",
                            ),
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.grey.shade200,
                              child: ClipOval(
                                child: Image.network(
                                  snapshot.data![index]['countryInfo']['flag'],
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Container();
                      }
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
