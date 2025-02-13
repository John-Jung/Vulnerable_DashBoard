package user;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import java.sql.Connection;

public class DBConnectionPool {
    private static HikariDataSource dataSource;

    static {
        HikariConfig config = new HikariConfig();
        config.setJdbcUrl("jdbc:oracle:thin:@192.168.17.132:1521:DB19");
        config.setUsername("LogBlog");
        config.setPassword("1234");
        config.setMaximumPoolSize(10);  // 최대 커넥션 수
        config.setMinimumIdle(5);       // 최소 유지 커넥션 수
        config.setIdleTimeout(300000);  // 유휴 커넥션 타임아웃: 5분
        config.setConnectionTimeout(10000);  // 커넥션 획득 타임아웃: 10초
        
        dataSource = new HikariDataSource(config);
    }

    public static Connection getConnection() {
        try {
            return dataSource.getConnection();
        } catch (Exception e) {
            throw new RuntimeException("Connection pool error", e);
        }
    }
}