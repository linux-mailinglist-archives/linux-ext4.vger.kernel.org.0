Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A57C028437F
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Oct 2020 02:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgJFAs7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Oct 2020 20:48:59 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56640 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgJFAs7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Oct 2020 20:48:59 -0400
Received: from mail-qk1-f198.google.com ([209.85.222.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mfo@canonical.com>)
        id 1kPbA0-0004Vj-HG
        for linux-ext4@vger.kernel.org; Tue, 06 Oct 2020 00:48:56 +0000
Received: by mail-qk1-f198.google.com with SMTP id w189so257960qkd.6
        for <linux-ext4@vger.kernel.org>; Mon, 05 Oct 2020 17:48:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5wW6u9KhIdzkZL6+0fxNb+/kiqeWxLKg1rVDMYJmums=;
        b=WX2D+8gsEVogI7XSLiXihbh9kl2hAOzT2m1MH2aH8VWTOrOgHFYlRI4QzJoYK9z+vx
         5fEvXedYtgrKLxxDsajkXDSjcKXZnx45j9DkQ/LqcL+U+f0QysqzCk1J91hiPGiqL6Iu
         lKN+E2pGzCao9WnT3xHhoSAjz6LNsqg1mE1Q9PKoHkbjZc5QWX3KyEEKNL9Z2iW2bZQa
         t3lBq715rK0Haivvu7QijqIYWhk9kSqeyrMHFufJdnxhDzJJ27u+VJ5nNIgdCtfPyDqA
         YO4Di9WHlzP1SASi95lyFic+SnyOjtIoOMKim4O5bfXobtaiccE3AegUO98BhcckiI/e
         FltA==
X-Gm-Message-State: AOAM531L0keQW7AIvmnm1QLGREXD+wFqpkr2+NkrD5bi4gxdPB2XGA7g
        4XRYF/uGmke+4IOAianiggAAn/gaEwyDNKbRl9Odh4wpZgQ7ztPp+PbNLwWGoQY5Ueb+VF18BvW
        qoAhQGUY/Dkv1rLwN1ex3dZBf65V9OEwSqxbewCU=
X-Received: by 2002:ac8:3ac4:: with SMTP id x62mr2729800qte.279.1601945335337;
        Mon, 05 Oct 2020 17:48:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwdMucG6vaINfiXNjEeZJAfO7IqGRJS5/76sQsYvjr0lPJUqN2NbG71SIOSUfr0cDWO8hqllw==
X-Received: by 2002:ac8:3ac4:: with SMTP id x62mr2729781qte.279.1601945335088;
        Mon, 05 Oct 2020 17:48:55 -0700 (PDT)
Received: from localhost.localdomain ([201.82.49.101])
        by smtp.gmail.com with ESMTPSA id l125sm1355322qke.23.2020.10.05.17.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 17:48:54 -0700 (PDT)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     linux-ext4@vger.kernel.org, ocfs2-devel@oss.oracle.com
Cc:     Jan Kara <jack@suse.cz>, Andreas Dilger <adilger@dilger.ca>,
        dann frazier <dann.frazier@canonical.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: [PATCH v5 2/4] jbd2, ext4, ocfs2: introduce/use journal callbacks j_submit|finish_inode_data_buffers()
Date:   Mon,  5 Oct 2020 21:48:39 -0300
Message-Id: <20201006004841.600488-3-mfo@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201006004841.600488-1-mfo@canonical.com>
References: <20201006004841.600488-1-mfo@canonical.com>
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
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
---
 fs/ext4/super.c      |  4 ++++
 fs/jbd2/commit.c     | 30 ++++++++++++++++++------------
 fs/ocfs2/journal.c   |  4 ++++
 include/linux/jbd2.h | 25 ++++++++++++++++++++++++-
 4 files changed, 50 insertions(+), 13 deletions(-)

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
index f79b86b4241f..6252b4c50666 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -197,6 +197,12 @@ int jbd2_journal_submit_inode_data_buffers(struct jbd2_inode *jinode)
 		.range_end = jinode->i_dirty_end,
 	};
 
+	/*
+	 * submit the inode data buffers. We use writepage
+	 * instead of writepages. Because writepages can do
+	 * block allocation with delalloc. We need to write
+	 * only allocated blocks here.
+	 */
 	return generic_writepages(mapping, &wbc);
 }
 
@@ -220,16 +226,13 @@ static int journal_submit_data_buffers(journal_t *journal,
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
@@ -267,9 +270,12 @@ static int journal_finish_inode_data_buffers(journal_t *journal,
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
diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
index b425f0b01dce..b9a9d69dde7e 100644
--- a/fs/ocfs2/journal.c
+++ b/fs/ocfs2/journal.c
@@ -883,6 +883,10 @@ int ocfs2_journal_init(struct ocfs2_journal *journal, int *dirty)
 		  OCFS2_JOURNAL_DIRTY_FL);
 
 	journal->j_journal = j_journal;
+	journal->j_journal->j_submit_inode_data_buffers =
+		jbd2_journal_submit_inode_data_buffers;
+	journal->j_journal->j_finish_inode_data_buffers =
+		jbd2_journal_finish_inode_data_buffers;
 	journal->j_inode = inode;
 	journal->j_bh = bh;
 
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

