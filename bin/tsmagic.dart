import 'dart:io';

void main() {
  String crntExePath = Platform.resolvedExecutable;
  String home =
      Platform.environment['HOME'] ?? Platform.environment['USERPROFILE']!;
  String tsmagicExePath = '$home\\.bun\\bin\\tsmagic.exe';

  if (crntExePath != tsmagicExePath) {
    print('* Installing Bun');
    Process.runSync('powershell', ['-c', 'irm bun.sh/install.ps1 | iex']);

    print('* Installing TypeScript');
    Process.runSync('$home/.bun/bin/bun', ['add', '-g', 'typescript']);

    print('* Installing TsMagic');
    File(crntExePath).copySync(tsmagicExePath);
  } else {
    print('* Creating tsconfig.json');
    File('tsconfig.json').writeAsStringSync('''
{
  "compilerOptions": {
    "target": "es2016",
    "module": "commonjs",
    "inlineSourceMap": true,
    "esModuleInterop": true,
    "forceConsistentCasingInFileNames": true,
    "strict": true,
    "noImplicitAny": true,
    "strictNullChecks": true,
    "strictFunctionTypes": true,
    "strictPropertyInitialization": true,
    "noImplicitThis": true,
    "useUnknownInCatchVariables": true,
    "alwaysStrict": true,
    "exactOptionalPropertyTypes": true,
    "noPropertyAccessFromIndexSignature": true,
  }
}
''');

    print('* Creating .vscode');
    Directory('.vscode').createSync();

    print('* Creating .vscode/tsconfig.json');
    File('.vscode/settings.json').writeAsStringSync('''
{
  "files.exclude": {
    ".vscode": true,
    "**/*.js": true,
    "tsconfig.json": true
  }
}
''');

    print('* Creating .vscode/tasks.json');
    File('.vscode/tasks.json').writeAsStringSync('''
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Watch TS",
      "type": "shell",
      "command": "tsc --watch",
      "isBackground": true,
      "presentation": {
        "reveal": "never",
        "focus": false,
        "panel": "dedicated",
      },
      "runOptions": {
        "runOn": "folderOpen"
      }
    }
  ]
}
''');

    print('* Running `tsc --watch`');
    Process.runSync('powershell', ['-c', 'tsc --watch']);
  }
}
