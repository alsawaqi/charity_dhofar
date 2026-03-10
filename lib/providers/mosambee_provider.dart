import 'dart:convert'; 
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/local_storage_service.dart';

final mosambeeProvider = Provider((ref) => MosambeeService());

class MosambeeService {
  static const platform = MethodChannel('com.example.mosambee');

  Future<String?>  loginAndPay(double amount) async {
   try {
      final terminalId = (await LocalStorageService.getTerminalId())?.trim();
      if (terminalId == null || terminalId.isEmpty) {
        throw PlatformException(
          code: 'MISSING_TERMINAL_ID',
          message: 'Terminal ID is not set',
        );
      }
               
      final result = await platform.invokeMethod<String>('loginAndPay', {
      'userName': terminalId,
      'pin': '1321',
      'partnerId':'',
      'packageName': 'com.mosambee.dhofar.softpos',
      'amount': (amount * 1000).toInt().toString(),
      'mobNo': '91264444',
      'description': 'Charity Donation',
      });
 
      return result;
    } on PlatformException catch (e) {
     return jsonEncode({
    'stage': 'flutter_platform',
    'status': 'failed',
    'code': e.code,
    'message': e.message,
    'details': e.details,
  });
    } catch (e) {
       return jsonEncode({
    'stage': 'flutter',
    'status': 'failed',
    'error': e.toString(),
  });
    }
}

}
