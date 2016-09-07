package com.example.sonya.grouplockapplication;

import android.content.Intent;
import android.content.pm.ActivityInfo;
import android.content.pm.PackageManager;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.PopupMenu;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.MenuInflater;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.view.MenuItem;



public class ChooseToDoActivity extends AppCompatActivity {


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_choose_to_do);

        Toolbar mToolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(mToolbar);
        try {
            ActivityInfo activityInfo = getPackageManager().getActivityInfo(
                    getComponentName(), PackageManager.GET_META_DATA);
            TextView tw=(TextView)findViewById(R.id.textViewPage);
            tw.setText(activityInfo.loadLabel(getPackageManager())
                    .toString()+" ▼");

        } catch (PackageManager.NameNotFoundException e) {
            e.printStackTrace();
        }
    }

    public void showMenu(View v) {

        IconizedMenu popupMenu = new IconizedMenu(this, v);
        MenuInflater inflater = popupMenu.getMenuInflater();
        inflater.inflate(R.menu.home_menu, popupMenu.getMenu());
        popupMenu.setOnMenuItemClickListener(new IconizedMenu.OnMenuItemClickListener() {

            @Override
            public boolean onMenuItemClick(MenuItem item) {

                switch (item.getItemId()) {

                    case R.id.library:{
                        Intent intent = new Intent(ChooseToDoActivity.this, LibraryActivity.class);
                        startActivity(intent);
                        return true;
                    }
                    case R.id.settings:{
                        Intent intent = new Intent(ChooseToDoActivity.this, SettingsActivity.class);
                        startActivity(intent);
                        return true;
                    }

                    default:
                        return false;
                }
            }
        });
        popupMenu.show();
    }

    public void showInfo(View view){
        TextView infoMessage = (TextView) findViewById(R.id.textViewInfoMessage);
        if (infoMessage.getVisibility()!=View.VISIBLE)
            infoMessage.setVisibility(View.VISIBLE);
        else
            infoMessage.setVisibility(View.INVISIBLE);
    }

    public void loadPage(View view) {
        Intent intent = new Intent(ChooseToDoActivity.this, LoadActivity.class);
        startActivity(intent);
    }


    public void chooseEncrypt(View v) {
        Intent intent = new Intent(this, LibraryActivity.class);
        intent.putExtra("state", LibraryActivity.LibraryState.ENCRYPT_SELECTING);
        startActivity(intent);
    }

    public void chooseDecrypt(View v) {
        Intent intent = new Intent(this, LibraryActivity.class);
        intent.putExtra("state", LibraryActivity.LibraryState.DECRYPT_SELECTING);
        startActivity(intent);
    }

    @Override
    public void onBackPressed() {
        moveTaskToBack(true);

        super.onDestroy();

        System.runFinalizersOnExit(true);
        System.exit(0);
    }
}
