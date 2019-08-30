package com.plantlanta.team9130.plantlanta.IntroViews;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;

import com.plantlanta.team9130.plantlanta.R;

public class VolunteerPreferences extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_volunteer_preferences);
    }

    public void navigateToTimePreferences(View view) {
        startActivity(new Intent(this, TimePreferences.class));
    }
}
