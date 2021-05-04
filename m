Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6746E372E26
	for <lists+linux-ext4@lfdr.de>; Tue,  4 May 2021 18:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbhEDQgt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 May 2021 12:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbhEDQgs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 May 2021 12:36:48 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D79C061574
        for <linux-ext4@vger.kernel.org>; Tue,  4 May 2021 09:35:53 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id k124so5075196vsk.3
        for <linux-ext4@vger.kernel.org>; Tue, 04 May 2021 09:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TOFU2+jRoOeADfaM4OUnr2BLewURnWVkHOdGuQEUre4=;
        b=I28qyF64OnaMJ8hyPUezcs+/cpXt5w8ILbfTQrYnt6doTFnOxKPHcmjbd+u7y7xIV+
         zUes45DPrbksTPTVNJFdk2cS16k/TYJdpVXN1exBl4YzpSSEVVXDL5o8hGHjRLzFew+b
         XiZ0JM6XZ22rBKQlflTtJkw/d/U9uHSqepeiNokLDcuvVM+lCnC6/V2qi8Afh/WZN8EM
         wJ2wQHTXczvvzMm4SGvx3wBaitgRopOyUkTucgj2KSqHf0sYvviKZCP+aWS2WFm9nO+J
         YpgAE3pVal9szL50mRdEEMN0IN7G1q93ZLv5aNVA13f4/0lFy4xRVXvEcCGqdnXkhhIj
         48Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TOFU2+jRoOeADfaM4OUnr2BLewURnWVkHOdGuQEUre4=;
        b=mJLHyQpfqiuOCAXgGed1SaS69Vh47XINt8cgQ61YdPO1+FI6mYNPayEPff2KlazHqG
         2AiElW7RC2SiqmqHjIpxrO9AKWdri5biFIKaQirNqr2zaxl9wbuHWxjUqLMhw8K+Kk/l
         nMZWSjcXJpTcajdoOj8QvBujRx4tNW2lX8hydfsrIUa6E0xM2kSFcVotWVYAxibbfYf2
         LaPZM32J7znZoVGkmR+4iQzumR1JwTw/zfM9Js7mVUcyJny8VLZExPgapbsvU0w7YApL
         gkOYc+rBmduCpHPjdvomlFsEGPK+PhvYybIHr1HQ71NOg1iV4TQLCIa3VUb88va84Lv8
         lpDQ==
X-Gm-Message-State: AOAM53398ktP7Jr/IbhZ6DsgE0Kj4gSrAOIfUwtajeqKT4fDoI6djw9L
        U40HKYb/K/O/nTSVnaKiJ4+xfeWvCEw=
X-Google-Smtp-Source: ABdhPJwdEcYr02LHbWY0PCkLtH47YuZcSRHp+sRh8JwNQz2+TzQuMNAQ+BG1f/Qa2cL8mqWxItkvTg==
X-Received: by 2002:a05:6102:245:: with SMTP id a5mr9964939vsq.24.1620146152007;
        Tue, 04 May 2021 09:35:52 -0700 (PDT)
Received: from leah-cloudtop2.c.googlers.com.com (241.36.196.104.bc.googleusercontent.com. [104.196.36.241])
        by smtp.googlemail.com with ESMTPSA id x1sm749879vse.0.2021.05.04.09.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 09:35:51 -0700 (PDT)
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH v3 1/3] ext4: add flags argument to jbd2_journal_flush
Date:   Tue,  4 May 2021 16:35:48 +0000
Message-Id: <20210504163550.1486337-1-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch will allow the following commit to pass a discard flag,
enabling discarding the journal blocks while flushing the journal.

Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
---
 fs/ext4/inode.c      | 4 ++--
 fs/ext4/ioctl.c      | 6 +++---
 fs/ext4/super.c      | 6 +++---
 fs/jbd2/journal.c    | 3 +--
 fs/ocfs2/alloc.c     | 2 +-
 fs/ocfs2/journal.c   | 8 ++++----
 include/linux/jbd2.h | 2 +-
 7 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 0948a43f1b3d..d308c57559e3 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3225,7 +3225,7 @@ static sector_t ext4_bmap(struct address_space *mapping, sector_t block)
 		ext4_clear_inode_state(inode, EXT4_STATE_JDATA);
 		journal = EXT4_JOURNAL(inode);
 		jbd2_journal_lock_updates(journal);
-		err = jbd2_journal_flush(journal);
+		err = jbd2_journal_flush(journal, false);
 		jbd2_journal_unlock_updates(journal);
 
 		if (err)
@@ -6007,7 +6007,7 @@ int ext4_change_inode_journal_flag(struct inode *inode, int val)
 	if (val)
 		ext4_set_inode_flag(inode, EXT4_INODE_JOURNAL_DATA);
 	else {
-		err = jbd2_journal_flush(journal);
+		err = jbd2_journal_flush(journal, false);
 		if (err < 0) {
 			jbd2_journal_unlock_updates(journal);
 			percpu_up_write(&sbi->s_writepages_rwsem);
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index e9b0a1fa2ba8..ef809feb7e77 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -701,7 +701,7 @@ static long ext4_ioctl_group_add(struct file *file,
 	err = ext4_group_add(sb, input);
 	if (EXT4_SB(sb)->s_journal) {
 		jbd2_journal_lock_updates(EXT4_SB(sb)->s_journal);
-		err2 = jbd2_journal_flush(EXT4_SB(sb)->s_journal);
+		err2 = jbd2_journal_flush(EXT4_SB(sb)->s_journal, false);
 		jbd2_journal_unlock_updates(EXT4_SB(sb)->s_journal);
 	}
 	if (err == 0)
@@ -879,7 +879,7 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		err = ext4_group_extend(sb, EXT4_SB(sb)->s_es, n_blocks_count);
 		if (EXT4_SB(sb)->s_journal) {
 			jbd2_journal_lock_updates(EXT4_SB(sb)->s_journal);
-			err2 = jbd2_journal_flush(EXT4_SB(sb)->s_journal);
+			err2 = jbd2_journal_flush(EXT4_SB(sb)->s_journal, false);
 			jbd2_journal_unlock_updates(EXT4_SB(sb)->s_journal);
 		}
 		if (err == 0)
@@ -1022,7 +1022,7 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		if (EXT4_SB(sb)->s_journal) {
 			ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_RESIZE);
 			jbd2_journal_lock_updates(EXT4_SB(sb)->s_journal);
-			err2 = jbd2_journal_flush(EXT4_SB(sb)->s_journal);
+			err2 = jbd2_journal_flush(EXT4_SB(sb)->s_journal, false);
 			jbd2_journal_unlock_updates(EXT4_SB(sb)->s_journal);
 		}
 		if (err == 0)
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 3868377dec2d..449ed222cdf8 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5613,7 +5613,7 @@ static int ext4_mark_recovery_complete(struct super_block *sb,
 		return 0;
 	}
 	jbd2_journal_lock_updates(journal);
-	err = jbd2_journal_flush(journal);
+	err = jbd2_journal_flush(journal, false);
 	if (err < 0)
 		goto out;
 
@@ -5755,7 +5755,7 @@ static int ext4_freeze(struct super_block *sb)
 		 * Don't clear the needs_recovery flag if we failed to
 		 * flush the journal.
 		 */
-		error = jbd2_journal_flush(journal);
+		error = jbd2_journal_flush(journal, false);
 		if (error < 0)
 			goto out;
 
@@ -6346,7 +6346,7 @@ static int ext4_quota_on(struct super_block *sb, int type, int format_id,
 		 * otherwise be livelocked...
 		 */
 		jbd2_journal_lock_updates(EXT4_SB(sb)->s_journal);
-		err = jbd2_journal_flush(EXT4_SB(sb)->s_journal);
+		err = jbd2_journal_flush(EXT4_SB(sb)->s_journal, false);
 		jbd2_journal_unlock_updates(EXT4_SB(sb)->s_journal);
 		if (err)
 			return err;
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 2dc944442802..4b7953934c82 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -2251,8 +2251,7 @@ EXPORT_SYMBOL(jbd2_journal_clear_features);
  * Filesystems can use this when remounting readonly to ensure that
  * recovery does not need to happen on remount.
  */
-
-int jbd2_journal_flush(journal_t *journal)
+int jbd2_journal_flush(journal_t *journal, bool discard)
 {
 	int err = 0;
 	transaction_t *transaction = NULL;
diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
index 78710788c237..5ff2c42cb46c 100644
--- a/fs/ocfs2/alloc.c
+++ b/fs/ocfs2/alloc.c
@@ -6020,7 +6020,7 @@ int __ocfs2_flush_truncate_log(struct ocfs2_super *osb)
 	 * Then truncate log will be replayed resulting in cluster double free.
 	 */
 	jbd2_journal_lock_updates(journal->j_journal);
-	status = jbd2_journal_flush(journal->j_journal);
+	status = jbd2_journal_flush(journal->j_journal, false);
 	jbd2_journal_unlock_updates(journal->j_journal);
 	if (status < 0) {
 		mlog_errno(status);
diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
index db52e843002a..1c356b29c66d 100644
--- a/fs/ocfs2/journal.c
+++ b/fs/ocfs2/journal.c
@@ -310,7 +310,7 @@ static int ocfs2_commit_cache(struct ocfs2_super *osb)
 	}
 
 	jbd2_journal_lock_updates(journal->j_journal);
-	status = jbd2_journal_flush(journal->j_journal);
+	status = jbd2_journal_flush(journal->j_journal, false);
 	jbd2_journal_unlock_updates(journal->j_journal);
 	if (status < 0) {
 		up_write(&journal->j_trans_barrier);
@@ -1002,7 +1002,7 @@ void ocfs2_journal_shutdown(struct ocfs2_super *osb)
 
 	if (ocfs2_mount_local(osb)) {
 		jbd2_journal_lock_updates(journal->j_journal);
-		status = jbd2_journal_flush(journal->j_journal);
+		status = jbd2_journal_flush(journal->j_journal, false);
 		jbd2_journal_unlock_updates(journal->j_journal);
 		if (status < 0)
 			mlog_errno(status);
@@ -1072,7 +1072,7 @@ int ocfs2_journal_load(struct ocfs2_journal *journal, int local, int replayed)
 
 	if (replayed) {
 		jbd2_journal_lock_updates(journal->j_journal);
-		status = jbd2_journal_flush(journal->j_journal);
+		status = jbd2_journal_flush(journal->j_journal, false);
 		jbd2_journal_unlock_updates(journal->j_journal);
 		if (status < 0)
 			mlog_errno(status);
@@ -1668,7 +1668,7 @@ static int ocfs2_replay_journal(struct ocfs2_super *osb,
 
 	/* wipe the journal */
 	jbd2_journal_lock_updates(journal);
-	status = jbd2_journal_flush(journal);
+	status = jbd2_journal_flush(journal, false);
 	jbd2_journal_unlock_updates(journal);
 	if (status < 0)
 		mlog_errno(status);
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 99d3cd051ac3..5e4349b76997 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1491,7 +1491,7 @@ extern int	 jbd2_journal_invalidatepage(journal_t *,
 				struct page *, unsigned int, unsigned int);
 extern int	 jbd2_journal_try_to_free_buffers(journal_t *journal, struct page *page);
 extern int	 jbd2_journal_stop(handle_t *);
-extern int	 jbd2_journal_flush (journal_t *);
+extern int	 jbd2_journal_flush(journal_t *journal, bool discard);
 extern void	 jbd2_journal_lock_updates (journal_t *);
 extern void	 jbd2_journal_unlock_updates (journal_t *);
 
-- 
2.31.1.527.g47e6f16901-goog

