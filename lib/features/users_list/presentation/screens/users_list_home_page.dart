import 'package:flutter/material.dart';
import 'package:tafeal_demo/core/app/app_scaffold_page.dart';
import 'package:tafeal_demo/core/helpers/l10n/app_localizations.dart';

import '../../../../core/presentation/widgets/common_title_text.dart';

class UsersListHomePage extends StatelessWidget {
  const UsersListHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffoldPage(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CommonTitleText(
                textKey: AppLocalizations.of(context)!.lblUsersList),
          ],
        ),
      ),
    );
  }
}
