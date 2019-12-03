Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5FB110FA70
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Dec 2019 10:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbfLCJGz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 3 Dec 2019 04:06:55 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:32976 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725954AbfLCJGy (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 3 Dec 2019 04:06:54 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A7D0FD1BEC34D5C3C84C;
        Tue,  3 Dec 2019 17:06:52 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Tue, 3 Dec 2019
 17:06:46 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <jack@suse.com>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <yi.zhang@huawei.com>, <liangyun2@huawei.com>,
        <luoshijie1@huawei.com>
Subject: [PATCH v2 3/4] Partially revert "ext4: pass -ESHUTDOWN code to jbd2 layer"
Date:   Tue, 3 Dec 2019 17:27:55 +0800
Message-ID: <20191203092756.26129-4-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191203092756.26129-1-yi.zhang@huawei.com>
References: <20191203092756.26129-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This partially reverts commit fb7c02445c497943e7296cd3deee04422b63acb8.

Commit fb7c02445c49 ("ext4: pass -ESHUTDOWN code to jbd2 layer") want to
allow jbd2 layer to distinguish shutdown journal abort from other error
cases, but this patch seems unnecessary because we distinguished those
cases well through a zero errno parameter when shutting down, thus the
jbd2 aborting peocess will not record the errno. So partially reverts
this commit and keep the proper locking.

Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
---
 fs/ext4/ioctl.c   |  4 ++--
 fs/jbd2/journal.c | 22 +++++++---------------
 2 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 0b7f316fd30f..f99eeba5767d 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -597,13 +597,13 @@ static int ext4_shutdown(struct super_block *sb, unsigned long arg)
 		set_bit(EXT4_FLAGS_SHUTDOWN, &sbi->s_ext4_flags);
 		if (sbi->s_journal && !is_journal_aborted(sbi->s_journal)) {
 			(void) ext4_force_commit(sb);
-			jbd2_journal_abort(sbi->s_journal, -ESHUTDOWN);
+			jbd2_journal_abort(sbi->s_journal, 0);
 		}
 		break;
 	case EXT4_GOING_FLAGS_NOLOGFLUSH:
 		set_bit(EXT4_FLAGS_SHUTDOWN, &sbi->s_ext4_flags);
 		if (sbi->s_journal && !is_journal_aborted(sbi->s_journal))
-			jbd2_journal_abort(sbi->s_journal, -ESHUTDOWN);
+			jbd2_journal_abort(sbi->s_journal, 0);
 		break;
 	default:
 		return -EINVAL;
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index a78b07841080..f3f9e0b994ef 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1475,14 +1475,11 @@ static void jbd2_mark_journal_empty(journal_t *journal, int write_op)
 void jbd2_journal_update_sb_errno(journal_t *journal)
 {
 	journal_superblock_t *sb = journal->j_superblock;
-	int errcode;
 
 	lock_buffer(journal->j_sb_buffer);
-	errcode = journal->j_errno;
-	if (errcode == -ESHUTDOWN)
-		errcode = 0;
-	jbd_debug(1, "JBD2: updating superblock error (errno %d)\n", errcode);
-	sb->s_errno    = cpu_to_be32(errcode);
+	jbd_debug(1, "JBD2: updating superblock error (errno %d)\n",
+		  journal->j_errno);
+	sb->s_errno = cpu_to_be32(journal->j_errno);
 
 	jbd2_write_superblock(journal, REQ_SYNC | REQ_FUA);
 }
@@ -2100,20 +2097,15 @@ void __jbd2_journal_abort_hard(journal_t *journal)
  * but don't do any other IO. */
 static void __journal_abort_soft (journal_t *journal, int errno)
 {
-	int old_errno;
-
 	write_lock(&journal->j_state_lock);
-	old_errno = journal->j_errno;
-	if (!journal->j_errno || errno == -ESHUTDOWN)
-		journal->j_errno = errno;
-
 	if (journal->j_flags & JBD2_ABORT) {
 		write_unlock(&journal->j_state_lock);
-		if (!old_errno && old_errno != -ESHUTDOWN &&
-		    errno == -ESHUTDOWN)
-			jbd2_journal_update_sb_errno(journal);
 		return;
 	}
+
+	if (!journal->j_errno)
+		journal->j_errno = errno;
+
 	write_unlock(&journal->j_state_lock);
 
 	__jbd2_journal_abort_hard(journal);
-- 
2.17.2

