package com.qa.models;

import lombok.Getter;
import lombok.Setter;

public class Flag {

    @Getter @Setter
    private String message;

    @Getter @Setter
    private int type;

    public Flag(String message, int type){
        this.message = message;
        this.type = type;
    }
}
