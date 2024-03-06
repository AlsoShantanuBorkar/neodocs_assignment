import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neodocs_assignment/models/data.dart';

class BarForm extends StatelessWidget {
  BarForm({super.key, required this.listenableValue});
  final ValueNotifier<int> listenableValue;
  final TextEditingController _controller = TextEditingController(text: "0");
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Form(
        key: _formKey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 300,
              height: 50,
              child: TextFormField(
                controller: _controller,
                validator: (value) {
                  if (value == null) {
                    return "Required";
                  }
                  if (value.isEmpty) {
                    return "Enter a value";
                  }

                  if (int.parse(value) > data.last.range.upperLimit) {
                    return "Value cannot be larger than ${data.last.range.upperLimit}";
                  }
                  return null;
                },
                style: const TextStyle(fontSize: 10),
                decoration: InputDecoration(
                    errorStyle: const TextStyle(fontSize: 10),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            ConfirmValue(
                formKey: _formKey,
                controller: _controller,
                listenableValue: listenableValue),
          ],
        ),
      ),
    );
  }
}

class ConfirmValue extends StatelessWidget {
  const ConfirmValue({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController controller,
    required this.listenableValue,
  })  : _formKey = formKey,
        _controller = controller;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _controller;
  final ValueNotifier<int> listenableValue;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (_formKey.currentState!.validate()) {
            if (_controller.text.isEmpty) {
              listenableValue.value = 0;
              return;
            }
            if (int.parse(_controller.text) > data.last.range.upperLimit) {
              listenableValue.value = 120;
              return;
            }

            listenableValue.value = int.parse(_controller.text);
          }
        },
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 2),
          ),
          child: const Icon(
            Icons.arrow_forward,
            size: 20,
          ),
        ));
  }
}
