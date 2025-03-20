package entity;

/**
 * Entity class for product pair recommendations (frequently bought together)
 */
public class ProductPair {
    private String product1Id;
    private String product1Name;
    private String product2Id;
    private String product2Name;
    private int frequency;
    private double correlationScore;
    
    public ProductPair() {
    }
    
    public ProductPair(String product1Id, String product1Name, String product2Id, String product2Name, int frequency) {
        this.product1Id = product1Id;
        this.product1Name = product1Name;
        this.product2Id = product2Id;
        this.product2Name = product2Name;
        this.frequency = frequency;
    }
    
    public ProductPair(String product1Id, String product1Name, String product2Id, String product2Name, 
            int frequency, double correlationScore) {
        this.product1Id = product1Id;
        this.product1Name = product1Name;
        this.product2Id = product2Id;
        this.product2Name = product2Name;
        this.frequency = frequency;
        this.correlationScore = correlationScore;
    }

    public String getProduct1Id() {
        return product1Id;
    }

    public void setProduct1Id(String product1Id) {
        this.product1Id = product1Id;
    }

    public String getProduct1Name() {
        return product1Name;
    }

    public void setProduct1Name(String product1Name) {
        this.product1Name = product1Name;
    }

    public String getProduct2Id() {
        return product2Id;
    }

    public void setProduct2Id(String product2Id) {
        this.product2Id = product2Id;
    }

    public String getProduct2Name() {
        return product2Name;
    }

    public void setProduct2Name(String product2Name) {
        this.product2Name = product2Name;
    }

    public int getFrequency() {
        return frequency;
    }

    public void setFrequency(int frequency) {
        this.frequency = frequency;
    }

    public double getCorrelationScore() {
        return correlationScore;
    }

    public void setCorrelationScore(double correlationScore) {
        this.correlationScore = correlationScore;
    }

    @Override
    public String toString() {
        return "ProductPair{" + "product1Id=" + product1Id + ", product1Name=" + product1Name + 
                ", product2Id=" + product2Id + ", product2Name=" + product2Name + 
                ", frequency=" + frequency + ", correlationScore=" + correlationScore + '}';
    }
} 