package com.acklenavenue.damechamba;

import com.acklenavenue.tabpanel.MyTabHostProvider;
import com.acklenavenue.tabpanel.TabHostProvider;
import com.acklenavenue.tabpanel.TabView;
import com.parse.ParseUser;

import android.app.Activity;
import android.os.Bundle;
import android.view.Window;
import android.view.WindowManager;
import android.widget.TextView;

public class MyProfile extends Activity{
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		
		TabHostProvider tabProvider = new MyTabHostProvider(MyProfile.this);
		TabView tabView = tabProvider.getTabHost("Home");
		tabView.setCurrentView(R.layout.profile);
		setContentView(tabView.render(0));
				
		ParseUser user = ParseUser.getCurrentUser();		
		String username = user.getUsername().toString();
		
		TextView txtUserName = (TextView) tabView.getCurrentView().findViewById(R.id.txtProfileNamee);
		txtUserName.setText(username);		
		
		TextView txtEmail = (TextView) tabView.getCurrentView().findViewById(R.id.txtProfileEmail);
		txtEmail.setText(user.getEmail());

		TextView txtCity = (TextView) tabView.getCurrentView().findViewById(R.id.txtCity);
		txtCity.setText(user.getString("city"));
	}
}
