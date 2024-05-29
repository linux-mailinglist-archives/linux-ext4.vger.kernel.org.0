Return-Path: <linux-ext4+bounces-2685-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F958D29DC
	for <lists+linux-ext4@lfdr.de>; Wed, 29 May 2024 03:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AAECB20BFB
	for <lists+linux-ext4@lfdr.de>; Wed, 29 May 2024 01:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6070815AAC7;
	Wed, 29 May 2024 01:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tc2TwK28"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745981E86E
	for <linux-ext4@vger.kernel.org>; Wed, 29 May 2024 01:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716945648; cv=none; b=Ug8PfAG2L4HoZVykEMMMg3R8pX84PFogLZTx/Ld5NwkCkh6VLfGDD8IP7jXXyAJINJNGg4lCXhzc5Xx16rZR41G3FtNbjmHONiponmFFZtQNpgGevMweLh406xTP/QVdGPlFBINY9ozc+RnSjO76sOpaqxN//G6XmNJp633VKFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716945648; c=relaxed/simple;
	bh=4XPxsX8sQ2GXcseex3wUkrzhI1XzuQofoIcsIDhXLI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KILFuc59QpJ3rB9qPoWHb6Na/AZukVjXBQXiGVIWsD5Y9gaV7HlOzV8Mw2yOXJvxYVydz/D5Gqaz43PUtND3oj5w+dFaDCTgi+ri0KhMv+JnPf9owFQ4QLZEE59L4A0nHS302oajDPCxRqoXtoPCEmv/BzaRS8ajDqE6QlUb9kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tc2TwK28; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2bf62b121ccso307105a91.0
        for <linux-ext4@vger.kernel.org>; Tue, 28 May 2024 18:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716945646; x=1717550446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=juejHXi1btkqPVBPv4LvDkZ/0p8lu23sMTaQ4tMTggc=;
        b=Tc2TwK28HdHrYPT1AW2/oFeO6IErJEUF6B8kbywdTHawcJoYSsXRvJD0WtAAqMH52O
         +y9Sh4o8V4aQwdIh1AYi4EDVsy822VIaSs5wrNLYC4Y0FZf95RTaKdPpRfKcTe3ZmJV5
         FbXeKLYpvAAGrokYCKBsa5ZflEKckahvxEimbReWam8czevG8yQ9hOyIoU7Ba2thF0sh
         uhjTy0hv0KowCbZm1b1lFkf0xUiyTmXRJ1vxuHPxKNZjlGeJ+e12Y/fG6Gg+8A0E78r6
         5+qs1fc+7dzxyYFqjtrBs3/Hx92/VaQzhSjv6Bz0qqAaGeZ0al9cZnZNNsXijoS8HCT1
         BXeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716945646; x=1717550446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=juejHXi1btkqPVBPv4LvDkZ/0p8lu23sMTaQ4tMTggc=;
        b=Y870dhT7/pQVlWSNl4NeSOhjESHV4oHNq+0pUEEk+6wKTXf1VpvZOLxO1/aXla1wqC
         RO6/msP4T+XsImBxflnUpEIHbNgx5VV10dJdBQLK8nrSPQpZ22bajS2uSD2dJY4pblR/
         Y+3xc2ZalwRcQ1gz0dCWE8e0EAyD38UKPx3/2t0ilS3fCK1HL9IVoWNeaLy81Ltv/LtR
         9h1QXZhPoih3F/qH8aSVpmlFYwsbiZeByUZ+jiunVFXJalzBMb3qCOy7k8blOTtLNz01
         TnnmRnHbZQ+IzW5MP8yor3+NdAcVUqGuM42zZkRMnftmfP9JJxDaRE/mj2g/+1IB28ij
         xnpw==
X-Gm-Message-State: AOJu0Yxcao7fyINZCFwtb6DtuGrFGA/gxQ61tj6tiCXcrFQMLChHmJgJ
	qwgjz0SBaac9nKVPvN3Mi3mcPdHapuMG7LenqMYDiR7AG9vm3CzpkvtMsmJr
X-Google-Smtp-Source: AGHT+IE9Bjvw4pPNleShWfUZNpzGjosvzsshmEEASeD9+uBueanK9MhNa2aVhC4cL5djsK+qx0tWdA==
X-Received: by 2002:a17:90a:4d82:b0:2bd:9284:d673 with SMTP id 98e67ed59e1d1-2c02ebc3f3cmr1001207a91.8.1716945645519;
        Tue, 28 May 2024 18:20:45 -0700 (PDT)
Received: from harshads.c.googlers.com.com (34.85.168.34.bc.googleusercontent.com. [34.168.85.34])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2bde008a188sm10139388a91.53.2024.05.28.18.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 18:20:45 -0700 (PDT)
From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	saukad@google.com,
	harshads@google.com,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v6 02/10] ext4: for committing inode, make ext4_fc_track_inode wait
Date: Wed, 29 May 2024 01:19:55 +0000
Message-ID: <20240529012003.4006535-3-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
In-Reply-To: <20240529012003.4006535-1-harshadshirwadkar@gmail.com>
References: <20240529012003.4006535-1-harshadshirwadkar@gmail.com>
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
2.45.1.288.g0e0cd299f1-goog


