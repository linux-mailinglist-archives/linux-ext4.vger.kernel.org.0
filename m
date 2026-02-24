Return-Path: <linux-ext4+bounces-13979-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOm+C++enWnwQgQAu9opvQ
	(envelope-from <linux-ext4+bounces-13979-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Feb 2026 13:51:59 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E731873DB
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Feb 2026 13:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D2F4302FA8D
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Feb 2026 12:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8113839A800;
	Tue, 24 Feb 2026 12:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+r1tUU6"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C711389473
	for <linux-ext4@vger.kernel.org>; Tue, 24 Feb 2026 12:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771937503; cv=none; b=tD/gvhX5pt9PPH9DyEEe5uTCTXuEh63y847jmh8qyyvFGOs7pEEqNhoazhO9b6vM3Qa+obmsQ3XpzvHedlbHPbrnwEBkhXS/9NF2F6UwiEu2wa2f0l42BbGVBJPJRRwgsPkTD7VMg0vVuxVubf0vRj5q26LZKmZh5HNfGJ5j2C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771937503; c=relaxed/simple;
	bh=lYi1KK3NNKr+5+DganXnGOweKJXI1vyqHpOospYsA74=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p72oQOoDMLaOabwKj0vfZAD2PuZXV8lmvmh6YehIwwbfe44attvMc88n/eTBD+B94p861q4qA5geQakBcvszHTPCOpSsm/2NiRDfYv6AND9rnB6UYF6lu+cK826PG5tw1k+y4Oww1NJtvF0BJXKXOb4h0ySrurSMtu/0xf1OnUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+r1tUU6; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2aaf43014d0so37687455ad.2
        for <linux-ext4@vger.kernel.org>; Tue, 24 Feb 2026 04:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771937501; x=1772542301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ntm/m5QpJaDRn+h1w7VU33hlplXMfVuCtDhq2BfS2fU=;
        b=F+r1tUU6MN75MHQL9q3xHgY8kunLimUikuyr/Us4/3PD+0V1GbvjYUWwElyt7mfSIP
         eGMwCPN9H/BWKC6IPfuh7Xs04/SOFwYUlutsuTneNoJsZ67aMcNU22oSMABtp3Yb7P9e
         ofl2yXeN6R0DpD3KvL4I/GMZj7h8AEPJJl77kK0OyFlCcKTtz7Dal/KIrbGILSvvGKmY
         cs8v90S9guTpxkokddJJE8Zo69Z0CoxnIYD/WU11AVQdkRFeRDc3x+ceNBFM1wxRmboM
         SVbt3+AtbkrbZilh08wvP7P6Yg+VMffh5isxoNj2CULf2vXJkLrln7ZPPShgMZlCe18R
         1KgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771937501; x=1772542301;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ntm/m5QpJaDRn+h1w7VU33hlplXMfVuCtDhq2BfS2fU=;
        b=LHhmPqCeIpDFmOIwJNZu2QuUE0OtRZZ07LZ3NmFmbTdxC/Bnjf4ziuJ69TLNBAYHiI
         TmDoP5QFT3Oh3OleFmVZDFJkISt3RN0MLYmJjP+sDdY2C7iBLrc3VtzDvzJTKEZDIEYs
         iXbbFP8+ElBy7uen3upxEMwbwXajWqNe269/K7acR4OHKKHf+lDLtPG6kQIj//EoMSQV
         wRShJczIj0O9UDvZBeESq/O/r7xEtk/mykhZmUCV7b23RID5cC8oE6IqmmQ1W6+oB9GO
         EgOQdgKWIc16CXaTouCRJaHygrrYVRNn3kTENDUJGCiLHusd4wbaFdiU7dC0DarnEqff
         Uj0g==
X-Gm-Message-State: AOJu0YwxrB850rHJSPJLvJqdA8LdOdPSD6laRHVwvUNhuz5orbj3a4IZ
	5ij2E629hS/yzeU8ZOfbdFsVLLWr4dwUt6g2o71vHqv4M3nofmcXedwn
X-Gm-Gg: ATEYQzzE8bUNWefDm9FF/cME1ykfL5cAQCg3Wg2apBNqPFEP2nypYDIfp0mWKglux+E
	cbliMMSRdw4RQ4Vc3bYYX5zaP+Zmp2rYm00/vz3XzzndR8s9VDDT5VJlAaNbg50Qq03ifCFizzV
	Zd1WojQOko2u0x7+ehXckU1vE3EVRzFN0dNW2IYh0R8/IogXTQlSR05ds2gqw7wtZ1skFIyIIv0
	5yUNGspAQegT34naIJCgibb0nfdHwpqm8ec6VU//qkuuOwwh2v6P+CszdWrc5HNkIT9dCiPrsei
	JZc2teDu02l6VH61/l6Uyx8JuxoE04BnWPcVZuLvjf3jHwhsSNwh72bYTWF4pJu14sa+fek2q6q
	gXrBJO4nas73t662tfqioQe+mV5rbevhqGXQmN4IdMxz81ILVcgH6Q0rrf3oMqfW+l0BnCYP5rO
	dDGsmg4Rz78inHp6W4s+KlyFg2BTO+DuM=
X-Received: by 2002:a17:903:32c8:b0:2aa:f0d6:bf3b with SMTP id d9443c01a7336-2ad7455d873mr119212625ad.53.1771937501421;
        Tue, 24 Feb 2026 04:51:41 -0800 (PST)
Received: from localhost ([120.235.196.245])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2ad75321543sm107484905ad.72.2026.02.24.04.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 04:51:40 -0800 (PST)
From: cuiweixie@gmail.com
To: dilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Weixie Cui <cuiweixie@gmail.com>
Subject: [PATCH v3] ext4: simplify mballoc preallocation size rounding for small files
Date: Tue, 24 Feb 2026 20:51:36 +0800
Message-Id: <20260224125136.62551-1-cuiweixie@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13979-lists,linux-ext4=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-ext4];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 86E731873DB
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
 fs/ext4/mballoc.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 20e9fdaf4301..a5c51daaba78 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4561,22 +4561,17 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
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
+		if (size <= (unsigned long)SZ_16K) {
+			size = SZ_16K;
+		} else {
+			size = roundup_pow_of_two(size);
+		}
 	} else if (NRL_CHECK_SIZE(size, 4 * 1024 * 1024, max, 2 * 1024)) {
 		start_off = ((loff_t)ac->ac_o_ex.fe_logical >>
 						(21 - bsbits)) << 21;
-- 
2.39.5 (Apple Git-154)


