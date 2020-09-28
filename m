Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6D9B27B585
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Sep 2020 21:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgI1TlR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 28 Sep 2020 15:41:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38911 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgI1TlQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 28 Sep 2020 15:41:16 -0400
Received: from mail-qk1-f197.google.com ([209.85.222.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mfo@canonical.com>)
        id 1kMz1N-00029r-JS
        for linux-ext4@vger.kernel.org; Mon, 28 Sep 2020 19:41:13 +0000
Received: by mail-qk1-f197.google.com with SMTP id 125so1291222qkh.4
        for <linux-ext4@vger.kernel.org>; Mon, 28 Sep 2020 12:41:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dsydCJbpZJgqvBtcGppNpwTpopS5m5EZ8lb0YworUAo=;
        b=ktUFQPKK4IYzKMXbzH8JyM+p6nwE+EV6H0wVINzoRaiEepyzWdh2NFmeNnB7t3r8V7
         t2zNaFnDfcAAlWlK9bTl/rVxMmG2Xb9XI9xh3NFxpBqwQ4yzqs4i5G7vcNYjMnXuPGex
         tQRjK6qtzr87SEe6Ew7RfRJQSmSwtF+IpZ4KRcfR0cVTkKKHMtjDawRwhqV0n7mkAvCa
         K7zQVoaAhlbwYkQpZUnAce0H0R8GDzIj+m/8zvLBWO26QaQnQoR6Dvhx5vvLeR9AFEYu
         1d2q1wkypZgAgNzfZdS3S7KR3BL/Ot+gGXrxP9hGaEfz9vDuv78TeCQtKsZCdqsk6yv9
         ybcQ==
X-Gm-Message-State: AOAM530cFrGfo1h0okLrj5+8BNFHDdT8wF8HXBeWz4GVmQ7YDSaqYUFN
        eOPRnIPEgps9mmIm730TcNjnAA+p2lTWROj1fDfK8Gk0GTIYslBHtZ+bixwdwKIzDhPHCziA1lI
        NFa9aW2SWsCxgUFXxmR1jo/Pl06381b1EgFgEC2Q=
X-Received: by 2002:ae9:ed91:: with SMTP id c139mr1081006qkg.7.1601322072484;
        Mon, 28 Sep 2020 12:41:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxcfLi6jhUPURp8r0Tp4lb41+Zeuc3kAsh73J///xcd1sHBns132iNahHxfkZr+jgR1XQGumw==
X-Received: by 2002:ae9:ed91:: with SMTP id c139mr1080980qkg.7.1601322072140;
        Mon, 28 Sep 2020 12:41:12 -0700 (PDT)
Received: from localhost.localdomain ([201.82.49.101])
        by smtp.gmail.com with ESMTPSA id u15sm2360222qtj.3.2020.09.28.12.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 12:41:11 -0700 (PDT)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org,
        dann frazier <dann.frazier@canonical.com>
Subject: [RFC PATCH v4 2/4] jbd2, ext4, ocfs2: introduce/use journal callbacks j_submit|finish_inode_data_buffers()
Date:   Mon, 28 Sep 2020 16:41:01 -0300
Message-Id: <20200928194103.244692-3-mfo@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200928194103.244692-1-mfo@canonical.com>
References: <20200928194103.244692-1-mfo@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Both CONFIG_EXT4_FS and CONFIG_OCSFS2_FS select CONFIG_JBD2,
which builds fs/jbd2/commit.c and journal.c that define and
export the functions, so we can call directly in ext4/ocfs2.

Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
Suggested-by: Jan Kara <jack@suse.cz>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/super.c      |  4 ++++
 fs/jbd2/commit.c     | 30 ++++++++++++++++++------------
 fs/ocfs2/super.c     |  5 +++++
 include/linux/jbd2.h | 25 ++++++++++++++++++++++++-
 4 files changed, 51 insertions(+), 13 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index ea425b49b345..a14c1ed39aa3 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4646,6 +4646,10 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	set_task_ioprio(sbi->s_journal->j_task, journal_ioprio);
 
 	sbi->s_journal->j_commit_callback = ext4_journal_commit_callback;
+	sbi->s_journal->j_submit_inode_data_buffers =
+		jbd2_journal_submit_inode_data_buffers;
+	sbi->s_journal->j_finish_inode_data_buffers =
+		jbd2_journal_finish_inode_data_buffers;
 
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
index 1d91dd1e8711..560f13d4e2aa 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -2211,6 +2211,11 @@ static int ocfs2_initialize_super(struct super_block *sb,
 	}
 	osb->journal = journal;
 	journal->j_osb = osb;
+	journal->j_journal->j_submit_inode_data_buffers =
+		jbd2_journal_submit_inode_data_buffers;
+	journal->j_journal->j_finish_inode_data_buffers =
+		jbd2_journal_finish_inode_data_buffers;
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

