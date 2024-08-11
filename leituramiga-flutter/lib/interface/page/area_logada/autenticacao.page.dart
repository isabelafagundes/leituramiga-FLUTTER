import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class AutenticacaoPage extends StatefulWidget {
  const AutenticacaoPage({
    super.key,
  });

  @override
  State<AutenticacaoPage> createState() => _AutenticacaoPageState();
}

class _AutenticacaoPageState extends State<AutenticacaoPage> {


  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }

}
