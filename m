Return-Path: <linux-ext4+bounces-5952-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9428DA038C0
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jan 2025 08:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BD953A5391
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jan 2025 07:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583F21DED71;
	Tue,  7 Jan 2025 07:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jwilk.net header.i=@jwilk.net header.b="j8Lw6N2i"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtpout3.mo534.mail-out.ovh.net (smtpout3.mo534.mail-out.ovh.net [51.210.94.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776DB1DE895
	for <linux-ext4@vger.kernel.org>; Tue,  7 Jan 2025 07:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.210.94.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736234835; cv=none; b=Pjb0gHUaL3IDvZPgDvQmjnwqPEacS7CNiKcy4s0Il5GFIWy0ShUyy1TZKH3Y9S458mNXe7z/6lmPzg52/jzf8QbAYIaulB8ZNU4x7Yfidl9sUsVMyYQmoU+sDHgkuCS6SkZx3j1OGtJ7euqJUjvOd9ghe0FgwtwbikOFeuGzPhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736234835; c=relaxed/simple;
	bh=/DrchkP+EG8TsmoKM5xVzqur0vGnRpjgC5eXbKVunJc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pvU+RFWBp8TZnooK24viFNkovEJfFUU1jP8CJXvRKyFuW70KjbZJu/bTWudik3NYtGM25HYBRMsXWprAtXe02ZyndtuXEyBMQ/37r2TvtKFpwumaR9w618GbNNboVrXBVlJgIYesLk6KKjJkbBDESCHZBVXXJxXhslMuA9zIAq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jwilk.net; spf=pass smtp.mailfrom=jwilk.net; dkim=pass (2048-bit key) header.d=jwilk.net header.i=@jwilk.net header.b=j8Lw6N2i; arc=none smtp.client-ip=51.210.94.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jwilk.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jwilk.net
Received: from director1.derp.mail-out.ovh.net (director1.derp.mail-out.ovh.net [51.68.80.175])
	by mo534.mail-out.ovh.net (Postfix) with ESMTPS id 4YS2DZ3jvcz1WPB;
	Tue,  7 Jan 2025 07:07:26 +0000 (UTC)
Received: from director1.derp.mail-out.ovh.net (director1.derp.mail-out.ovh.net. [127.0.0.1])
        by director1.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <jwilk@jwilk.net>; Tue,  7 Jan 2025 07:07:26 +0000 (UTC)
Received: from mta7.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.108.17.166])
	by director1.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4YS2DZ1gJgzHZcS;
	Tue,  7 Jan 2025 07:07:26 +0000 (UTC)
Received: from jwilk.net (unknown [10.1.6.2])
	by mta7.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 449A0C2E0F;
	Tue,  7 Jan 2025 07:07:25 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-113S00721587b2c-b351-4de6-9e86-dffa1ee0d996,
                    AFE5C42F773DB75F3A1F38CD4C2124A9E9014CC7) smtp.auth=jwilk@jwilk.net
X-OVh-ClientIp:31.0.177.73
From: Jakub Wilk <jwilk@jwilk.net>
To: Theodore Ts'o <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org
Subject: [PATCH e2fsprogs] e2image.8: add missing comma
Date: Tue,  7 Jan 2025 08:07:24 +0100
Message-Id: <20250107070724.6375-1-jwilk@jwilk.net>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 15181071394542005409
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 49
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrudeguddguddtjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecuogfuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeflrghkuhgsucghihhlkhcuoehjfihilhhksehjfihilhhkrdhnvghtqeenucggtffrrghtthgvrhhnpeehleeigefguedvleduuedvleejtefgffelhfejtefgffehfffftdehveekudejhfenucffohhmrghinhepshhouhhrtggvfhhorhhgvgdrnhgvthenucfkphepuddvjedrtddrtddruddpfedurddtrddujeejrdejfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepjhifihhlkhesjhifihhlkhdrnhgvthdpnhgspghrtghpthhtohepfedprhgtphhtthhopehjfihilhhksehjfihilhhkrdhnvghtpdhrtghpthhtohepthihthhsohesmhhithdrvgguuhdprhgtphhtthhopehlihhnuhigqdgvgihtgeesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheefgegmpdhmohguvgepshhmthhpohhuth
DKIM-Signature: a=rsa-sha256; bh=46bvUCml+GNYCBlb+j0DfSM3dY0za4AQcwibYPUq/3w=;
 c=relaxed/relaxed; d=jwilk.net; h=From; s=ovhmo917968-selector1;
 t=1736233646; v=1;
 b=j8Lw6N2iGsEkrAbjWFs1hqG+wF6PqT/xOwbYDYM7M4zNm3tHgRDXpIgN1nTxyf3gefktCPQ9
 9+MCC/HjerDP1RcHMjOC6QyI6upD/mxRCocDRHomChCs6eRxRwlS/jCss90mIPtMAbBEDqPTIGr
 v4OnYs01HK7qfxhfbBN1sowLltFasAVK2vOPBOl0vpG2FFIaW7QORCdJzwgKLdFToGnZP65Jecx
 pP6UT3139lbQlBp4bGQFGJitfl6XV9eTfyu0dgNmfkmLsmQrAO0nrMnxWbw9BNniz3UdKZWpSpW
 JlMMQBJZpI2nj+ZjuNSxJD2E7ofKMk//mFpV/w4iiS7rA==

Signed-off-by: Jakub Wilk <jwilk@jwilk.net>
---
 misc/e2image.8.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc/e2image.8.in b/misc/e2image.8.in
index 384ef302..0be1c751 100644
--- a/misc/e2image.8.in
+++ b/misc/e2image.8.in
@@ -326,5 +326,5 @@ http://e2fsprogs.sourceforge.net.
 
 .SH SEE ALSO
 .BR dumpe2fs (8),
-.BR debugfs (8)
+.BR debugfs (8),
 .BR e2fsck (8)
-- 
2.39.5


