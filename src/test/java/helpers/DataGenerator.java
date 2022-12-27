package helpers;

import com.github.javafaker.Faker;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import net.minidev.json.JSONObject;



public class DataGenerator {
    public static String getRandomEmail(){
        Faker faker = new Faker();
        String email = faker.name().firstName().toLowerCase() + faker.random().nextInt(0, 100) + "@test.com";
        return email;
    }

    public static String getRandomUserName(){
        Faker faker = new Faker();
        String userName = faker.name().username();
        return userName;
    }

    public static JSONObject getRandomArticleValues(){
        Faker faker = new Faker();
        String title = faker.gameOfThrones().character();
        String description = faker.gameOfThrones().city();
        String body = faker.gameOfThrones().dragon();
        JSONObject json = new JSONObject();
        json.put("title", title);
        json.put("description", description);
        json.put("body", body);
        return json;
    }

    public static String commentArticle(){
        Faker faker = new Faker();
        String commentArt = faker.book().title();
        return  commentArt;
    }

    public static String dueDate(int incrementDay) {
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");  
        LocalDateTime now = LocalDateTime.now();  
        return (dtf.format(now.plusDays(incrementDay)));  
    }

}