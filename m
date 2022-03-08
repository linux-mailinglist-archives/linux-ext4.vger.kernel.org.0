Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E684D1528
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Mar 2022 11:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345991AbiCHKw2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 8 Mar 2022 05:52:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235309AbiCHKwY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 8 Mar 2022 05:52:24 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0AF433B1
        for <linux-ext4@vger.kernel.org>; Tue,  8 Mar 2022 02:51:28 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id f8so6521278pfj.5
        for <linux-ext4@vger.kernel.org>; Tue, 08 Mar 2022 02:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5FqHDCh+ScEk0Cjb7aX/EmRL7IuHgX2PByz5FuGiJ7U=;
        b=Nd9yHnDMsLvxWjTq4t/W6Ng5Uhshou5GAUEjuRZBBQKDVZU8bpNXu+AH4cUIoI6gha
         78UrIDcYbIulkH+zyiOgX+FgQmXTW2Qk0D92UOiumoDbKbTEJWv0T/O8cqBRgnQ6hSoL
         oBtx+kqIM7DBWK6h31KzwyNBf90yHcEmUiiX6ZqRmXE3xXkAbf3PKqng5C2i0X8pirMv
         wEl2UXmCdsIWB5quQGVbg75czMOV2QLf7Pk/yTx37vFrjMzK6xHvKSDP9hRbUe+e1sGP
         MfsgTUI1/r9hDU7k+oSw5qO45zuDuk7jb9GJyuGWh3o6TBVzefefXMdDxHm6Cq45OTsv
         /5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5FqHDCh+ScEk0Cjb7aX/EmRL7IuHgX2PByz5FuGiJ7U=;
        b=bqgs8UmpmOwJUZEnC1FWGy5eoe9pbBAb5ACffHJ6XpmqWLFVc88tJBGzOUvZIOMBQB
         o2TMzN4W5Gdgjz60Tva2/0jTzbE32wo4XX0E9+RG0eZtojJdjwig0wABtq+6UXAhxzvE
         QQXupod5vjo8ty0FNPDxa1IIroklu/ef5BjLOlcp7mImgzQSScwnzX4Cjiw4AjFN6E3U
         uFt+HDB/8yoXA0VxjdbPlZycZzNu+0+f8CLySIcvllC6LmBCVIZpmCzG9C0SlAwt280G
         B9NlLIwNe5+LvfZ3UGDNpiL7dHfSplm0HeR1IiZVtOQ+aGO7xrEvGXl3l7JPXG07qL3f
         QSIQ==
X-Gm-Message-State: AOAM533ZurqXJbPCsLoQGP+VfddbTn1azYmIep7nhpvl9OYCbo905bE4
        T/fkFvvG4TH+SZv9h3ak3ZZlYBX28DFAq8/W
X-Google-Smtp-Source: ABdhPJw+RytSPj3UBp0eN1NEyisNrSS1TfVc++WcJyaNA1u8a6mTcumcCPlUR2F6UezWL0Eioyznqw==
X-Received: by 2002:a63:c156:0:b0:37c:9955:ab24 with SMTP id p22-20020a63c156000000b0037c9955ab24mr13652625pgi.90.1646736687340;
        Tue, 08 Mar 2022 02:51:27 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:c24c:d8e5:a9be:227])
        by smtp.googlemail.com with ESMTPSA id f6-20020a056a00228600b004f709f5f3c1sm6282040pfe.28.2022.03.08.02.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 02:51:26 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     riteshh@linux.ibm.com, jack@suse.cz, tytso@mit.edu,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 1/5] ext4: convert i_fc_lock to spinlock
Date:   Tue,  8 Mar 2022 02:51:08 -0800
Message-Id: <20220308105112.404498-2-harshads@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
In-Reply-To: <20220308105112.404498-1-harshads@google.com>
References: <20220308105112.404498-1-harshads@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Convert ext4_inode_info->i_fc_lock to spinlock to avoid sleeping
in invalid contexts.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4.h        |  7 +++++--
 fs/ext4/fast_commit.c | 24 ++++++++++++++----------
 fs/ext4/super.c       |  2 +-
 3 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 3f87cca49f0c..fb6d65f1176f 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1065,8 +1065,11 @@ struct ext4_inode_info {
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
index 5ac594e03402..4f2caf6f987c 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -387,7 +387,7 @@ static int ext4_fc_track_template(
 		return -EINVAL;
 
 	tid = handle->h_transaction->t_tid;
-	mutex_lock(&ei->i_fc_lock);
+	spin_lock(&ei->i_fc_lock);
 	if (tid == ei->i_sync_tid) {
 		update = true;
 	} else {
@@ -395,7 +395,7 @@ static int ext4_fc_track_template(
 		ei->i_sync_tid = tid;
 	}
 	ret = __fc_track_fn(inode, args, update);
-	mutex_unlock(&ei->i_fc_lock);
+	spin_unlock(&ei->i_fc_lock);
 
 	if (!enqueue)
 		return ret;
@@ -427,11 +427,11 @@ static int __track_dentry_update(struct inode *inode, void *arg, bool update)
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
 
@@ -444,7 +444,7 @@ static int __track_dentry_update(struct inode *inode, void *arg, bool update)
 			kmem_cache_free(ext4_fc_dentry_cachep, node);
 			ext4_fc_mark_ineligible(inode->i_sb,
 				EXT4_FC_REASON_NOMEM, NULL);
-			mutex_lock(&ei->i_fc_lock);
+			spin_lock(&ei->i_fc_lock);
 			return -ENOMEM;
 		}
 		memcpy((u8 *)node->fcd_name.name, dentry->d_name.name,
@@ -478,7 +478,7 @@ static int __track_dentry_update(struct inode *inode, void *arg, bool update)
 		list_add_tail(&node->fcd_dilist, &ei->i_fc_dilist);
 	}
 	spin_unlock(&sbi->s_fc_lock);
-	mutex_lock(&ei->i_fc_lock);
+	spin_lock(&ei->i_fc_lock);
 
 	return 0;
 }
@@ -867,15 +867,15 @@ static int ext4_fc_write_inode_data(struct inode *inode, u32 *crc)
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
@@ -972,9 +972,13 @@ static int ext4_fc_wait_inode_data_all(journal_t *journal)
 
 	spin_lock(&sbi->s_fc_lock);
 	list_for_each_entry_safe(pos, n, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
+		spin_lock(&pos->i_fc_lock);
 		if (!ext4_test_inode_state(&pos->vfs_inode,
-					   EXT4_STATE_FC_COMMITTING))
+					   EXT4_STATE_FC_COMMITTING)) {
+			spin_unlock(&pos->i_fc_lock);
 			continue;
+		}
+		spin_unlock(&pos->i_fc_lock);
 		spin_unlock(&sbi->s_fc_lock);
 
 		ret = jbd2_wait_inode_data(journal, pos->jinode);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 1e5f4994fe57..38d63113c383 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1346,7 +1346,7 @@ static struct inode *ext4_alloc_inode(struct super_block *sb)
 	atomic_set(&ei->i_unwritten, 0);
 	INIT_WORK(&ei->i_rsv_conversion_work, ext4_end_io_rsv_work);
 	ext4_fc_init_inode(&ei->vfs_inode);
-	mutex_init(&ei->i_fc_lock);
+	spin_lock_init(&ei->i_fc_lock);
 	return &ei->vfs_inode;
 }
 
-- 
2.35.1.616.g0bdcbb4464-goog

