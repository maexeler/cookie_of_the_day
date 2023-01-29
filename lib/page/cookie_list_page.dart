import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../model/cookie.dart';
import '../service/cookie_service.dart';
import 'util/cookie_error.dart';

/// Consists of a form to add a new Cookie and list of existing Cookies.
///
/// Cookies in the list can be edited
/// or deleted (by swiping then to the left).
class CookieListPage extends ConsumerWidget {
  const CookieListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cookieService = ref.watch(cookieServiceProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Cookie Maintenance')),
      body: Column(
        children: [
          // The input form
          CookieInputWidget(),
          // react on data changes
          cookieService.when(
            // While the data is loading, show a progress indicator
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            // we have data, show the cookie list
            data: (cookies) {
              return CookieListWidget(cookies);
            },
            // If data retrieval got an error, show an error screen
            error: (error, stackTrace) {
              return CookieErrorWidget(
                'Error loading Cookies',
                ref.read(cookieServiceProvider.notifier).retryLoadingCookies,
              );
            },
          ),
        ],
      ),
    );
  }
}

/// Show two input fields and a button to create a new Cookie.
class CookieInputWidget extends HookConsumerWidget {
  const CookieInputWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Each input needs a text controller
    final wisdomController = useTextEditingController();
    final authorController = useTextEditingController();

    return ListView(
      shrinkWrap: true, // Minimize height
      padding: EdgeInsets.symmetric(horizontal: 32),
      children: [
        TextField(
          controller: wisdomController,
          decoration: const InputDecoration(labelText: 'Wisdom'),
        ),
        TextField(
          controller: authorController,
          decoration: const InputDecoration(labelText: 'Author'),
        ),
        ElevatedButton(
          onPressed: () {
            if (wisdomController.text.isNotEmpty) {
              ref
                  .read(cookieServiceProvider.notifier)
                  .addCookie(wisdomController.text, authorController.text);
              wisdomController.clear();
              authorController.clear();
            }
          },
          child: Text('Add new Cookie'),
        ),
      ],
    );
  }
}

/// Show the list of available cookies.
class CookieListWidget extends ConsumerWidget {
  final List<Cookie> cookies;
  const CookieListWidget(this.cookies, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      // Make the ListView as big as possible
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        children: [
          for (final cookie in cookies)
            Dismissible(
              // A Dismissible lets us remove a Cookies with a swipe
              key: Key(cookie.id),
              child: CookieListItem(cookie),
              onDismissed: (_) {
                ref.read(cookieServiceProvider.notifier).deleteCookie(cookie);
              },
            ),
        ],
      ),
    );
  }
}

/// A CookieListItem shows a Cookie in a [ListTile]
///
/// Each [CookieListItem] reacts to focus changes and
/// displays its content either as text or sa input field
class CookieListItem extends HookConsumerWidget {
  final Cookie cookie;

  const CookieListItem(this.cookie, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemFocusNode = useFocusNode();
    final textFieldFocusNode =
        useFocusNode(); // I really don't know what this is doing
    final itemIsFocused =
        useIsFocused(itemFocusNode); // it knows if we have the focus or not

    final wisdomEditingController = useTextEditingController();
    final authorEditingController = useTextEditingController();

    return Column(
      children: [
        Focus(
          focusNode: itemFocusNode,
          onFocusChange: (focused) {
            if (focused) {
              wisdomEditingController.text = cookie.wisdom;
              authorEditingController.text = cookie.author;
            } else {
              // edit cookie
              ref.read(cookieServiceProvider.notifier).updateCookie(cookie,
                  wisdomEditingController.text, authorEditingController.text);
            }
          },
          child: ListTile(
            onTap: () {
              itemFocusNode.requestFocus();
              textFieldFocusNode.requestFocus();
            },
            title: itemIsFocused
                ? TextField(
                    controller: wisdomEditingController,
                  )
                : Text(cookie.wisdom),
            subtitle: itemIsFocused
                ? TextField(
                    controller: authorEditingController,
                  )
                : Text(cookie.author.isEmpty ? '© - ' : '© ${cookie.author}'),
          ),
        ),
        const Divider(height: 0, thickness: 1),
      ],
    );
  }
}

/// Observe the FocusNode
///
/// return true if the FocusNode has focus, false otherwise
bool useIsFocused(FocusNode node) {
  final isFocused = useState(node.hasFocus);
  useEffect(
    () {
      void listener() {
        isFocused.value = node.hasFocus;
      }

      node.addListener(listener);
      return () => node.removeListener(listener);
    },
    [node],
  );
  return isFocused.value;
}
