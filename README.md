# TS Magic

1. Creates a file that installs:
	1. Bun, by running: `powershell -c "irm bun.sh/install.ps1|iex"`
	2. TypeScript, by running: `bun add typescript`
	1. ts-magic
2. the ts-magic is a command, that when run in a certain directory:
	1. creates a tsconfig.json file with the content:
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
		    "strictBindCallApply": true,
		    "strictPropertyInitialization": true,
		    "noImplicitThis": true,
		    "useUnknownInCatchVariables": true,
		    "alwaysStrict": true,
		    "exactOptionalPropertyTypes": true,
		    "noPropertyAccessFromIndexSignature": true,
		    "skipLibCheck": true
		  }
		}
		```
		if it does not already exist
	2. creates or overrides a .vscode/settings.json with the content:
		```
		{
		  "files.exclude": {
		    ".vscode": true,
		    "**/*.js": true,
		    "tsconfig.json": true
		  }
		}
		```
	3. runs `tsc --watch`.
