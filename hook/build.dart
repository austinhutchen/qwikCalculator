
import 'package:code_assets/code_assets.dart';
import 'package:hooks/hooks.dart';
import 'package:native_toolchain_c/native_toolchain_c.dart';


void main(List<String> args) async{
   await build(args, (input,output)async{
   if(input.config.buildCodeAssets){
      final builder = CBuilder.library(
      name:'helpers',
      assetName: 'helpers.g.dart',
      sources: ['lib/helpers.c'],
      );
      await builder.run(input: input, output:output);
    }

    });

  
  }

  
