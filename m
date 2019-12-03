Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCA1F10FA71
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Dec 2019 10:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbfLCJG4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 3 Dec 2019 04:06:56 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:32966 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726086AbfLCJGz (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 3 Dec 2019 04:06:55 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A2D401B315D0F6C06F56;
        Tue,  3 Dec 2019 17:06:52 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Tue, 3 Dec 2019
 17:06:45 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <jack@suse.com>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <yi.zhang@huawei.com>, <liangyun2@huawei.com>,
        <luoshijie1@huawei.com>
Subject: [PATCH v2 2/4] ext4, jbd2: ensure panic when journal aborting with zero errno
Date:   Tue, 3 Dec 2019 17:27:54 +0800
Message-ID: <20191203092756.26129-3-yi.zhang@huawei.com>
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

JBD2_REC_ERR flag used to indicate the errno has been updated when jbd2
aborted, and then __ext4_abort() and ext4_handle_error() can invoke
panic if ERRORS_PANIC is specified. But if the journal has been aborted
with zero errno, jbd2_journal_abort() didn't set this flag so we can
no longer panic. Fix this by rename JBD2_REC_ERR to JBD2_ABORT_DONE and
set such flag even if there is no need to record errno in the jbd2 super
block.

Fixes: 4327ba52afd03 ("ext4, jbd2: ensure entering into panic after recording an error in superblock")
Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
---
 fs/ext4/super.c      |  4 ++--
 fs/jbd2/journal.c    | 10 +++++-----
 include/linux/jbd2.h |  3 ++-
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index dd654e53ba3d..25b0c883bd15 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -482,7 +482,7 @@ static void ext4_handle_error(struct super_block *sb)
 		sb->s_flags |= SB_RDONLY;
 	} else if (test_opt(sb, ERRORS_PANIC)) {
 		if (EXT4_SB(sb)->s_journal &&
-		  !(EXT4_SB(sb)->s_journal->j_flags & JBD2_REC_ERR))
+		  !(EXT4_SB(sb)->s_journal->j_flags & JBD2_ABORT_DONE))
 			return;
 		panic("EXT4-fs (device %s): panic forced after error\n",
 			sb->s_id);
@@ -701,7 +701,7 @@ void __ext4_abort(struct super_block *sb, const char *function,
 	}
 	if (test_opt(sb, ERRORS_PANIC) && !system_going_down()) {
 		if (EXT4_SB(sb)->s_journal &&
-		  !(EXT4_SB(sb)->s_journal->j_flags & JBD2_REC_ERR))
+		  !(EXT4_SB(sb)->s_journal->j_flags & JBD2_ABORT_DONE))
 			return;
 		panic("EXT4-fs panic from previous error\n");
 	}
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 1c58859aa592..a78b07841080 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -2118,12 +2118,12 @@ static void __journal_abort_soft (journal_t *journal, int errno)
 
 	__jbd2_journal_abort_hard(journal);
 
-	if (errno) {
+	if (errno)
 		jbd2_journal_update_sb_errno(journal);
-		write_lock(&journal->j_state_lock);
-		journal->j_flags |= JBD2_REC_ERR;
-		write_unlock(&journal->j_state_lock);
-	}
+
+	write_lock(&journal->j_state_lock);
+	journal->j_flags |= JBD2_ABORT_DONE;
+	write_unlock(&journal->j_state_lock);
 }
 
 /**
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 603fbc4e2f70..71cab887fb98 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1248,7 +1248,8 @@ JBD2_FEATURE_INCOMPAT_FUNCS(csum3,		CSUM_V3)
 #define JBD2_ABORT_ON_SYNCDATA_ERR	0x040	/* Abort the journal on file
 						 * data write error in ordered
 						 * mode */
-#define JBD2_REC_ERR	0x080	/* The errno in the sb has been recorded */
+#define JBD2_ABORT_DONE	0x080	/* Abort done, the errno in the sb has been
+				 * recorded if necessary */
 
 /*
  * Function declarations for the journaling transaction and buffer
-- 
2.17.2

