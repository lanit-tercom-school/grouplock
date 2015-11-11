package com.example.sonya.grouplockapplication;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.Menu;
import android.widget.TextView;
import android.view.*;


public class LibraryActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.library_layout);
    }
    /*public void GoToChooseFileLibrary(View v)
    {
        Intent intent  = new Intent(this, LibraryActivity.class);
        startActivity(intent);
    }
    public void GoToChooseFileSF(View v)
    {
        Intent intent  = new Intent(this, LibraryActivity.class);
        startActivity(intent);
    }
    */
    public void GoToPrevStep(View v)
    {
        Intent intent  = new Intent(this, ChooseToDoActivity.class);
        startActivity(intent);
    }
               @Override
               public boolean onCreateOptionsMenu(Menu menu) {
                   getMenuInflater().inflate(R.menu.second_menu, menu);
                   return true;
               }
               @Override
               public boolean onOptionsItemSelected(MenuItem item) {
                   // получим идентификатор выбранного пункта меню
                   int id = item.getItemId();



                   // Операции для выбранного пункта меню
                   switch (id) {
                       case R.id.action_change:

                           return true;
                       case R.id.action_search:

                           return true;
                       case R.id.action_make_dir:

                           return true;
                       default:
                           return super.onOptionsItemSelected(item);
                   }
               }

}
