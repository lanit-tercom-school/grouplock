package com.example.sonya.grouplockapplication;

import android.annotation.TargetApi;
import android.app.Activity;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Point;
import android.media.Image;
import android.os.Build;
import android.os.Bundle;
import android.os.Environment;
import android.support.v7.app.ActionBar;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.Display;
import android.view.MenuItem;
import android.view.View;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.NumberPicker;
import android.widget.TextView;
import android.widget.Toast;

import com.example.sonya.grouplockapplication.Encryption.Factory;
import com.example.sonya.grouplockapplication.Encryption.IEncryption;
import com.example.sonya.grouplockapplication.Encryption.SaveBMP;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.integration.android.IntentIntegrator;
import com.google.zxing.integration.android.IntentResult;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;


/**
 * Created by gimba on 10.03.2016.
 */

public class DecrImg extends AppCompatActivity {

    ImageView IwDecrImg;
    IEncryption EncrClass;

    Bundle b;
    private ArrayList<LibraryEntry> filesToOperateWith;
    String nameFile;

    String[] Keys;
    int AmountScanKeys=0;

    @TargetApi(Build.VERSION_CODES.JELLY_BEAN)
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_decr_img);


        IwDecrImg=(ImageView)findViewById(R.id.imageDecr);

        b = getIntent().getExtras();
        filesToOperateWith = (ArrayList<LibraryEntry>)b.get("files");
        nameFile=filesToOperateWith.get(0).getName();
        Bitmap bitmap = BitmapFactory.decodeFile(Environment.getExternalStorageDirectory().getAbsolutePath() + "/GroupLock/Encrypted/" + nameFile);
        Factory factory = new Factory(bitmap);
        EncrClass = factory.getClass("bmp");

        ScanQr();

    }

    protected  void ScanQr(){
        final Activity activity = this;
        IntentIntegrator integrator = new IntentIntegrator(activity);
        integrator.setDesiredBarcodeFormats(IntentIntegrator.ALL_CODE_TYPES);
        integrator.setPrompt("Scan");
        integrator.setCameraId(0);
        integrator.setBeepEnabled(false);
        integrator.setBarcodeImageEnabled(false);
        integrator.initiateScan();
    }


    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        IntentResult result = IntentIntegrator.parseActivityResult(requestCode, resultCode, data);

        if(result != null) {
            if(result.getContents() == null) {
             // Toast.makeText(this, "Cancelled", Toast.LENGTH_LONG).show();
                Intent intent = new Intent(DecrImg.this, ChooseToDoActivity.class);
                startActivity(intent);
            } else {
             //   Toast.makeText(this, "Scanned123: " + result.getContents(), Toast.LENGTH_LONG).show();
                if (AmountScanKeys==0){
                    Keys= new String[Integer.parseInt(String.copyValueOf(result.getContents().toCharArray(),2,2))];
                    for(int i=0;i<Keys.length;i++)
                        Keys[i]="";
                    Log.i("wh", "Зоздан массив из "+ Integer.toString(Keys.length)+" элементов");
                }

                int index=Integer.parseInt(String.copyValueOf(result.getContents().toCharArray(),0,2));
                if((index<=Keys.length)&&(Keys[index-1].equals(""))){
                    Log.i("wh", "опознал как нужный");
                    Keys[index-1]=String.copyValueOf(result.getContents().toCharArray(),4,result.getContents().length()-4);
                    AmountScanKeys++;           //!!!!!!!!!
                    if (AmountScanKeys<Keys.length)
                        DialogMessage(true);
                    else
                        Rashifr();
                }
                else{
                    Log.i("wh", "опознал как ненужный");
                    DialogMessage(false);
                }
            }
        } else {
            // This is important, otherwise the result will not be passed to the fragment
            super.onActivityResult(requestCode, resultCode, data);
        }
    }

    protected void DialogMessage(boolean usl){
        AlertDialog.Builder builder = new AlertDialog.Builder(DecrImg.this);
        if (usl) {
            builder.setTitle("Progress")
                    .setMessage("Introduced "+AmountScanKeys +"/"+Keys.length+" part(s) of the key")
                    .setCancelable(false)
                    .setNegativeButton("Continue",
                            new DialogInterface.OnClickListener() {
                                public void onClick(DialogInterface dialog, int id) {
                                    dialog.cancel();
                                    ScanQr();
                                }
                            });
        }
        else {
            builder.setTitle("Error!")
                    .setMessage("The entered key is incorrect or has been introduced")
                    .setCancelable(false)
                    .setPositiveButton("Try again",
                            new DialogInterface.OnClickListener() {
                                public void onClick(DialogInterface dialog, int id) {
                                    dialog.cancel();
                                    ScanQr();
                                }
                            })
                    .setNegativeButton("Go Home",
                            new DialogInterface.OnClickListener() {
                                public void onClick(DialogInterface dialog, int id) {
                                    dialog.cancel();
                                    Intent intent = new Intent(DecrImg.this, ChooseToDoActivity.class);
                                    startActivity(intent);
                                }
                            });
        }

        AlertDialog alert = builder.create();
        alert.show();
    }

    protected void Rashifr(){
        String DecrKey="";
        for(int i=0;i<Keys.length;i++){
            DecrKey+=Keys[i];
        }
        Bitmap img = EncrClass.ResultDecr(DecrKey);
        IwDecrImg.setImageBitmap(img);
      //  SaveBMP bmpUtil = new SaveBMP();
        //   boolean isSaveResult = bmpUtil.save(img, Environment.getExternalStorageDirectory().getAbsolutePath() + "/GroupLock/Decrypted/" + nameFile);
        EncrClass.SaveResult(Environment.getExternalStorageDirectory().getAbsolutePath() + "/GroupLock/Decrypted/" + nameFile);
        File file = new File(Environment.getExternalStorageDirectory().getAbsolutePath() + "/GroupLock/Encrypted/", nameFile);
        file.delete();
    }

    public void onBackPressed(){

    }
    public void goToNextStep(View v){
        Intent intent = new Intent(DecrImg.this, ChooseToDoActivity.class);
        startActivity(intent);
    }

}