Return-Path: <linux-ext4+bounces-13978-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACIKLl6enWnwQgQAu9opvQ
	(envelope-from <linux-ext4+bounces-13978-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Feb 2026 13:49:34 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2D6187353
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Feb 2026 13:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89B4831419CE
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Feb 2026 12:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1A339A7FF;
	Tue, 24 Feb 2026 12:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hqc3z5Mq"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BE32DB7A0
	for <linux-ext4@vger.kernel.org>; Tue, 24 Feb 2026 12:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771937255; cv=none; b=l8hzvzlEBQ02zuyVLnQG7RQLW1Qs5bHBJVkynA2za/5F9GZ427bzzL6X+KRE5u3nalzErNloNS+J5scyO4GsmmIt0E+WmIXHKxCx474Ic+3qFgAtTqUPf44KKpuY9n439fX6lQOF1e4k60mJMf36pRa33Ou7ltcjnmEcuUUw0d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771937255; c=relaxed/simple;
	bh=8SN7zgnwcL0WRqAhSbscCKYgJ9U4F6nvAJBy3/SsDjA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dLoRHDn81jF9N4nY4t5t0s0t8NA/C/mApb3V26aiRHbXdFBcKT82TMsZMCU5rF1cvsXjBqAop6WY+bDdGCwT+swA40CMQUUxTBXuAscvOGo1zMe7XhdvCnCggKA63Ugdx7inH+dXZ7AKBlL+rzStdPQ3ud5eOLAX7N+lhkqR3eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hqc3z5Mq; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c70c112cb61so1512813a12.0
        for <linux-ext4@vger.kernel.org>; Tue, 24 Feb 2026 04:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771937252; x=1772542052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HZCAGkuMPq7tF14SyJvLaSbQCH8XuWyE97stWsPADsk=;
        b=Hqc3z5Mqukfcc1vy8J7vnQZhSa+Wvrn6u0dHmkpMWEutr9ULHklS1I56Xo3XB1r6ut
         G+fef8J0HFcJolulsRWpm/p0pW7+xFsKiCRo1a+Exu/2xzKH/Qytp7zvl6Z7SYv7wS67
         tEkRfZh/qqgBkMUalpqCL+tA3OOfwNx/27FQUVSyauTedTbl2fPv6RFkPSBq2rd0Hpco
         l0Jc/8Np5aRtB86efQcQLvw570y4+i2C7AUwY4QZJlHEcfxIBSw7KJEWPF3yam4pZJf4
         b4GZ3y/njEdm8kHcPoleEZYNZRw2tsaMF1Gf5OqbiePyieP94ljkX/kbxfisPsYqQPbs
         8ODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771937252; x=1772542052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZCAGkuMPq7tF14SyJvLaSbQCH8XuWyE97stWsPADsk=;
        b=lEwiJbzpGJukSlfrhzGL950HBOPFjDI+Ie7Ej+zfvtv6c0SfFqTa5CoE6pptwBHePP
         pcLDEEC/JUIGVkiQa16Vh4sigaQgFD3ruILPdOMu5EZbKTK9ay7RVtsNszkmNHPLJRQQ
         uceDfJ9f3Wigyv2wctxtjUuB9Y9oQsSLQbBB2QT1hcBDgxtEoqGcoDil59KYt5FNQVav
         Vm6AQ5/W/aWO9ZYpOc+NsO9+2V8RXeF8X7zvYJjlRkSXRDUD9IJuRp3uhMoKhXrJXfqm
         lzaqp9mOgu2NzBzIpMXcDOQbqt2VPYqn/Ly/9mqs01PsVBwz/Noa0OMnVoDfpkdmhuxx
         4ydw==
X-Gm-Message-State: AOJu0YyZdzQ14QeTEA/CVnAUuouK7CCRsaQNckDuveddHHTSgjD5jJI6
	Gm6maxYd3vNeC7qyvKBDfBssy+NoOi5XfVIWpxH5suPwM5GQIry0IDFq
X-Gm-Gg: AZuq6aLQ1QEXM1aLrWS7t6RF27Zu60ZHddoFiAuHCWQZ3r+WoEd3JI+OA+nIBQXuKwp
	GJUiq7l1Sgn5QUV49BBLmgbDEaJWFSDlzHORblMeSMCit+BzoQjeIQxmg/gf177r+I6oLZh8WB4
	LyjNkGh7HYoPPfXBHTKtNV7s9w7uEB7+T+UGK0iecJ2yRviPwE+JulNe5xj6FS5dxDviFWqc4Jv
	4X6/5FcYOCWbnr034tVm4kObEHzL5gVqPzUilmaKiAVAvHRswEnDqSfUka6Nv8UeFifQ7LD2swL
	Ip3QfsAWBQ5R0wwwMfy/APnF9JZ+u9Q75ivrIoRLD+mFvtedynojnRxo3A++vbkbdXY4TdWUlsp
	i48y1zmVyUwLWfD/dbsHA0A8A6XC86KecFmRtTUtCtnvCzI/4idh+RQgD5Tc7qHS4W7adw5Cbdi
	ZjlBSqbo1k7J7iOOiCIIy8XcEjm9b/oxE=
X-Received: by 2002:a05:6a21:330e:b0:375:4426:e78b with SMTP id adf61e73a8af0-39545faf8cemr11008959637.71.1771937252236;
        Tue, 24 Feb 2026 04:47:32 -0800 (PST)
Received: from localhost ([120.235.196.245])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-c70b71814f8sm10318755a12.4.2026.02.24.04.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 04:47:31 -0800 (PST)
From: cuiweixie@gmail.com
To: dilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Weixie Cui <cuiweixie@gmail.com>
Subject: [PATCH v2] ext4: simplify mballoc preallocation size rounding for small files
Date: Tue, 24 Feb 2026 20:47:27 +0800
Message-Id: <20260224124727.56016-1-cuiweixie@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13978-lists,linux-ext4=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cuiweixie@gmail.com,linux-ext4@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-ext4];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5B2D6187353
X-Rspamd-Action: no action

From: Weixie Cui <cuiweixie@gmail.com>

The if-else ladder in ext4_mb_normalize_request() manually rounds up
the preallocation size to the next power of two for files up to 1MB,
enumerating each step from 16KB to 1MB individually. Replace this with
a single roundup_pow_of_two() call clamped to a 16KB minimum, which
is functionally equivalent but much more concise.

Also replace raw byte constants with SZ_1M and SZ_16K from
<linux/sizes.h> for clarity, and remove the stale "XXX: should this
table be tunable?" comment that has been there since the original
mballoc code.

No functional change.

Signed-off-by: Weixie Cui <cuiweixie@gmail.com>
---
 fs/ext4/mballoc.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 20e9fdaf4301..2caf0633c6d4 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4561,22 +4561,16 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 		(req <= (size) || max <= (chunk_size))
 
 	/* first, try to predict filesize */
-	/* XXX: should this table be tunable? */
 	start_off = 0;
-	if (size <= 16 * 1024) {
-		size = 16 * 1024;
-	} else if (size <= 32 * 1024) {
-		size = 32 * 1024;
-	} else if (size <= 64 * 1024) {
-		size = 64 * 1024;
-	} else if (size <= 128 * 1024) {
-		size = 128 * 1024;
-	} else if (size <= 256 * 1024) {
-		size = 256 * 1024;
-	} else if (size <= 512 * 1024) {
-		size = 512 * 1024;
-	} else if (size <= 1024 * 1024) {
-		size = 1024 * 1024;
+	if (size <= SZ_1M) {
+		/*
+		 * For files up to 1MB, round up the preallocation size to
+		 * the next power of two, with a minimum of 16KB.
+		 */
+		size = roundup_pow_of_two(size);
+		if (size < (unsigned long)SZ_16K) {
+			size = SZ_16K;
+		}
 	} else if (NRL_CHECK_SIZE(size, 4 * 1024 * 1024, max, 2 * 1024)) {
 		start_off = ((loff_t)ac->ac_o_ex.fe_logical >>
 						(21 - bsbits)) << 21;
-- 
2.39.5 (Apple Git-154)


