package com.example.sonya.grouplockapplication;

import android.content.Intent;
import android.content.res.Resources;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Point;
import android.graphics.drawable.TransitionDrawable;
import android.os.Bundle;
import android.os.Environment;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.Display;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.TableLayout;
import android.widget.TableRow;

import com.example.sonya.grouplockapplication.Encryption.Factory;
import com.example.sonya.grouplockapplication.Encryption.IEncryption;
import com.example.sonya.grouplockapplication.Encryption.SaveBMP;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

public class OutputQrActivity extends AppCompatActivity {

    Bundle b;
    private ArrayList<LibraryEntry> filesToOperateWith;
    int minK;
    int maxK;
    String nameFile;
    String[] keys;

    private TransitionDrawable mTransition;
    ArrayList<ImageButton> buttonList = new ArrayList<ImageButton>();
    int n = 5;//зависит от того, сколько ключей выбрано
    int nextbutton = n;
    Resources res;
    Bitmap bmNewSize;
    Bitmap bmOriginal;
    Button next;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Log.i("wtf", "111??????????????????????????????????????????????????");
        setContentView(R.layout.activity_output_qr);
      //  Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar_actionbar);
       // setSupportActionBar(toolbar);
        Log.i("wtf", "??????????????????????????????????????????????????");
        Encr();




        TableLayout tableLayout = (TableLayout) findViewById(R.id.tableLayout);
        res = this.getResources();
      //  mTransition = (TransitionDrawable) res.getDrawable(R.drawable.transition);
        DisplayMetrics metrics = res.getDisplayMetrics();
        float px = 85 * (metrics.densityDpi / 160f);

        for (int i = 0; i < (n / 3) + 1; i++) {
            TableRow tableRow = new TableRow(this);
            tableRow.setLayoutParams(new ViewGroup.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT));
            for (int j = 0; j < 3; j++) {//столбцы
                final int numberimage = i * 3 + (j /*+ 1*/);
             //   final int id = getResources().getIdentifier("qr" + numberimage, "drawable", getPackageName());
                bmOriginal = crQR(numberimage);
                bmNewSize = Bitmap.createScaledBitmap(bmOriginal, (int) px,
                        (int) px, false);
                buttonList.add(new ImageButton(this));
                buttonList.get(numberimage - 1).setImageBitmap(bmNewSize);

                buttonList.get(numberimage - 1).setOnClickListener(new View.OnClickListener() {
                    public void onClick(View v) {
                        Intent intent = new Intent(OutputQrActivity.this,
                                OpenQrActivity.class);
                        intent.putExtra("image", bmOriginal);

                        startActivity(intent);

                        buttonList.get(numberimage - 1).setAlpha(100);
                        nextbutton--;
                        if (nextbutton ==0){}
                    }
                });
                tableRow.addView(buttonList.get(numberimage - 1), j);

                if (numberimage >= n) break;
            }
            tableLayout.addView(tableRow, i);
        }
    }

  /*  @Override
    public boolean onCreateOptionsMenu(Menu menu)
    {
        MenuInflater inflater = getMenuInflater();
        inflater.inflate(R.menu.menu_open_image, menu);
        return true;
    }*/


    public void Encr(){
        b = getIntent().getExtras();
        minK = (Integer)b.get("minK");
        maxK = (Integer)b.get("maxK");
        Log.i("EncrImgAndQr", Integer.toString(minK));
        Log.i("EncrImgAndQr", Integer.toString(maxK));
        filesToOperateWith = (ArrayList<LibraryEntry>)b.get("files");
        nameFile=filesToOperateWith.get(0).getName();

        Bitmap bitmap = BitmapFactory.decodeFile(Environment.getExternalStorageDirectory().getAbsolutePath() + "/GroupLock/Decrypted/" + nameFile);

        Factory factory = new Factory(bitmap);
        IEncryption EncrClass = factory.getClass("bmp");
        // String Key=EncrClass.EncrImg();
        EncrClass.EncrImg();
        keys=EncrClass.PartsOfSecret(minK,maxK);
        Bitmap img=EncrClass.ResultEncr();

        String sdcardBmpPath = Environment.getExternalStorageDirectory().getAbsolutePath() + "/GroupLock/Encrypted/" + nameFile;

        SaveBMP bmpUtil = new SaveBMP();
        try {
            boolean isSaveResult = bmpUtil.save(img, sdcardBmpPath);
        } catch (IOException e) {
            e.printStackTrace();
        }
        File file = new File(Environment.getExternalStorageDirectory().getAbsolutePath() + "/GroupLock/Decrypted/", nameFile);
     //   file.delete();

    }

    public Bitmap crQR(int index){
        WindowManager manager = (WindowManager) getSystemService(WINDOW_SERVICE);
        Display display = manager.getDefaultDisplay();
        Point point = new Point();
        display.getSize(point);
        int width = point.x;
        int height = point.y;
        int smallerDimension = width < height ? width : height;
        smallerDimension = smallerDimension /1;

        //Encode with a QR Code image
        QRCodeEncoder qrCodeEncoder = new QRCodeEncoder(keys[index],
                null,
                "TEXT_TYPE",
                BarcodeFormat.QR_CODE.toString(),
                smallerDimension);


        try {
            return qrCodeEncoder.encodeAsBitmap();
            //ImageView myImage = (ImageView) findViewById(R.id.imageView1);
            //IwQr.setImageBitmap(bitmap2);



        } catch (WriterException e) {
            e.printStackTrace();
        }
        return null;
    }
}
