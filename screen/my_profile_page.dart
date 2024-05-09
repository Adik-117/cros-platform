import 'package:flutter/material.dart';

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: ListView(
        children: <Widget>[
          _buildUserInfo(context),
          _buildListTile(Icons.shopping_basket, 'Orders', onTap: () {
            // TODO: Implement navigation to Orders
          }),
          _buildListTile(Icons.details, 'My Details', onTap: () {
            // TODO: Implement navigation to My Details
          }),
          _buildListTile(Icons.location_on, 'Delivery Address', onTap: () {
            // TODO: Implement navigation to Delivery Address
          }),
          _buildListTile(Icons.payment, 'Payment Methods', onTap: () {
            // TODO: Implement navigation to Payment Methods
          }),
          _buildListTile(Icons.code, 'Promo Code', onTap: () {
            // TODO: Implement navigation to Promo Code
          }),
          SwitchListTile(
            title: Text('Notifications'),
            value: true,
            onChanged: (bool value) {
              // TODO: Implement notification toggle
            },
          ),
          _buildListTile(Icons.help, 'Help', onTap: () {
            // TODO: Implement navigation to Help
          }),
          _buildListTile(Icons.info, 'About', onTap: () {
            // TODO: Implement navigation to About
          }),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // TODO: Implement log out functionality
              },
              child: Text('Log Out'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfo(BuildContext context) {
    return UserAccountsDrawerHeader(
      accountName: Text('Nurkanov Zhalgas'),
      accountEmail: Text('Glock@gmail.com'),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        child: Text('A'),
      ),
    );
  }

 ListTile _buildListTile(IconData icon, String title, {VoidCallback? onTap}) {
  return ListTile(
    leading: Icon(icon),
    title: Text(title),
    trailing: Icon(Icons.chevron_right),
    onTap: onTap,
  );
}

}
