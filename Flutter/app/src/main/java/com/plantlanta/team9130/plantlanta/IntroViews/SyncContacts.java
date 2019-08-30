package com.plantlanta.team9130.plantlanta.IntroViews;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.preference.PreferenceManager;
import android.view.View;

import com.plantlanta.team9130.plantlanta.Home;
import com.plantlanta.team9130.plantlanta.R;

public class SyncContacts extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_sync_contacts);
    }

    public void navigateToHome(View view) {
        SharedPreferences sharedPreferences =
                PreferenceManager.getDefaultSharedPreferences(this);
        sharedPreferences.edit().putBoolean("first_login", false).apply();
        Intent goHome = new Intent(this, Home.class);
        goHome.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TASK);
        startActivity(goHome);
    }
}
