import 'dart:io'
import 'dart:ffigen/ffigen.dart'

Future<void> main() async{
   final packageRoot= Platform.script.resolve('../');
   final generator = Ffigenerator(
   output: Output(
   dart: DartOutput(path: packageRoot.resolve('lib/myCHelpers.g.dart'))
   ),
   input: Input(entryPoints: [packageRoot.resolve('src/myCHelpers.h')]),
    visitors: [Visitor(func: (node)=> node.isIncluded = node.name =='add' ) ],
   );
await generator.generate();
  }
