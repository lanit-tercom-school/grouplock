package com.example.sonya.grouplockapplication;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Spinner;
import android.widget.Toast;

public class ChooseToDoActivity extends AppCompatActivity implements AdapterView.OnItemSelectedListener {

    Spinner spinner;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_choose_to_do);

        spinner = (Spinner) findViewById(R.id.Main);

        ArrayAdapter adapter = ArrayAdapter.createFromResource(this, R.array.Menu, android.R.layout.simple_spinner_item);
        spinner.setAdapter(adapter);
        spinner.setOnItemSelectedListener(this);
    }

    public void GoToNextActivityTwo(View v)
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

    @Override
    public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
        switch ( position )
        {
            case 1: {
                Intent intent  = new Intent(this, MainActivity.class);
                startActivity(intent);
                break;
            }
            case 2: {
                Intent intent  = new Intent(this,LibraryActivity.class);
                startActivity(intent);
                break;
            }
            case 3: break;
            case 4: break;
            default:
        }
    }

    @Override
    public void onNothingSelected(AdapterView<?> parent) {

    }
}
