package com.plantlanta.team9130.plantlanta;

import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.preference.PreferenceManager;
import android.view.MenuItem;

import com.google.android.material.bottomnavigation.BottomNavigationView;
import com.plantlanta.team9130.plantlanta.IntroViews.Welcome;
import com.plantlanta.team9130.plantlanta.fragments.FragmentEvent;
import com.plantlanta.team9130.plantlanta.fragments.FragmentReccuringEvent;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.fragment.app.FragmentTransaction;

public class Home extends AppCompatActivity {


    private BottomNavigationView.OnNavigationItemSelectedListener mOnNavigationItemSelectedListener
            = new BottomNavigationView.OnNavigationItemSelectedListener() {

        @Override
        public boolean onNavigationItemSelected(@NonNull MenuItem item) {
            switch (item.getItemId()) {
                case R.id.navigation_home:
                    return true;
                case R.id.navigation_market:
                    return true;
                case R.id.navigation_profile:
                    return true;
            }
            return false;
        }
    };

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_home);
        SharedPreferences sharedPreferences =
                PreferenceManager.getDefaultSharedPreferences(this);
        // Check if we need to display our OnboardingFragment
        if (sharedPreferences.getBoolean("first_login", true)) {
            Intent setup = new Intent(this, Welcome.class);
            setup.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TASK);
            startActivity(setup);
        }

        BottomNavigationView navigation =  findViewById(R.id.navigation);
        navigation.setSelectedItemId(R.id.navigation_home);
        navigation.setOnNavigationItemSelectedListener(mOnNavigationItemSelectedListener);

        String eventName1 = "Plantlanta Summer Festival \n 6/10/2019";
        String eventName2 = "Piedmont Park Clean Up \n 7/23/2019";
        String eventName3 = "Orphanage Playtime \n 5/17/2019";
        String eventName4 = "WWF Fundraiser \n 9/8/2019";
        String eventName5 = "WHO Awareness Day \n 11/29/2019";

        String location1 = "Piedmont Park";
        String time1 = "10AM - 7PM";
        String description1 = "Join Plantlanta and artists’ such as Migos, Cardi B, Beyonce and many others as we bring awareness to the many project on our platform" +
                "\nwww.plantlanta.com/sf19";

        FragmentTransaction ft = getSupportFragmentManager().beginTransaction();
        FragmentEvent eventFragment1 = FragmentEvent.newInstance(eventName1, location1, time1, description1);
        FragmentReccuringEvent eventFragment2 = FragmentReccuringEvent.newInstance(eventName2, location1, time1, description1);
        FragmentEvent eventFragment3 = FragmentEvent.newInstance(eventName3, location1, time1, description1);
        FragmentEvent eventFragment4 = FragmentEvent.newInstance(eventName4, location1, time1, description1);
        FragmentEvent eventFragment5 = FragmentEvent.newInstance(eventName5, location1, time1, description1);

        ft.replace(R.id.event_placeholder, eventFragment1);
        ft.replace(R.id.event_placeholder2, eventFragment2);
        ft.replace(R.id.event_placeholder3, eventFragment3);
        ft.replace(R.id.event_placeholder4, eventFragment4);
        ft.replace(R.id.event_placeholder5, eventFragment5);

        ft.commit();

    }
}
