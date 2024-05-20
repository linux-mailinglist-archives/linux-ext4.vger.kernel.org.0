Return-Path: <linux-ext4+bounces-2590-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D59538C98D8
	for <lists+linux-ext4@lfdr.de>; Mon, 20 May 2024 07:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04BFA1C20E6D
	for <lists+linux-ext4@lfdr.de>; Mon, 20 May 2024 05:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534991AAD7;
	Mon, 20 May 2024 05:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMUHISvY"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F46912E5B
	for <linux-ext4@vger.kernel.org>; Mon, 20 May 2024 05:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716184335; cv=none; b=H5fYwNXDWWhVr8laaBczX7q0Y6/PEyjSfKdT8W5+RymDJcFjb5ohrnWa+eq3Qs1/od00jg0XJLOt1HDHs3nLJQcF0+C/WhkjOPl+TSdaIPRzZg34FuKyhO6r9/CR0wSuXktm3qz4A5j0saLPkpbcYe1JtyQk73GuQ/jz6ZI072k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716184335; c=relaxed/simple;
	bh=R/mg/4PfJz04tKTKn0dPzmeOMEUgmSqqNU4zjb+SE70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GHjeV2rh+iSv5JeZURCkU7hRofppDhrweN+GFQ00vACBdPilj6/euI/kHUtjxPXUnZ3XmIRni3yMaNIqp9Rax0cJbUlekVGVazHnbfTHeOX9omDa2EZoiofcNGzdRQ6IPh+nQWEGBGK4Bmw1QYDxFwfr+AlK6Fz8/hqM1lLAF5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IMUHISvY; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5b2768410d3so1680724eaf.2
        for <linux-ext4@vger.kernel.org>; Sun, 19 May 2024 22:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716184330; x=1716789130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/l4xAC5tBItHLV2dxxyHUEeJ3AcHJlFU+wR42sPa9e8=;
        b=IMUHISvY8ZnoFZzYlfb8dMm4rOUyAjayzMoh8cRrnIZuXv272PckoARDzR7C3o2hNq
         ZAyKBrsErIOQw29dkbznz0OXRJRYPU/e6Nau0atDmG0N6PBrEMEn660xWE+gUECte1Zm
         XwbnzqS/mbPu3lDE7IXrIJvipO9U0T76ihY5O2OVn/W2R7V3/o0epzosmO03ymv46f3s
         fcWTF32X3Hg7fWUJr490bg2gMkfA2QQHJEmo2HH6MGVp98owMFglgo5AF0h+8D5AEa24
         +G2e2JNxEZ5Nm5we+bfWvMX+/zU11hTdQGqfEPVSzX9UFlCvAlsqtDxzpmzL9zwBj0xH
         xl0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716184330; x=1716789130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/l4xAC5tBItHLV2dxxyHUEeJ3AcHJlFU+wR42sPa9e8=;
        b=eK1ymTZBSIQUdmwtE+/4PJVgrXPLaH8ez07GI/4utjZwviC3HkXs2LeLmLbD9z7k1p
         AG4j1a5TzARAC3BKfnSNuQshbG3/p3pGJ6OZiHqqIdXuZlMe+wk5XVK1iNjZvw7NfZ1X
         tprGwGvR8cdXu3c1Sw8dkoWY37ahUHBthftwGPWdB/HfU8whFSrDxlNjBJqtOTM1IM63
         Q4WpMOvN7RdlUjKvyKhNZrETg29z7qR7CpqfAWBv2joORYTQoEF1IHrzTeaf1e/QbROx
         RLY1P2OfjzLfTVixo1sJic4xKkU2sqmxkNgapa438wdq1oeQJ9CX1zwtkjfGLcprhkI4
         sMdQ==
X-Gm-Message-State: AOJu0YyVjGTzCx4mFwyGuT1/TasXfLib4n3DpRAEE+fvONmJrjsRFHge
	462NnR2TBlRMoHdN6HRZ1UDiH76UnOwYPamVT/S5z5R8RGzzEXQdRb5ULoUs
X-Google-Smtp-Source: AGHT+IH9GmYa+gd4LflG+A08ScES3pLXGEiGgKRh/qtTWi6+0zgTIK46vkuT0c9UcuGwpwfoCE68lg==
X-Received: by 2002:a05:6358:9481:b0:196:ecaf:a54d with SMTP id e5c5f4694b2df-196ecafa74cmr300447755d.20.1716184330139;
        Sun, 19 May 2024 22:52:10 -0700 (PDT)
Received: from harshads.c.googlers.com.com (34.85.168.34.bc.googleusercontent.com. [34.168.85.34])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-659f66bf18csm6769297a12.46.2024.05.19.22.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 22:52:09 -0700 (PDT)
From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	saukad@google.com,
	harshads@google.com,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 02/10] ext4: for committing inode, make ext4_fc_track_inode wait
Date: Mon, 20 May 2024 05:51:45 +0000
Message-ID: <20240520055153.136091-3-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240520055153.136091-1-harshadshirwadkar@gmail.com>
References: <20240520055153.136091-1-harshadshirwadkar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the inode that's being requested to track using ext4_fc_track_inode
is being committed, then wait until the inode finishes the
commit. Also, add calls to ext4_fc_track_inode at the right places.

With this patch, now calling ext4_reserve_inode_write() results in
inode being tracked for next fast commit. A subtle lock ordering
requirement with i_data_sem (which is documented in the code) requires
that ext4_fc_track_inode() be called before grabbing i_data_sem. So,
this patch also adds explicit ext4_fc_track_inode() calls in places
where i_data_sem grabbed.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/fast_commit.c | 34 ++++++++++++++++++++++++++++++++++
 fs/ext4/inline.c      |  3 +++
 fs/ext4/inode.c       |  4 ++++
 3 files changed, 41 insertions(+)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index a1aadebfcd66..fa93ce399440 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -581,6 +581,8 @@ static int __track_inode(struct inode *inode, void *arg, bool update)
 
 void ext4_fc_track_inode(handle_t *handle, struct inode *inode)
 {
+	struct ext4_inode_info *ei = EXT4_I(inode);
+	wait_queue_head_t *wq;
 	int ret;
 
 	if (S_ISDIR(inode->i_mode))
@@ -598,6 +600,38 @@ void ext4_fc_track_inode(handle_t *handle, struct inode *inode)
 	if (ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_INELIGIBLE))
 		return;
 
+	if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT) ||
+	    (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY) ||
+		ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_INELIGIBLE) ||
+		!list_empty(&ei->i_fc_list))
+		return;
+
+	/*
+	 * If we come here, we may sleep while waiting for the inode to
+	 * commit. We shouldn't be holding i_data_sem in write mode when we go
+	 * to sleep since the commit path needs to grab the lock while
+	 * committing the inode.
+	 */
+	WARN_ON(lockdep_is_held_type(&ei->i_data_sem, 1));
+
+	while (ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING)) {
+#if (BITS_PER_LONG < 64)
+		DEFINE_WAIT_BIT(wait, &ei->i_state_flags,
+				EXT4_STATE_FC_COMMITTING);
+		wq = bit_waitqueue(&ei->i_state_flags,
+				   EXT4_STATE_FC_COMMITTING);
+#else
+		DEFINE_WAIT_BIT(wait, &ei->i_flags,
+				EXT4_STATE_FC_COMMITTING);
+		wq = bit_waitqueue(&ei->i_flags,
+				   EXT4_STATE_FC_COMMITTING);
+#endif
+		prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
+		if (ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING))
+			schedule();
+		finish_wait(wq, &wait.wq_entry);
+	}
+
 	ret = ext4_fc_track_template(handle, inode, __track_inode, NULL, 1);
 	trace_ext4_fc_track_inode(handle, inode, ret);
 }
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index d5bd1e3a5d36..bd5778e680c0 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -596,6 +596,7 @@ static int ext4_convert_inline_data_to_extent(struct address_space *mapping,
 			goto out;
 	}
 
+	ext4_fc_track_inode(handle, inode);
 	ret = ext4_destroy_inline_data_nolock(handle, inode);
 	if (ret)
 		goto out;
@@ -696,6 +697,7 @@ int ext4_try_to_write_inline_data(struct address_space *mapping,
 		goto convert;
 	}
 
+	ext4_fc_track_inode(handle, inode);
 	ret = ext4_journal_get_write_access(handle, inode->i_sb, iloc.bh,
 					    EXT4_JTR_NONE);
 	if (ret)
@@ -948,6 +950,7 @@ int ext4_da_write_inline_data_begin(struct address_space *mapping,
 		if (ret < 0)
 			goto out_release_page;
 	}
+	ext4_fc_track_inode(handle, inode);
 	ret = ext4_journal_get_write_access(handle, inode->i_sb, iloc.bh,
 					    EXT4_JTR_NONE);
 	if (ret)
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 4bae9ccf5fe0..aa6440992a55 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -607,6 +607,7 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 	 */
 	map->m_flags &= ~EXT4_MAP_FLAGS;
 
+	ext4_fc_track_inode(handle, inode);
 	/*
 	 * New blocks allocate and/or writing to unwritten extent
 	 * will possibly result in updating i_data, so we take
@@ -3978,6 +3979,7 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 	if (stop_block > first_block) {
 		ext4_lblk_t hole_len = stop_block - first_block;
 
+		ext4_fc_track_inode(handle, inode);
 		down_write(&EXT4_I(inode)->i_data_sem);
 		ext4_discard_preallocations(inode);
 
@@ -4131,6 +4133,7 @@ int ext4_truncate(struct inode *inode)
 	if (err)
 		goto out_stop;
 
+	ext4_fc_track_inode(handle, inode);
 	down_write(&EXT4_I(inode)->i_data_sem);
 
 	ext4_discard_preallocations(inode);
@@ -5727,6 +5730,7 @@ ext4_reserve_inode_write(handle_t *handle, struct inode *inode,
 			brelse(iloc->bh);
 			iloc->bh = NULL;
 		}
+		ext4_fc_track_inode(handle, inode);
 	}
 	ext4_std_error(inode->i_sb, err);
 	return err;
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


