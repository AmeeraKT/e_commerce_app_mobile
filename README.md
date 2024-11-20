<details>
<summary>ASSIGNMENT 9</summary>

# ASSIGNMENT 9 QUESTIONS AND ANSWERS:

 ## 1. Explain why we need to create a model to retrieve or send JSON data. Will an error occur if we don't create a model first?
       In Flutter, these models can convert JSON data into Dart objects
       by parsing so that Flutter can use is more effectively. 
       They can also convert data into JSON for sending back to
       the Django backend.
       These models eliminate the need to do manual JSON parsing for
       data.
       No errors will occur if a model if not made but there might be
       type mismatches.

 ## 2. Explain the function of the http library that you implemented for this task.
       The http library is used in this task for making requests that will
       be sent to the Django backend. The library has the actions GET, POST,
       PUT and DELETE. The GET actions is for retrieving product list data
       and the POST action is for submitting product data and login and
       registration forms.
       With the library, the Flutter app can send and receive actions to
       and from the Django backend.

 ## 3. Explain the function of CookieRequest and why it’s necessary to share the CookieRequest instance with all components in the Flutter app.
       CookieRequest handles cookies sessions which tells the server that
       the user who has logged in is authenticated. Sharing a CookieRequest
       instance with all components ensures that cookies is implemented in
       every HTTP request so all pages of the app will know that the
       current user is authenticated already and logged in.
       This prevents the app from sending a login request each time a
       different page is accessed or when another HTTP request is sent.

## 4. Explain the mechanism of data transmission, from input to display in Flutter.
       Data transmission starts when a user submits a product form on the
       Flutter app. Flutter sends a POST request to the Django backend
       and the data is processed and stored. After that, Django sends the
       data back in JSON format which gets parsed into Dart objects by the 
       models in Flutter. The objects are then displayed on the updated app
       UI by the FutureBuild tool.
       The same process occurs for GET actions sent by the user from the 
       Flutter app.

## 5. Explain the authentication mechanism from login, register, to logout. Start from inputting account data in Flutter to Django’s completion of the authentication process and display of the menu in Flutter.
       When a user submits the user registration form or the log in form
       on the Flutter app, a POST request and the data is sent to the Django
       backend using CookieRequest.
       This data is then authenticated and a token, session and cookie is
       sent to the Flutter app so Flutter can remember the user logged in.
       When the user logs out, Flutter sends a DELETE request for the
       session and cookie which is also deleted on the Flutter app.
       The UI of the app changes based on the authentication status of the
       user. For example it will not show the main page if they are not
       logged in.

 ## Step-by-step explanation for checklist :

       1. Implement the registration feature in the Flutter project.

              1. I created a new file called register.dart in
              lib/screens.

              2. I then added code to make the fully functional
              register page and form.

       2. Create a login page in the Flutter project.

              1. I created a new file called login.dart in lib/screens.

              2. Next I added code in login.dart to make a functional page

              3. In main.dart I changed home: MyHomePage() to
              home: LoginPage() and imported login.dart.

              4. I imported register.dart into login.dart.


       3. Integrate the Django authentication system with the Flutter project.
       
              1. I created a new app called authentication on my Django
              app and added it to installed apps in /e_commerce_app/
              settings.py.

              2. Next I installed django-cors-headers and added it to
              the requirements file.

              3. After that I added 
              corsheaders.middleware.CorsMiddleware to MIDDLEWARE
              in the same settings.py. 

              4. I added the following variables below:
```py
CORS_ALLOW_ALL_ORIGINS = True
CORS_ALLOW_CREDENTIALS = True
CSRF_COOKIE_SECURE = True
SESSION_COOKIE_SECURE = True
CSRF_COOKIE_SAMESITE = 'None'
SESSION_COOKIE_SAMESITE = 'None'
```
              and added "10.0.2.2" in ALLOWED_HOSTS.

              5. In /authentication/ views.py, I created a view
              method for login and did URL routing for the method.

              6. In /e_commerce_app/ urls.py I added this path:

```py
path('auth/', include('authentication.urls'))
```
       
              7. In Flutter, I installed the following packages:

              flutter pub add provider
              flutter pub add pbp_django_auth 

              8. Finally in main.dart I added the code below
              to the root Widget. So that a Provier object will
              be created which will share the CookieRequest
              with all components in the app.

```dart
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

  @override
  Widget build(BuildContext context) {
      
    return Provider(
      create: (_) {
        CookieRequest request = CookieRequest();
        return request;
      },

      child: MaterialApp(
       ...
```    
              9. I then created a new register function in
              /authentication/ views.py and imported the following:

              from django.contrib.auth.models import User
              import json

              I also made url routing for the register method.    

              10. In main/ views.py, I created a new function for
              sending the product entries to the Flutter app
```dart
@csrf_exempt
def create_product_flutter(request):
    if request.method == 'POST':

        data = json.loads(request.body)
        new_product = ProductEntryForm.objects.create(
            user=request.user,
            product=data["product"],
            price=int(data["price"]),
            description=data["description"]
        )

        new_product.save()

        return JsonResponse({"status": "success"}, status=200)
    else:
        return JsonResponse({"status": "error"}, status=401)
```

              11. I then did url routing for the new function above.

              12. In Flutter I connected the productentry_form.dart with
              CookieRequest by adding the line below:
```dart
final request = context.watch<CookieRequest>();
```

              13. In productentry_form.dart I changed the button:
```dart
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final response = await request.postJson(
                          "http://localhost:8000/create-flutter/",
                          jsonEncode(<String, String>{
                            'name': _name,
                            'price': _price.toString(),
                            'description': _description,
                          }),
                        );
                        if (context.mounted) {
                          if (response['status'] == 'success') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "New product has been saved successfully!",
                                ),
                              ),
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyHomePage()),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Something went wrong, please try again.",
                                ),
                              ),
                            );
                          }
                        }
                      }
                    },
```

       4. Create a custom model according to your Django application project.

              1. To create the Dart model I went to the Quicktype website
              and inputted JSON data of cookie products from my Django
              project.

              2. I created a new folder 'models' and created a new file
              'product_entry.dart' and added the model code here.

       5. Create a page containing a list of all items available at the JSON endpoint in Django that you have deployed.
       &
       6. Display the name, price, and description of each item on this page.
              (note: i hid the price and description of the items
              they are visible after clicking them to view the details.)
       
              1. I created new file 'list_productentry.dart' in lib/screens.

              2. I then imported the following:

                     import 'package:flutter/material.dart';
                     import 'package:e_commerce_app_mobile/models/product_entry.dart';
                     import 'package:e_commerce_app_mobile/widgets/left_drawer.dart';
                     import 'package:pbp_django_auth/pbp_django_auth.dart';
                     import 'package:provider/provider.dart';

              3. Then added code to make the page functional.

              4. I then added the new screen to the left drawer so it is accessible.
```dart
ListTile(
leading: const Icon(Icons.add_reaction_rounded),
title: const Text('Product List'),
onTap: () {
       // Route to the produt page
       Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProductEntryFormPage()),
       );
},
),
```
              5. In product_card.dart I added the following code so that the 
              product list page is accessible
```dart
import 'package:e_commerce_app_mobile/screens/list_productentry.dart';

else if (item.name == "View Product") {
    Navigator.push(context,
        MaterialPageRoute(
            builder: (context) => const ProductEntryPage()
        ),
    );
}
```
       7. Create a detail page for each item listed on the Product list page.

              In lib/screens I created a new file productentry_details.dart
              and filled it with the following code:
```dart
import 'package:flutter/material.dart';
import 'package:e_commerce_app_mobile/models/product_entry.dart';

class ProductEntryDetailPage extends StatelessWidget {
  final ProductEntry product;

  const ProductEntryDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.fields.name),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous page
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.fields.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(product.fields.description),
            const SizedBox(height: 10),
            Text("Price: ${product.fields.price}"),
          ],
        ),
      ),
    );
  }
}
```
       8. This page can be accessed by tapping on any item on the Product list page.
       The page is accessed by pressing the View Cookie List button
       in the menu

       9. Display all attributes of your item model on this page.

              All of the attributes are displayed by the following
              code snippet in list_productentry.dart:
```dart
...
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${snapshot.data![index].fields.name}",
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text("${snapshot.data![index].fields.description}"),
                      const SizedBox(height: 10),
                      Text("${snapshot.data![index].fields.price}"),
                    ],
...
```
       10. Add a button to return to the item list page.
              This is the button code:
```dart
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous page
          },
        ),
```

       11. Filter the item list page to display only items associated with the currently logged-in user.
              The items are already automatically filtered based on user
              in the Django backend.




</details>

<details>
<summary>ASSIGNMENT 8</summary>

# ASSIGNMENT 8 QUESTIONS AND ANSWERS:

 ## 1. What is the purpose of const in Flutter? Explain the advantages of using const in Flutter code. When should we use const, and when should it not be used?
       
       The purpose of const is to tell the Flutter compiler that the value of a variable
       will never change and is known at compile time. For example if i assign a variable
       a const keyword and the value 1, at compile-time this variable will be assgined
       an unchanging value of 1.

       One of the advantages of using const is improved performance because the variable
       will never be rebuilt again once it is made, unlike other variable types.
       Using const also leads to more concise widget trees and more efficient widget tree
       management. Since variables or widgets with const do not have extra states to
       rebuild into, these trees will be smaller and no unnecessary widgets will be created.

       We should use const when we want the value of the variable to be unchanged
       and to create only one copy of it.
       When making stateless widgets, const should be used.
       It should also be used when we want to define variables with predefined values.

       We should not use const when we have variables or widgets whose value or state
       will change throughout the lifetime of the app. The keyword should not be used
       for making stateful widgets.

 ## 2. Explain and compare the usage of Column and Row in Flutter. Provide example implementations of each layout widget!

       Column is used for arranging widgets vertically in a vertical container.
       Here is an example of using a column widget:
```dart
    child: const Column(
      children: [
        Text(
          'Mental Health Tracker',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Padding(padding: EdgeInsets.all(8)),
        Text(
          "Track your mental health every day here!",
          // TODO: Add text style with center alignment, font size 15, white color, and normal weight
        ),
      ],
    ),
```
       While Row is used for arranging widgets horizontally in a hortizontal
       container. Here is an example of using a horizontal widget:
```dart
const Row(
  children: <Widget>[
    Expanded(
      child: Text('Deliver features faster', textAlign: TextAlign.center),
    ),
    Expanded(
      child: Text('Craft beautiful UIs', textAlign: TextAlign.center),
    ),
    Expanded(
      child: FittedBox(
        child: FlutterLogo(),
      ),
    ),
  ],
)
```
 
 ## 3. List the input elements you used on the form page in this assignment. Are there other Flutter input elements you didn't use in this assignment? Explain!

       The input elements I used in this assignment are:
       1. Form for creating an input form
       2. (Text)FormField for creating areas or fields in the input form
          for the user to type data into

       The input elements I did not use in this assignment are:
       1. Autocomplete which gives the user complete input suggestions
          based on their incomplete input.
       2. KeyboardListener which calls a callback when the user releases
          or presses on a key on the keyboard.

 ## 4. How do you set the theme within a Flutter application to ensure consistency? Did you implement a theme in your application?

       To set a theme, I ensured that the colors used for widgets that appear in
       other pages of the website are the same such as the navbar and some
       buttons.
       The main theme of the app is defined in main.dart over here:
```dart
        colorScheme: ColorScheme.fromSwatch(
       primarySwatch: Colors.orange,
 ).copyWith(secondary: Colors.orange[200]),
        useMaterial3: true,
      )
```
       I implemented a warm orange color as the main theme.

 ## 5. How do you manage navigation in a multi-page Flutter application?

       To manage navigation I used the Navigation widget, which keeps tracks of
       visited pages in the app in a stack model.
       When a new page or a route object is accessed, its data is pushed into 
       the stack and displayed on the screen. When the back arrow is pressed,
       the head of the stack is popped out. THe top of the stack can also be
       replaced with other pages.

       To implement routing, the name of the page's class should be defined
       within a Navigation method so that the page's can be pushed, popped or
       replaced in the navigation stack.

</details>

<details>
<summary>ASSIGNMENT 7</summary>

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

        The setState() method tells the framework that when the state of a State object
        has changed, making Flutter rebuild the affected UI and widgets with the
        updated information. It is called within a State class and takes stateful widgets
        as its parameter.
        The function will update such widgets and their appearance on the UI.
        Variables within the State class, such as user input data or counters, can be
        modified inside setState() to trigger this rebuild. Without setState(),
        these changes would not be applied.

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