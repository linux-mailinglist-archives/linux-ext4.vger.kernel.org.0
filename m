Return-Path: <linux-ext4+bounces-8560-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FECAE16AF
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Jun 2025 10:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E550518992EC
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Jun 2025 08:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC91259C94;
	Fri, 20 Jun 2025 08:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Win2QS6R"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D608D23AB98;
	Fri, 20 Jun 2025 08:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750409414; cv=none; b=bniMEZNu2P+eU9ehuEwfUZ3PTwH/Q4XPY004r24TznLNlLrn7qk61ML6FKR77tpoPRQvHh3MSaLhgRHYy9UoYrx+ADl65EifZ9pGd8aNJ7Lzf6UGEObzvO0l28/S5zdMBP4+QKHIDNOxazAVgOQh8VE55X8VcXXlvWrasb8j5cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750409414; c=relaxed/simple;
	bh=fMqy+8/3TT5p0kYWCyolzeW2u0xrjSaTAga4krQp6B8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nf8o9IJVdS+wRutWypRCdQ89UZZfQbULAs0xEJQU46qrS4u+pFt76YmO/DSdCSSGV4yFla2zM4sF58lD56OqwYhm5h8sQrdUSY83jJbsM4xVYDvGrRE9qxjIq2ul3FCVa1Y35R/WC/i+m4JMpOGQU44pW7Ks+g9ZcUS4DQNjXmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Win2QS6R; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-234bfe37cccso20589345ad.0;
        Fri, 20 Jun 2025 01:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750409412; x=1751014212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9f++1L9JPARRRmhscC5vGTt/mbYkerHL7J3e8y04jzM=;
        b=Win2QS6R72190Xk+w0cCWR1jGcEEqLfMXl7wnPY3Aa2OM8dhHfGsxeqerE9Qcckxms
         FZu6ieGWvRFHctKBmer6xOMz41BSaSfErGnJyRE/JgBfZEx5i6+F6AEek0cyrckmO2hP
         stdTa6/12tmFExxcqHB4NWhyi22Mz66V2mPPxdu7kZm84jqKFmhBSGat/dOmVx0xYWmG
         JFp3OagXPgI3/FX/qx1ABHC3GAU9+E1BoT2jd+gfhGkgVP6Qv9I5SIRlpz5OAFavmBaF
         z2rqG7AkiuWfDY4QDO6sRLGnq5p3Z7ac8luCSechkuzQrhk8Xi2Z+ACj8Zme8dCbkqub
         4PAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750409412; x=1751014212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9f++1L9JPARRRmhscC5vGTt/mbYkerHL7J3e8y04jzM=;
        b=a72TpT+3nddYx0s3BTi4giTULauOsFiillHX1Xk5DWMdnIAln9Dbi+5YI4ASK07rid
         J8Darkh8KRybGD0cHsYwCEd4FvQHTOaw4KzmKTR2QZsFByLK3YBmtYTgzk4nS8gyoiEC
         y1F6OG9croQw/zzU3f9tFQlPp7QhPl6zCfEayKBsICtJ0YUR5ltSmDSUK0OQuHY9hVuY
         VQKGDKfiVH0FCULpm05ScMSHVSisFpGmlYEmqQmT5ZaYjV9LqvB/ZhJ9T7FwYqIOlcGM
         /qjxeIqKgKmrmPcA5lHvkZoErLIrptnOUAkz9PFbocRL6Hg15B50OYh6AYbvdYQrgTn3
         fKZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUr4EC5Y6aSOTu1/X7wWgSt6Ufouqo/Xu4eDuJrepov2s84EINLoh0VBlJvB3zoYv9GJXJAP75lkCvm@vger.kernel.org, AJvYcCWkrHAMh1aP8ebrwxYNtKSfPt4+eu6s67hB5BEkQllHzBzbQ/C4HIqH6v4ON48vwo7utpMZtbIUEwhcP8e4@vger.kernel.org
X-Gm-Message-State: AOJu0YzJpHyW2a+ytVT+DVQHxMDbDv4ruInYWsRhw8HLx3ZfUI5YkVwx
	AzJZXYQ24M4gxbVDo+LcKwhJjjwHjR3SGL79EBS6FJGWH9oxuNQiSUpevHLGhZNd
X-Gm-Gg: ASbGncuFm/Oy98N0BKTL8Lw6kJ8UqyqVeEnoEew9bwsdG/Vj8Vk5nhb8hDnhuTGMObK
	UVEJpNY+Sn37AJVD8YD0twdM80ej0xf5s70+4uU4vYpFXdNepoLdi66J39lpwG4ogDHZGc6brI4
	oo7CzndBlXpVYwE2MvkH/tx1iq05PS8Y02/fA61OAA4GM9KSHK4MCL0XcjfV7ITOfDTTpJRZI9g
	aR4M9yo7HHWSasqbS69R/MoqDp3zA7lntpd+awpp4habu984LrZbzraIcKMuOZWX0yPIrZ/fepf
	OTKjvrv2RyjvnWqxz6FOcq3YA7AFqYwIvr+5FYw/FzW0q8g3lKo7YOTksAOmghTgCZmOejB4VA=
	=
X-Google-Smtp-Source: AGHT+IE7cwLWsLGRcruAimZFYCSBtpeIi+1mCmFGKF6W7wxEKUlXxQkrtfZf+apkbYxuGjT/r0KjJQ==
X-Received: by 2002:a17:903:32c9:b0:236:9c95:6585 with SMTP id d9443c01a7336-237d9917e0cmr34397695ad.32.1750409411695;
        Fri, 20 Jun 2025 01:50:11 -0700 (PDT)
Received: from localhost.localdomain ([118.46.108.16])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d860a8a8sm12735285ad.132.2025.06.20.01.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 01:50:11 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: stable@vger.kernel.org
Cc: tytso@mit.edu,
	jack@suse.com,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+de24c3fe3c4091051710@syzkaller.appspotmail.com,
	Jeongjun Park <aha310510@gmail.com>,
	Jan Kara <jack@suse.cz>,
	stable@kernel.org
Subject: [PATCH 5.4.y] jbd2: fix data-race and null-ptr-deref in jbd2_journal_dirty_metadata()
Date: Fri, 20 Jun 2025 17:49:58 +0900
Message-ID: <20250620084958.26672-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <2025062052-vigorous-overlaid-8bec@gregkh>
References: <2025062052-vigorous-overlaid-8bec@gregkh>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit af98b0157adf6504fade79b3e6cb260c4ff68e37 upstream.

Since handle->h_transaction may be a NULL pointer, so we should change it
to call is_handle_aborted(handle) first before dereferencing it.

And the following data-race was reported in my fuzzer:

==================================================================
BUG: KCSAN: data-race in jbd2_journal_dirty_metadata / jbd2_journal_dirty_metadata

write to 0xffff888011024104 of 4 bytes by task 10881 on cpu 1:
 jbd2_journal_dirty_metadata+0x2a5/0x770 fs/jbd2/transaction.c:1556
 __ext4_handle_dirty_metadata+0xe7/0x4b0 fs/ext4/ext4_jbd2.c:358
 ext4_do_update_inode fs/ext4/inode.c:5220 [inline]
 ext4_mark_iloc_dirty+0x32c/0xd50 fs/ext4/inode.c:5869
 __ext4_mark_inode_dirty+0xe1/0x450 fs/ext4/inode.c:6074
 ext4_dirty_inode+0x98/0xc0 fs/ext4/inode.c:6103
....

read to 0xffff888011024104 of 4 bytes by task 10880 on cpu 0:
 jbd2_journal_dirty_metadata+0xf2/0x770 fs/jbd2/transaction.c:1512
 __ext4_handle_dirty_metadata+0xe7/0x4b0 fs/ext4/ext4_jbd2.c:358
 ext4_do_update_inode fs/ext4/inode.c:5220 [inline]
 ext4_mark_iloc_dirty+0x32c/0xd50 fs/ext4/inode.c:5869
 __ext4_mark_inode_dirty+0xe1/0x450 fs/ext4/inode.c:6074
 ext4_dirty_inode+0x98/0xc0 fs/ext4/inode.c:6103
....

value changed: 0x00000000 -> 0x00000001
==================================================================

This issue is caused by missing data-race annotation for jh->b_modified.
Therefore, the missing annotation needs to be added.

Reported-by: syzbot+de24c3fe3c4091051710@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=de24c3fe3c4091051710
Fixes: 6e06ae88edae ("jbd2: speedup jbd2_journal_dirty_metadata()")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20250514130855.99010-1-aha310510@gmail.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
---
 fs/jbd2/transaction.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 91c2d3f6d1b3..72e9297d6adc 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -1419,7 +1419,6 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
 		goto out;
 	}
 
-	journal = transaction->t_journal;
 	jbd_lock_bh_state(bh);
 
 	if (is_handle_aborted(handle)) {
@@ -1434,6 +1433,8 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
 		goto out_unlock_bh;
 	}
 
+	journal = transaction->t_journal;
+
 	if (jh->b_modified == 0) {
 		/*
 		 * This buffer's got modified and becoming part
--

