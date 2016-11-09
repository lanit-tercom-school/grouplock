package com.example.sonya.grouplockapplication;

import android.app.Activity;
import android.content.Intent;
import android.content.pm.ActivityInfo;
import android.content.pm.PackageManager;
import android.database.Cursor;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.os.Bundle;
import android.os.Environment;
import android.provider.MediaStore;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import java.io.IOException;
import java.lang.String;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.util.Random;
import android.content.Intent;
import android.support.v7.app.ActionBar;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.CompoundButton;

import com.example.sonya.grouplockapplication.Encryption.SaveBMP;

public class LoadActivity extends AppCompatActivity {
    private static int RESULT_LOAD_IMG = 1;
    String imgDecodableString;
    String nameFile;
  //  File destination;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.load_layout);

      /*  Toolbar mToolbar = (Toolbar) findViewById(R.id.keys_type_selection_toolbar);
        setSupportActionBar(mToolbar);*/

        Toolbar mToolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(mToolbar);

        try {
            ActivityInfo activityInfo = getPackageManager().getActivityInfo(
                    getComponentName(), PackageManager.GET_META_DATA);
            TextView tw=(TextView)findViewById(R.id.textViewPage);
            tw.setText(activityInfo.loadLabel(getPackageManager())
                    .toString());
        } catch (PackageManager.NameNotFoundException e) {
            e.printStackTrace();
        }
       /* ActionBar ab = getSupportActionBar();
        ab.setDisplayHomeAsUpEnabled(true);*/


        loadImagefromGallery();
    }
    Bitmap temp;

    public void loadImagefromGallery() {
        // Create intent to Open Image applications like Gallery, Google Photos
        Intent galleryIntent = new Intent(Intent.ACTION_PICK,
                android.provider.MediaStore.Images.Media.EXTERNAL_CONTENT_URI);
        // Start the Intent
        startActivityForResult(galleryIntent, RESULT_LOAD_IMG);
    }

    //save image
    public void accDec(View view) {
        SaveImage(temp,"Decrypted");
        Intent intent = new Intent(LoadActivity.this, ChooseToDoActivity.class);
        startActivity(intent);
    }
    public void accEnc(View view) {
        SaveImage(temp, "Encrypted");
        Intent intent = new Intent(LoadActivity.this, ChooseToDoActivity.class);
        startActivity(intent);
    }


    //getImage from Gallery
    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        try {
            // When an Image is picked
            if (requestCode == RESULT_LOAD_IMG && resultCode == RESULT_OK
                    && null != data) {
                // Get the Image from data

                Uri selectedImage = data.getData();
                String[] filePathColumn = { MediaStore.Images.Media.DATA };

                // Get the cursor
                Cursor cursor = getContentResolver().query(selectedImage,
                        filePathColumn, null, null, null);
                // Move to first row
                cursor.moveToFirst();

                int columnIndex = cursor.getColumnIndex(filePathColumn[0]);
                imgDecodableString = cursor.getString(columnIndex);

                nameFile=String.copyValueOf(imgDecodableString.toCharArray(),
                        imgDecodableString.lastIndexOf('/')+1,
                        imgDecodableString.length() - imgDecodableString.lastIndexOf('/')-1);

              //  Log.i("WTF????", nameFile);
                cursor.close();
                ImageView imgView = (ImageView) findViewById(R.id.imgView);
                // Set the Image in ImageView after decoding the String
                imgView.setImageBitmap(BitmapFactory
                        .decodeFile(imgDecodableString));

            } else {
                /*Toast.makeText(this, "You haven't picked Image",
                        Toast.LENGTH_LONG).show();*/
                Intent intent = new Intent(LoadActivity.this, ChooseToDoActivity.class);
                startActivity(intent);
            }
        } catch (Exception e) {
            Toast.makeText(this, "Something went wrong", Toast.LENGTH_LONG)
                    .show();
        }
        temp = BitmapFactory
                .decodeFile(imgDecodableString);

    }

    //save image in externalStorage
    private void SaveImage(Bitmap finalBitmap, String str) {
        String root = Environment.getExternalStorageDirectory().toString();

        String typeFile=String.copyValueOf(nameFile.toCharArray(), nameFile.lastIndexOf('.') + 1,
                nameFile.length() - nameFile.lastIndexOf('.') - 1);

        if ((typeFile.toLowerCase().equals("jpg"))||typeFile.toLowerCase().equals("jpeg")) {
            try {
                File myDir = new File(root + "/GroupLock/" + str);
                myDir.mkdirs();
                File file = new File (myDir, nameFile);
                if (file.exists ()) file.delete ();
                FileOutputStream out = new FileOutputStream(file);
                finalBitmap.compress(Bitmap.CompressFormat.JPEG, 90, out);
                out.flush();
                out.close();

            } catch (Exception e) {
                e.printStackTrace();
            }
        } else if (typeFile.toLowerCase().equals("bmp")) {
            SaveBMP SB = new SaveBMP();
            try {
                SB.save(finalBitmap, root + "/GroupLock/" + str + "/" + nameFile);
            } catch (IOException e) {
                e.printStackTrace();
            }
        } else if (typeFile.toLowerCase().equals("png")) {
            try {
                File myDir = new File(root + "/GroupLock/" + str);
                myDir.mkdirs();
                File file = new File (myDir, nameFile);
                if (file.exists ()) file.delete ();
                FileOutputStream out = new FileOutputStream(file);
                finalBitmap.compress(Bitmap.CompressFormat.PNG, 90, out);
                out.flush();
                out.close();

            } catch (Exception e) {
                e.printStackTrace();
            }
        }


    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        int id = item.getItemId();

        switch (id) {
            /* If pressed Back button, close this screen and go to the previous one */
            case android.R.id.home:
                this.finish();
                return true;

            default:
                return super.onOptionsItemSelected(item);
        }
    }


}

