Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87C750768F
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Apr 2022 19:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353810AbiDSRew (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Apr 2022 13:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344945AbiDSRes (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 19 Apr 2022 13:34:48 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE4038DBD
        for <linux-ext4@vger.kernel.org>; Tue, 19 Apr 2022 10:32:05 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id v12so16446595plv.4
        for <linux-ext4@vger.kernel.org>; Tue, 19 Apr 2022 10:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D2/AduS6GDuRHHXS9j3Fwszd78tLRARpYZSKdM0um+A=;
        b=QzeyDFEkdtmS667QeLcw74OtYwZuqmS23uYBZdOGXL5ucbCm918GLYxOIcORqM8nx8
         +pau9RZSSgI6ny3IwayKO9eU1we6mhwMvcZBQlM/QikDknQlEZKfFHw6p0oQ6TRWfJfs
         ETHETHnPueNaSO4ImWh1CT1kN6oiSLnnFOoI/YdnnUF+4dBUKmKCkxwiRfR495pKYyxD
         7So7Z0tndT2XGyukLtaNdG8Lte5xzWc0dUxH+TzhDnW1Hwg/dkAh+Tv+DYW1I+DnYyAU
         ZufxQlq0ar1cj/6gbwuYG8T3NYGL+QzmukRKW8K79U216rbRw2uUOOlMvJmhOJMZb+PN
         DFnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D2/AduS6GDuRHHXS9j3Fwszd78tLRARpYZSKdM0um+A=;
        b=sL/suOy7qFjcTTPqaqQ5RezO1URLF1VVSLdW9R0PJvTEQMt6Rq50GTGx2WTLsc4YiN
         qvKfZB4MQShmb7HdAuEfMwJ4ZB5XiXyCCPlKRyvs25MW8JRBuh2yh1H6gnyyN/94YtHh
         SI6zJGBeqgHbSS/LaUEH7owbMUdgl7EwgfMRC1l72SllTOOtIK+uQbECIr25y/bW+oK5
         J5mIQdkqTdRZHfZUuZy1TVtpcfcgIjBAYZQuofeCxLd9oUHiwwPmmCV/q4BGrKhU0AsV
         tgaVHaPMBvJdb00PgrIdIHLOsH9gj71UHEA3l/p5OykQfdmge5QGPhUxejqhBGhwrFk6
         M7Zg==
X-Gm-Message-State: AOAM532eP0py8ZDvnz1d36QbvHYo1JTH6QBNzbnaS4c9lSZoL9T/+jU6
        3iIjTNJHqAXpBEOjHq5hPseRUPwbICiByg==
X-Google-Smtp-Source: ABdhPJw/2FxG5Wd3nKHDnGyt+u6jP+QvS6DbbqYwSkUZVYQKaKL/S0lJHYitYwVQWBZg3cWu9iQO3w==
X-Received: by 2002:a17:902:e9d3:b0:158:8521:1e8f with SMTP id 19-20020a170902e9d300b0015885211e8fmr16482391plk.82.1650389524434;
        Tue, 19 Apr 2022 10:32:04 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:91ac:bc24:f886:dffc])
        by smtp.googlemail.com with ESMTPSA id q9-20020a638c49000000b00398677b6f25sm17266093pgn.70.2022.04.19.10.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 10:32:03 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     riteshh@linux.ibm.com, jack@suse.cz, tytso@mit.edu,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v3 2/6] ext4: for committing inode, make ext4_fc_track_inode wait
Date:   Tue, 19 Apr 2022 10:31:39 -0700
Message-Id: <20220419173143.3564144-3-harshads@google.com>
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
 fs/ext4/fast_commit.c | 38 ++++++++++++++++++++++++++++++++++++++
 fs/ext4/inline.c      |  3 +++
 fs/ext4/inode.c       |  5 ++++-
 3 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index c278060a15bc..55f4c5ddd8e5 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -574,8 +574,14 @@ static int __track_inode(struct inode *inode, void *arg, bool update)
 	return 0;
 }
 
+/*
+ * Track inode as part of the next fast commit. If the inode is being
+ * committed, this function will wait for the commit to finish.
+ */
 void ext4_fc_track_inode(handle_t *handle, struct inode *inode)
 {
+	struct ext4_inode_info *ei = EXT4_I(inode);
+	wait_queue_head_t *wq;
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	int ret;
 
@@ -595,6 +601,38 @@ void ext4_fc_track_inode(handle_t *handle, struct inode *inode)
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
index 9c076262770d..5d824d528f1c 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -586,6 +586,7 @@ static int ext4_convert_inline_data_to_extent(struct address_space *mapping,
 			goto out;
 	}
 
+	ext4_fc_track_inode(handle, inode);
 	ret = ext4_destroy_inline_data_nolock(handle, inode);
 	if (ret)
 		goto out;
@@ -686,6 +687,7 @@ int ext4_try_to_write_inline_data(struct address_space *mapping,
 		goto convert;
 	}
 
+	ext4_fc_track_inode(handle, inode);
 	ret = ext4_journal_get_write_access(handle, inode->i_sb, iloc.bh,
 					    EXT4_JTR_NONE);
 	if (ret)
@@ -967,6 +969,7 @@ int ext4_da_write_inline_data_begin(struct address_space *mapping,
 		if (ret < 0)
 			goto out_release_page;
 	}
+	ext4_fc_track_inode(handle, inode);
 	ret = ext4_journal_get_write_access(handle, inode->i_sb, iloc.bh,
 					    EXT4_JTR_NONE);
 	if (ret)
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 955dd978dccf..e88940251afd 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -622,6 +622,7 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 	 */
 	map->m_flags &= ~EXT4_MAP_FLAGS;
 
+	ext4_fc_track_inode(handle, inode);
 	/*
 	 * New blocks allocate and/or writing to unwritten extent
 	 * will possibly result in updating i_data, so we take
@@ -4058,7 +4059,7 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 
 	/* If there are blocks to remove, do it */
 	if (stop_block > first_block) {
-
+		ext4_fc_track_inode(handle, inode);
 		down_write(&EXT4_I(inode)->i_data_sem);
 		ext4_discard_preallocations(inode, 0);
 
@@ -4214,6 +4215,7 @@ int ext4_truncate(struct inode *inode)
 	if (err)
 		goto out_stop;
 
+	ext4_fc_track_inode(handle, inode);
 	down_write(&EXT4_I(inode)->i_data_sem);
 
 	ext4_discard_preallocations(inode, 0);
@@ -5734,6 +5736,7 @@ ext4_reserve_inode_write(handle_t *handle, struct inode *inode,
 			brelse(iloc->bh);
 			iloc->bh = NULL;
 		}
+		ext4_fc_track_inode(handle, inode);
 	}
 	ext4_std_error(inode->i_sb, err);
 	return err;
-- 
2.36.0.rc0.470.gd361397f0d-goog

