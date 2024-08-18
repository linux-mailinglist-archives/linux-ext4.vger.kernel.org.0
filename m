Return-Path: <linux-ext4+bounces-3761-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7760955ABA
	for <lists+linux-ext4@lfdr.de>; Sun, 18 Aug 2024 06:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F517281DEA
	for <lists+linux-ext4@lfdr.de>; Sun, 18 Aug 2024 04:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7052EC125;
	Sun, 18 Aug 2024 04:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6DAaCUY"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D756944F
	for <linux-ext4@vger.kernel.org>; Sun, 18 Aug 2024 04:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723953860; cv=none; b=Z1HT4KFw3NzcKE+CwE7ehET+YSHG5Q+itH0Ly4sbZ5RnEVUDOzQRDDEohao7tBhksgs46mDfqWCwmpdQbXQCc1FqjxLCYFMoj6fYFwEj6oW3GGX2AdMs1y48QIXHxr9KJfWUrCzgxIbFwO7/qZw1zZC7Ab689nGVtmi0/fW7vOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723953860; c=relaxed/simple;
	bh=1LE3dg8gghJ1wuk5hei02YIfm/Px6H0AiCfAq21vllM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SDi2ZOvVXA1ZdRfAGRC96okFbwksLRMqWUOT8ft3JCZpCVs1js0e0IJVeKm6fMq+GSKNiEoBI00SfYajts+Dpypu0zHj94Hvrlr8qtU6XDj5Ozf7xB1jS8sVAoQfU11VVWcnWS+0DPZGH/1rafN2quX+5+/8YabZTtGltS1AvyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6DAaCUY; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-39d2f638050so5765895ab.3
        for <linux-ext4@vger.kernel.org>; Sat, 17 Aug 2024 21:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723953857; x=1724558657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WXFociNZYmdSBS4f2g2Q4NZ/f6SsaZ5Ytw4aF/Mh0jk=;
        b=S6DAaCUYTid0xl33sOUeFbmZo9wgllyJ9nN0g3iZjIMLmSJnDYkk05/u7KXzEmVTyY
         VVglhFzDQOm8kBzSdebiYa+XzSFxhyxnooqZuOY8tRnPzYGr/Tj8yUcA4zJXkGel2wKP
         htncjXpxACF2XtwECc+FNnL2M49CCLHjcXmENJD4IJqoaUHxlqf8IksSETpcSMdA+341
         SwAR//+aYFXp5CAgLry3BS4J78r4Mylr6fKKJFNgUvHV290JSqY/tYgrGAhEgpAB0sIm
         Hq9D4wrUkI7CHPP2/PDbNlUQjDZXUo96+ZoCgHnQfakJ5z3h2DMadGoUUP2qJCaofvku
         1lyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723953857; x=1724558657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WXFociNZYmdSBS4f2g2Q4NZ/f6SsaZ5Ytw4aF/Mh0jk=;
        b=w+Nd2685Dgk1RmfKpbuWxcE3dwfwirsgWHDYuf2HIKLpwB/Dq7peTo8aYTWYR7NWt5
         UvAecyd5m39DplhX9GoGLebX0XYMjTrr+jSdZlJKZjrjFBE01lY0Be8HoRF8Dn3ISp/G
         FIILJFgYGi48p/OLC2IB4bm388tQlX6fb+ejstKSoE1bUHE6zpUrdiQIeJdePU8jwrqI
         1kWtL1g71ioyo37S2OsLYx4hLLealPo85SGxJAuxb/gr4xdLrtD8Z5Bo9feWcsJ6xLBn
         JNwfU9qeS1TNlmTbiU+1i75/fXg3/hwVCP+Ut1LL8PtF5hbp6RHEGCEcZZQRcSkDgpes
         REIg==
X-Gm-Message-State: AOJu0Yzt1TMa8Dn6KKP7HX9/gbSz00cPZI19QY9CtEJ55vkWBRBw54fC
	56wAm61qS3YUc2PairPMUjOZjTpOt60wiVqmq38H7T8zYJGyB2wDx9UIV6tDGdg=
X-Google-Smtp-Source: AGHT+IEFSMIm095p3Qhoq1k6sIqvOW+GfGo3jRpy2jvJP0GG4AUAleyKStO8Lq+KiLZqYUN3MG9gHw==
X-Received: by 2002:a92:cd81:0:b0:39d:48df:e485 with SMTP id e9e14a558f8ab-39d48dfe6eamr11525165ab.17.1723953856936;
        Sat, 17 Aug 2024 21:04:16 -0700 (PDT)
Received: from harshads.c.googlers.com.com (27.179.83.34.bc.googleusercontent.com. [34.83.179.27])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-201f0375649sm45138235ad.124.2024.08.17.21.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 21:04:16 -0700 (PDT)
From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	jack@suse.cz,
	harshads@google.com,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v7 2/9] ext4: for committing inode, make ext4_fc_track_inode wait
Date: Sun, 18 Aug 2024 04:03:49 +0000
Message-ID: <20240818040356.241684-4-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
In-Reply-To: <20240818040356.241684-1-harshadshirwadkar@gmail.com>
References: <20240818040356.241684-1-harshadshirwadkar@gmail.com>
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
 fs/ext4/fast_commit.c | 33 +++++++++++++++++++++++++++++++++
 fs/ext4/inline.c      |  3 +++
 fs/ext4/inode.c       |  4 ++++
 3 files changed, 40 insertions(+)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 8731728cc..dfa999913 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -12,6 +12,7 @@
 #include "ext4_extents.h"
 #include "mballoc.h"
 
+#include <linux/lockdep.h>
 /*
  * Ext4 Fast Commits
  * -----------------
@@ -581,6 +582,8 @@ static int __track_inode(struct inode *inode, void *arg, bool update)
 
 void ext4_fc_track_inode(handle_t *handle, struct inode *inode)
 {
+	struct ext4_inode_info *ei = EXT4_I(inode);
+	wait_queue_head_t *wq;
 	int ret;
 
 	if (S_ISDIR(inode->i_mode))
@@ -598,6 +601,36 @@ void ext4_fc_track_inode(handle_t *handle, struct inode *inode)
 	if (ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_INELIGIBLE))
 		return;
 
+	if (!list_empty(&ei->i_fc_list))
+		return;
+
+#ifdef CONFIG_LOCKDEP
+	/*
+	 * If we come here, we may sleep while waiting for the inode to
+	 * commit. We shouldn't be holding i_data_sem when we go to sleep since
+	 * the commit path needs to grab the lock while committing the inode.
+	 */
+	WARN_ON(lockdep_is_held(&ei->i_data_sem));
+#endif
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
index e7a09a998..534a5c1bf 100644
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
index 941c1c0d5..e11f00ff8 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -636,6 +636,7 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 	 */
 	map->m_flags &= ~EXT4_MAP_FLAGS;
 
+	ext4_fc_track_inode(handle, inode);
 	/*
 	 * New blocks allocate and/or writing to unwritten extent
 	 * will possibly result in updating i_data, so we take
@@ -4057,6 +4058,7 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 	if (stop_block > first_block) {
 		ext4_lblk_t hole_len = stop_block - first_block;
 
+		ext4_fc_track_inode(handle, inode);
 		down_write(&EXT4_I(inode)->i_data_sem);
 		ext4_discard_preallocations(inode);
 
@@ -4210,6 +4212,7 @@ int ext4_truncate(struct inode *inode)
 	if (err)
 		goto out_stop;
 
+	ext4_fc_track_inode(handle, inode);
 	down_write(&EXT4_I(inode)->i_data_sem);
 
 	ext4_discard_preallocations(inode);
@@ -5806,6 +5809,7 @@ ext4_reserve_inode_write(handle_t *handle, struct inode *inode,
 			brelse(iloc->bh);
 			iloc->bh = NULL;
 		}
+		ext4_fc_track_inode(handle, inode);
 	}
 	ext4_std_error(inode->i_sb, err);
 	return err;
-- 
2.46.0.184.g6999bdac58-goog


