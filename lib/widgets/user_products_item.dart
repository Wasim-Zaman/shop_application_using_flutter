import 'package:flutter/material.dart';

class UserProductsItem extends StatelessWidget {
  final String title;
  final String imageUrl;

  const UserProductsItem({
    super.key,
    required this.title,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
        ),
        title: Text(title),
        trailing: SizedBox(
          width: MediaQuery.of(context).size.width * 0.36,
          child: Row(
            children: [
              TextButton(
                onPressed: () {},
                child: Icon(
                  Icons.edit,
                  // ignore: deprecated_member_use
                  color: Theme.of(context).accentColor,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
