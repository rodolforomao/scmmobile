package br.com.scmengenharia.dicii

import android.Manifest
import android.annotation.TargetApi
import android.app.AlertDialog
import android.content.pm.PackageManager
import android.os.Build
import android.os.Bundle
import androidx.annotation.RequiresApi

import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.embedding.engine.FlutterEngine

class MainActivity: FlutterActivity() {

    private val permissions = arrayOf(
        Manifest.permission.READ_EXTERNAL_STORAGE,
        Manifest.permission.WRITE_EXTERNAL_STORAGE)

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(FlutterEngine(this));
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            if (arePermissionsEnabled()) {
                //                    permissions granted, continue flow normally
            } else {
                requestMultiplePermissions()
            }
        }
        // val intent: Intent = getIntent()
        //  if (Intent.ACTION_VIEW.equals(intent.getAction())) {
        //  val uri: Uri = intent.getData()
        // }
    }

    @RequiresApi(api = Build.VERSION_CODES.M)
    private fun arePermissionsEnabled(): Boolean {
        return permissions.none { checkSelfPermission(it) != PackageManager.PERMISSION_GRANTED }
    }

    @RequiresApi(api = Build.VERSION_CODES.M)
    private fun requestMultiplePermissions() {
        val remainingPermissions = permissions.filter { checkSelfPermission(it) != PackageManager.PERMISSION_GRANTED }
        requestPermissions(remainingPermissions.toTypedArray(), 101)
    }

    @TargetApi(Build.VERSION_CODES.M)
    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<String>, grantResults: IntArray) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if (requestCode == 101) {
            if (grantResults.any { it != PackageManager.PERMISSION_GRANTED }) {
                if (permissions.any { shouldShowRequestPermissionRationale(it) }) {
                    AlertDialog.Builder(this).setMessage("Não foi liberado as permissões para o uso do aplicativo, por favor permitir. ! ").setPositiveButton("Permitir") { dialog, which -> requestMultiplePermissions() }.setNegativeButton("Cancelar") { dialog, which -> dialog.dismiss() }.create().show()
                }
            }
            //all is good, continue flow
        }
    }

}
