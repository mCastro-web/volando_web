package org.utec.volandouy;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.utec.volandouy.web.filters.ContadorRutasFilter;
import org.utec.volandouy.web.filters.MobileAccessFilter;

@Configuration
public class FilterConfig {

    @Bean
    public FilterRegistrationBean<MobileAccessFilter> mobileFilter() {
        FilterRegistrationBean<MobileAccessFilter> registrationBean = new FilterRegistrationBean<>();
        registrationBean.setFilter(new MobileAccessFilter());
        registrationBean.addUrlPatterns("/*");
        registrationBean.setOrder(1);
        return registrationBean;
    }

    @Bean
    public FilterRegistrationBean<ContadorRutasFilter> contadorFilter() {
        FilterRegistrationBean<ContadorRutasFilter> registrationBean = new FilterRegistrationBean<>();
        registrationBean.setFilter(new ContadorRutasFilter());
        registrationBean.addUrlPatterns("/ConsultaRutaVueloServlet");
        registrationBean.setOrder(2);
        return registrationBean;
    }
}