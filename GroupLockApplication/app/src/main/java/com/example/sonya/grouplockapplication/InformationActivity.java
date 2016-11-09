package com.example.sonya.grouplockapplication;

import android.content.Intent;
import android.content.pm.ActivityInfo;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

public class InformationActivity extends AppCompatActivity  {


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_information);

        Toolbar mToolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(mToolbar);

        try {
            ActivityInfo activityInfo = getPackageManager().getActivityInfo(
                    getComponentName(), PackageManager.GET_META_DATA);
            TextView tw=(TextView)findViewById(R.id.textViewPage);
            tw.setText("About ▼");
        } catch (PackageManager.NameNotFoundException e) {
            e.printStackTrace();
        }

        ImageView imageInfo = (ImageView) findViewById(R.id.imageInfo);
        imageInfo.setVisibility(View.INVISIBLE);
        

    }


    public void showMenu(View v) {
        IconizedMenu popupMenu = new IconizedMenu(this, v);
        MenuInflater inflater = popupMenu.getMenuInflater();
        inflater.inflate(R.menu.home_menu, popupMenu.getMenu());
        popupMenu.setOnMenuItemClickListener(new IconizedMenu.OnMenuItemClickListener() {

                                                 @Override
                                                 public boolean onMenuItemClick(MenuItem item) {

                                                     switch (item.getItemId()) {

                                                         case R.id.library: {
                                                             Intent intent = new Intent(InformationActivity.this, LibraryActivity.class);
                                                             startActivity(intent);
                                                             return true;
                                                         }
                                                         case R.id.home: {
                                                             Intent intent = new Intent(InformationActivity.this, ChooseToDoActivity.class);
                                                             startActivity(intent);
                                                             return true;
                                                         }
                                                         case R.id.settings: {
                                                             Intent intent = new Intent(InformationActivity.this, SettingsActivity.class);
                                                             startActivity(intent);
                                                             return true;
                                                         }

                                                         default:
                                                             return false;
                                                     }
                                                 }
                                             }

        );
            popupMenu.show();
        }

    }

