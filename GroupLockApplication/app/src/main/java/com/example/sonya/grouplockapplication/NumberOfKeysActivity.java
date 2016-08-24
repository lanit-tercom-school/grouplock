package com.example.sonya.grouplockapplication;

import android.annotation.TargetApi;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Build;
import android.os.Bundle;
import android.support.v7.app.ActionBar;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.NumberPicker;
import android.widget.TextView;
import android.widget.Toast;

import com.example.sonya.grouplockapplication.Encryption.check;

import java.util.ArrayList;


/**
 * Created by gimba on 10.03.2016.
 */

public class NumberOfKeysActivity extends AppCompatActivity {

    NumberPicker np1, np2;
 //   Button goNext,helpButton;
    boolean check = false;
    Toast toast;
    TextView textMin, textMax;
    ImageView btnBack, btnInfo;
    TextView btnNext;

    private ArrayList<LibraryEntry> filesToOperateWith;
    Bundle b;

    @TargetApi(Build.VERSION_CODES.JELLY_BEAN)
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.number_of_keys);
        np1 = (NumberPicker) findViewById(R.id.minKeys);
        np2 = (NumberPicker) findViewById(R.id.maxKeys);

        //deselect numberpickers
        np1.setDescendantFocusability(NumberPicker.FOCUS_BLOCK_DESCENDANTS);
        np2.setDescendantFocusability(NumberPicker.FOCUS_BLOCK_DESCENDANTS);

        np1.setMinValue(0);
        np1.setMaxValue(20);
        np2.setMinValue(0);
        np2.setMaxValue(20);
        np1.setWrapSelectorWheel(false);
        np2.setWrapSelectorWheel(false);

    //    goNext = (Button) findViewById(R.id.button3);
    //    helpButton = (Button) findViewById(R.id.button4);

        textMin = (TextView) findViewById(R.id.textMin);
        textMax = (TextView) findViewById(R.id.textMax);
        btnNext = (TextView) findViewById(R.id.textNext);
        btnBack = (ImageView) findViewById(R.id.buttonBack);
        btnInfo = (ImageView) findViewById(R.id.imageInfo);

        btnNext.setVisibility(View.VISIBLE);
        btnBack.setVisibility(View.VISIBLE);
        btnInfo.setVisibility(View.INVISIBLE);

        Toolbar mToolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(mToolbar);
     /*   ActionBar ab = getSupportActionBar();
        ab.setDisplayHomeAsUpEnabled(true);*/

        b = getIntent().getExtras();
        if(b!=null&& b.containsKey("files")){
            filesToOperateWith = (ArrayList<LibraryEntry>)b.get("files");
            Log.i("что же произошло?", "Получены файлы для шифрования");
            Log.i("nameF", filesToOperateWith.get(0).getAbsolutePath());
        }

        //EventListener for numberpickers

        NumberPicker.OnValueChangeListener onValueChangeListener = new NumberPicker.OnValueChangeListener() {

            @Override
            public void onValueChange(NumberPicker picker, int oldVal, int newVal) {



                switch (picker.getId()) {
                    case R.id.minKeys: {
                        String header = getString(R.string.minKeys);
                        textMin.setText(String.format(header,newVal));
                        if (np1.getValue()>np2.getValue()) {
                            np2.setValue(np1.getValue());
                            textMax.setText(String.format(getString(R.string.maxKeys), newVal));
                        }
                        break;
                    }
                    case R.id.maxKeys: {
                        String header = getString(R.string.maxKeys);
                        textMax.setText(String.format(header,newVal));
                        if (np2.getValue()<np1.getValue()) {
                            np1.setValue(np2.getValue());
                            textMin.setText(String.format(getString(R.string.minKeys), newVal));
                        }
                        break;
                    }

                }

                check = ((np1.getValue() != 0) && (np2.getValue() != 0));
            }
        };

        //EventListener for buttons
  /*      View.OnClickListener onClickListener = new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                switch (v.getId()) {

                    case R.id.button3: {
                        if (check) {    //go to the next page if button active
                            Intent intent = new Intent(NumberOfKeysActivity.this, EncrImgAndQr.class);
                            intent.putExtras(b);
                            intent.putExtra("minK", np1.getValue());
                            intent.putExtra("maxK", np2.getValue());
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
                    }
                }
            }
        };*/

    //    goNext.setOnClickListener(onClickListener);
    //    helpButton.setOnClickListener(onClickListener);
        np1.setOnValueChangedListener(onValueChangeListener);
        np2.setOnValueChangedListener(onValueChangeListener);
    }

 /*   @TargetApi(Build.VERSION_CODES.JELLY_BEAN)
    public void nextEnable() {
        check = true;
     //   goNext.setBackground(this.getResources().getDrawable(R.drawable.ic_arrow_forward_black_48dp));
    }

    @TargetApi(Build.VERSION_CODES.JELLY_BEAN)
    public void nextDisable() {
        check = false;
     //   goNext.setBackground(this.getResources().getDrawable(R.drawable.ic_arrow_forward_grey_48dp));
    }*/

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

    public void goBack(View v){
        onBackPressed();
    }
    public void goToNextStep(View v){
        if (check) {    //go to the next page if button active
            Intent intent = new Intent(NumberOfKeysActivity.this, EncrImgAndQr.class);
            intent.putExtras(b);
            intent.putExtra("minK", np1.getValue());
            intent.putExtra("maxK", np2.getValue());
            startActivity(intent);

        } else {        //info if button disable
            toast = Toast.makeText(getApplicationContext(),
                    R.string.infoNumbers,
                    Toast.LENGTH_SHORT);
            toast.show();
        }
    }
}