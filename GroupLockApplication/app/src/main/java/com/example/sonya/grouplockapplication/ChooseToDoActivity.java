package com.example.sonya.grouplockapplication;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Spinner;
import android.widget.Toast;

public class ChooseToDoActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_choose_to_do);
    }
    public void GoToNextActivityTwo(View v)
    {
        Intent intent  = new Intent(this, LibraryActivity.class);
        startActivity(intent);
    }
}
