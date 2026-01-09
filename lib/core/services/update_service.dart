import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AppUpdate {
  const AppUpdate({
    required this.version,
    required this.downloadUrl,
    required this.releaseNotes,
    required this.isPrerelease,
  });

  final String version;
  final String downloadUrl;
  final String releaseNotes;
  final bool isPrerelease;
}

class UpdateService {
  UpdateService({
    required this.owner,
    required this.repo,
  });

  final String owner;
  final String repo;

  Future<AppUpdate?> checkForUpdate({bool includePrerelease = false}) async {
    if (kIsWeb) return null;

    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersion = packageInfo.version;

      final response = await http.get(
        Uri.parse('https://api.github.com/repos/$owner/$repo/releases'),
        headers: {'Accept': 'application/vnd.github.v3+json'},
      );

      if (response.statusCode != 200) return null;

      final releases = jsonDecode(response.body) as List;
      if (releases.isEmpty) return null;

      for (final release in releases) {
        final isPrerelease = release['prerelease'] as bool;
        if (isPrerelease && !includePrerelease) continue;

        final tagName = release['tag_name'] as String;
        final version = tagName.replaceFirst('v', '');

        if (_isNewerVersion(version, currentVersion)) {
          final downloadUrl = _getDownloadUrl(release as Map<String, dynamic>);
          if (downloadUrl == null) continue;

          return AppUpdate(
            version: version,
            downloadUrl: downloadUrl,
            releaseNotes: release['body'] as String? ?? '',
            isPrerelease: isPrerelease,
          );
        }
      }

      return null;
    } catch (e) {
      debugPrint('Error checking for updates: $e');
      return null;
    }
  }

  String? _getDownloadUrl(Map<String, dynamic> release) {
    final assets = release['assets'] as List;
    if (assets.isEmpty) return release['html_url'] as String?;

    String? targetAsset;

    if (Platform.isAndroid) {
      targetAsset = 'apk';
    } else if (Platform.isIOS) {
      targetAsset = 'ipa';
    }

    if (targetAsset != null) {
      for (final asset in assets) {
        final name = asset['name'] as String;
        if (name.contains(targetAsset)) {
          return asset['browser_download_url'] as String;
        }
      }
    }

    return release['html_url'] as String?;
  }

  bool _isNewerVersion(String newVersion, String currentVersion) {
    final newParts = newVersion.split('.').map(int.tryParse).toList();
    final currentParts = currentVersion.split('.').map(int.tryParse).toList();

    for (var i = 0; i < newParts.length && i < currentParts.length; i++) {
      final newPart = newParts[i] ?? 0;
      final currentPart = currentParts[i] ?? 0;

      if (newPart > currentPart) return true;
      if (newPart < currentPart) return false;
    }

    return newParts.length > currentParts.length;
  }

  Future<void> openDownloadPage(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
