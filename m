Return-Path: <linux-ext4+bounces-7770-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DD0AB01F1
	for <lists+linux-ext4@lfdr.de>; Thu,  8 May 2025 19:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 742761BA793B
	for <lists+linux-ext4@lfdr.de>; Thu,  8 May 2025 17:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E889286D59;
	Thu,  8 May 2025 17:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIerUTvw"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879CA286D40
	for <linux-ext4@vger.kernel.org>; Thu,  8 May 2025 17:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746727176; cv=none; b=Z2O91sHX6JVaI0A5tm1iI//93L9FxiWxGEUSCX2GB94itxUhHTVVPXha74wdiOpt13ENccsn13JmPrumI5SEJ5RpfDJIbrec0qZntGCbHI6STRnJkCG/ViIlXhuEx9ORKRFtjbzuBlsLg4aRQgFwaDgtx3+mvn7EE/jwCUYZR7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746727176; c=relaxed/simple;
	bh=z345HmiXRblzh9RR3dTjnXWi5tMWsvqosRjz4pAnSbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R55d1JFfaHkIxRqxbU/x5Daoo/cgqI5aUjjiXw4DQpSpQ7/PzwpkFHlJbFQEXHiibRuaIdzD1o/Bp5Wm8dIyOGB7ctyE9iEpNfYR1XQmW4b74V6Cpp5pht2MAKXuwALVDuPVGF9DbUU93qwAxs/y+/0+U/aX1Aufvyhjmmw1sBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIerUTvw; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso1417495b3a.2
        for <linux-ext4@vger.kernel.org>; Thu, 08 May 2025 10:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746727173; x=1747331973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3v4Uu7RM19taHKPPYlIfAPfDGMsscwFvhEcFJtV9Ek=;
        b=XIerUTvwvwIJH6FrOwVYT1MtWZEiiUzYeFc3w1Rp77SGKK7wRRq1hhimcUFr2/OAVA
         45XWSp1NoLfaYBxQYbglWCAn2+UNVqSsWyAfs6OyAesgfbBJtJFByM4VcKS9DfXbeVfW
         xHyeTh5GMegOebxdiJPvdTdZGkvAeP/1f7QEcDPzHGn7SN+IbEBfLBatBPQ3UdPOJ8yR
         eoQvQ5hxJZ8DqyXUHnk1wnfLKZRuF7Es7/CWbvEbyTEzTYm0p1j0d7mUbmau5dLzFXla
         1b0fJsbhjspGBM6qKZp2VXCxzEcu9GHwBS/mvK5kMhzhtd3aKU6CMhIx8I7pL3hFeWaN
         AMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746727173; x=1747331973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F3v4Uu7RM19taHKPPYlIfAPfDGMsscwFvhEcFJtV9Ek=;
        b=MDB7qjn7lZphW2ZbKWs8k1n8L+MDObFageuNHbAjG6eKYhDK7Vvd3Ux0uRkHO454jZ
         7ONpIa6vZgfY44RBuIxuFNP0z/syvQRvRijT6HB0eN9ZF0akoNShVfEphTGw1bylHrct
         eRuZmeUtAx5bA7ZS2qmXa+vu9OXMhnaIFAgcUHTYgODs5N55nGwdB3rIgMA3EMUoeXHR
         QcI0rU6oJB3NxodZizcchGuHjv37bwgcLAcns9Xenebi5K5XSIxbfNm7feWh0bPbW2Ch
         Poil1GeDfVW1XClQoINYIK3iApeO+hagyCFfUH5ZKbFmH2TtHMLH5pa21vfxe5PdW8bN
         f3iw==
X-Gm-Message-State: AOJu0Yz+0S5b4g9B1R5ggSTDh52sjNWNzXBqLCRmlFAq2Jl6ngu4nbF3
	3lCSgtxr5wVllxtmr1ZxF6Cj8W/r4eXLaCrFu7SmqNmZoFH4KsKQ5Lib3/8Q
X-Gm-Gg: ASbGncuUiviLdznnku7frS6BtrNNC5OrmDWSzKJCTbOhls7f0dCIlLOS/bOgYOdtzaj
	t7cqZruEJ0I6L/zb+LtgamVoJ15HnxHtLI5n4oxbJxdhOsHgogupsFiZYsGXx4aIk6XdS/6hV4X
	8uSjAdFT5sTUcAeW7I63CROfVBxD2jJv+23ewLHm8/wrOSPZh/Sc/M4/iBCc2i76ELeR6dD2Dr7
	roNQSce9OmUA2ZZWnHXgegjvkFAPr9dXvWVcsJYQZa4JH2+Vk9gYkO/LfDwIKQ/LP59wt4pfaK+
	3nCcBVS+VvGbYD0Oi5MTnzcferEfL8UGQ3rcIYWA5OnYDKQ2HdmePP4VqTrESW4UH2VJMyor0vf
	3qQQFwog8DNOB7/OmhL5p2TEz6HcjA6VKBhjH
X-Google-Smtp-Source: AGHT+IHAEZOfcR0nigbt5Mgl0RXYnZ9UjdaobEamaPuKxjxH4DEtPh99YbJ9jEzAc8qxxoVmPe9xvw==
X-Received: by 2002:a17:902:f709:b0:224:1af1:87f4 with SMTP id d9443c01a7336-22fc8b73b24mr4619785ad.22.1746727173148;
        Thu, 08 May 2025 10:59:33 -0700 (PDT)
Received: from harshads.c.googlers.com.com (156.242.82.34.bc.googleusercontent.com. [34.82.242.156])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-22fc828939asm2153535ad.164.2025.05.08.10.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 10:59:32 -0700 (PDT)
From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	jack@suse.cz,
	harshads@google.com,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v9 2/9] ext4: for committing inode, make ext4_fc_track_inode wait
Date: Thu,  8 May 2025 17:59:01 +0000
Message-ID: <20250508175908.1004880-3-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
In-Reply-To: <20250508175908.1004880-1-harshadshirwadkar@gmail.com>
References: <20250508175908.1004880-1-harshadshirwadkar@gmail.com>
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
inode being tracked for next fast commit. This ensures that by the
time ext4_reserve_inode_write() returns, it is ready to be modified
and won't be committed until the corresponding handle is open.

A subtle lock ordering requirement with i_data_sem (which is
documented in the code) requires that ext4_fc_track_inode() be called
before grabbing i_data_sem. So, this patch also adds explicit
ext4_fc_track_inode() calls in places where i_data_sem grabbed.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/fast_commit.c | 35 +++++++++++++++++++++++++++++++++++
 fs/ext4/inline.c      |  1 +
 fs/ext4/inode.c       |  5 +++++
 3 files changed, 41 insertions(+)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 63859ec6d..c4d3c71d5 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -12,6 +12,7 @@
 #include "ext4_extents.h"
 #include "mballoc.h"
 
+#include <linux/lockdep.h>
 /*
  * Ext4 Fast Commits
  * -----------------
@@ -570,6 +571,8 @@ static int __track_inode(handle_t *handle, struct inode *inode, void *arg,
 
 void ext4_fc_track_inode(handle_t *handle, struct inode *inode)
 {
+	struct ext4_inode_info *ei = EXT4_I(inode);
+	wait_queue_head_t *wq;
 	int ret;
 
 	if (S_ISDIR(inode->i_mode))
@@ -587,6 +590,38 @@ void ext4_fc_track_inode(handle_t *handle, struct inode *inode)
 	if (ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_INELIGIBLE))
 		return;
 
+	if (!list_empty(&ei->i_fc_list))
+		return;
+
+	/*
+	 * If we come here, we may sleep while waiting for the inode to
+	 * commit. We shouldn't be holding i_data_sem when we go to sleep since
+	 * the commit path needs to grab the lock while committing the inode.
+	 */
+	lockdep_assert_not_held(&ei->i_data_sem);
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
+	/*
+	 * From this point on, this inode will not be committed either
+	 * by fast or full commit as long as the handle is open.
+	 */
 	ret = ext4_fc_track_template(handle, inode, __track_inode, NULL, 1);
 	trace_ext4_fc_track_inode(handle, inode, ret);
 }
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 2c9b76292..fbc1c84b5 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -601,6 +601,7 @@ static int ext4_convert_inline_data_to_extent(struct address_space *mapping,
 			goto out;
 	}
 
+	ext4_fc_track_inode(handle, inode);
 	ret = ext4_destroy_inline_data_nolock(handle, inode);
 	if (ret)
 		goto out;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 94c7d2d82..d58b99407 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -696,6 +696,8 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 		if (!(flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN))
 			return retval;
 
+
+	ext4_fc_track_inode(handle, inode);
 	/*
 	 * New blocks allocate and/or writing to unwritten extent
 	 * will possibly result in updating i_data, so we take
@@ -4072,6 +4074,7 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 	if (end_lblk > start_lblk) {
 		ext4_lblk_t hole_len = end_lblk - start_lblk;
 
+		ext4_fc_track_inode(handle, inode);
 		down_write(&EXT4_I(inode)->i_data_sem);
 		ext4_discard_preallocations(inode);
 
@@ -4224,6 +4227,7 @@ int ext4_truncate(struct inode *inode)
 	if (err)
 		goto out_stop;
 
+	ext4_fc_track_inode(handle, inode);
 	down_write(&EXT4_I(inode)->i_data_sem);
 
 	ext4_discard_preallocations(inode);
@@ -5895,6 +5899,7 @@ ext4_reserve_inode_write(handle_t *handle, struct inode *inode,
 			brelse(iloc->bh);
 			iloc->bh = NULL;
 		}
+		ext4_fc_track_inode(handle, inode);
 	}
 	ext4_std_error(inode->i_sb, err);
 	return err;
-- 
2.49.0.1045.g170613ef41-goog


