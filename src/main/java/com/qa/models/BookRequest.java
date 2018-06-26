package com.qa.models;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class BookRequest {

    @Id @Getter @Setter
    private String bookTitle;

    @Getter @Setter
    private String bookAuthor;
}
