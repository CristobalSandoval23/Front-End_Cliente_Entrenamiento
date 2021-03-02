import 'dart:convert';
import 'dart:io';

import 'package:entrenamiento_usuario/models/crear_microciclo_del_usuario_model.dart';
import 'package:entrenamiento_usuario/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:mime_type/mime_type.dart';


class MicrocicloProviders {

  final String _url = 'https://entrenamiento-adcaf.firebaseio.com';


  final _prefs = new PreferenciasUsuario();
  
  Future<bool> crearMicrociclo( MicrocicloModel microciclo ) async {
    
    final url = '$_url/microciclo/.json?auth=${_prefs.token}';

    final resp = await http.post( url, body: microcicloModelToJson(microciclo) );

    final decodedData = json.decode(resp.body);

    print( decodedData );

    return true;

  }

  
  Future<bool> editarMicrociclo( MicrocicloModel microciclo ) async {
    
     final url = '$_url/microciclo/${ microciclo.id2 }.json?auth=${_prefs.token}';

    final resp = await http.put( url, body: microcicloModelToJson(microciclo) );

    final decodedData = json.decode(resp.body);

    print( decodedData );

    return true;

  }


  Future<List<MicrocicloModel>> cargarMicrociclos() async {
                
    final url = '$_url/microciclo.json?orderBy="idCliente"&equalTo="${_prefs.correoUsuario}"&print=pretty';
    // final url = '$_url/microciclo.json?auth=${_prefs.token}';
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<MicrocicloModel> dias = new List();


    if ( decodedData == null ) return [];
    if ( decodedData['error'] != null ) return [];   

    decodedData.forEach( ( id, prod ){

      final prodTemp = MicrocicloModel.fromJson(prod);
      prodTemp.id2 = id;

      dias.add( prodTemp );
      print(prodTemp);
    });

    // print( productos[0].id );

    return dias;

  }


  Future<int> borrarMicrociclo( String id ) async { 

    final url = '$_url/microciclo/$id.json?auth=${_prefs.token}';
    final resp = await http.delete(url);

    print( resp.body );

    return 1;
  }

  Future<String> subirImagen( File imagen ) async {

    final url = Uri.parse('https://api.cloudinary.com/v1_1/dcuibrzz2/image/upload?upload_preset=bhhh1hrl');
    

    final mimeType = mime(imagen.path).split('/'); //image/jpeg

    final imageUploadRequest = http.MultipartRequest(
      'POST',
      url
    );

    final file = await http.MultipartFile.fromPath(
      'file', 
      imagen.path,
      contentType: MediaType( mimeType[0], mimeType[1] )
    );

    imageUploadRequest.files.add(file);


    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if ( resp.statusCode != 200 && resp.statusCode != 201 ) {
      print('Algo salio mal');
      print( resp.body );
      return null;
    }

    final respData = json.decode(resp.body);
    print( respData);

    return respData['secure_url'];


  }


}

