/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package control.resilient;

import dao.DebentureDAO;
import dao.DebtDAO;
import entity.Debenture;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.LinkedBlockingQueue;

/**
 *
 * @author vietanhdang
 */
public class QueueManager {

    private static final QueueManager INSTANCE = new QueueManager();
    private final BlockingQueue<Debenture> queue = new LinkedBlockingQueue<>();

    private QueueManager() {
        // Khởi tạo thread xử lý yêu cầu
        new Thread(() -> {
            while (true) {
                Debenture data = this.getRequest();
                if (data != null) {
                    try {
                        new DebentureDAO().insertDebenture(data);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
                try {
                    Thread.sleep(10000); // Delay 10 giây
                } catch (InterruptedException e) {
                    Thread.currentThread().interrupt();
                }
            }
        }).start();
    }
    
    public static QueueManager getInstance() {
        return INSTANCE;
    }

    public void addRequest(Debenture data) {
        try {
            queue.put(data); // Thêm data vào queue
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }
    }

    public Debenture getRequest() {
        try {
            return queue.take(); // Lấy request từ queue
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            return null;
        }
    }
}