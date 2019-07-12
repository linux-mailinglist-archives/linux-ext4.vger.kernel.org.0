Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E441866763
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Jul 2019 09:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbfGLHC4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 12 Jul 2019 03:02:56 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:56008 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726078AbfGLHCz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 12 Jul 2019 03:02:55 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TWgXO5w_1562914972;
Received: from localhost(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0TWgXO5w_1562914972)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 12 Jul 2019 15:02:53 +0800
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     Theodore Ts'o <tytso@mit.edu>, Ross Zwisler <zwisler@chromium.org>,
        linux-ext4@vger.kernel.org, ocfs2-devel@oss.oracle.com
Subject: [PATCH 2/2] jbd2: remove jbd2_journal_inode_add_[write|wait]
Date:   Fri, 12 Jul 2019 15:02:52 +0800
Message-Id: <1562914972-97318-2-git-send-email-joseph.qi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1562914972-97318-1-git-send-email-joseph.qi@linux.alibaba.com>
References: <1562914972-97318-1-git-send-email-joseph.qi@linux.alibaba.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Since ext4/ocfs2 are using jbd2_inode dirty range scoping APIs now,
jbd2_journal_inode_add_[write|wait] are not used any more, remove them.

Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
---
 fs/jbd2/journal.c     |  2 --
 fs/jbd2/transaction.c | 12 ------------
 include/linux/jbd2.h  |  2 --
 3 files changed, 16 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 953990e..1c58859 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -89,8 +89,6 @@
 EXPORT_SYMBOL(jbd2_journal_invalidatepage);
 EXPORT_SYMBOL(jbd2_journal_try_to_free_buffers);
 EXPORT_SYMBOL(jbd2_journal_force_commit);
-EXPORT_SYMBOL(jbd2_journal_inode_add_write);
-EXPORT_SYMBOL(jbd2_journal_inode_add_wait);
 EXPORT_SYMBOL(jbd2_journal_inode_ranged_write);
 EXPORT_SYMBOL(jbd2_journal_inode_ranged_wait);
 EXPORT_SYMBOL(jbd2_journal_init_jbd_inode);
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 990e7b5..9bf793d 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -2619,18 +2619,6 @@ static int jbd2_journal_file_inode(handle_t *handle, struct jbd2_inode *jinode,
 	return 0;
 }
 
-int jbd2_journal_inode_add_write(handle_t *handle, struct jbd2_inode *jinode)
-{
-	return jbd2_journal_file_inode(handle, jinode,
-			JI_WRITE_DATA | JI_WAIT_DATA, 0, LLONG_MAX);
-}
-
-int jbd2_journal_inode_add_wait(handle_t *handle, struct jbd2_inode *jinode)
-{
-	return jbd2_journal_file_inode(handle, jinode, JI_WAIT_DATA, 0,
-			LLONG_MAX);
-}
-
 int jbd2_journal_inode_ranged_write(handle_t *handle,
 		struct jbd2_inode *jinode, loff_t start_byte, loff_t length)
 {
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index df03825..603fbc4 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1410,8 +1410,6 @@ extern int	   jbd2_journal_update_sb_log_tail	(journal_t *, tid_t,
 extern int	   jbd2_journal_bmap(journal_t *, unsigned long, unsigned long long *);
 extern int	   jbd2_journal_force_commit(journal_t *);
 extern int	   jbd2_journal_force_commit_nested(journal_t *);
-extern int	   jbd2_journal_inode_add_write(handle_t *handle, struct jbd2_inode *inode);
-extern int	   jbd2_journal_inode_add_wait(handle_t *handle, struct jbd2_inode *inode);
 extern int	   jbd2_journal_inode_ranged_write(handle_t *handle,
 			struct jbd2_inode *inode, loff_t start_byte,
 			loff_t length);
-- 
1.8.3.1

