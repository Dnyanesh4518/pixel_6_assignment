import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:pixel_6/Logic/applogic.dart';
import 'package:pixel_6/models/UserList.dart';

class UserProvider extends ChangeNotifier{
    String? selectedCountry;
    String? selectedGender;
    List<Users>? users;
    bool isLoading=false;
    bool apply=true;
    UserList? userList;
    int limit=10;
    Future<void> getAllUsers() async {
      /* This function will first return loading state and then it will call getUserList function
       from AppLogic class and then assign the received data to userList */
      isLoading=true;
      notifyListeners();
      try{
        userList = await AppLogic.getUserList(limit);
        isLoading=false;
        notifyListeners();
      }
      on SocketException catch(e)
      {
        isLoading=false;
        notifyListeners();
        throw Exception(e);
      }
      catch(e){
        isLoading=false;
        notifyListeners();
        rethrow;
      }
    }
    void sortById(bool ascending){
      // This function will sort the rows based  on user's id & boolean value of ascending
      userList!.users!.sort((a, b){
        return ascending ? a.id!.compareTo(b.id!) : b.id!.compareTo(a.id!);
      });
      notifyListeners();
    }
    void sortByName(bool ascending){
      // This function will sort the rows based  on user's name & boolean value of ascending
      userList!.users!.sort((a, b) {
        return ascending ? a.firstName!.compareTo(b.firstName!) : b.firstName!.compareTo(a.firstName!);
      });
      notifyListeners();

    }
    void sortByAge(bool ascending){
      // This function will sort the rows based  on user's age & boolean value of ascending
      userList!.users!.sort((a, b) {
        return ascending ? a.age!.compareTo(b.age!) : b.age!.compareTo(a.age!);
      });
      notifyListeners();

    }
    Future<void> LoadMore() async{

      /* This function will load more data from api when the user scroll to end of page
         the controller of Listview containing Datatable will notify for scroll then we will
         increase limit by 10 and also will check whether it is less than total no records and
         then we will update userList with updated users list
       */
      notifyListeners();
      limit+=10;
      if(userList!.total!>limit)
        {
          userList = await AppLogic.getUserList(limit);
          notifyListeners();
        }
    }
    Future<void> resetFilter() async{
      // This function will simply reset the filters
      userList= await AppLogic.getUserList(limit);
      selectedGender=null;
      selectedCountry=null;
      apply=true;
      notifyListeners();
    }
    void setGender(String gender){
      // This function will set the gender value for filtering
      selectedGender = gender;
      apply=true;
      notifyListeners();
    }
    void setCountry(String country){
      // This function will set the country value for filtering
      selectedCountry=country;
      apply=true;
      notifyListeners();
    }
    Future<void> applyFilter() async{
      /* This function will takes updated values of filters and then
         it will fetch the filtered list and assign back to list of users
       */
      UserList? list = await AppLogic.getUserList(limit);
      List<Users> filteredList=[];
      if(selectedCountry!=null && selectedGender!=null)
        {
          filteredList=list!.users!.where((user)=>user.address!.country!.contains(selectedCountry!)).where((user)=>user.gender==selectedGender).toList();
          userList=UserList(
            users: filteredList,
          );
          apply=false;
          notifyListeners();
        }
      else if(selectedGender==null)
        {
          filteredList=list!.users!.where((user)=>user.address!.country!.contains(selectedCountry!)).toList();
          userList=UserList(
            users: filteredList,
          );
          apply=false;
          notifyListeners();
        }
      else if(selectedCountry==null)
      {
        filteredList=list!.users!.where((user)=>user.gender==selectedGender).toList();
        userList=UserList(
          users: filteredList,
        );
        apply=false;
        notifyListeners();
      }
      else
        {
          apply=false;
          notifyListeners();
        }
    }
}