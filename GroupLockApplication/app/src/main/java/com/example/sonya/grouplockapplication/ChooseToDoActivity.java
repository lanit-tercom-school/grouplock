package com.example.sonya.grouplockapplication;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.widget.Toast;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.ArrayAdapter;
import android.widget.AdapterView;

public class ChooseToDoActivity extends AppCompatActivity  {

    public int ForEncrypt;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_choose_to_do);
        Toolbar mToolbar = (Toolbar) findViewById(R.id.toolbar_actionbar);
        setSupportActionBar(mToolbar);
    }

    public void ChooseEncrypt(View v)
    {
        ForEncrypt = 1;
        GoToNextActivityTwo(v);
    }

    public void ChooseDecrypt(View v)
    {
        ForEncrypt = 2;
        GoToNextActivityTwo(v);
    }

    private void GoToNextActivityTwo(View v)
    {
        Intent intent  = new Intent(this, LibraryActivity.class);
        startActivity(intent);
    }

    public void AskClick(View v) {
        Toast toast = Toast.makeText(getApplicationContext(),
                "Click button <Encrypt> or <Decrypt> for encrypt or decrypt file. Click <Load> for loading file from phone",
                Toast.LENGTH_SHORT);
        toast.show();
    }

    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.home_menu, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // получим идентификатор выбранного пункта меню
        int id = item.getItemId();


        // Операции для выбранного пункта меню
        switch (id) {
            case R.id.library: {
                Intent intent = new Intent(this, LibraryActivity.class);
                startActivity(intent);
                return true;
            }

            case R.id.settings:
                return true;

            case R.id.info:
                return true;

            case R.id.help_button:
            {
                Toast toast = Toast.makeText(getApplicationContext(),
                    "Click button <Encrypt> or <Decrypt> for encrypt or decrypt file. Click <Load> for loading file from phone",
                    Toast.LENGTH_SHORT);
                toast.show();
                return true;
            }

            default:
                return super.onOptionsItemSelected(item);
        }
    }
}
