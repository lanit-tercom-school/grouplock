package com.example.sonya.grouplockapplication;

import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.CompoundButton;
import android.widget.CompoundButton.OnCheckedChangeListener;
import android.widget.Switch;
import android.widget.Toast;

public class SettingsActivity extends AppCompatActivity {

    SharedPreferences sPref;
    boolean passReq;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        loadData();
        setContentView(R.layout.activity_settings);
        Toolbar mToolbar = (Toolbar) findViewById(R.id.toolbar_actionbar);
        setSupportActionBar(mToolbar);


        Switch switchPass = (Switch)findViewById(R.id.switchPass);
        switchPass.setChecked(passReq);
       /* if (passReq)
            switchPass.setChecked(true);
        else
            switchPass.setChecked(false);*/


        switchPass.setOnCheckedChangeListener(new OnCheckedChangeListener() {

            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                saveOpt(isChecked);
            }
        });
    }

    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.settings_menu, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        int id = item.getItemId();

        switch (id) {
            case R.id.library: {
                Intent intent = new Intent(this, LibraryActivity.class);
                startActivity(intent);
                return true;
            }

            case R.id.home: {
                Intent intent = new Intent(this, ChooseToDoActivity.class);
                startActivity(intent);
                return true;
            }

            default:
                return super.onOptionsItemSelected(item);
        }
    }

    void loadData() {
        //sPref = getPreferences(MODE_PRIVATE);
        sPref = getSharedPreferences("DB",MODE_PRIVATE);
        passReq = sPref.getBoolean("req_pass", true);
    }

    void saveOpt(boolean opt) {
        //sPref = getPreferences(MODE_PRIVATE);
        sPref = getSharedPreferences("DB",MODE_PRIVATE);
        SharedPreferences.Editor ed = sPref.edit();
        ed.putBoolean("req_pass", opt);
        ed.commit();
        Toast.makeText(this, "Settings changed", Toast.LENGTH_SHORT).show();
    }

}