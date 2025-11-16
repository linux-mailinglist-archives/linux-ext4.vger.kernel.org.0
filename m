Return-Path: <linux-ext4+bounces-11869-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3699DC61549
	for <lists+linux-ext4@lfdr.de>; Sun, 16 Nov 2025 14:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 13A7F4EB536
	for <lists+linux-ext4@lfdr.de>; Sun, 16 Nov 2025 13:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E90A2D9EC8;
	Sun, 16 Nov 2025 13:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b="TYVAjDgC"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BC82D94BE
	for <linux-ext4@vger.kernel.org>; Sun, 16 Nov 2025 13:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763298087; cv=none; b=Ax/4UGf7DByD/tzm7Kx/LSmGHN3CvQJ9RMlPhRjgk8eLsd14YOyXMMpko/TxH5+KHxJDHWb08EKXDdiZtRVcjM1YhVM7/M7fsfOd0oTdlLzw0XE1jtQ8clCb7CEANwxk4kXK1/Nnb4TyUzl5OpHPC5u3tQOi73vsmR97AakER7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763298087; c=relaxed/simple;
	bh=IzM2rX93+RHwFR2a+6Yd+RyUhFuyNZo1QK+1Qc3NuLo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Aj/WMGZ2xlL3OohTPE1rcHERW+4gbcZ5M+GAarfqCCq1vaofDkfsFdWV6uYWIPA5jf/4czy1rGBuRy6k5JLY68SxbPItPCnUrGH46pkfb8UzicoCPf6++ozBspr2sn/JZHwRpFhGh2uPL8tr3ryV4A1lvYwiftnH3lOOWQl8ulg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw; spf=pass smtp.mailfrom=gms.tku.edu.tw; dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b=TYVAjDgC; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gms.tku.edu.tw
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-29586626fbeso35307425ad.0
        for <linux-ext4@vger.kernel.org>; Sun, 16 Nov 2025 05:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1763298082; x=1763902882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xdEiaivqbt3ZJ9LZRb4AerKCg8xyT7dRU3CkTYVGPyQ=;
        b=TYVAjDgCeeje9Ncf6ABJgdWntppcgchMEcIGvh26A9XcBaJdHj7B+PrYhFTmbLSHKL
         XYqkkdP6WRsKoCanhYX5vvEz6mBi/uOAH6kPkg6+86a3c825ctGYYRIw2kK1je5iDLJs
         TLPRZUB7pmN2+CbFKyeQd0I9pZaT9UIhYofXXoo8W+9FFGa13dmi9wFzt2boPir1QLnl
         B1i+3pyb9BSIN0iwtAvCCG4+J+4SAIn4Nk9/ta1TvFHywWnohKYFIXRII7RN6C48KL7f
         WQKIIBcNwPwVF8KzQl72renTdfyS2KUfabLGUUTjQ/91KzvJiAgHs4TH8jzpR67U04ch
         /l4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763298082; x=1763902882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xdEiaivqbt3ZJ9LZRb4AerKCg8xyT7dRU3CkTYVGPyQ=;
        b=eV0MqWUM9z3TIwkSHg70YwIMB71dPblKezR7Q4T9TeKrq/UJFmEEa3p2eb+dUenEh7
         z1nLAaioCPKRpjzZhLBGvvZIiWMh30QCNTBX3Ycfz3ClusJPUj0ORroPOUhGBKQc6LHc
         0F0ercw3wqcv1+koyD0UxU6RRV5vRTsYxsbSvfOmkHDDFTLuE4LIrOTyqsZfQUEFYf74
         ng5GLgwJifrgphAOnf7qwryCSRYoYsShiv0jaCSpnIuYv9IX6y94ZKrds+fcycXvJ9SX
         uyfRSHW8e/KVYGt2rXaCZiNMJTWLBS6y8YkWQ4kff4ibgqz8fz3q4aRg118j1Lsur5hX
         OBRQ==
X-Gm-Message-State: AOJu0YzYD1JGuzc1MLxeOXWVlUlsEZGEqMhsfHKBfODIHSo3kBhnsYx8
	dhSneapo8dsDwe9uQ4jxFpIfkycd06jj9uf2NW+pq4hvoN56F70lPT+piMEEhrtJaRU=
X-Gm-Gg: ASbGnctyy0ofbheQcl4wy5xVkcNVQUHAndLT6/yxuM4njjZovbLl9lx90AcNQfZtu6a
	W41r073hInUHdh07U9Ul1mWeMyBmS9SI8o0ANGE3vFB+aUMhveEzsLwTXS6HKLUoLj7mgMtyIU3
	SkS+Ohek5iyl9MyEJUHlN5+rlNmBDm9j+G5BHhaIAJPfTU0t0ZNs71QNJwUH4HoZqpB35JTNciD
	LyGYT1WE1ialRV8l10ESTXSSTWY4wHb44Pbt80DTaGtswQB7UMrOFTDxpXdVJr2oTn0ap95+L8e
	OcVK9UFYJvxqyDzK1u2HHZket6SWSO7v1OY0xNyqWZpKiVPyGEpZlKrQsPNbtJi0eWY9MQtjJHu
	b/+hpFlUVyLo9NrPpnjJn8kZRdUfwvLGAGdGvLARHWECT3WMeF3r3TGQHt7bbMxAUIkBcCw9awf
	O9B501LihtY8CJPl/MAlyVJizo
X-Google-Smtp-Source: AGHT+IEstqBjQhXguo6+A7ZemqvPVHBFS3JNn5HflPVWpYARnHN4wPA7VYupnZlAxbgQXvlGaFcVKA==
X-Received: by 2002:a17:903:22c5:b0:296:1beb:6776 with SMTP id d9443c01a7336-2986a76a4ffmr98604625ad.58.1763298081806;
        Sun, 16 Nov 2025 05:01:21 -0800 (PST)
Received: from wu-Pro-E500-G6-WS720T.. ([2001:288:7001:2703:22b3:6dbf:5b14:3737])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2cca00sm109379595ad.101.2025.11.16.05.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 05:01:21 -0800 (PST)
From: Guan-Chun Wu <409411716@gms.tku.edu.tw>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	visitorckw@gmail.com,
	Guan-Chun Wu <409411716@gms.tku.edu.tw>
Subject: [PATCH] ext4: improve str2hashbuf by processing 4-byte chunks
Date: Sun, 16 Nov 2025 21:01:05 +0800
Message-Id: <20251116130105.1988020-1-409411716@gms.tku.edu.tw>
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

This change removes per-byte modulo checks and reduces loop iterations,
improving efficiency.

Performance test (x86_64, Intel Core i7-10700 @ 2.90GHz, average over 10000
runs, using kernel module for testing):

    len | orig_s | new_s | orig_u | new_u
    ----+--------+-------+--------+-------
      1 |   70   |   71  |   63   |   63
      8 |   68   |   64  |   64   |   62
     32 |   75   |   70  |   75   |   63
     64 |   96   |   71  |  100   |   68
    255 |  192   |  108  |  187   |   84

Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
---
 fs/ext4/hash.c | 48 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/fs/ext4/hash.c b/fs/ext4/hash.c
index 33cd5b6b02d5..75105828e8b4 100644
--- a/fs/ext4/hash.c
+++ b/fs/ext4/hash.c
@@ -141,21 +141,29 @@ static void str2hashbuf_signed(const char *msg, int len, __u32 *buf, int num)
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
+		val = ((int)scp[0] << 24) + ((int)scp[1] << 16) +
+				((int)scp[2] << 8) + (int)scp[3];
+		*buf++ = val;
+		scp += 4;
+		len -= 4;
+		num--;
 	}
+
+	val = pad;
+
+	for (i = 0; i < len; i++)
+		val = (int)scp[i] + (val << 8);
+
 	if (--num >= 0)
 		*buf++ = val;
+
 	while (--num >= 0)
 		*buf++ = pad;
+
 }
 
 static void str2hashbuf_unsigned(const char *msg, int len, __u32 *buf, int num)
@@ -167,21 +175,29 @@ static void str2hashbuf_unsigned(const char *msg, int len, __u32 *buf, int num)
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
+		val = ((int)ucp[0] << 24) | ((int)ucp[1] << 16) |
+				((int)ucp[2] << 8) | (int)ucp[3];
+		*buf++ = val;
+		ucp += 4;
+		len -= 4;
+		num--;
 	}
+
+	val = pad;
+
+	for (i = 0; i < len; i++)
+		val = (int)ucp[i] + (val << 8);
+
 	if (--num >= 0)
 		*buf++ = val;
+
 	while (--num >= 0)
 		*buf++ = pad;
+
 }
 
 /*
-- 
2.34.1


