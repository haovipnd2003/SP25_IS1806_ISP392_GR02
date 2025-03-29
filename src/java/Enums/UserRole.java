/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Enums;

/**
 *
 * @author vietanhdang
 */
public enum UserRole {
    NONE(1),
    ADMIN(2),
    EMPLOYEE(3);
    
    private final int value;

    private UserRole(int value) {
        this.value = value;
    }

    public int getValue() {
        return value;
    }
}
