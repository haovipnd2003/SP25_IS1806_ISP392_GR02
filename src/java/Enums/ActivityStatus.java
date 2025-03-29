/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Enums;

/**
 *
 * @author ASUS
 */
public enum ActivityStatus {
    NOT_WORKING(0),
    WORKING(1);
    
    private final int value;

    private ActivityStatus(int value) {
        this.value = value;
    }

    public int getValue() {
        return value;
    }
}
