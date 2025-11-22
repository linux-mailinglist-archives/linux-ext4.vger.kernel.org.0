Return-Path: <linux-ext4+bounces-12006-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 653ACC7C653
	for <lists+linux-ext4@lfdr.de>; Sat, 22 Nov 2025 05:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97FCA3A7ADD
	for <lists+linux-ext4@lfdr.de>; Sat, 22 Nov 2025 04:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53FD2741B6;
	Sat, 22 Nov 2025 04:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b="2sbMIj/0"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAD4246781
	for <linux-ext4@vger.kernel.org>; Sat, 22 Nov 2025 04:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763786383; cv=none; b=myNEfdHwi5F+8J1aSsfuNDYAFTtYXdb6poFac/u++17OgRxgVyAXrsWknKoQTWM1z9qMJuP7+6PK0Bp0hXvUPjRqbURJSdb6Hsy0Fhg8kbBiB7UHZksa/9cQVkPDvz4XMhbuiS3X7q7uv0D+FoTHtmYAg61Hi8DSXYMuHq6G61Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763786383; c=relaxed/simple;
	bh=0PJHlRdDNHgFhKZLahfMtcd2ubwxvw8Pv/LLSCLsO4w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AbjNvaR+Dl2amSzOWdOJLD7luBaFULKOVGz6HAKhL0V68CPal86RcutW/RmcLcA0s8+/tB50GDLP51KYVxggYhS6v+7o0auDSweRVh+n4oa67KylX5YLYu4Ix7NoK1ovsnjfuOMs4v96vZasDQlJJj70Gh/elOjOhK0GUhlG4GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw; spf=pass smtp.mailfrom=gms.tku.edu.tw; dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b=2sbMIj/0; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gms.tku.edu.tw
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7b9c17dd591so2293678b3a.3
        for <linux-ext4@vger.kernel.org>; Fri, 21 Nov 2025 20:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1763786379; x=1764391179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c7C3mqrCsMVwpowQpUu7S+e5Gpr1AgruIqWh0f/HNmo=;
        b=2sbMIj/0XKlcFvp9NmCgb2raj/fIhZbZMbP3Yh/PIq8f34bmOZ00iLhpBRe7q9ovwz
         vRuSrmGSPdVJ0wVqQ10IVWXMzyL0HghSZwm/iAG/bukH58TZVkgK2e7Ryk/3rV351xeh
         WUf4Vb7pwH2CcMKaKqlcqEyoL5O0Z1pOTYWnz/G7lEO/XjoTw1n+r6B+KAi/04oi0pbc
         yfJr27yD7a0CAcW6Zj49gfV3kvxJrD1NxcUnAhuqed/SJhqmoPBEtURZFTLuEj1O5faj
         SsQMEOP0xP9ZjwPOBPCyusQ05v5hbovQ3gnAUM6sQLtXdX2L2CFGR7yiLnoLtjd67fmH
         yj5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763786379; x=1764391179;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7C3mqrCsMVwpowQpUu7S+e5Gpr1AgruIqWh0f/HNmo=;
        b=SVa8IoI9k3AlzgRWlMoopI8F4PSbF27UwEIkZQqw9fqTEC3wD3AAhEv6+/deRGJuAE
         jgYb7FyEDSGlHaP96eWWgEZZfTCneGI12NY13+skj9lEdjmIgXoD3YT5yP/KF4k5fDHf
         a6s4RHJmogCF+OUT3OdqZrH2m1VrJgfHEmG2E4YugAB2swdKSz1/R1if2TIRjvQRa9QX
         C5ALylM1yb8b6yDI9YUqoR3fztGAosKXP+O83xcoq6qBEkIIf7aVdupD8/xC1tjM4n44
         8ZrowutoXc9NjsQnXcK88nmHQOt5ekjUo+7vDDtH6htD8hDtzEzJp61Ux3DukL78aVcU
         JaeA==
X-Gm-Message-State: AOJu0YzBg7lZWFDwxJbufvWWuIN5auwNqiU1G5WwJNZ8g+CCjI6C5UyK
	9v9/b+HkqZ7jqjS+VuVwcmNghqITdR2y3tYpwl2bNsfgvr0/PIpujj+PJLaGUgZ93wKDHCB6CqQ
	BgQYF5LA=
X-Gm-Gg: ASbGnctIS6HpaybTGQARB8wgsRHlYEECut2xdqYA/UZsjRh8kIMwC7a6ed/Vxs3uKFW
	0l20qmBeh4rDWeqdwxmxSYSWBk8PBtiBeNR8dsYLwQZdK7wQQOQNatelWAGqhvDWvfcVkNYb7lQ
	Y4g5u3K1CiY2LjhTx3JyV2jWvH98suiL3K1Wxg5FyvJIZDe1AwNWHYZmzO7cLY9tmkIfAgAZ8Jf
	YLICyLWE13NnFEINJ4/qTq3uBooV5T8PEVJ7fmPAlO97G9d7YSqHkQR9hu5lqTG7cApu93q9oGW
	QQ9zCdkmoqcHTEGaRF/fvERxbEAFIRx79ksdteTzdicm2JMTeycmK0+LLW+M8graA8FUR1tX12M
	b5BNhmM1ePA+N7VBFfiHpzOjGBTV8AM89NGT9RNNYD/9TlRq1Ln7/lAhDcL8LJw+YNOD4WtH7yO
	NHOmP1ANAe3LH/zmXKkEyFysG/FwDKyXSbJg==
X-Google-Smtp-Source: AGHT+IFjRdWdT+ZczsEHOR0lZAgSTTpkYWA9lKk0ziJQeV3FWTigkgKWYKSTUFKFttAN59yjmKKKaA==
X-Received: by 2002:a05:6a00:8d6:b0:7b9:7f18:c716 with SMTP id d2e1a72fcca58-7c58c2a7c48mr4545485b3a.1.1763786378738;
        Fri, 21 Nov 2025 20:39:38 -0800 (PST)
Received: from wu-Pro-E500-G6-WS720T.. ([2001:288:7001:2703:f19:917c:589d:681d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f0b63dbcsm7618838b3a.50.2025.11.21.20.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 20:39:38 -0800 (PST)
From: Guan-Chun Wu <409411716@gms.tku.edu.tw>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	visitorckw@gmail.com,
	david.laight.linux@gmail.com,
	Guan-Chun Wu <409411716@gms.tku.edu.tw>
Subject: [PATCH v2] ext4: improve str2hashbuf by processing 4-byte chunks and removing function pointers
Date: Sat, 22 Nov 2025 12:39:29 +0800
Message-Id: <20251122043929.1908643-1-409411716@gms.tku.edu.tw>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The original byte-by-byte implementation with modulo checks is less
efficient. Refactor str2hashbuf_unsigned() and str2hashbuf_signed()
to process input in explicit 4-byte chunks instead of using a
modulus-based loop to emit words byte by byte.

Additionally, the use of function pointers for selecting the appropriate
str2hashbuf implementation has been removed. Instead, the functions are
directly invoked based on the hash type, eliminating the overhead of
dynamic function calls.

Performance test (x86_64, Intel Core i7-10700 @ 2.90GHz, average over 10000
runs, using kernel module for testing):

    len | orig_s | new_s | orig_u | new_u
    ----+--------+-------+--------+-------
      1 |   70   |   71  |   63   |   63
      8 |   68   |   64  |   64   |   62
     32 |   75   |   70  |   75   |   63
     64 |   96   |   71  |  100   |   68
    255 |  192   |  108  |  187   |   84

This change improves performance, especially for larger input sizes.

Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
---
v1 -> v2:
- Drop redundant (int) casts.
- Replace indirect calls with simple conditionals.
- Use get_unaligned_be32() instead of manual byte extraction.
- Link to v1: https://lore.kernel.org/lkml/20251116130105.1988020-1-409411716@gms.tku.edu.tw/
---
 fs/ext4/hash.c | 64 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 42 insertions(+), 22 deletions(-)

diff --git a/fs/ext4/hash.c b/fs/ext4/hash.c
index 33cd5b6b02d5..97b7a3b0603e 100644
--- a/fs/ext4/hash.c
+++ b/fs/ext4/hash.c
@@ -9,6 +9,7 @@
 #include <linux/unicode.h>
 #include <linux/compiler.h>
 #include <linux/bitops.h>
+#include <linux/unaligned.h>
 #include "ext4.h"
 
 #define DELTA 0x9E3779B9
@@ -141,21 +142,28 @@ static void str2hashbuf_signed(const char *msg, int len, __u32 *buf, int num)
 	pad = (__u32)len | ((__u32)len << 8);
 	pad |= pad << 16;
 
-	val = pad;
 	if (len > num*4)
 		len = num * 4;
-	for (i = 0; i < len; i++) {
-		val = ((int) scp[i]) + (val << 8);
-		if ((i % 4) == 3) {
-			*buf++ = val;
-			val = pad;
-			num--;
-		}
+
+	while (len >= 4) {
+		val = (scp[0] << 24) + (scp[1] << 16) + (scp[2] << 8) + scp[3];
+		*buf++ = val;
+		scp += 4;
+		len -= 4;
+		num--;
 	}
+
+	val = pad;
+
+	for (i = 0; i < len; i++)
+		val = scp[i] + (val << 8);
+
 	if (--num >= 0)
 		*buf++ = val;
+
 	while (--num >= 0)
 		*buf++ = pad;
+
 }
 
 static void str2hashbuf_unsigned(const char *msg, int len, __u32 *buf, int num)
@@ -167,21 +175,28 @@ static void str2hashbuf_unsigned(const char *msg, int len, __u32 *buf, int num)
 	pad = (__u32)len | ((__u32)len << 8);
 	pad |= pad << 16;
 
-	val = pad;
 	if (len > num*4)
 		len = num * 4;
-	for (i = 0; i < len; i++) {
-		val = ((int) ucp[i]) + (val << 8);
-		if ((i % 4) == 3) {
-			*buf++ = val;
-			val = pad;
-			num--;
-		}
+
+	while (len >= 4) {
+		val = get_unaligned_be32(ucp);
+		*buf++ = val;
+		ucp += 4;
+		len -= 4;
+		num--;
 	}
+
+	val = pad;
+
+	for (i = 0; i < len; i++)
+		val = ucp[i] + (val << 8);
+
 	if (--num >= 0)
 		*buf++ = val;
+
 	while (--num >= 0)
 		*buf++ = pad;
+
 }
 
 /*
@@ -205,8 +220,7 @@ static int __ext4fs_dirhash(const struct inode *dir, const char *name, int len,
 	const char	*p;
 	int		i;
 	__u32		in[8], buf[4];
-	void		(*str2hashbuf)(const char *, int, __u32 *, int) =
-				str2hashbuf_signed;
+	bool use_unsigned = false;
 
 	/* Initialize the default seed for the hash checksum functions */
 	buf[0] = 0x67452301;
@@ -232,12 +246,15 @@ static int __ext4fs_dirhash(const struct inode *dir, const char *name, int len,
 		hash = dx_hack_hash_signed(name, len);
 		break;
 	case DX_HASH_HALF_MD4_UNSIGNED:
-		str2hashbuf = str2hashbuf_unsigned;
+		use_unsigned = true;
 		fallthrough;
 	case DX_HASH_HALF_MD4:
 		p = name;
 		while (len > 0) {
-			(*str2hashbuf)(p, len, in, 8);
+			if (use_unsigned)
+				str2hashbuf_unsigned(p, len, in, 8);
+			else
+				str2hashbuf_signed(p, len, in, 8);
 			half_md4_transform(buf, in);
 			len -= 32;
 			p += 32;
@@ -246,12 +263,15 @@ static int __ext4fs_dirhash(const struct inode *dir, const char *name, int len,
 		hash = buf[1];
 		break;
 	case DX_HASH_TEA_UNSIGNED:
-		str2hashbuf = str2hashbuf_unsigned;
+		use_unsigned = true;
 		fallthrough;
 	case DX_HASH_TEA:
 		p = name;
 		while (len > 0) {
-			(*str2hashbuf)(p, len, in, 4);
+			if (use_unsigned)
+				str2hashbuf_unsigned(p, len, in, 4);
+			else
+				str2hashbuf_signed(p, len, in, 4);
 			TEA_transform(buf, in);
 			len -= 16;
 			p += 16;
-- 
2.34.1


