Return-Path: <linux-ext4+bounces-13613-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAshNYijhmkPPgQAu9opvQ
	(envelope-from <linux-ext4+bounces-13613-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Sat, 07 Feb 2026 03:29:28 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52740104A89
	for <lists+linux-ext4@lfdr.de>; Sat, 07 Feb 2026 03:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF9EF300D142
	for <lists+linux-ext4@lfdr.de>; Sat,  7 Feb 2026 02:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDDE3314DF;
	Sat,  7 Feb 2026 02:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6EnsNi8"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6074C3314C4
	for <linux-ext4@vger.kernel.org>; Sat,  7 Feb 2026 02:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770431364; cv=none; b=rkqPJR+NNXpZcpfyhP7X/p66cFCjOPeeSpMwv+DfFeeKC4zxzZgv9MSypKDAaOpqyajVke9rudf5qUU28T1NtROPEDYFba46HnP6k7YkFOgiMNTj+hNrjIrlWD/ZSngiD+jBe36blIO+iglA5DkBS2+egIkA4e2JL1Ro8ZasQNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770431364; c=relaxed/simple;
	bh=W/zKT8pihZuNeRNWFE+Iz0LR9lkmqLLeLgH0gTHNuhA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hfLdju5sZN665zpWgQOSwvSvWMcuhW/61FLSsgHZiDPvoSdh9/I4Tu3TQmVPC/Ot3+O3d5BYb3/69er+EyCcgEPtQUYFIdsa5qUIQtJ4TwBwhnmz8c94V8WZ46YScTvzy8bdRhnh7yUqj1VVrZIFGCwsTQaVhfgPGE3GJqcVyFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N6EnsNi8; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2b4520f6b32so4081282eec.0
        for <linux-ext4@vger.kernel.org>; Fri, 06 Feb 2026 18:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770431363; x=1771036163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=81NOIKyjXWY4ZCoXjtiblPwU1GJd25Azk4Mn/8eNrCo=;
        b=N6EnsNi8cZUg4afDNsFmze8tX85L4cTsiQz/mJRlXa3sdHHBsBfazQNmGMnKX9232o
         EM9MbnTUREBF4b5AcIfvOEUqTc/T/SP13gVSmeNBNJ4U0cpoYi1cj0peOp920CVBlAhK
         IOPT8sJJ1zXykR8DiXNRQh4npnk+AYraKoKbzwZ23Zbh8Txr3Z2uCiy+RtrA9yWvy5AY
         ZFGVHApVVNGKWgiqXo2YE++7pZeq3slSXZjNTotKTzAQFbZx2Dj9biu4txNjrAJaAbcP
         jAY5vefr+v1EogcszNQd3a5ByoyFI8gpMDhzp9n88fQn7oaXCeUCn/pfKcTNhsN//x8l
         YOTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770431363; x=1771036163;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=81NOIKyjXWY4ZCoXjtiblPwU1GJd25Azk4Mn/8eNrCo=;
        b=Rc32c+WEquHcils5e9m0bP1mV7Q3OYU8+/dg1w8ctpbsBorbxQ5xskxNlNylB6hbOV
         EBgOnO2gszq0hmec7r81hzpY2kU8cpnYFtJYbi2NrRtYa8Oj1UlwE6Q+uF/oIz9J2RFU
         /wfeulcga2wMzYegkm2cx6CYAC64aSGcFvx2O5HoiDm092cxLkXDB52IsLy/U2xdTVGc
         qMV3K2UwehBTbr24BFG1Jp/iBkdy09mzOaE03GbyMiVt9GYv1lhXPkw6rV16zlXNb7Em
         BEAJy6ZlzgbybfCIrfQWXMY330kUyfbcL3u67TJGEv23Dy/zkJYNjLKQ/D6Nxkfsqegf
         UzfQ==
X-Gm-Message-State: AOJu0YyEpmvolucVAU73hUfz/5KtdevxTh6tABp/rP5a78vXvVfc1dIY
	OoNEQTDP231kERm57Th9xZVTn9M7WZZBMrfQlVgnT0WFdtMS/9byppGDxQ6s0jrd
X-Gm-Gg: AZuq6aI/rMxKwwS5n3O8id9+QfBoErBoo5GGf+OAeqvC8Ctsxtkzm7+FGQJtR4n4xoy
	77km6toRtIijpxDT5eMbRDULuSJcVBJODHJ9DNLHgrgUkuvQvr4LWbT7uvJ4jlxzKVMDTYcJotw
	gta4PuqvvU8AW+3h4wmEaUDIzGNbrtE8bSekbiSUB+nmiFo1JpMCt9rho7epqpR2QpZ8l/X4x8D
	XGHgspeTphWE0e1axUJXXXH8JSMrTSye9rvNlx3/tgMbkLjo8uHErrSZFJEO+vbQ4oPEuQCel/g
	HYwVPE6xkyKByNyLL6jb417HnGO2vkmx5RHKyuBQW+uOQ/N+4UR4R+f6dMwCLkhi0KmzB8SQRXO
	ngwm1S+g8wegkpHD6fvEySeSpyIbIRuDpzzQiwP47ntj3l97Ao9SrIuNUISGFSRZNOBRHr1xnUr
	+wqDo11mlXsIz4DKQtvFbsZWQneVE0c/PjRJq7+szR2fDIiLSzgPm/sPRurgpBqUhKryZh5zwBQ
	8QgOx77lqZSGLLr7dXuDQhiD2Vrb76KvYIz
X-Received: by 2002:a05:7300:4352:b0:2b6:c617:f79d with SMTP id 5a478bee46e88-2b85647cde3mr2281838eec.13.1770431363324;
        Fri, 06 Feb 2026 18:29:23 -0800 (PST)
Received: from arch.lan (c-98-51-119-100.hsd1.ca.comcast.net. [98.51.119.100])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b855b0f624sm3761035eec.14.2026.02.06.18.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 18:29:22 -0800 (PST)
From: Milos Nikic <nikic.milos@gmail.com>
To: jack@suse.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Milos Nikic <nikic.milos@gmail.com>
Subject: [PATCH] ext2: guard reservation window dump with EXT2FS_DEBUG
Date: Fri,  6 Feb 2026 18:29:20 -0800
Message-ID: <20260207022920.258247-1-nikic.milos@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13613-lists,linux-ext4=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[nikicmilos@gmail.com,linux-ext4@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-ext4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 52740104A89
X-Rspamd-Action: no action

The function __rsv_window_dump() is a heavyweight debug tool that walks
the reservation red-black tree. It is currently guarded by #if 1,
forcing it to be compiled into all kernels, even production ones.

Match the rest of the file by guarding it with #ifdef EXT2FS_DEBUG,
so it is only included when explicit debugging is enabled.

This removes the unused function code from standard builds.

Signed-off-by: Milos Nikic <nikic.milos@gmail.com>
---
 fs/ext2/balloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext2/balloc.c b/fs/ext2/balloc.c
index b8cfab8f98b9..0fee01ed56d0 100644
--- a/fs/ext2/balloc.c
+++ b/fs/ext2/balloc.c
@@ -201,7 +201,7 @@ static void group_adjust_blocks(struct super_block *sb, int group_no,
  * windows(start, end). Otherwise, it will only print out the "bad" windows,
  * those windows that overlap with their immediate neighbors.
  */
-#if 1
+#ifdef EXT2FS_DEBUG
 static void __rsv_window_dump(struct rb_root *root, int verbose,
 			      const char *fn)
 {
@@ -248,7 +248,7 @@ static void __rsv_window_dump(struct rb_root *root, int verbose,
 	__rsv_window_dump((root), (verbose), __func__)
 #else
 #define rsv_window_dump(root, verbose) do {} while (0)
-#endif
+#endif /* EXT2FS_DEBUG */
 
 /**
  * goal_in_my_reservation()
-- 
2.52.0


