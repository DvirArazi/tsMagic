# TS Magic

## Installation
1. Install Dart
2. run `dart compile exe bin/tsmagic.dart -o tsmagic-installer.exe`;

## Usage

1. Execute the tsmagic-installer.exe to install:
	1. Bun, by running: `powershell -c "irm bun.sh/install.ps1|iex"`
	2. TypeScript, by running: `bun add typescript`
	1. ts-magic

2. run `tsmagic` from your desired directory to:
	1. create or override a tsconfig.json file with the content:
		```
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
		```
		if it does not already exist
	2. create or override or overrides a .vscode/settings.json with the content:
		```
		{
		  "files.exclude": {
		    ".vscode": true,
		    "**/*.js": true,
		    "tsconfig.json": true
		  }
		}
		```
  	3. create or override or overrides a .vscode/tasks.json with the content:
		```
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
  		```
	4. run `tsc --watch`.
