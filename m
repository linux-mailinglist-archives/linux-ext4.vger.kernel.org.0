Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC5A72FFC4E
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Jan 2021 06:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbhAVFpv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 22 Jan 2021 00:45:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbhAVFpr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 22 Jan 2021 00:45:47 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B298BC061786
        for <linux-ext4@vger.kernel.org>; Thu, 21 Jan 2021 21:45:22 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id j12so2969220pfj.12
        for <linux-ext4@vger.kernel.org>; Thu, 21 Jan 2021 21:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XVXBeNzWfHcOAfSxKxtVU/+ztWZ0wJ0i9TEgJEDNk0M=;
        b=IKtrbYNRZA/PAPwpmxNYNNH9CxxWeNCLWf9PPMK7i5CXBF8MbgLTIVJpqdxSO/LZjD
         FOvAFmMovjtnGHgJ1SIOnrSz4vSfj7bRjXf8kOFJRtRltqgTFzxy2av3rPH/zqPvfb9f
         T3DPC4XokZ370Fy3oVtWMxXM3TpMHM2/TP+MVZ+6Zi8V328yUGGTS4/2UnLTsh9yhRyG
         fXYIDiUERVPLThL85nidbnWat4AF8DxW2zCi81PXFFC0afw9mkHrI246yYAWSQMUTk6C
         p9QYuXiVyijMZmpfLpajvW7uGW9X7N0/soIFPw4wMIW6ngxcaz7WkxXtpZztm25pzJVA
         hdrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XVXBeNzWfHcOAfSxKxtVU/+ztWZ0wJ0i9TEgJEDNk0M=;
        b=hRZv+wIGIh1PPAu155e2Z+ilnvgntmUVhnenpu3U5Dw4ulEBUeZk92P5VFRVaWiHS3
         zbs5v+qxvrMwuIObOGMavbrPu+n+IFAhf/4SaPHGOINa9hHr94XBEJx/C0IwS5O4jptY
         t1CPczH07pZcexeKt1/umi6Ur16K+Tzcs8yPVrld+hAdgNqHcu+YdA72j9WhT26lCBuF
         bMR7Tr+7U5WWITpd+lFnjdfFFNmK34urVvdfDlA/hpfl8f/2ImcZ4cwRxSX4qcCWE7TW
         BMUqhmpq66q0O9xyiYe25b8jFMpEPFs5L1+q7dDzcBDE67mcze7hMAztfMjduZxEYaZ/
         rW/A==
X-Gm-Message-State: AOAM532CS3fXP5y7M1f6f5IMYn6r0lFOwEbL5IQA7MGJ/LZKNwg2nqz1
        +t6ugjsPZA42Sl3JGjhyeMSOssTRmLk=
X-Google-Smtp-Source: ABdhPJzLUYbvxPui2M7yzoLXgfP9YMyTFuiQ7HkQebrsWuk9xI+SLACwOcGaVEGb+9rPfa634eHePg==
X-Received: by 2002:a17:90a:9a89:: with SMTP id e9mr3413150pjp.2.1611294321937;
        Thu, 21 Jan 2021 21:45:21 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id gg6sm12245827pjb.2.2021.01.21.21.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 21:45:21 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <--global>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v4 3/8] e2fsck: add fast commit setup code
Date:   Thu, 21 Jan 2021 21:44:59 -0800
Message-Id: <20210122054504.1498532-4-user@harshads-520.kir.corp.google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
In-Reply-To: <20210122054504.1498532-1-user@harshads-520.kir.corp.google.com>
References: <20210122054504.1498532-1-user@harshads-520.kir.corp.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Introduce "e2fsck_fc_replay_state" structure which is needed for ext4
fast commit replay.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Reviewed-by: Theodore Ts'o <tytso@mit.edu>
---
 e2fsck/e2fsck.h      | 16 ++++++++++++++++
 e2fsck/journal.c     | 15 +++++++++++++++
 lib/ext2fs/ext2_fs.h |  1 +
 3 files changed, 32 insertions(+)

diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index 3b9c1874..f75cc343 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -68,6 +68,7 @@
 #endif
 
 #include "support/quotaio.h"
+#include "ext2fs/fast_commit.h"
 
 /*
  * Exit codes used by fsck-type programs
@@ -239,6 +240,18 @@ struct extent_list {
 	errcode_t retval;
 	ext2_ino_t ino;
 };
+
+/* State structure for fast commit replay */
+struct e2fsck_fc_replay_state {
+	struct extent_list fc_extent_list;
+	int fc_replay_num_tags;
+	int fc_replay_expected_off;
+	int fc_current_pass;
+	int fc_cur_tag;
+	int fc_crc;
+	__u16 fc_super_state;
+};
+
 struct e2fsck_struct {
 	ext2_filsys fs;
 	const char *program_name;
@@ -431,6 +444,9 @@ struct e2fsck_struct {
 
 	/* Undo file */
 	char *undo_file;
+
+	/* Fast commit replay state */
+	struct e2fsck_fc_replay_state fc_replay_state;
 };
 
 /* Data structures to evaluate whether an extent tree needs rebuilding. */
diff --git a/e2fsck/journal.c b/e2fsck/journal.c
index 75fefcde..2c8e3441 100644
--- a/e2fsck/journal.c
+++ b/e2fsck/journal.c
@@ -278,6 +278,17 @@ static int process_journal_block(ext2_filsys fs,
 	return 0;
 }
 
+/*
+ * Main recovery path entry point. This function returns JBD2_FC_REPLAY_CONTINUE
+ * to indicate that it is expecting more fast commit blocks. It returns
+ * JBD2_FC_REPLAY_STOP to indicate that replay is done.
+ */
+static int ext4_fc_replay(journal_t *journal, struct buffer_head *bh,
+				enum passtype pass, int off, tid_t expected_tid)
+{
+	return JBD2_FC_REPLAY_STOP;
+}
+
 static errcode_t e2fsck_get_journal(e2fsck_t ctx, journal_t **ret_journal)
 {
 	struct process_block_struct pb;
@@ -514,6 +525,10 @@ static errcode_t e2fsck_get_journal(e2fsck_t ctx, journal_t **ret_journal)
 
 	journal->j_sb_buffer = bh;
 	journal->j_superblock = (journal_superblock_t *)bh->b_data;
+	if (ext2fs_has_feature_fast_commit(ctx->fs->super))
+		journal->j_fc_replay_callback = ext4_fc_replay;
+	else
+		journal->j_fc_replay_callback = NULL;
 
 #ifdef USE_INODE_IO
 	if (j_inode)
diff --git a/lib/ext2fs/ext2_fs.h b/lib/ext2fs/ext2_fs.h
index bfc30c29..b1e4329c 100644
--- a/lib/ext2fs/ext2_fs.h
+++ b/lib/ext2fs/ext2_fs.h
@@ -543,6 +543,7 @@ struct ext2_inode *EXT2_INODE(struct ext2_inode_large *large_inode)
 #define EXT2_VALID_FS			0x0001	/* Unmounted cleanly */
 #define EXT2_ERROR_FS			0x0002	/* Errors detected */
 #define EXT3_ORPHAN_FS			0x0004	/* Orphans being recovered */
+#define EXT4_FC_REPLAY			0x0020	/* Ext4 fast commit replay ongoing */
 
 /*
  * Misc. filesystem flags
-- 
2.30.0.280.ga3ce27912f-goog

