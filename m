Return-Path: <linux-ext4+bounces-7242-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6435A8890F
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Apr 2025 18:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19ED03A66D0
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Apr 2025 16:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AB3289343;
	Mon, 14 Apr 2025 16:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzkqGfAJ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D2C2749E2
	for <linux-ext4@vger.kernel.org>; Mon, 14 Apr 2025 16:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744649687; cv=none; b=TzbI87pBkl9zWdPDxVG3rtSWmd2CGF50UcZYGO/GLfV8OVFAKMQFHXnHxEI2js/xGSvKKFTFzhFhTzGI1UhaYw/I8DRLgyN4LWypJ+D0OhQb86gyfDUZmjKUtXvnVDN14Sn6O59jZQTYto/y5VgY7nzbyNBMbSz3UPQkSseKgIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744649687; c=relaxed/simple;
	bh=odVJX7v3xiVVBEUsLafbEe7gcgNOuA+M8J03bQx1wYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dl8gyvUDGFwewcoJzxYU1MC5uA/qz4Y9Z2uvhT1QBG3HQGDAgU92gOBtuQKZ2bZWmokQYz9iXvWazc506/WheQxd1l2UQbVAvBy4t8WGxu4RFW+fiGRRb9HJwoFst1MWELp0u8Uas58861CM90xraHRNViMIwrwURpBSOmXkhe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LzkqGfAJ; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-af9a7717163so4812507a12.2
        for <linux-ext4@vger.kernel.org>; Mon, 14 Apr 2025 09:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744649685; x=1745254485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8xzdSgvYoXx1KqqdMTKA1N3d8ybhIsNjXcPMqiwpIM=;
        b=LzkqGfAJrOvr43TF+8Lr5Ko4Pi4qaVrcIVVA0Sq/yDwYd59m8r94XcKzxAcmlL+wWe
         VFCWM6998By/Bd1JpM7S2cdLaXEp+JW4fcQy3hZhkT45NeYcGGykOW7j6kfWJqGTk1qZ
         qMNIIX1EO88S6B5oy+mIANTjTXFfJJYK/4A4ZEjkimzPOmbSXfZoUxg7HNs5zP9Q0a+v
         s6yX6r+2HtAKqLscxyazcJiX54lk0K/M728Xu4mLONlJYH62k5maDKBRYofBtE8v4F0B
         AOBdPG8lD5y80wKw57KehLGGekekfzZdPha+8DbNEBK+0boqdVaaYXffpeYKFiMFoxdp
         Feag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744649685; x=1745254485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e8xzdSgvYoXx1KqqdMTKA1N3d8ybhIsNjXcPMqiwpIM=;
        b=LZAXyugWFI7rcsZI8+qWM+6MwARQgINqmTHU4I0oVeXmIKFVkPTLGEgq9QNhKFryS4
         qCrw3tueO7MXThEveusK7jJqJqusvTuJ5XIjso0JtIXJqHROg5nhbjVweDn8mvwIas22
         0HKPdJZaZQm2XbE5ubGTUkQVfTJhEQf0yiQS1Ri5vq13xn4xnO8C9U/PIMhW+gZRlto7
         VXUUS7L8E0L8HmVEt+UvOMY8ODVi/aoTZM6A+uVR7rgPodzt/G5UWBEpkUIC9LXevo6m
         yqJ5AFn284i5ksGZ6Li7bs8/Ajum9brYVEgd3paSnP9xzCNTAUEKEm2C+Fk1GAdE+cHo
         mmiw==
X-Gm-Message-State: AOJu0YxGEAR4noS3p21I4y1VjqHMadk81Ubvnzkk/R3fzOukmu7+N9Bx
	deoveWk4So3jVphaTaQMwMCaS7y3j4vAw8tCqUMt0nP6wKvg+Hz6lc8rFFYS
X-Gm-Gg: ASbGncsHsY+OXQ6ZriqhuROB/dwUXOF3o4aSyaG5BukluMFTBm2oqXcOoHpl7tl4m//
	B2bAFPAA0oXrGNb1HhfkIYMiHoB/jgaPTSE/dtcs12yKARFQW6R9v/YS3EQUuGn/lpyreQsiSrv
	37UYes2XVSSnqsrIlS7bVKyKiELRZTZKtmX9GNIHuYREJEeZ/0GtxDF74u+Bqr4McPzvtJO27/l
	8iAh8b/bj63Zxfk2F1D62VIVz/1qBlMF0/0On1pkdQOCd/VlYtHeFNfhFo43xGI+8rF4cUdkR0Z
	orzQJ3zxcWntDspdVoSTQoyF87kIjRDYxiEo9IOEIy94doT89CHwxUp74zXPanaS+TZMXSR6bAR
	EOEeO9KLqNrdv+Owv3K84Gj5RNwyVicPkbg==
X-Google-Smtp-Source: AGHT+IF4u44Dp0gwUSzt0fOo+VK1J6xxg+0g3tHKdjav8L44LQGiu+vW+6GNVSfEmOzQlMcwfrJ8+g==
X-Received: by 2002:a17:90a:d44d:b0:2fe:a614:5cf7 with SMTP id 98e67ed59e1d1-308236244f3mr19365634a91.3.1744649684638;
        Mon, 14 Apr 2025 09:54:44 -0700 (PDT)
Received: from harshads.c.googlers.com.com (121.61.83.34.bc.googleusercontent.com. [34.83.61.121])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-306dd1717cesm11543107a91.31.2025.04.14.09.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 09:54:44 -0700 (PDT)
From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	jack@suse.cz,
	harshads@google.com,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v8 2/9] ext4: for committing inode, make ext4_fc_track_inode wait
Date: Mon, 14 Apr 2025 16:54:09 +0000
Message-ID: <20250414165416.1404856-3-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
In-Reply-To: <20250414165416.1404856-1-harshadshirwadkar@gmail.com>
References: <20250414165416.1404856-1-harshadshirwadkar@gmail.com>
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
index 63859ec6d91d..c4d3c71d5e6c 100644
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
index f608f6554b95..271e7c93e477 100644
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
index aede80fa1781..cd0879f5f178 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -693,6 +693,8 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 		if (!(flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN))
 			return retval;
 
+
+	ext4_fc_track_inode(handle, inode);
 	/*
 	 * New blocks allocate and/or writing to unwritten extent
 	 * will possibly result in updating i_data, so we take
@@ -4079,6 +4081,7 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 	if (end_lblk > start_lblk) {
 		ext4_lblk_t hole_len = end_lblk - start_lblk;
 
+		ext4_fc_track_inode(handle, inode);
 		down_write(&EXT4_I(inode)->i_data_sem);
 		ext4_discard_preallocations(inode);
 
@@ -4231,6 +4234,7 @@ int ext4_truncate(struct inode *inode)
 	if (err)
 		goto out_stop;
 
+	ext4_fc_track_inode(handle, inode);
 	down_write(&EXT4_I(inode)->i_data_sem);
 
 	ext4_discard_preallocations(inode);
@@ -5874,6 +5878,7 @@ ext4_reserve_inode_write(handle_t *handle, struct inode *inode,
 			brelse(iloc->bh);
 			iloc->bh = NULL;
 		}
+		ext4_fc_track_inode(handle, inode);
 	}
 	ext4_std_error(inode->i_sb, err);
 	return err;
-- 
2.49.0.604.gff1f9ca942-goog


