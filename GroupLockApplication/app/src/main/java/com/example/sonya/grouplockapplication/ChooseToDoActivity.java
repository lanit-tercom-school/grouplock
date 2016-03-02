package com.example.sonya.grouplockapplication;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.widget.TextView;
import android.view.Menu;
import android.view.MenuItem;

public class ChooseToDoActivity extends AppCompatActivity  {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_choose_to_do);
        Toolbar mToolbar = (Toolbar) findViewById(R.id.toolbar_actionbar);
        setSupportActionBar(mToolbar);
    }

    public void chooseEncrypt(View v)
    {
        Intent intent  = new Intent(this, LibraryActivity.class);
        intent.putExtra("state", LibraryActivity.LibraryState.ENCRYPT_SELECTING);
        startActivity(intent);
    }

    public void chooseDecrypt(View v)
    {
        Intent intent  = new Intent(this, LibraryActivity.class);
        intent.putExtra("state", LibraryActivity.LibraryState.DECRYPT_SELECTING);
        startActivity(intent);
    }

    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.home_menu, menu);
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

            case R.id.settings:
                return true;

            case R.id.info:
            {
                TextView infoMessage = (TextView) findViewById(R.id.textViewInfoMessage);
                infoMessage.setVisibility(View.VISIBLE);
                return true;
            }

            default:
                return super.onOptionsItemSelected(item);
        }
    }
}
