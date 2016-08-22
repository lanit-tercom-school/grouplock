package com.example.sonya.grouplockapplication;

import android.content.Intent;
import android.content.pm.ActivityInfo;
import android.content.pm.PackageManager;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.PopupMenu;
import android.support.v7.widget.Toolbar;
import android.view.View;
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
        PopupMenu popupMenu = new PopupMenu(ChooseToDoActivity.this, v);
        popupMenu.inflate(R.menu.home_menu);
        popupMenu.setOnMenuItemClickListener(new PopupMenu.OnMenuItemClickListener() {

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
                    case R.id.info:{
                        TextView infoMessage = (TextView) findViewById(R.id.textViewInfoMessage);
                        infoMessage.setVisibility(View.VISIBLE);
                        return true;
                    }
                    case R.id.qr:{
                        Intent intent = new Intent(ChooseToDoActivity.this, QrReaderActivity.class);
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
