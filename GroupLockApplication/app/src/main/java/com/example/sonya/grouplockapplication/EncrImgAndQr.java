package com.example.sonya.grouplockapplication;

import android.annotation.TargetApi;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Point;
import android.media.Image;
import android.os.Build;
import android.os.Bundle;
import android.support.v7.app.ActionBar;
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
import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;


/**
 * Created by gimba on 10.03.2016.
 */

public class EncrImgAndQr extends AppCompatActivity {

    Button goNext,helpButton;
    ImageView IwEncrImg;
    ImageView IwQr;

    @TargetApi(Build.VERSION_CODES.JELLY_BEAN)
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_encr_img_and_qr);

        IwEncrImg=(ImageView)findViewById(R.id.imageEncr);
        IwQr=(ImageView)findViewById(R.id.imageQr);


        Bitmap bitmap = BitmapFactory.decodeResource(getResources(), R.drawable.cat3);
        Factory factory = new Factory(bitmap);
        IEncryption EncrClass = factory.getClass("bmp");
        String Key=EncrClass.EncrImg();
        Bitmap img=EncrClass.ResultEncr();

        IwEncrImg.setImageBitmap(img);
        Log.i("Sth", Key);

        //!!!!!!!!!!

        WindowManager manager = (WindowManager) getSystemService(WINDOW_SERVICE);
        Display display = manager.getDefaultDisplay();
        Point point = new Point();
        display.getSize(point);
        int width = point.x;
        int height = point.y;
        int smallerDimension = width < height ? width : height;
        smallerDimension = smallerDimension * 2/4;

        //Encode with a QR Code image
        QRCodeEncoder qrCodeEncoder = new QRCodeEncoder(Key,
                null,
                "TEXT_TYPE",
                BarcodeFormat.QR_CODE.toString(),
                smallerDimension);


        try {
            Bitmap bitmap2 = qrCodeEncoder.encodeAsBitmap();
            //ImageView myImage = (ImageView) findViewById(R.id.imageView1);
            IwQr.setImageBitmap(bitmap2);

        } catch (WriterException e) {
            e.printStackTrace();
        }

        //!!!!!!!!!!


       /* Intent intent = getIntent();
        Bitmap bm=intent.getParcelableExtra("image");
        Iw.setImageBitmap(bm);*/

        //Iw.setImageBitmap(BitmapFactory.decodeResource(getResources(), R.drawable.cat));
        /*goNext = (Button) findViewById(R.id.button3);
        helpButton = (Button) findViewById(R.id.button4);*/


        Toolbar mToolbar = (Toolbar) findViewById(R.id.keys_type_selection_toolbar);
        setSupportActionBar(mToolbar);
        ActionBar ab = getSupportActionBar();
        ab.setDisplayHomeAsUpEnabled(true);

        //EventListener for numberpickers


        //EventListener for buttons
        View.OnClickListener onClickListener = new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                switch (v.getId()) {

               /*     case R.id.button3: {
                        if (check) {    //go to the next page if button active
                            Intent intent = new Intent(EncrImgAndQr.this, ChooseToDoActivity.class);
                            startActivity(intent);

                        } else {        //info if button disable
                            toast = Toast.makeText(getApplicationContext(),
                                    R.string.infoNumbers,
                                    Toast.LENGTH_SHORT);
                            toast.show();
                        }
                        break;
                    }
                    case R.id.button4: { //info button
                        toast = Toast.makeText(getApplicationContext(),
                                R.string.infoNumbers,
                                Toast.LENGTH_LONG);
                        toast.show();
                        break;
                    }*/
                }
            }
        };

   //     goNext.setOnClickListener(onClickListener);
   //     helpButton.setOnClickListener(onClickListener);
    }


}