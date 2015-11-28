package http;

import java.util.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HttpController {

    @RequestMapping(value = "/")
    public String index0() {
        return "hello world";
    }

    @RequestMapping(value = "ping")
    public String index1() {
        return "pong";
    }

    @RequestMapping(value = "date")
    public String index2() {
	DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
	Date date = new Date();
	return dateFormat.format(date);
    }

}
