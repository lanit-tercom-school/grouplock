package com.example.sonya.grouplockapplication;

import android.annotation.TargetApi;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Point;
import android.media.Image;
import android.os.Build;
import android.os.Bundle;
import android.os.Environment;
import android.support.v7.app.ActionBar;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.Display;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.NumberPicker;
import android.widget.TableLayout;
import android.widget.TableRow;
import android.widget.TextView;
import android.widget.Toast;

import com.example.sonya.grouplockapplication.Encryption.Factory;
import com.example.sonya.grouplockapplication.Encryption.IEncryption;
import com.example.sonya.grouplockapplication.Encryption.SaveBMP;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;


/**
 * Created by gimba on 10.03.2016.
 */

public class EncrImgAndQr extends AppCompatActivity {


    int VALUE_OF_ALPHA = 10;

    Bundle b;
    private ArrayList<LibraryEntry> filesToOperateWith;
    int minK;
    int maxK;
    String nameFile;
    String[] Key;

    ArrayList<Bitmap> QrCodes=new ArrayList<Bitmap>();
    ArrayList<ImageButton> buttonList = new ArrayList<ImageButton>();
    boolean[] viwedQR;

    ImageView btnInfo;
    TextView btnNext;


    @TargetApi(Build.VERSION_CODES.JELLY_BEAN)
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        // Загрузка контента формы и toolbar
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_encr_img_and_qr);
        Toolbar mToolbar = (Toolbar) findViewById(R.id.encr_img_and_qr_toolbar);
        setSupportActionBar(mToolbar);


        // Получение необходимых данных, для шифрования файла
        b = getIntent().getExtras();
        minK = (Integer)b.get("minK");
        maxK = (Integer)b.get("maxK");
        Log.i("EncrImgAndQr",Integer.toString(minK));
        Log.i("EncrImgAndQr",Integer.toString(maxK));
        filesToOperateWith = (ArrayList<LibraryEntry>)b.get("files");
        nameFile=filesToOperateWith.get(0).getName();
        Log.i("EncrImgAndQr", filesToOperateWith.get(0).getName());

        //Загружаем файл из библиотеки и шифруем его
        Bitmap bitmap = BitmapFactory.decodeFile(Environment.getExternalStorageDirectory().getAbsolutePath() + "/GroupLock/Decrypted/" + nameFile);
        Factory factory = new Factory(bitmap);
        IEncryption EncrClass = factory.getClass(String.copyValueOf(nameFile.toCharArray(),
                nameFile.lastIndexOf('.') + 1, nameFile.length() - nameFile.lastIndexOf('.') - 1)
                .toLowerCase());
        EncrClass.EncrImg();
        Bitmap img=EncrClass.ResultEncr();
        Key = EncrClass.PartsOfSecret(minK, maxK);

        // Выводим QR-коды:
        Display display = getWindowManager().getDefaultDisplay();
        DisplayMetrics metricsB = new DisplayMetrics();
        display.getMetrics(metricsB);
        double WidthScreen=metricsB.widthPixels*0.265;

        int nKeys=Key.length;
        viwedQR = new boolean[nKeys];
        Log.i("cyvbjnk",Integer.toString(nKeys));
        TableLayout tableLayout = (TableLayout) findViewById(R.id.tableLayout2);

        for(int i=0;i<(nKeys/3)+1;i++){
            TableRow tableRow = new TableRow(this);
            tableRow.setLayoutParams(new ViewGroup.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT));
            for(int j = 0; j < 3; j++) {
                final int numberimage = i * 3 + j;
                if (numberimage >= nKeys) break;
                Bitmap QrOriginal = crQR(numberimage);
                Bitmap QrNewSize = Bitmap.createScaledBitmap(QrOriginal, (int) WidthScreen,
                        (int) WidthScreen, false);

                buttonList.add(new ImageButton(this));
                buttonList.get(numberimage).setImageBitmap(QrNewSize);
                viwedQR[numberimage]=false;

                buttonList.get(numberimage).setOnClickListener(new View.OnClickListener() {
                    public void onClick(View v) {
                        if (!viwedQR[numberimage]) {
                            Intent intent = new Intent(EncrImgAndQr.this, OpenQrActivity.class);
                            intent.putExtra("QrCode", QrCodes.get(numberimage));
                            startActivity(intent);

                            buttonList.get(numberimage).setAlpha(VALUE_OF_ALPHA);
                            viwedQR[numberimage]=true;
                        }
                    }
                });
                tableRow.addView(buttonList.get(numberimage), j);
            }
            tableLayout.addView(tableRow, i);
        }


        // Сохраняем получившейся результат
        String sdcardFilePath = Environment.getExternalStorageDirectory().getAbsolutePath() + "/GroupLock/Encrypted/" + nameFile;
        EncrClass.SaveResult(sdcardFilePath);

        // Удаляем исходную картинку
        File file = new File(Environment.getExternalStorageDirectory().getAbsolutePath() + "/GroupLock/Decrypted/", nameFile);
        file.delete();
    }


    public Bitmap crQR(int index){
        Bitmap bitmap = null;
        WindowManager manager = (WindowManager) getSystemService(WINDOW_SERVICE);
        Display display = manager.getDefaultDisplay();
        Point point = new Point();
        display.getSize(point);
        int width = point.x;
        int height = point.y;
        int smallerDimension = width < height ? width : height;
        smallerDimension = smallerDimension /3;

        //Encode with a QR Code image
        String textQr=String.format("%02d",index+1)+String.format("%02d",Key.length)+Key[index];
      //  String textQr=Key[index];
        QRCodeEncoder qrCodeEncoder = new QRCodeEncoder(textQr,
                null,
                "TEXT_TYPE",
                BarcodeFormat.QR_CODE.toString(),
                smallerDimension);


        try {
            bitmap = qrCodeEncoder.encodeAsBitmap();
            QrCodes.add(bitmap);

        } catch (WriterException e) {
            e.printStackTrace();
        }
        return bitmap;
    }

    @Override
    public void onBackPressed(){

    }

    public void goToNextStep(View v){
            Intent intent = new Intent(EncrImgAndQr.this, ChooseToDoActivity.class);
            startActivity(intent);
    }
}