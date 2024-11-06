<details>
<summary>ASSIGNMENT 5</summary>

# ASSIGNMENT 7 QUESTIONS AND ANSWERS:

 ## 1.  Explain what are stateless widgets and stateful widgets, and explain the difference between them.

        A state of a widget is the information of the widget at the time in the app's memory
        that can be synchronously read when the widget is built and can change overtime.

        A stateless widget does not have a state and stays the same after it is built, it
        cannot change. Its information depends on the widget itself, not on external factors.
        The widget has an @override decorator over the build() function.
        The build() function is only called once. Examples of stateless widgets include 
        Text, RaisedButton and IconButtons. They are used for widgets that are intended
        to be the same at all times in the app.

        A stateful widget has a state and can its appearance and information can change
        throughout the lifetime of the app. Its information depends on external factors
        such as user interaction and it needs an extra class to represent its state, unlike
        stateless widgets.
        In the app class the widget will have an @override decorator for the createState()
        function which returns a state for dynamic changes in the UI. This method is pointed
        to the name of the class of the state.
        In the class for the state, there's an @override decorator with the build() function,
        which will be called many times to create the widget in a new state.
        Examples of stateful widgets include CheckBox, RadioButton, Form and TextField.

 ## 2.  Mention the widgets that you have used for this project and its uses.

        The widgets I used in this project are:
            1. Containers which are used to customize child widgets' margin and paddings
               and to place child widgets within a designated area or box.
            2. Text which are for adding text strings.
            3. Icons which are for adding image icons to buttons.
            4. AppBar which is like a navigation bar in browser websites.
            5. Scaffold which gives the app a basic page layout, it also has an AppBar
               and body
            6. Padding controls spaces around a child widget
            7. Column arranges child widgets vertically
            8. Row arranges child widgets horizontally
            9. MaterialApp which is the root widget of the app, it gives navigation
               support and themes for the rest of the app.
           10. Card for displaying information in a box.
           11. Center arranges child widgets in the middle of their parent.
           12. SizedBox provides fixed space around or between widgets.
           13. InkWell adds a ripple effect when the widget is tapped.
           14. GridView.count gives a grid-based layout for the ItemCard widgets, it
               has a fixed number of columns.
           15. SnackBar appears on screen shortly with a message when the user interacts 
               with the buttons on the main page.
           16. Material provides styling to widgets such as background color and styled
               shapes.
           17. ItemCard is used for making interactive buttons with icons and text.
           18. InfoCard displays information in a card for the name, NPM and class.
           19. ItemHomePage represents the buttons that are to be displayed in the
               ItemCard widget for buttons.
  
 ## 3. What is the use-case for setState()? Explain the variable that can be affected by setState().

        The function of setState() is 
        The setState() method tells the framework that when the state of a State object
        has changed, making Flutter rebuild the affected UI and widgets with the
        updated information. It is also for updating variables that affect the visual
        presentation or data displayed on the UI. Variables within the State class,
        such as user input data or counters, can be modified inside setState() to
        trigger this rebuild. Without setState(), these changes would not be applied.

 ## 4. Explain the difference between const and final keyword.

        Variables with const keyword should be assigned a value during compile-time,
        after it is assigned a value it cannot change its value again during runtime.
        Const is used for variables with known values at runtime.
        Const is less flexible as the class must have a const constructor while
        all of its fields should have final constructors.

        While variables with the final keyword can be assigned to a value during
        runtime but cannot be changed once assigned.
        Final is used for variables whose values cannot be reassigned but can be
        calculcated during runtime. Final is more flexible as it can be used with   
        any constructor.
 

 ## Step-by-step explanation for checklist :
 ### 1. Create a new Flutter application with the E-Commerce theme that matches the previous assignments.
        1. To initialize the project I ran the following lines in terminal:

            flutter create e_commerce_app_mobile
            cd e_commerce_app_mobile

        2. I then created a menu.dart file in the mental_health_tracker/lib
           directory and added the classes MyHomePage and _MyHomePageState.

       3. I then added this line to the top of main.dart.
```dart
import 'package:e_commerce_app_mobile/menu.dart';

```
       4. I then replaced the previous colorScheme code with this:
```dart
        colorScheme: ColorScheme.fromSwatch(
       primarySwatch: Colors.orange,
 ).copyWith(secondary: Colors.orange[200]),

```
       5. To start making the widget page menu to a stateless one, I
          replaced the previous 'home:' with: 
```dart
home: MyHomePage(),
```    
          Changed stateful to stateless in class MyHomePage extends
          StatelessWidget and added an @override decorator

       6. I added data to be displayed on the cards under the class of MyHomePage in menu.dart:
```dart
  final String npm = '2306256223'; // NPM
  final String name = 'Ameera Khaira Tawfiqa'; // Name
  final String className = 'KKI'; // Class
```
       7. In menu.dart I added a new class called InfoCard, ItemHomepage

       8. In menu.dart, I added the following:
```dart
     final List<ItemHomepage> items = [
         ItemHomepage("View Product", Icons.product),
         ItemHomepage("Add Product", Icons.add),
         ItemHomepage("Logout", Icons.logout),
     ];
```
       9. I then added a class called ItemCard to display the product cards
          and put it in menu.dart.

       10. Finally, I added code within the Widget build() section within
           the MyHomePage class that will display all the widgets on the 
           main page.

 ### 2.  Create three simple buttons with icons and texts for:
 #### a. Viewing the product list (View Product List)
 #### b. Adding a product (Add Product)
 #### c. Logout (Logout)
       In menu.dart, I made a class for making the buttons below
```dart
 class ItemHomepage {
     final String name;
     final IconData icon;

     ItemHomepage(this.name, this.icon);
 }
```
       I added the code below in the MyHomePage class that uses
       the button class to add the respective text and icons.
```dart
         final List<ItemHomepage> items = [
      ItemHomepage("View Product", Icons.shopping_cart),
      ItemHomepage("Add Product", Icons.add),
      ItemHomepage("Logout", Icons.logout),
    ];
```
       Finally, I added another class called ItemCard that will       
       display the buttons on the main page.


 ### 3. Implement different colors for each button (View Product List, Add Product, and Logout). 
       To give each button a different color, i added a color property in
       the ItemHomePage class.
```dart
class ItemHomepage {
  final String name;
  final IconData icon;
  final Color color; // New property

  ItemHomepage(this.name, this.icon, this.color); // Added color parameter
}
```
       I then added the colors to the buttons in the final List like this:
```dart
final List<ItemHomepage> items = [
      ItemHomepage("View Product", Icons.shopping_cart, Colors.deepPurple[600]!),
      ItemHomepage("Add Product", Icons.add,  Colors.blue[600]!),
      ItemHomepage("Logout", Icons.logout,  Colors.red[600]!),
];
```
       Finally in the ItemCard class, I changed this line from this:
```dart
color: Theme.of(context).colorScheme.secondary,
```
       to this:
```dart
color: item.color,
```

 ### 4. Display a Snackbar with the following messages:
 #### a. "You have pressed the View Product List button" when the View Product List button is pressed.
 #### b. "You have pressed the Add Product button" when the Add Product button is pressed.
 #### c. "You have pressed the Logout button" when the Logout button is pressed.

       In the class ItemCard I added the following code under
       its child the Container:
```dart
  @override
  Widget build(BuildContext context) {

       ...
      
      child: InkWell(
        // Action when the card is pressed.
        onTap: () {
          // Display the SnackBar message when the card is pressed.
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text("You have pressed the ${item.name} button!"))
            );
        },
```    
       This code will display a snackbar with a message related
       to its respective button. The ${item.name} represents
       the names of the buttons which are shown here:
```dart
  final List<ItemHomepage> items = [
      ItemHomepage("View Product List", Icons.shopping_cart, Colors.deepPurple[600]!),
      ItemHomepage("Add Product", Icons.add,  Colors.blue[600]!),
      ItemHomepage("Logout", Icons.logout,  Colors.red[600]!),
    ];
``` 

</details>