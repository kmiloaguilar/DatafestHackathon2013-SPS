package com.acklenavenue.damechamba;

import java.util.ArrayList;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.TextView;

import com.fima.cardsui.objects.Card;

public class JobCard extends Card{

	String title;
	ArrayList<Object> skills;
	public JobCard(String title, ArrayList<Object> skills){
		super(title);
		this.title = title;
		this.skills = skills;
	}
	
	@Override
	public View getCardContent(Context context) {
		View view = LayoutInflater.from(context).inflate(R.layout.card_play, null);
		//String skills = getSkillsFormatted();
				
		((TextView) view.findViewById(R.id.txtCardTitle)).setText(title);
		((TextView) view.findViewById(R.id.txtSkills)).setText(skills+"");
		return view;
	}
	
	private String getSkillsFormatted()
	{
		String skls = "";
		int count = 0;
		for(Object skill : skills){
			if( count == 2){
				skls += " ...";
				break;
			}
			skls += skill +",";
			count++;
		}
		return skls;
	}

	@Override
	public boolean convert(View convertCardView) {
		// TODO Auto-generated method stub
		return false;
	}

}
