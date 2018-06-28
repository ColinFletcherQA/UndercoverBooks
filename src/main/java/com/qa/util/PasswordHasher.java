package com.qa.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class PasswordHasher {

    private static PasswordHasher instance = null;

    private PasswordHasher(){
    }

    public static PasswordHasher getInstance(){
        if(instance == null){
            instance = new PasswordHasher();
        }
        return instance;
    }

    public String encrypt(String input){
        if(input == null){
            return null;
        }
        try {
            MessageDigest messageDigest = MessageDigest.getInstance("MD5");
            messageDigest.update(input.getBytes());
            byte[] bytes = messageDigest.digest();
            StringBuilder builder = new StringBuilder();
            for (byte aByte : bytes) {
                builder.append(Integer.toString((aByte & 0xff) + 0x100, 16).substring(1));
            }
            return builder.toString();
        } catch (NoSuchAlgorithmException e){
            e.printStackTrace();
            return input;
        }
    }

}
