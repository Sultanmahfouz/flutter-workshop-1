import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTask extends StatefulWidget {
  final Function addNewTask;
  NewTask(this.addNewTask);

  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  final TitleTask = TextEditingController();
  DateTime selectedDate;
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  var Title;

  void presentCalender() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2023),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        selectedDate = pickedDate;
      });
    });
  }
////.
  void submitTask() {
    var formData = formState.currentState;
    if (formData.validate()) {
    } else if (TitleTask.text.isNotEmpty || selectedDate == null) {
      return;
    }

    widget.addNewTask(
      TitleTask.text,
      selectedDate,
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Form(
        key: formState,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: TextFormField(
                controller: TitleTask,
                // autovalidateMode: AutovalidateMode.always,
                validator: (vil) {
                  if (vil.length < 4) {
                    return ("The note cannot be less than 4 characters");
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                    ),
                    child: Text(
                      selectedDate == null
                          ? 'no chosen date'
                          : 'picked date: ${DateFormat.yMMMEd().format(selectedDate)}',
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                  ),
                ),

                TextButton(
                  onPressed: presentCalender,
                  child: Text(
                    'choose a date',
                    style: TextStyle(color: Colors.white),
                  ),
                )

                // Text('choose a date'),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF64FCDB),
                ),
                onPressed: submitTask,
                child: Text(
                  'Add task',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            )
          ],
        ),
         )
           );
}
}
