package egovframework.cmmn;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

public class HTMLTagFilter implements Filter {
	@SuppressWarnings("unused")
	private FilterConfig config;

	@Override
	public void init(FilterConfig config) throws ServletException {
		// TODO Auto-generated method stub
		this.config = config;
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		// TODO Auto-generated method stub
		chain.doFilter(new HTMLTagFilterRequestWrapper((HttpServletRequest)request), response);
	}

	@Override
	public void destroy() {
		// TODO Auto-generated method stub

	}

}
