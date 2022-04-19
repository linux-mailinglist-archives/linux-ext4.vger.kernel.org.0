Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA3E507691
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Apr 2022 19:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353410AbiDSRet (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Apr 2022 13:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347669AbiDSReq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 19 Apr 2022 13:34:46 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83A936E26
        for <linux-ext4@vger.kernel.org>; Tue, 19 Apr 2022 10:32:03 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id mp16-20020a17090b191000b001cb5efbcab6so2488387pjb.4
        for <linux-ext4@vger.kernel.org>; Tue, 19 Apr 2022 10:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c9EWHIurp+luA1eBTvgbOU2mM9qsp11MaFFZL7olJgc=;
        b=a0qNuzLd9vOZHqr4+JECEusOWnFFpFv0TYEGp/8QNdg7129Nex27dSOTj47EJS57xR
         xD2ibX/G1qj2HuAP5t2k1CcMjweitRCVx71enzU4XA8g8it2lHHVnKZZY6PJANCF3wCp
         dvqQ9LOQBsyNs6BCVINsmM2fiNsuQilr5egSvzXBCYnTlsGC5ZCKBylNvF6ekKMJ6Jb4
         oiE1NTFPnHfTLvi/SuXko+CAGAmT3UgNdgPuP01G4brS8P8ms1wm64hrABjZw2m4QHi6
         17y6wCHGlHjlM5+bMb+WHdfEfQSTVsqnfuqK5VWyy7FrdJVcwCQAw1CFybdI3tqj2RTK
         IXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c9EWHIurp+luA1eBTvgbOU2mM9qsp11MaFFZL7olJgc=;
        b=y75qIrepSb8DIccno63dBcxVpf/Y5htgbKbAGwv9xDEjmKh1UtgiN06XqFtrBKPAhD
         hFmYCRyaACyhGPDB2+dSWzye43pFAwKqB55gB5DpoorY5TQRxw0aikwtFUPGdSSvKPWr
         GEYdInuehEEP8TAPeOOw5osX2q0li2NTU5ygNvRgKMDPFpEvLjzjalWWaRzvJoie277i
         GJefn7Vd4HbBClsO4rRqfYzb+rgmBWCW3uPn/+v7YFX0fwF9ONe/UqnmZLSpm8u9VW+r
         1N6mJiJNMXBdGqveCBKYaU5XR0pUHzA24ZCwFA8fYUkqYJvuNkFS+ZwKGFQltYmWHnvg
         Erqw==
X-Gm-Message-State: AOAM532IrPfYfcwM2zVf0ZgZxjb3wQ0xW4Y5tymLifjkkXT/H+NcORVw
        6rRIt16AerCSDjKKLSgjLbpM0dcBrX3/Xw==
X-Google-Smtp-Source: ABdhPJzK2GzX2cNQNnF3aXhlaIEHF4wXGB8DV5c2q1mkGfAk/NuoWQxZWP0LypCCFDUN78xEyVddUw==
X-Received: by 2002:a17:902:7e85:b0:158:c12f:d662 with SMTP id z5-20020a1709027e8500b00158c12fd662mr16718799pla.141.1650389522791;
        Tue, 19 Apr 2022 10:32:02 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:91ac:bc24:f886:dffc])
        by smtp.googlemail.com with ESMTPSA id q9-20020a638c49000000b00398677b6f25sm17266093pgn.70.2022.04.19.10.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 10:32:02 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     riteshh@linux.ibm.com, jack@suse.cz, tytso@mit.edu,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v3 1/6] ext4: convert i_fc_lock to spinlock
Date:   Tue, 19 Apr 2022 10:31:38 -0700
Message-Id: <20220419173143.3564144-2-harshads@google.com>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
In-Reply-To: <20220419173143.3564144-1-harshads@google.com>
References: <20220419173143.3564144-1-harshads@google.com>
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
 fs/ext4/fast_commit.c | 22 ++++++++++------------
 fs/ext4/super.c       |  2 +-
 3 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 1d79012c5a5b..46ca0979e73b 100644
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
index 3d72565ec6e8..c278060a15bc 100644
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
index ae98b07285d2..d6fc12782657 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1347,7 +1347,7 @@ static struct inode *ext4_alloc_inode(struct super_block *sb)
 	atomic_set(&ei->i_unwritten, 0);
 	INIT_WORK(&ei->i_rsv_conversion_work, ext4_end_io_rsv_work);
 	ext4_fc_init_inode(&ei->vfs_inode);
-	mutex_init(&ei->i_fc_lock);
+	spin_lock_init(&ei->i_fc_lock);
 	return &ei->vfs_inode;
 }
 
-- 
2.36.0.rc0.470.gd361397f0d-goog

