Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6801A57C40A
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Jul 2022 08:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbiGUGC5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 21 Jul 2022 02:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbiGUGC4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 21 Jul 2022 02:02:56 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF437A536
        for <linux-ext4@vger.kernel.org>; Wed, 20 Jul 2022 23:02:55 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id go3so684837pjb.0
        for <linux-ext4@vger.kernel.org>; Wed, 20 Jul 2022 23:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=15ANQp0dwnsCHTF03pUt3yxdPH7n6txqP2v/xxtddnc=;
        b=kPB8fWONO8F8QzDLidnwEWAXYm4XPbTfALoAWHIJzS3ogycNUg3itIgRDQ46PDQ63f
         /F7LlhP3Twbpki5I1vArlQewmHzzoxnOjUtynmAC4ysWX9mjz6pSha4kiYVr3ro5h4/S
         UdrvB3amqiaW5AMB+eMawQ6n27wHc6jUOPEFLsGKVEiPolg+ONy7h5jraXQgxAZNUAPF
         tq0ZmxbeCfqHoNfA4K3KDM2IxPOLeZd1DAH1lsa0Ct33a2CaXxA+abqxJ0FWtoL+GtZH
         8vP81Rs7z+NYjd49eIKgGP6WiJu32cNj2jT7nXS1+NtBLLEexOgXDjJFyaIoVmslEWbZ
         27pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=15ANQp0dwnsCHTF03pUt3yxdPH7n6txqP2v/xxtddnc=;
        b=u9VIJ21WsjDqHl+WjPo+NnfiqoFsS/dUkr8L4gcFmL5URPqUH9V3TIMQnfAhuPWCEq
         g7tQd0/SjDaYXgJ59NAteTAJKfIZQSBthb/lye2VKIr4UJSmgBO5irWQqcZP0MpuzYiX
         /h474wEHg5cO1xY7nd9ZHvOOFp2nGBRNm3mMWtHuXBfoYEOXxtzyek23OmuRi5bdgzOD
         6LUCMtbRR4xzBEoBRPUTjKn506C+wjQ0fAR5lmTtb4ojiSPUXOTojEeInNWrFCs8RTfv
         /3uscH6lrYtg6z2Sfiq/0V6httVHPEn4HOWIj3Up0WwxVRzEEUjlyb0yaoLOYFIVuX0m
         AxsQ==
X-Gm-Message-State: AJIora9zLL7TGAeIjdnufUbfulDIKFP7NftGne+TRW+wfid3x16JbbH5
        sR8uHO307AhAIWqDSc6NOUKFrwr4/QhIEQ==
X-Google-Smtp-Source: AGRyM1v4phghZLcK1n4NGB2onC9yEdOHcrEuecOikp5hf4rSP6519PR+L62gUzAe8jz6rUoH+/vwQA==
X-Received: by 2002:a17:902:8ec9:b0:16b:d5bf:c465 with SMTP id x9-20020a1709028ec900b0016bd5bfc465mr19934960plo.128.1658383374530;
        Wed, 20 Jul 2022 23:02:54 -0700 (PDT)
Received: from harshads.c.googlers.com.com (34.133.83.34.bc.googleusercontent.com. [34.83.133.34])
        by smtp.googlemail.com with ESMTPSA id rm10-20020a17090b3eca00b001ed27d132c1sm9105377pjb.2.2022.07.20.23.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 23:02:53 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [RFC PATCH v4 1/8] ext4: convert i_fc_lock to spinlock
Date:   Thu, 21 Jul 2022 06:02:39 +0000
Message-Id: <20220721060246.1696852-2-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220721060246.1696852-1-harshadshirwadkar@gmail.com>
References: <20220721060246.1696852-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Convert ext4_inode_info->i_fc_lock to spinlock to avoid sleeping
in invalid contexts.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ext4.h        |  7 +++++--
 fs/ext4/fast_commit.c | 22 ++++++++++------------
 fs/ext4/super.c       |  2 +-
 3 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 75b8d81b2469..12c8691f08d3 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1067,8 +1067,11 @@ struct ext4_inode_info {
 	/* Fast commit wait queue for this inode */
 	wait_queue_head_t i_fc_wait;
 
-	/* Protect concurrent accesses on i_fc_lblk_start, i_fc_lblk_len */
-	struct mutex i_fc_lock;
+	/*
+	 * Protect concurrent accesses on i_fc_lblk_start, i_fc_lblk_len
+	 * and inode's EXT4_FC_STATE_COMMITTING state bit.
+	 */
+	spinlock_t i_fc_lock;
 
 	/*
 	 * i_disksize keeps track of what the inode size is ON DISK, not
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 795a60ad1897..8d6d5155a646 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -380,7 +380,7 @@ static int ext4_fc_track_template(
 	int ret;
 
 	tid = handle->h_transaction->t_tid;
-	mutex_lock(&ei->i_fc_lock);
+	spin_lock(&ei->i_fc_lock);
 	if (tid == ei->i_sync_tid) {
 		update = true;
 	} else {
@@ -388,7 +388,7 @@ static int ext4_fc_track_template(
 		ei->i_sync_tid = tid;
 	}
 	ret = __fc_track_fn(inode, args, update);
-	mutex_unlock(&ei->i_fc_lock);
+	spin_unlock(&ei->i_fc_lock);
 
 	if (!enqueue)
 		return ret;
@@ -420,11 +420,11 @@ static int __track_dentry_update(struct inode *inode, void *arg, bool update)
 	struct dentry *dentry = dentry_update->dentry;
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 
-	mutex_unlock(&ei->i_fc_lock);
+	spin_unlock(&ei->i_fc_lock);
 	node = kmem_cache_alloc(ext4_fc_dentry_cachep, GFP_NOFS);
 	if (!node) {
 		ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_NOMEM, NULL);
-		mutex_lock(&ei->i_fc_lock);
+		spin_lock(&ei->i_fc_lock);
 		return -ENOMEM;
 	}
 
@@ -437,7 +437,7 @@ static int __track_dentry_update(struct inode *inode, void *arg, bool update)
 			kmem_cache_free(ext4_fc_dentry_cachep, node);
 			ext4_fc_mark_ineligible(inode->i_sb,
 				EXT4_FC_REASON_NOMEM, NULL);
-			mutex_lock(&ei->i_fc_lock);
+			spin_lock(&ei->i_fc_lock);
 			return -ENOMEM;
 		}
 		memcpy((u8 *)node->fcd_name.name, dentry->d_name.name,
@@ -471,7 +471,7 @@ static int __track_dentry_update(struct inode *inode, void *arg, bool update)
 		list_add_tail(&node->fcd_dilist, &ei->i_fc_dilist);
 	}
 	spin_unlock(&sbi->s_fc_lock);
-	mutex_lock(&ei->i_fc_lock);
+	spin_lock(&ei->i_fc_lock);
 
 	return 0;
 }
@@ -611,10 +611,8 @@ static int __track_range(struct inode *inode, void *arg, bool update)
 	struct __track_range_args *__arg =
 		(struct __track_range_args *)arg;
 
-	if (inode->i_ino < EXT4_FIRST_INO(inode->i_sb)) {
-		ext4_debug("Special inode %ld being modified\n", inode->i_ino);
+	if (inode->i_ino < EXT4_FIRST_INO(inode->i_sb))
 		return -ECANCELED;
-	}
 
 	oldstart = ei->i_fc_lblk_start;
 
@@ -906,15 +904,15 @@ static int ext4_fc_write_inode_data(struct inode *inode, u32 *crc)
 	struct ext4_extent *ex;
 	int ret;
 
-	mutex_lock(&ei->i_fc_lock);
+	spin_lock(&ei->i_fc_lock);
 	if (ei->i_fc_lblk_len == 0) {
-		mutex_unlock(&ei->i_fc_lock);
+		spin_unlock(&ei->i_fc_lock);
 		return 0;
 	}
 	old_blk_size = ei->i_fc_lblk_start;
 	new_blk_size = ei->i_fc_lblk_start + ei->i_fc_lblk_len - 1;
 	ei->i_fc_lblk_len = 0;
-	mutex_unlock(&ei->i_fc_lock);
+	spin_unlock(&ei->i_fc_lock);
 
 	cur_lblk_off = old_blk_size;
 	jbd_debug(1, "%s: will try writing %d to %d for inode %ld\n",
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 845f2f8aee5f..307871359e23 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1354,7 +1354,7 @@ static struct inode *ext4_alloc_inode(struct super_block *sb)
 	atomic_set(&ei->i_unwritten, 0);
 	INIT_WORK(&ei->i_rsv_conversion_work, ext4_end_io_rsv_work);
 	ext4_fc_init_inode(&ei->vfs_inode);
-	mutex_init(&ei->i_fc_lock);
+	spin_lock_init(&ei->i_fc_lock);
 	return &ei->vfs_inode;
 }
 
-- 
2.37.0.170.g444d1eabd0-goog

