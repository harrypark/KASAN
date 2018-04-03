package com.kspat;

public class AnnualTest {

	public static void main(String[] args) {
		double availCount =15.0;
		double usedCount = 2.0;



		double lateSub = (1/5)*3d + (1/3) * 2d;
		System.out.println(lateSub);
		double currCount = availCount - usedCount - lateSub - 0.5 - 0.5;

		System.out.println(currCount);

	}

}
