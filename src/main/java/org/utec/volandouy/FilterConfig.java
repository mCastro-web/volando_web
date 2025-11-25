package org.utec.volandouy;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.utec.volandouy.web.filters.MobileAccessFilter;

@Configuration
public class FilterConfig {

    @Bean
    public FilterRegistrationBean<MobileAccessFilter> mobileFilter() {
        FilterRegistrationBean<MobileAccessFilter> registrationBean = new FilterRegistrationBean<>();
        registrationBean.setFilter(new MobileAccessFilter());
        registrationBean.addUrlPatterns("/*"); // todas las rutas
        registrationBean.setOrder(1); // prioridad
        return registrationBean;
    }
}
