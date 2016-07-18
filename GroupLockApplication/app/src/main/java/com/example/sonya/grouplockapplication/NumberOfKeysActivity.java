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
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.NumberPicker;
import android.widget.TextView;
import android.widget.Toast;

import com.example.sonya.grouplockapplication.Encryption.check;


/**
 * Created by gimba on 10.03.2016.
 */

public class NumberOfKeysActivity extends AppCompatActivity {

    NumberPicker np1, np2;
    Button goNext,helpButton;
    boolean check = false;
    Toast toast;
    TextView textMin, textMax;

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

        goNext = (Button) findViewById(R.id.button3);
        helpButton = (Button) findViewById(R.id.button4);

        textMin = (TextView) findViewById(R.id.textMin);
        textMax = (TextView) findViewById(R.id.textMax);

        Toolbar mToolbar = (Toolbar) findViewById(R.id.keys_type_selection_toolbar);
        setSupportActionBar(mToolbar);
        ActionBar ab = getSupportActionBar();
        ab.setDisplayHomeAsUpEnabled(true);

        //EventListener for numberpickers

        NumberPicker.OnValueChangeListener onValueChangeListener = new NumberPicker.OnValueChangeListener() {

            @Override
            public void onValueChange(NumberPicker picker, int oldVal, int newVal) {
                if ((np1.getValue() != 0) && (np2.getValue() != 0))
                    nextEnable();   //enable button for turn to the next page
                else nextDisable(); //disable button for turn to the next page


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
            }
        };

        //EventListener for buttons
        View.OnClickListener onClickListener = new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                switch (v.getId()) {

                    case R.id.button3: {
                        if (check) {    //go to the next page if button active
                            Intent intent = new Intent(NumberOfKeysActivity.this, EncrImgAndQr.class);
                         //   Bitmap bitmap = BitmapFactory.decodeResource(getResources(), R.drawable.cat3);
                         //   intent.putExtra("image", bitmap);

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
        };

        goNext.setOnClickListener(onClickListener);
        helpButton.setOnClickListener(onClickListener);
        np1.setOnValueChangedListener(onValueChangeListener);
        np2.setOnValueChangedListener(onValueChangeListener);
    }

    @TargetApi(Build.VERSION_CODES.JELLY_BEAN)
    public void nextEnable() {
        check = true;
        goNext.setBackground(this.getResources().getDrawable(R.drawable.ic_arrow_forward_black_48dp));
    }

    @TargetApi(Build.VERSION_CODES.JELLY_BEAN)
    public void nextDisable() {
        check = false;
        goNext.setBackground(this.getResources().getDrawable(R.drawable.ic_arrow_forward_grey_48dp));
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