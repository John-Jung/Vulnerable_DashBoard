package util;

import java.util.Base64;
import java.nio.charset.StandardCharsets;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

public class SimpleJWTUtil {
    
    // JWT 생성
    public static String createToken(String userID) {
        try {
            // Header
            JSONObject header = new JSONObject();
            header.put("alg", "none");
            header.put("typ", "JWT");
            
            // Payload
            JSONObject payload = new JSONObject();
            payload.put("sub", userID);
            payload.put("isAdmin", userID.equals("admin"));
            
            // Base64 인코딩
            String encodedHeader = Base64.getUrlEncoder().withoutPadding()
                    .encodeToString(header.toString().getBytes(StandardCharsets.UTF_8));
            String encodedPayload = Base64.getUrlEncoder().withoutPadding()
                    .encodeToString(payload.toString().getBytes(StandardCharsets.UTF_8));
            
            // JWT 형식: header.payload.
            return encodedHeader + "." + encodedPayload + ".";
            
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    
    // JWT 검증 (취약한 구현 - alg: none 허용)
    public static JSONObject verifyToken(String token) {
        try {
            String[] parts = token.split("\\.");
            if (parts.length >= 2) { // signature는 무시 (취약점)
                // header 디코딩
                String decodedHeader = new String(Base64.getUrlDecoder()
                        .decode(parts[0]), StandardCharsets.UTF_8);
                JSONParser parser = new JSONParser();
                JSONObject header = (JSONObject) parser.parse(decodedHeader);
                
                // alg: none 확인 (취약점)
                if ("none".equals(header.get("alg"))) {
                    // payload 디코딩
                    String decodedPayload = new String(Base64.getUrlDecoder()
                            .decode(parts[1]), StandardCharsets.UTF_8);
                    return (JSONObject) parser.parse(decodedPayload);
                }
            }
            return null;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    
    // 토큰에서 사용자 ID 추출
    public static String getUserIdFromToken(String token) {
        try {
            JSONObject payload = verifyToken(token);
            return payload != null ? (String) payload.get("sub") : null;
        } catch (Exception e) {
            return null;
        }
    }
    
    // 토큰에서 admin 여부 확인
    public static boolean isAdminFromToken(String token) {
        try {
            JSONObject payload = verifyToken(token);
            return payload != null && (Boolean) payload.get("isAdmin");
        } catch (Exception e) {
            return false;
        }
    }
}