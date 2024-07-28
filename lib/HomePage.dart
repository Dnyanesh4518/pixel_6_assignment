import 'package:flutter/material.dart';
import 'package:pixel_6/Provider/UserProvider.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});
  @override
  State<Homepage> createState() => _HomepageState();
}
class _HomepageState extends State<Homepage> {
  ScrollController controller = ScrollController();
  bool isAscending = true;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      /*
       This will first ensure that all UI frames are rendered and the call getAllUsers function
       if any error occur it will catch and display it.
       */
          Provider.of<UserProvider>(context, listen: false).getAllUsers().then((value){},
            onError:(e){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No Connection")));
        });
    });
    controller.addListener(() {
      /*
       This is listener of the controller of Listview which contains the DataTable
       it will listen scrolling activity and at end of page it will call LoadMore function
       on any error it will display it as snack bar
       */
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        Provider.of<UserProvider>(context, listen: false).LoadMore().then((value){},
            onError:(e){
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No Connection")));
            });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shadowColor: Colors.black,
        elevation: 0.5,
        forceMaterialTransparency: true,
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        leading: Image.asset(
          "assets/images/pixel6Logo.png",
          height: 20,
          width: 20,
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.dehaze,
                  color: Color.fromRGBO(175, 45, 40, 1.0)))
        ],
      ),
      body: Consumer<UserProvider>(
          builder: (context, value, child) {
        if(value.isLoading){
          // This will make sure that the userList has successfully fetched
          return const Center(child: CircularProgressIndicator());
        }
        else if (value.userList != null) {
          return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Container(
                        height: 90,
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Employees",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40,
                                  color: Colors.black),
                            ),
                            Row(
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.filter_alt_rounded,
                                            color: Color.fromRGBO(175, 40, 40, 1),
                                            size: 20,
                                          ),
                                        ),
                                        Container(
                                          margin:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 10),
                                          height: 35,
                                          width: 120,
                                          child: InputDecorator(
                                            decoration: InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.all(
                                                        11),
                                                border: OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                      color: Colors.black,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius
                                                            .circular(10))),
                                            child: DropdownButton<String>(
                                                icon: const Icon(Icons.keyboard_arrow_down),
                                                iconEnabledColor: const Color.fromRGBO(155, 45, 45,1),
                                                value: value.selectedCountry,
                                                isDense: true,
                                                underline: Container(),
                                                elevation: 0,
                                                hint: const Text("Country"),
                                                items: const [
                                                  DropdownMenuItem(
                                                      value: 'United States',
                                                      child: Text("USA")),
                                                  DropdownMenuItem(
                                                    value: 'India',
                                                    child: Text("India"),
                                                  )
                                                ],
                                                onChanged: (String? e) {
                                                  Provider.of<UserProvider>(context, listen: false).setCountry(e.toString());
                                                }),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.symmetric(horizontal: 10),
                                          height: 35,
                                          width: 120,
                                          child: InputDecorator(
                                            decoration: InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.all(
                                                        11),
                                                border: OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                      color: Colors.black,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius
                                                            .circular(10))),
                                            child: DropdownButton<String>(
                                                icon: const Icon(Icons.keyboard_arrow_down),
                                                iconEnabledColor: const Color.fromRGBO(155, 45, 45,1),
                                                value: value.selectedGender,
                                                underline: Container(),
                                                elevation: 0,
                                                hint: const Text("Gender"),
                                                items: const [
                                                  DropdownMenuItem(
                                                    value: 'male',
                                                    child: Text("Male"),
                                                  ),
                                                  DropdownMenuItem(
                                                    value: 'female',
                                                    child: Text("Female"),
                                                  )
                                                ],
                                                onChanged: (String? e) {
                                                  Provider.of<UserProvider>(context, listen: false).setGender(e.toString());
                                                }),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          margin:
                                              const EdgeInsets.symmetric(
                                                  vertical: 5,
                                                  horizontal: 10),
                                          width: 120,
                                          child: Visibility(
                                            maintainSize: false,
                                            visible: value.apply,
                                            replacement: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    foregroundColor: Colors.black,
                                                    backgroundColor:
                                                    Colors.white,
                                                    elevation: 0,
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            10),
                                                        side: const BorderSide(
                                                            color: Colors
                                                                .grey)
                                                    )),
                                                onPressed: () {
                                                  Provider.of<UserProvider>(
                                                      context,
                                                      listen: false)
                                                      .resetFilter();
                                                },
                                                child: const Text("Reset")),
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.white,
                                                    foregroundColor:
                                                        Colors.black,
                                                    elevation: 0,
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    10),
                                                        side: const BorderSide(
                                                            color: Colors
                                                                .grey))),
                                                onPressed: () {
                                                      Provider.of<UserProvider>(context,listen: false).applyFilter();
                                                },
                                                child: const Text("Apply")),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      child: SizedBox(
                        height: MediaQuery.sizeOf(context).height,
                        child: ListView(
                            controller: controller,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: InputDecorator(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16))),
                                  child: DataTable(
                                      dividerThickness: 1,
                                      showBottomBorder: true,
                                      columns: [
                                        DataColumn(
                                            onSort: (colIndex, _) {
                                              isAscending = !isAscending;
                                              Provider.of<UserProvider>(
                                                      context,
                                                      listen: false)
                                                  .sortById(isAscending);
                                            },
                                            label: const Row(
                                              children: [
                                                Text("ID",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black)),
                                                Image(
                                                  image: AssetImage(
                                                      "assets/Icons/sort.png"),
                                                  height: 15,
                                                  width: 19,
                                                )
                                              ],
                                            )),
                                        const DataColumn(
                                            label: Text("Image",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold,
                                                    color: Colors.black))),
                                        DataColumn(
                                            onSort: (columnId, _) {
                                              isAscending = !isAscending;
                                              Provider.of<UserProvider>(
                                                      context,
                                                      listen: false)
                                                  .sortByName(isAscending);
                                            },
                                            label: const Row(
                                              children: [
                                                Text("FullName",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black)),
                                                Image(
                                                  image: AssetImage(
                                                      "assets/Icons/sort.png"),
                                                  height: 15,
                                                  width: 19,
                                                )
                                              ],
                                            )),
                                        DataColumn(
                                            onSort: (columnId, _) {
                                              isAscending = !isAscending;
                                              Provider.of<UserProvider>(
                                                      context,
                                                      listen: false)
                                                  .sortByAge(isAscending);
                                            },
                                            label: const Row(
                                              children: [
                                                Text("Demography",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black)),
                                                Image(
                                                  image: AssetImage(
                                                      "assets/Icons/sort.png"),
                                                  height: 15,
                                                  width: 19,
                                                )
                                              ],
                                            )
                                        ),
                                        const DataColumn(
                                            label: Text("Designation",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold,
                                                    color: Colors.black))),
                                        const DataColumn(
                                            label: Text("Location",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold,
                                                    color: Colors.black)))
                                      ],
                                      rows: value.userList!.users!
                                              .map((user) => DataRow(cells: [
                                                    DataCell(Text(user.id.toString())),
                                                    DataCell(user.image !=
                                                          null
                                                        ? CircleAvatar(
                                                            backgroundImage:
                                                                NetworkImage(user
                                                                    .image!))
                                                        : const Icon(
                                                            Icons.person)),
                                                    DataCell(Text(
                                                        "${user.firstName} ${user.maidenName} ${user.lastName}")),
                                                    DataCell(Text(
                                                        "${user.gender![0].toUpperCase()}/${user.age.toString()}")),
                                                    DataCell(Text(user
                                                        .company!.title!)),
                                                    DataCell(Text(
                                                        "${user.address!.state}, ${user.address!.country}"))
                                                  ]))
                                              .toList()),
                                ),
                              )
                            ]),
                      ),
                    ),
                  ],
                );
        }
        else {
          return const Center(child: Text("Something went wrong !"));
        }
      }),
    );
  }
}
