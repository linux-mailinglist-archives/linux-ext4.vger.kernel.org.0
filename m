Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55F7327B584
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Sep 2020 21:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgI1TlP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 28 Sep 2020 15:41:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38907 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgI1TlO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 28 Sep 2020 15:41:14 -0400
Received: from mail-qk1-f200.google.com ([209.85.222.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mfo@canonical.com>)
        id 1kMz1L-00029M-G3
        for linux-ext4@vger.kernel.org; Mon, 28 Sep 2020 19:41:11 +0000
Received: by mail-qk1-f200.google.com with SMTP id w64so1278709qkc.14
        for <linux-ext4@vger.kernel.org>; Mon, 28 Sep 2020 12:41:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VRC6uFJa1v8Fej+10IywOo/zW3EV6qwHE1HatZ5a/9o=;
        b=D4OkumUD1/8lTFVcDLqHa4kCa44iz2RfZqubfARXaTRv9Fr10RGY3TvGybNg0FIYO+
         c+ovOQKl79puu+7GlFx1KYtyT0zv6PYy4F6y3D5b9bpxNkQ/hw0GtYwwbdA41HPFE7LB
         S4zuBndufqEYJtsvlBHSGTivDXoH++NuNpq1L9qZpy5pDOSDlvCmax9FQ4PejpEl4Sk1
         vm61ozt/pCCjTiDNGW1tKSA0SejUOzHe8y1Z0qFsg24us9ywPdO7Z+NTmfqFQXSmKfns
         opCyCDjrmrwJw+MldyhH0ZbVrLKsTzGJdC9w+JvpD5sA++u18ezTEop4UCG96ujnmtXn
         8CDA==
X-Gm-Message-State: AOAM531Rl3zxvIMLDwh+6QIuHc7RNhK9RmvaUjqrenpw75AgPaR+4yhZ
        8r2zpjrEMWXEoZPkO8WJBM5L24/5piz8yp8FG0W8gzjpnX0rrT6c+eHkKi1HNctQduSlPNdX7gB
        EuqTj4hDwIWhxW7dY9z3b/mfdNnaYFQjURIbXljw=
X-Received: by 2002:a05:620a:15f6:: with SMTP id p22mr1107349qkm.198.1601322070377;
        Mon, 28 Sep 2020 12:41:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyUkO8HAXQPZJp4JldR/iFSvoh9ZAMJmIHkknsv/GFMjziGcuK/gfbz13OZoS/gjSefOxqKfw==
X-Received: by 2002:a05:620a:15f6:: with SMTP id p22mr1107317qkm.198.1601322070108;
        Mon, 28 Sep 2020 12:41:10 -0700 (PDT)
Received: from localhost.localdomain ([201.82.49.101])
        by smtp.gmail.com with ESMTPSA id u15sm2360222qtj.3.2020.09.28.12.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 12:41:09 -0700 (PDT)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org,
        dann frazier <dann.frazier@canonical.com>
Subject: [RFC PATCH v4 1/4] jbd2: introduce/export functions jbd2_journal_submit|finish_inode_data_buffers()
Date:   Mon, 28 Sep 2020 16:41:00 -0300
Message-Id: <20200928194103.244692-2-mfo@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200928194103.244692-1-mfo@canonical.com>
References: <20200928194103.244692-1-mfo@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Export functions that implement the current behavior done
for an inode in journal_submit|finish_inode_data_buffers().

No functional change.

Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
Suggested-by: Jan Kara <jack@suse.cz>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/commit.c     | 32 +++++++++++++++++---------------
 fs/jbd2/journal.c    |  2 ++
 include/linux/jbd2.h |  4 ++++
 3 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 6d2da8ad0e6f..c17cda96926e 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -187,9 +187,11 @@ static int journal_wait_on_commit_record(journal_t *journal,
  * use writepages() because with delayed allocation we may be doing
  * block allocation in writepages().
  */
-static int journal_submit_inode_data_buffers(struct address_space *mapping,
-		loff_t dirty_start, loff_t dirty_end)
+int jbd2_journal_submit_inode_data_buffers(struct jbd2_inode *jinode)
 {
+	struct address_space *mapping = jinode->i_vfs_inode->i_mapping;
+	loff_t dirty_start = jinode->i_dirty_start;
+	loff_t dirty_end = jinode->i_dirty_end;
 	int ret;
 	struct writeback_control wbc = {
 		.sync_mode =  WB_SYNC_ALL,
@@ -215,16 +217,11 @@ static int journal_submit_data_buffers(journal_t *journal,
 {
 	struct jbd2_inode *jinode;
 	int err, ret = 0;
-	struct address_space *mapping;
 
 	spin_lock(&journal->j_list_lock);
 	list_for_each_entry(jinode, &commit_transaction->t_inode_list, i_list) {
-		loff_t dirty_start = jinode->i_dirty_start;
-		loff_t dirty_end = jinode->i_dirty_end;
-
 		if (!(jinode->i_flags & JI_WRITE_DATA))
 			continue;
-		mapping = jinode->i_vfs_inode->i_mapping;
 		jinode->i_flags |= JI_COMMIT_RUNNING;
 		spin_unlock(&journal->j_list_lock);
 		/*
@@ -234,8 +231,7 @@ static int journal_submit_data_buffers(journal_t *journal,
 		 * only allocated blocks here.
 		 */
 		trace_jbd2_submit_inode_data(jinode->i_vfs_inode);
-		err = journal_submit_inode_data_buffers(mapping, dirty_start,
-				dirty_end);
+		err = jbd2_journal_submit_inode_data_buffers(jinode);
 		if (!ret)
 			ret = err;
 		spin_lock(&journal->j_list_lock);
@@ -248,6 +244,17 @@ static int journal_submit_data_buffers(journal_t *journal,
 	return ret;
 }
 
+int jbd2_journal_finish_inode_data_buffers(struct jbd2_inode *jinode)
+{
+	struct address_space *mapping = jinode->i_vfs_inode->i_mapping;
+	loff_t dirty_start = jinode->i_dirty_start;
+	loff_t dirty_end = jinode->i_dirty_end;
+	int ret;
+
+	ret = filemap_fdatawait_range_keep_errors(mapping, dirty_start, dirty_end);
+	return ret;
+}
+
 /*
  * Wait for data submitted for writeout, refile inodes to proper
  * transaction if needed.
@@ -262,16 +269,11 @@ static int journal_finish_inode_data_buffers(journal_t *journal,
 	/* For locking, see the comment in journal_submit_data_buffers() */
 	spin_lock(&journal->j_list_lock);
 	list_for_each_entry(jinode, &commit_transaction->t_inode_list, i_list) {
-		loff_t dirty_start = jinode->i_dirty_start;
-		loff_t dirty_end = jinode->i_dirty_end;
-
 		if (!(jinode->i_flags & JI_WAIT_DATA))
 			continue;
 		jinode->i_flags |= JI_COMMIT_RUNNING;
 		spin_unlock(&journal->j_list_lock);
-		err = filemap_fdatawait_range_keep_errors(
-				jinode->i_vfs_inode->i_mapping, dirty_start,
-				dirty_end);
+		err = jbd2_journal_finish_inode_data_buffers(jinode);
 		if (!ret)
 			ret = err;
 		spin_lock(&journal->j_list_lock);
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 17fdc482f554..c0600405e7a2 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -91,6 +91,8 @@ EXPORT_SYMBOL(jbd2_journal_try_to_free_buffers);
 EXPORT_SYMBOL(jbd2_journal_force_commit);
 EXPORT_SYMBOL(jbd2_journal_inode_ranged_write);
 EXPORT_SYMBOL(jbd2_journal_inode_ranged_wait);
+EXPORT_SYMBOL(jbd2_journal_submit_inode_data_buffers);
+EXPORT_SYMBOL(jbd2_journal_finish_inode_data_buffers);
 EXPORT_SYMBOL(jbd2_journal_init_jbd_inode);
 EXPORT_SYMBOL(jbd2_journal_release_jbd_inode);
 EXPORT_SYMBOL(jbd2_journal_begin_ordered_truncate);
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 08f904943ab2..2865a5475888 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1421,6 +1421,10 @@ extern int	   jbd2_journal_inode_ranged_write(handle_t *handle,
 extern int	   jbd2_journal_inode_ranged_wait(handle_t *handle,
 			struct jbd2_inode *inode, loff_t start_byte,
 			loff_t length);
+extern int	   jbd2_journal_submit_inode_data_buffers(
+			struct jbd2_inode *jinode);
+extern int	   jbd2_journal_finish_inode_data_buffers(
+			struct jbd2_inode *jinode);
 extern int	   jbd2_journal_begin_ordered_truncate(journal_t *journal,
 				struct jbd2_inode *inode, loff_t new_size);
 extern void	   jbd2_journal_init_jbd_inode(struct jbd2_inode *jinode, struct inode *inode);
-- 
2.17.1

