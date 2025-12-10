Return-Path: <linux-ext4+bounces-12261-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F9BCB222B
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Dec 2025 08:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F00A302530C
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Dec 2025 07:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17EC27EC80;
	Wed, 10 Dec 2025 07:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="JO8NXj2K"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7E027380A
	for <linux-ext4@vger.kernel.org>; Wed, 10 Dec 2025 07:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765350155; cv=none; b=AMttfI565EWvwh4jCeMVOCuYx1N/Q+o6c/ez3Qm/KB30hTP/7zLI4AdRsClGRZzYqclkJkwrYW2am15aocnpAtSYyJNkwA3BHYtvBZxd3Uq+8A8Bsmd6L6BSa+STwvkc2uH0psfrcBN/RRjI2rFoTgBPMJObwFmAV+o8xSvcP2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765350155; c=relaxed/simple;
	bh=BjRbEtin8yKUNt3HyTKMOknT5yl7nwuAIrIzdfFqXNE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=dG/wiAKTfWKAhZz1IdbyRAGDY/7EoFwawbg5CK6XLYZlBAdNES4urZipcgFcH2uRIdjJLyiA/e6EgaE6sBRp0nXfd8XfKHqXdaE++rJhU5ofIXBdwwPT2uWRQQCHDtUUcWRtFzaMGefboECSFp7sPnZGA3SHwv5DkhRnfbTVozE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=JO8NXj2K; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1765350139;
	bh=eqpA1ThUR5vxi3Hii8Qu2slaPALl2FVT5naBxCYoXUE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=JO8NXj2KWm8WTZQAmDBCraEo4JQH22NarA3Sz7PQ2N4LrUbhugnr8ZdOYFnjD+aOj
	 47Vb9fPKhYMpde10SFjA4DhF72nQR8pcufHwjlpEINdcw1kLN/Y/rQHu+cWkqjtkAy
	 bjYYtmhP3oFO1jHAeJ29vdidv0U120TuiFdlZgfI=
X-QQ-mid: zesmtpip4t1765350133ta469c32d
X-QQ-Originating-IP: NkcnqOy3G0oFtK4BXPZY4oyjlH6j6NnOn96dV5/QWaQ=
Received: from winn-pc ( [localhost])
	by bizesmtp.qq.com (ESMTP) with SMTP id 0
	for <linux-ext4@vger.kernel.org>; Wed, 10 Dec 2025 15:02:12 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11077546269076531751
Date: Wed, 10 Dec 2025 15:02:11 +0800
From: Winston Wen <wentao@uniontech.com>
To: linux-ext4@vger.kernel.org
Subject: Inquiry: Possible built-in support for longer filenames in ext4
 (beyond 256 bytes)
Message-ID: <63C71AFEB9EEBDC8+20251210145935.72a6f028@winn-pc>
Organization: Uniontech
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5b-0
X-QQ-XMAILINFO: Ns4o82esMDegnQY56cenmJcuoRYw3wQtHZNnuiNrrxckEE+q5x+WtQI+
	bGmSRC5grqy57iIEkV9zBbETGfAZ1aAoanGV0/EY12JtHOW65NIO/WmvP8AVbYrAZ57Ag8C
	oGGIwu3n174I/7GPoUOrMwtwrXXTz7BUMKqeFdtNDmyWHssIFBX/+gBq9LjzReZcNR1wxa3
	JLkMq5MryBE1WjTRISFkRMeTh1C5tdtqOUK992UBa46QX5GequJrlCQOEsnZpUnP0qpso2U
	ag5/O4ucfbT/OgqcgiqiOg96cRhJBan0m1PB1b3EyoUvdpPdWfFWSxVVh+l97GYDiFegXiM
	6AwksSSoe8OM5KXlGfIjDU24GpKiLrJ7Qfkkke8ajOQRKVJUFzd7pQ7R63ekVB6egjLXJGw
	Y5SryAXDEbwebY0eT5Tqvh0DVLBPkb42KALArs854FqnUm/aHmcAy+WjCUZbw9Us2sdTnBQ
	bILuqbDNMbAp8BSwqaMeCZqLZSMwyjd/35S6Y6hPyxLD/3tolOc9AteYN4F15NRd9iXeTEr
	4vXvfj9ARZThepG+cz6qCUvO1QBS8fBjgDfd7QRcNxLMq6N1vQHBKuqxejNffHIo7UILWZ2
	15b0d2EAWq1S4LboIDwyi8O7EOP3VnTSLtkHQ6ZJ03RtDzgZCGwD3VbsCUmnwCyX4H8G4H6
	0s/U/sb8u97jOAd2T4upG7lHjBQqSefT2xCsoJ2TOVeEOaR0VpWn7UiGUFunc0eXXYDnFPv
	gwFqmsOeYd6CGaTZDECESRNkolJp1jlg7W14B4ZDvE1ftIN4hU/IhZQSEWEYcNdCv4eSI8p
	KDFjnm+xnml5h9kTPwZx6XDyqpYLMlifW2DdroO5btTFD3vy+nio+jtVTtM8UG/8hwUxG+3
	uWhoNGrUwwINkCuXcbDachR/ehBJDuxWuADXVz2GUm0LPiOq9iXQEMQWXqgQtKWd0x6yNkw
	LxTWfdb/NoinIkgAcTDDEihUGBX+hoBgj7TjFdCZCNRV2/g==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

Hello ext4 maintainers and community,

I am writing to seek your advice on a potential enhancement regarding
filename length support in ext4.

Currently, ext4 supports filenames up to 255 bytes, which is sufficient
for most use cases. However, in cross-platform scenarios, particularly
when migrating directories from Windows to Linux, we encounter issues
with filenames that exceed this limit. Windows allows filenames longer
than 256 bytes (including multi-byte characters such as Chinese), which
can lead to filename overflow when copying such files to ext4.

We are aware that workarounds like wrapfs can be used to support longer
filenames, but in practice, this approach is not ideal for seamless
user experience. We are therefore curious whether it would be feasible
to implement built-in support for longer filenames in ext4 itself.

One idea we considered is using extended attributes (xattr) to map long
filenames, or perhaps another mechanism that would allow storing and
accessing filenames beyond the current limit without breaking existing
compatibility. However, we are not experts in this area and would
appreciate guidance from the community.

Could you share your thoughts on:

- Whether there is interest in supporting longer filenames in ext4
natively.
- Possible implementation approaches (e.g., xattr-based mapping,
on-disk format extensions, etc.).
- Any prior discussions or attempts in this direction that we might
have missed.

If there is a feasible path forward, we are willing to research the
issue in depth and attempt to implement an RFC patch for community
review. We would greatly appreciate your guidance on where to start and
what the key considerations would be.

Thank you for your time and insights.

-- 
Thanks,
Winston


