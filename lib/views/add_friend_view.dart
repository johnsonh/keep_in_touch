import 'package:flutter/material.dart';

class AddFriendView extends StatefulWidget {
  AddFriendView(this.onTapSave);

  final Function onTapSave;

  @override
  AddFriendViewState createState() {
    return AddFriendViewState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class AddFriendViewState extends State<AddFriendView> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            validator: (String value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  Scaffold.of(context)
                      .showSnackBar(const SnackBar(content: Text('Processing Data')));
                  widget.onTapSave(); 
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}