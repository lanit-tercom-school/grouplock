package com.example.sonya.grouplockapplication;

import android.support.v7.app.ActionBar;
//import android.support.v7.app.AppCompatActivity;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.CompoundButton;

import java.util.ArrayList;

public class KeysTypeSelectionActivity extends ActionBarActivity/*AppCompatActivity*/
        implements CompoundButton.OnCheckedChangeListener, View.OnClickListener {

    private Button btnNextStep;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_keys_type_selection);

        Toolbar mToolbar = (Toolbar) findViewById(R.id.keys_type_selection_toolbar);
        setSupportActionBar(mToolbar);

        /* Add Back button at the top of the screen */
        ActionBar ab = getSupportActionBar();
        ab.setDisplayHomeAsUpEnabled(true);

        btnNextStep = (Button) findViewById(R.id.keys_type_selection_btnNext);
        btnNextStep.setEnabled(false);
        btnNextStep.setOnClickListener(this);

        CheckBox qr = (CheckBox)findViewById(R.id.checkBoxQRCode);
        qr.setOnCheckedChangeListener(this);
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

    @Override
    public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
        btnNextStep.setEnabled(isChecked);
    }

    @Override
    public void onClick(View v) {
        if (v.getId() != R.id.keys_type_selection_btnNext) {
            return;
        }

        /* Get passed data from the previous screen */
        ArrayList<LibraryEntry> files = getIntent().getParcelableArrayListExtra("files");
        // TODO: go to next activity and pass all needed data to it
        for (LibraryEntry entry: files) {
            Log.d("crypt", entry.getAbsolutePath());
        }
    }

}
