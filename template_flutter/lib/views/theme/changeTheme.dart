import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:s_fam/generated/i10n.dart';
import 'package:s_fam/view_models/app_provider.dart';
class ChangeTheme extends StatefulWidget {
  const ChangeTheme({Key? key}) : super(key: key);

  @override
  _ChangeThemeState createState() => _ChangeThemeState();
}

class _ChangeThemeState extends State<ChangeTheme> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height:50,

          alignment: Alignment.center,
          color: Colors.white,
          child: SwitchListTile(
            secondary: Icon(Icons.brightness_2, color: Theme.of(context).accentColor, size: 24),
            value: Provider.of<AppProvider>(context).darkTheme,
            activeColor: const Color(0xFF0066B4),
            onChanged: (bool value) {
              if (value) {
                Provider.of<AppProvider>(context, listen: false).updateTheme(true);
              } else {
                Provider.of<AppProvider>(context, listen: false).updateTheme(false);
              }
            },
            title: Text(S.of(context)!.darkTheme, style: const TextStyle(fontSize: 16)),
          ),
        ),
      ),
    );
  }
}
