package com.example.sonya.grouplockapplication;

import android.content.Intent;
//import android.support.v7.app.AppCompatActivity;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Toast;
import android.app.Activity;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;


public class MainActivity extends Activity implements OnClickListener {

    EditText edText, editText;
    Button EnterButton;
    SharedPreferences sPref;
    String savedText;
    final String SAVED_TEXT = "saved_text";
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        editText = (EditText) findViewById(R.id.editText);

        EnterButton  = (Button) findViewById(R.id.EnterButton);
        EnterButton.setOnClickListener(this);
        loadText();
    }
    @Override
    public void onClick(View v) {

        switch (v.getId()) {
            case R.id.EnterButton:
                if (savedText.equals("")) {
                    saveText();
                    GoToNextActivity(v);
                }
                else
                if (editText.getText().toString().equals(savedText)) {
                    Toast.makeText(this, "Accept!", Toast.LENGTH_SHORT).show();
                    GoToNextActivity(v);
                }
                else {
                    Toast.makeText(this, "Password is incorrect", Toast.LENGTH_SHORT).show();
                }
                 break;
            default:
                break;
        }
    }

    void saveText() {
        sPref = getPreferences(MODE_PRIVATE);
        Editor ed = sPref.edit();
        ed.putString(SAVED_TEXT, editText.getText().toString());
        ed.commit();
        Toast.makeText(this, "Text saved", Toast.LENGTH_SHORT).show();
    }

    void loadText() {
        sPref = getPreferences(MODE_PRIVATE);
        savedText = sPref.getString(SAVED_TEXT, "");
    }
    public void GoToNextActivity(View v)
    {
        Intent intent = new Intent(this, ChooseToDoActivity.class);
        startActivity(intent);
    }

}