Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9E06264F0D
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Sep 2020 21:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgIJTdn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Sep 2020 15:33:43 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43010 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727977AbgIJTbk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Sep 2020 15:31:40 -0400
Received: from mail-qv1-f70.google.com ([209.85.219.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mfo@canonical.com>)
        id 1kGSID-0000jI-Li
        for linux-ext4@vger.kernel.org; Thu, 10 Sep 2020 19:31:37 +0000
Received: by mail-qv1-f70.google.com with SMTP id j5so3916386qvb.16
        for <linux-ext4@vger.kernel.org>; Thu, 10 Sep 2020 12:31:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qAGZ3zwaYkfZjWHevep26DeFrC83Znglqf4joWJDHuE=;
        b=bZpXzbF0KaBUJy4KJakKVFneGCXkkSYrQnbdmkGo6Av8GzJrL9H1BEtL2rHM33b2YY
         OFl35L3CMmfQNhqxdTxL8uKMIPvjL3dY+WqxJ7udqOWaVBjhAOrkAyU3cxhZ4GLVoRt1
         xeIrbo09ZDoqhAMB3Fv9PbNE6U5MqfoPRIDMoW4rc8y+nH1YFE2yMhWH0hsDBgzqZH07
         9msYLVvE3a1o07iG30aECjnUIfYf/Xlnk9NsfXnOXJnNUcOoRxxaveGg5kEB1ncwm5AA
         CGKm/kZv5cbAauB/KT7J2KFu7SWUusaABjDDRe++Ukd69Ynfc4+6cU5DVZvgqq/m90FU
         ERbA==
X-Gm-Message-State: AOAM532bMu12XgzrscqckNdNKiQTy3yUx3JW/FUB+SMksbyGtFzfYzM1
        R6oxX20D//O3u5F47A6TA5ztw9JNJUxAVpFIzmP/xn2ZLFsL7HgNql3pMCqcPxkQas9qv67M0VO
        9yIpfNtJVI5dhaS3LAvaiWJ3rq3EllAW/fPiDx0A=
X-Received: by 2002:a0c:c58d:: with SMTP id a13mr3744217qvj.113.1599766296458;
        Thu, 10 Sep 2020 12:31:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyNQu5/K0I6VC6pQFpz0YonYa7QFmOdaeE+XTXxNmgy3gGh1cPn345LfvS9vbX5hCMwkYzFXw==
X-Received: by 2002:a0c:c58d:: with SMTP id a13mr3744196qvj.113.1599766296194;
        Thu, 10 Sep 2020 12:31:36 -0700 (PDT)
Received: from localhost.localdomain ([201.82.49.101])
        by smtp.gmail.com with ESMTPSA id u4sm6410391qkk.68.2020.09.10.12.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 12:31:35 -0700 (PDT)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org,
        dann frazier <dann.frazier@canonical.com>,
        Mauricio Faria de Oliveira <mauricio.foliveira@gmail.com>
Subject: [RFC PATCH v3 2/3] jbd2, ext4, ocfs2: introduce/use journal callbacks j_submit|finish_inode_data_buffers()
Date:   Thu, 10 Sep 2020 16:31:26 -0300
Message-Id: <20200910193127.276214-3-mfo@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910193127.276214-1-mfo@canonical.com>
References: <20200910193127.276214-1-mfo@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Introduce journal callbacks to allow different behaviors
for an inode in journal_submit|finish_inode_data_buffers().

The existing users of the current behavior (ext4, ocfs2)
are adapted to use the previously exported functions
that implement the current behavior.

Users are callers of jbd2_journal_inode_ranged_write|wait(),
which adds the inode to the transaction's inode list with
the JI_WRITE|WAIT_DATA flags. Only ext4 and ocfs2 in-tree.

Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
Suggested-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/super.c      | 14 ++++++++++++++
 fs/jbd2/commit.c     | 30 ++++++++++++++++++------------
 fs/ocfs2/super.c     | 15 +++++++++++++++
 include/linux/jbd2.h | 25 ++++++++++++++++++++++++-
 4 files changed, 71 insertions(+), 13 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index ea425b49b345..7303839d7ad9 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -472,6 +472,16 @@ static void ext4_journal_commit_callback(journal_t *journal, transaction_t *txn)
 	spin_unlock(&sbi->s_md_lock);
 }
 
+static int ext4_journal_submit_inode_data_buffers(struct jbd2_inode *jinode)
+{
+	return jbd2_journal_submit_inode_data_buffers(jinode);
+}
+
+static int ext4_journal_finish_inode_data_buffers(struct jbd2_inode *jinode)
+{
+	return jbd2_journal_finish_inode_data_buffers(jinode);
+}
+
 static bool system_going_down(void)
 {
 	return system_state == SYSTEM_HALT || system_state == SYSTEM_POWER_OFF
@@ -4646,6 +4656,10 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	set_task_ioprio(sbi->s_journal->j_task, journal_ioprio);
 
 	sbi->s_journal->j_commit_callback = ext4_journal_commit_callback;
+	sbi->s_journal->j_submit_inode_data_buffers =
+		ext4_journal_submit_inode_data_buffers;
+	sbi->s_journal->j_finish_inode_data_buffers =
+		ext4_journal_finish_inode_data_buffers;
 
 no_journal:
 	if (!test_opt(sb, NO_MBCACHE)) {
diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index c17cda96926e..23d3fcc11b97 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -200,6 +200,12 @@ int jbd2_journal_submit_inode_data_buffers(struct jbd2_inode *jinode)
 		.range_end = dirty_end,
 	};
 
+	/*
+	 * submit the inode data buffers. We use writepage
+	 * instead of writepages. Because writepages can do
+	 * block allocation with delalloc. We need to write
+	 * only allocated blocks here.
+	 */
 	ret = generic_writepages(mapping, &wbc);
 	return ret;
 }
@@ -224,16 +230,13 @@ static int journal_submit_data_buffers(journal_t *journal,
 			continue;
 		jinode->i_flags |= JI_COMMIT_RUNNING;
 		spin_unlock(&journal->j_list_lock);
-		/*
-		 * submit the inode data buffers. We use writepage
-		 * instead of writepages. Because writepages can do
-		 * block allocation  with delalloc. We need to write
-		 * only allocated blocks here.
-		 */
+		/* submit the inode data buffers. */
 		trace_jbd2_submit_inode_data(jinode->i_vfs_inode);
-		err = jbd2_journal_submit_inode_data_buffers(jinode);
-		if (!ret)
-			ret = err;
+		if (journal->j_submit_inode_data_buffers) {
+			err = journal->j_submit_inode_data_buffers(jinode);
+			if (!ret)
+				ret = err;
+		}
 		spin_lock(&journal->j_list_lock);
 		J_ASSERT(jinode->i_transaction == commit_transaction);
 		jinode->i_flags &= ~JI_COMMIT_RUNNING;
@@ -273,9 +276,12 @@ static int journal_finish_inode_data_buffers(journal_t *journal,
 			continue;
 		jinode->i_flags |= JI_COMMIT_RUNNING;
 		spin_unlock(&journal->j_list_lock);
-		err = jbd2_journal_finish_inode_data_buffers(jinode);
-		if (!ret)
-			ret = err;
+		/* wait for the inode data buffers writeout. */
+		if (journal->j_finish_inode_data_buffers) {
+			err = journal->j_finish_inode_data_buffers(jinode);
+			if (!ret)
+				ret = err;
+		}
 		spin_lock(&journal->j_list_lock);
 		jinode->i_flags &= ~JI_COMMIT_RUNNING;
 		smp_mb();
diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index 1d91dd1e8711..f4e62aafc89c 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -2010,6 +2010,16 @@ static int ocfs2_journal_addressable(struct ocfs2_super *osb)
 	return status;
 }
 
+static int ocfs2_journal_submit_inode_data_buffers(struct jbd2_inode *jinode)
+{
+	return jbd2_journal_submit_inode_data_buffers(jinode);
+}
+
+static int ocfs2_journal_finish_inode_data_buffers(struct jbd2_inode *jinode)
+{
+	return jbd2_journal_finish_inode_data_buffers(jinode);
+}
+
 static int ocfs2_initialize_super(struct super_block *sb,
 				  struct buffer_head *bh,
 				  int sector_size,
@@ -2211,6 +2221,11 @@ static int ocfs2_initialize_super(struct super_block *sb,
 	}
 	osb->journal = journal;
 	journal->j_osb = osb;
+	journal->j_journal->j_submit_inode_data_buffers =
+		ocfs2_journal_submit_inode_data_buffers;
+	journal->j_journal->j_finish_inode_data_buffers =
+		ocfs2_journal_finish_inode_data_buffers;
+
 
 	atomic_set(&journal->j_num_trans, 0);
 	init_rwsem(&journal->j_trans_barrier);
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 2865a5475888..4aaa408c0ca7 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -629,7 +629,9 @@ struct transaction_s
 	struct journal_head	*t_shadow_list;
 
 	/*
-	 * List of inodes whose data we've modified in data=ordered mode.
+	 * List of inodes associated with the transaction; e.g., ext4 uses
+	 * this to track inodes in data=ordered and data=journal mode that
+	 * need special handling on transaction commit; also used by ocfs2.
 	 * [j_list_lock]
 	 */
 	struct list_head	t_inode_list;
@@ -1111,6 +1113,27 @@ struct journal_s
 	void			(*j_commit_callback)(journal_t *,
 						     transaction_t *);
 
+	/**
+	 * @j_submit_inode_data_buffers:
+	 *
+	 * This function is called for all inodes associated with the
+	 * committing transaction marked with JI_WRITE_DATA flag
+	 * before we start to write out the transaction to the journal.
+	 */
+	int			(*j_submit_inode_data_buffers)
+					(struct jbd2_inode *);
+
+	/**
+	 * @j_finish_inode_data_buffers:
+	 *
+	 * This function is called for all inodes associated with the
+	 * committing transaction marked with JI_WAIT_DATA flag
+	 * after we have written the transaction to the journal
+	 * but before we write out the commit block.
+	 */
+	int			(*j_finish_inode_data_buffers)
+					(struct jbd2_inode *);
+
 	/*
 	 * Journal statistics
 	 */
-- 
2.17.1

