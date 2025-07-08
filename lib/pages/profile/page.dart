import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_app/generated/l10n.dart';
import 'package:hotel_app/logic/language/provider.dart';
import 'package:hotel_app/logic/language/supported_languages.dart';
import 'package:hotel_app/style/common.dart';
import 'package:hotel_app/style/paddings.dart';
import 'package:hotel_app/widgets/avatar/user_avatar.dart';
import 'package:hotel_app/widgets/navigation/container.dart';
import 'package:hotel_app/widgets/navigation/navigation_title.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final selectedLanguage = languageProvider.languageNotifier.value;
    final languages = Languages.values;

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(
            context,
          ).scaffoldBackgroundColor.withAlpha(0),
          surfaceTintColor: Theme.of(
            context,
          ).scaffoldBackgroundColor.withAlpha(0),

          floating: true,
          // toolbarHeight: height,
          // expandedHeight: height,
          pinned: true,
          flexibleSpace: NavigationContainer(
            color: Theme.of(context).scaffoldBackgroundColor.withAlpha(200),
            child: SafeArea(
              child: Column(
                children: [
                  Row(
                    children: [
                      NavigationTitle(
                        title: S.current.profile,
                        onTap: () {
                          context.pop();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        SliverPadding(
          padding: pagePadding.add(EdgeInsetsGeometry.only(top: 30)),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Container(
                  decoration: CommonThemeBuilders.boxDecorationTap,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10,
                    children: [
                      UserAvatarWidget(size: 100),
                      Text(
                        'Andry DJ',
                        style: Theme.of(
                          context,
                        ).textTheme.titleLarge!.copyWith(fontSize: 28),
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                decoration: CommonThemeBuilders.boxDecoration,
                padding: infoBoxPadding,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        'Languages',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    ...languages.map((lang) {
                      final isSelected = lang == selectedLanguage;
                      return GestureDetector(
                        onTap: () => languageProvider.setLanguage(lang),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Theme.of(
                                    context,
                                  ).colorScheme.primary.withOpacity(0.1)
                                : null,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.grey.shade300,
                              width: isSelected ? 2 : 1,
                            ),
                          ),

                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  lang.name,
                                  style: TextStyle(
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color: isSelected
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(
                                            context,
                                          ).textTheme.bodyMedium?.color,
                                  ),
                                ),
                              ),

                              if (isSelected)
                                Icon(
                                  Icons.check_circle,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
