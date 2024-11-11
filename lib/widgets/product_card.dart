import 'package:flutter/material.dart';
import 'package:e_commerce_app_mobile/screens/productentry_form.dart';

// Icons class
class ItemHomepage {
  final String name;
  final IconData icon;
  final Color color; // New property

  ItemHomepage(this.name, this.icon, this.color); // Added color parameter
}

// For displaying the buttons
class ItemCard extends StatelessWidget {
  // Display the card with an icon and name.

  final ItemHomepage item; 
  
  const ItemCard(this.item, {super.key}); 

  @override
  Widget build(BuildContext context) {
    return Material(
      // Specify the background color of the application theme.
      color: item.color,
      // Round the card border.
      borderRadius: BorderRadius.circular(12),
      
      child: InkWell(
        // Action when the card is pressed.
        onTap: () {
          // Display the SnackBar message when the card is pressed.
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text("You have pressed the ${item.name} button!"))
            );

            // Navigate to the appropriate route (depending on the button type)
            if (item.name == "Add Cookie") {
              // Used Navigator.push to navigate to a MaterialPageRoute that includes ProductEntryFormPage.

              Navigator.push (
                context,
                MaterialPageRoute(
                  builder: (context) => const ProductEntryFormPage(),
                  )
              );
            }

        },
        // Container to store the Icon and Text
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              // Place the Icon and Text in the center of the card.
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}