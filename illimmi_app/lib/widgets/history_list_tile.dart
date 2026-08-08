import 'package:flutter/material.dart';

import '../api/history_client.dart';

class HistoryListTile extends StatelessWidget {
  final HistoryEntry entry;
  final VoidCallback onTap;

  const HistoryListTile({super.key, required this.entry, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final title = (entry.subject?.isNotEmpty ?? false) ? entry.subject! : entry.prompt;
    return ListTile(
      dense: true,
      title: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text(_relativeDate(entry.createdAt), style: Theme.of(context).textTheme.bodySmall),
      onTap: onTap,
    );
  }

  String _relativeDate(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 1) return 'À l\'instant';
    if (diff.inHours < 1) return 'Il y a ${diff.inMinutes} min';
    if (diff.inDays < 1) return 'Il y a ${diff.inHours} h';
    return 'Il y a ${diff.inDays} j';
  }
}
