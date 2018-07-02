package net.wedjaa.wetnet.business.dao;

/**
 * @author graziella cipolletti
 *
 */

public class Response {

	public String message;
	
	public String code;
	
	public Object result;

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public Object getResult() {
		return result;
	}

	public void setResult(Object result) {
		this.result = result;
	}
	
	
}
