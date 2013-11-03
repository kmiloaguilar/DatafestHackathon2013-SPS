package com.acklenavenue.damechamba;

import android.app.Activity;
import android.app.Dialog;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.Window;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;
import com.parse.LogInCallback;
import com.parse.ParseException;
import com.parse.ParseUser;
import com.parse.RequestPasswordResetCallback;

public class Login extends Activity {

	private boolean isLoggingIn = false;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.login);
		((EditText)findViewById(R.id.txtSignupName)).setText("man");
		((EditText)findViewById(R.id.txtPassword)).setText("123");
		
		Button btnLogin = (Button) findViewById(R.id.btnLogin);
		btnLogin.setOnClickListener(new OnClickListener() {
			
			@Override
			public void onClick(View v) {
				final String user = ((EditText)findViewById(R.id.txtSignupName)).getText().toString();
				final String password = ((EditText)findViewById(R.id.txtPassword)).getText().toString();
				
				if(user.equals("") || user.equals("")){
					Toast.makeText(Login.this, "Please enter a user and a password", Toast.LENGTH_LONG).show();
					return;
				}
				if(!isLoggingIn){
					isLoggingIn = true;
					ParseUser.logInInBackground(user, password, new LogInCallback() {					
						@Override
						public void done(ParseUser user, ParseException exception) {
							if(user != null){
								startActivity(new Intent(Login.this, MyProfile.class));
							}
							else{
								Toast.makeText(Login.this, "No such user existe", Toast.LENGTH_LONG).show();
							}
						}
					});
				}
				else{
					Toast.makeText(Login.this, "Wait, you are currently logging in", Toast.LENGTH_SHORT).show();
				}
			}
		});		
		
		TextView txtSignup = (TextView) findViewById(R.id.txtSignup);
		txtSignup.setOnClickListener(new OnClickListener() {
			
			@Override
			public void onClick(View v) {
				startActivity(new Intent(Login.this, Signup.class));
			}
		});
		
		TextView txtForgotPass = (TextView) findViewById(R.id.txtForgotPass);
		txtForgotPass.setOnClickListener(new OnClickListener() {
			
			@Override
			public void onClick(View v) {
				final Dialog dialog = new Dialog(Login.this);
				dialog.setContentView(R.layout.reset_password_popup);
				dialog.setTitle("Forgot Password");
				
				final TextView txtEmail = (TextView) findViewById(R.id.txtSignupName);
				Button btnResetPassword = (Button) dialog.findViewById(R.id.btnResetPassword);
				btnResetPassword.setOnClickListener(new OnClickListener() {
					
					@Override
					public void onClick(View v) {
						Toast.makeText(Login.this, "Sending email...", Toast.LENGTH_SHORT).show();					
						ParseUser.requestPasswordResetInBackground(txtEmail.getText().toString(), new RequestPasswordResetCallback() {
							
							@Override
							public void done(ParseException arg0) {
								Toast.makeText(Login.this, "Email sent!", Toast.LENGTH_LONG).show();
								dialog.dismiss();
							}
						});
					}
				});
				dialog.show();
			}
		});
	}

	@Override
	protected void onResume() {
		isLoggingIn = false;
		super.onResume();
	}
}
