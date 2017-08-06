<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.security.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%!public static String TRANSACTION_TOKEN_KEY = "TRANSACTION_TOKEN_KEY";

	public static String TOKEN_KEY = "TOKEN_KEY";

	private long previous;
	
	public synchronized void resetToken(HttpServletRequest request) {
		HttpSession session = request.getSession(false);

		if (session == null) {
			return;
		}

		session.removeAttribute(TRANSACTION_TOKEN_KEY);
	}

	public synchronized String saveToken(HttpServletRequest request) {
		HttpSession session = request.getSession();
		String token = generateToken(request);

		if (token != null) {
			session.setAttribute(TRANSACTION_TOKEN_KEY, token);
		}

		return token;
	}

	public synchronized String generateToken(HttpServletRequest request) {
		HttpSession session = request.getSession();
		return generateToken(session.getId());
	}

	public synchronized String generateToken(String id) {
		try {
			long current = System.currentTimeMillis();

			if (current == previous) {
				current++;
			}

			previous = current;

			byte[] now = new Long(current).toString().getBytes();
			MessageDigest md = MessageDigest.getInstance("MD5");

			md.update(id.getBytes());
			md.update(now);

			return toHex(md.digest());
		} catch (NoSuchAlgorithmException e) {
			return null;
		}
	}

	private String toHex(byte[] buffer) {
		StringBuffer sb = new StringBuffer(buffer.length * 2);

		for (int i = 0; i < buffer.length; i++) {
			sb.append(Character.forDigit((buffer[i] & 0xf0) >> 4, 16));
			sb.append(Character.forDigit(buffer[i] & 0x0f, 16));
		}

		return sb.toString();
	}%>
	
	<%= generateToken(request) %>

</body>
</html>