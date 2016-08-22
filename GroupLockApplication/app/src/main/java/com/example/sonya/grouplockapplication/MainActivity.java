package com.example.sonya.grouplockapplication;

import android.content.Intent;
import android.graphics.Color;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.view.WindowManager;
import android.widget.TextView;
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

import org.w3c.dom.Text;


public class MainActivity extends Activity implements OnClickListener {

    TextView textEntPass;
    EditText editText;
    Button EnterButton;
    SharedPreferences sPref;
    String savedText;
    boolean passReq;
    final String SAVED_TEXT = "saved_text";
    final String REQ_PASS= "req_pass";
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        loadData();
        setContentView(R.layout.activity_main);
        textEntPass=(TextView)findViewById(R.id.Password);
        editText = (EditText) findViewById(R.id.editText);
        EnterButton  = (Button) findViewById(R.id.EnterButton);
        EnterButton.setOnClickListener(this);

        if(editText.requestFocus()) {
            getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_STATE_ALWAYS_VISIBLE);
        }

        // loadText();
        if (passReq==false)
            GoToNextActivity();

    }
    @Override
    public void onClick(View v) {

        switch (v.getId()) {
            case R.id.EnterButton:
                if (savedText.equals("")) {
                    saveText();
                    GoToNextActivity();
                }
                else
                if (editText.getText().toString().equals(savedText)) {
                    Toast.makeText(this, "Accept!", Toast.LENGTH_SHORT).show();
                    GoToNextActivity();
                    editText.setText("");

                }
                else {
                    textEntPass.setTextColor(getResources().getColor(R.color.colorPasswordIncorrect));
                    editText.setText("");
                    Toast.makeText(this, "Password is incorrect", Toast.LENGTH_SHORT).show();
                }
                break;
            default:
                break;
        }
    }

    void saveText() {
        //sPref = getPreferences(MODE_PRIVATE);
        sPref = getSharedPreferences("DB",MODE_PRIVATE);
        Editor ed = sPref.edit();
        ed.putString(SAVED_TEXT, editText.getText().toString());
        ed.commit();
        Toast.makeText(this, "Text saved", Toast.LENGTH_SHORT).show();
    }

    void loadData() {
        sPref = getSharedPreferences("DB",MODE_PRIVATE);
        savedText = sPref.getString(SAVED_TEXT, "");
        passReq = sPref.getBoolean("req_pass", true);
    }

    public void GoToNextActivity()
    {
        Intent intent = new Intent(this, ChooseToDoActivity.class);
        startActivity(intent);
    }

}