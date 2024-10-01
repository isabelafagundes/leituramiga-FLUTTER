import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class AreaLogadaPage extends StatefulWidget {
  const AreaLogadaPage({
    super.key,
  });

  @override
  State<AreaLogadaPage> createState() => _AreaLogadaPageState();
}

class _AreaLogadaPageState extends State<AreaLogadaPage> {
  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}
