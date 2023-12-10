import 'package:flutter/material.dart';

class MessageFieldBox extends StatefulWidget {
  // esto permite notificar cuando se haya realizado algun cambio en  value
  final ValueChanged<String> onValue;

  const MessageFieldBox({super.key, required this.onValue});

  @override
  State<MessageFieldBox> createState() => _MessageFieldBoxState();
}

class _MessageFieldBoxState extends State<MessageFieldBox> {
  // esto permite guardar el valor del input
  final textController = TextEditingController();
  // esto permite mantener el focus despues de accionar una accion en el input text
  final focusNode = FocusNode();

  @override
  void dispose() {
    focusNode.dispose(); // No olvides liberar el FocusNode
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final outlineBorder = UnderlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(20));

    final inputDecoration = InputDecoration(
        //esto permite agregarle un placeholder
        hintText: 'End your message with a "?"',
        // esta clase sirve para modificar border el textform
        enabledBorder: outlineBorder,
        // esto permite agregarle un border al focus
        focusedBorder: outlineBorder,
        // esto para que sea el contendido background del text field
        filled: true,
        suffixIcon: IconButton(
            // esto permite agregarle un icono al input text
            icon: const Icon(Icons.send_outlined),
            onPressed: () {
              // retorna el valor del caja de texto
              final textValue = textController.value.text;
              textController.clear();
              widget.onValue(textValue);
            }));

    return TextFormField(
        // y permite disparar un evento cuando estas fuera de caja de texto
        onTapOutside: (event) {
          debugPrint("Se disparo el evento");
          // esto permite salir del focus
          focusNode.unfocus();
        },
        controller: textController,
        focusNode: focusNode,
        decoration: inputDecoration,
        onFieldSubmitted: (value) {
          // esto limpia la caja de texto
          textController.clear();
          focusNode.requestFocus();
          debugPrint("Se disparo el evento");
          widget.onValue(value);
        });
  }
}
