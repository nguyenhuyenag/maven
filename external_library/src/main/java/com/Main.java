package com;

import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringUtils;

@SuppressWarnings("deprecation")
public class Main {

	public static void main(String[] args) {
		System.out.println(StringUtils.isEmpty(null));
		byte[] arr = { 84, 104, 105, 115, 32, 105, 115, 32, 97, 32, 116, 101, 120, 116 };
		String output = IOUtils.toString(arr);
		System.out.println(output);
	}

}
