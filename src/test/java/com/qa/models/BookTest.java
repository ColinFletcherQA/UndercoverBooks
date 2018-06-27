package com.qa.models;

import org.junit.Test;

import static org.junit.Assert.*;

public class BookTest {

    @Test
    public void equals() {
        Book book1 = new Book();
        book1.setBookId(0);
        book1.setPaperISBN("TestISBN1");

        Book book2 = new Book();
        book2.setBookId(0);
        book2.setPaperISBN("TestISBN2");

        assertTrue(book1.equals(book2));
    }
}