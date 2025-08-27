Return-Path: <linux-ext4+bounces-9693-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FD3B38221
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Aug 2025 14:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21011980FAD
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Aug 2025 12:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DFA303CB6;
	Wed, 27 Aug 2025 12:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Ljb5XLeN"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1618F302CB5
	for <linux-ext4@vger.kernel.org>; Wed, 27 Aug 2025 12:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756297101; cv=none; b=bLkTvFzd279MMUncljzaSZgDZcWosKwdx5F6OLe8dwyHGmBBKkk28uTyMo/+Y+8zHwJzo0BGc64UibTG6niXHYC1b4HENuBjkrmsmLILf030Jdefg3jDDZ461rFOODisrRfJFliCySrOf339AS4nKcdmylQ17MUtrg6qv4AFGeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756297101; c=relaxed/simple;
	bh=QAEXeYp4ZwNEF11A+LDId32CXx6FbODT+0plZ7vPAnU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UgvemuTM2TV8VYFrfMiBlRXKY7ONj4kRxKi8GUGch6T0JsplTXRJcZD56N94iE8riJdDKeEygtn67qDbd0tXPXsUF3/tJbp4xZXIeL/y90/U/90OTJDA/c/oyPtHSMncJOHPd4Ofq3uLR2y7fjwT93h8PnNeBiIgj7ZYpPkPEi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Ljb5XLeN; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2460757107bso62299895ad.2
        for <linux-ext4@vger.kernel.org>; Wed, 27 Aug 2025 05:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756297096; x=1756901896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lk37+tVypbmq7tD8itHdvPagwtmzPZc7iO9u/V3pJxI=;
        b=Ljb5XLeNtQyofaBPGFjwIH5L5cLNKFDx/J8BG3Uv/rIh6rwmqw+kSrPv5Im0mTDc9O
         YmzpBFAsfdPUIEWoKKknAfcKRW0YXJSUIRz/KS6hhx0Hyg560LVGdBX3v0bsoEsi1Wm7
         8H4kJuB391qN/ePCJuCKNz9981GCfE6tZ2UV0rUQHJwAfcnqmEc33+QOj11Ufi/brDnP
         ocm6Ft+5rnbd81kPp9mNI37Rdq/Mof1/icx/4Mx0yF3sMUsDmCNyROMb45g8iKhlqcPn
         t3fp68djZpRejqSACLCM4nTv4QajDlMWO7TrzQ2WhIHeTpRWq/GLY/xuHYsUDFzYp7N0
         Qg3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756297096; x=1756901896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lk37+tVypbmq7tD8itHdvPagwtmzPZc7iO9u/V3pJxI=;
        b=Os07LoWMZuPjHMNqgeycFjyeDL610SKhOrsW6nbueNNm1CITDv1jP/en78xAx7VCr0
         +/g9dc2Ij8KnpEEIFzd2VDEjzubOgRPQ+LzvCyvM/eMiyqQ5RGKJ20f5ne56mabiGdOF
         9DEgxwzDWPfPSHBg6nj6U2aEdRHWvOx/y00mX4M1rJ3mpyJ6H6+ESE++oX+MB6V+ofPh
         /l0H9j/S3GcGHCv2+E75FZoL5u1Dde25W4lFkhaEuAgyf+GYODAWLkNgvYxS9T8h/FAB
         mw+LOPH1PHxmUbz8NUcrySD0MoZgI/udB6JE6+n/QKolC68mVBm1WqqQq08uc9wzGMTi
         9gWQ==
X-Gm-Message-State: AOJu0Yw188GMVGtk7JNMXCLmhkM/nag6DBdme1TU5UJsVqcqbUeAyJsi
	lRVtIh9ULWX0A/0kWVZPsOVCD05JSCheEbaLzrFS1NCYyyI2zBwbzDXVKmopYpVh2umgINFRgIE
	gAsFiAN8=
X-Gm-Gg: ASbGncuxTVAHueuCDHu08R4MlJPDjoDu9Zi38bBKSaPjPpC70OYIxHD4I+IGa1nIyeR
	xtXBqLu1n1Y1PKod8SVV9KHsoc+TFkGodlTwt8CKMjZt/RDRgfoXMTHc9n2J/QEMB238xODG9dU
	2ZO2hPtDFuOouQZOwbNy2yoQv1PKFLmQfyLWBZDOBUyG46qsi3DN5J8nX54dfZxrBwHoKBe1X3e
	rJei/fvbUV41a/4Dhlv3K9dU9NstUzA7bYBeI5gOCy+eUNICyv0uzzrm8LmaHZ7Ow1X+nZI8UHy
	YX5K/Bv/ZLOIJlDrLYBqGCLVTu4xs3+rV0dYIVjIIiPedDI3XKT5lm/G4VgClxwlAoSqEIqgGDY
	q3Vdv8ExBOTmmM64MUrUZWkSp8qfr+NOTBA==
X-Google-Smtp-Source: AGHT+IHNjWgsy86D4oCGUNJlNDx1DAL0SuJkv9s8s3Q9iftrmIv4mkxhJ1MWSZkZszQ7UN022SzRVA==
X-Received: by 2002:a17:903:1b6d:b0:246:b1fd:298c with SMTP id d9443c01a7336-246b1fd2fc8mr168609675ad.1.1756297096004;
        Wed, 27 Aug 2025 05:18:16 -0700 (PDT)
Received: from localhost ([106.38.226.228])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687c75b5sm120905385ad.66.2025.08.27.05.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 05:18:15 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	jack@suse.cz,
	harshadshirwadkar@gmail.com,
	ritesh.list@gmail.com
Subject: [PATCH] ext4: Increase IO priority of fastcommit.
Date: Wed, 27 Aug 2025 20:18:12 +0800
Message-Id: <20250827121812.1477634-1-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following code paths may result in high latency or even task hangs:
   1. fastcommit io is throttled by wbt.
   2. jbd2_fc_wait_bufs() might wait for a long time while
JBD2_FAST_COMMIT_ONGOING is set in journal->flags, and then
jbd2_journal_commit_transaction() waits for the
JBD2_FAST_COMMIT_ONGOING bit for a long time while holding the write
lock of j_state_lock.
   3. start_this_handle() waits for read lock of j_state_lock which
results in high latency or task hang.

Given the fact that ext4_fc_commit() already modifies the current
process' IO priority to match that of the jbd2 thread, it should be
reasonable to match jbd2's IO submission flags as well.

Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
---
 fs/ext4/fast_commit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 42bee1d4f9f9..fa66b08de999 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -663,7 +663,7 @@ void ext4_fc_track_range(handle_t *handle, struct inode *inode, ext4_lblk_t star
 
 static void ext4_fc_submit_bh(struct super_block *sb, bool is_tail)
 {
-	blk_opf_t write_flags = REQ_SYNC;
+	blk_opf_t write_flags = JBD2_JOURNAL_REQ_FLAGS;
 	struct buffer_head *bh = EXT4_SB(sb)->s_fc_bh;
 
 	/* Add REQ_FUA | REQ_PREFLUSH only its tail */
-- 
2.20.1


