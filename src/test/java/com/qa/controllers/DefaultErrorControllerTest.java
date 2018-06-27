package com.qa.controllers;

import org.junit.Test;

import static org.junit.Assert.*;

public class DefaultErrorControllerTest {

    @Test
    public void getErrorPath() {
        DefaultErrorController defaultErrorController = new DefaultErrorController();
        assertEquals(defaultErrorController.getErrorPath(), "/error");
    }
}