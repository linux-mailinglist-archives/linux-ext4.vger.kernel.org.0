Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0240132F8C8
	for <lists+linux-ext4@lfdr.de>; Sat,  6 Mar 2021 08:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhCFH2I (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 6 Mar 2021 02:28:08 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12703 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbhCFH2C (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 6 Mar 2021 02:28:02 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Dsx3H6qzKzlSm3;
        Sat,  6 Mar 2021 15:25:47 +0800 (CST)
Received: from [10.174.176.121] (10.174.176.121) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Sat, 6 Mar 2021 15:27:49 +0800
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
CC:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        harshad shirwadkar <harshadshirwadkar@gmail.com>,
        "liuzhiqiang (I)" <liuzhiqiang26@huawei.com>,
        linfeilong <linfeilong@huawei.com>, <liangyun2@huawei.com>
From:   Haotian Li <lihaotian9@huawei.com>
Subject: [PATCH v2] e2fsck: Avoid changes on recovery flags when
 jbd2_journal_recover() failed
Message-ID: <b7c93630-9b74-994a-8a82-8ab827ca5a2d@huawei.com>
Date:   Sat, 6 Mar 2021 15:27:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.121]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

jbd2_journal_recover() may fail when some error occers such
as ENOMEM and EIO.  However, jsb->s_start is still cleared
by func e2fsck_journal_release(). This may break consistency
between metadata and data in disk. Sometimes, failure in
jbd2_journal_recover() is temporary but retry e2fsck will
skip the journal recovery when the temporary problem is fixed.

Following harshad shirwadkar's suggestion£¬we add an option
"recovery_error_behavior" with default value "continue" to
e2fsck.conf. User may set it to "retry" or "exit" to adopt
different behavior when such journal recovery errors occur.

Reported-by: Liangyun <liangyun2@huawei.com>
Signed-off-by: Haotian Li <lihaotian9@huawei.com>
Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
---
 e2fsck/e2fsck.h  | 11 +++++++++++
 e2fsck/journal.c | 33 +++++++++++++++++++++++++++++++--
 e2fsck/unix.c    | 13 ++++++++++++-
 3 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index 15d043ee..22f9ad11 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -451,6 +451,9 @@ struct e2fsck_struct {

 	/* Fast commit replay state */
 	struct e2fsck_fc_replay_state fc_replay_state;
+
+	/* Behavior when journal recovery fails */
+	int recovery_error_behavior;
 };

 /* Data structures to evaluate whether an extent tree needs rebuilding. */
@@ -474,6 +477,14 @@ typedef struct region_struct *region_t;
 extern int e2fsck_strnlen(const char * s, int count);
 #endif

+/* Different behaviors when journal recovery fails */
+#define RECOVERY_ERROR_CONTINUE 0
+#define RECOVERY_ERROR_RETRY 1
+#define RECOVERY_ERROR_EXIT 2
+
+/* Journal retry times if RECOVERY_ERROR_RETRY is set*/
+#define RECOVERY_TIMES_LIMIT 3
+
 /*
  * Procedure declarations
  */
diff --git a/e2fsck/journal.c b/e2fsck/journal.c
index a425bbd1..c1c6f6ee 100644
--- a/e2fsck/journal.c
+++ b/e2fsck/journal.c
@@ -1600,11 +1600,26 @@ no_has_journal:
 	return retval;
 }

+static void set_recovery_error_behavior(e2fsck_t ctx, const char *recovery_behavior)
+{
+	if (!recovery_behavior) {
+		ctx->recovery_error_behavior = RECOVERY_ERROR_CONTINUE;
+		return;
+	}
+	if (strcmp(recovery_behavior, "retry") == 0)
+		ctx->recovery_error_behavior = RECOVERY_ERROR_RETRY;
+	else if (strcmp(recovery_behavior, "exit") == 0)
+		ctx->recovery_error_behavior = RECOVERY_ERROR_EXIT;
+	else
+		ctx->recovery_error_behavior = RECOVERY_ERROR_CONTINUE;
+}
+
 static errcode_t recover_ext3_journal(e2fsck_t ctx)
 {
 	struct problem_context	pctx;
 	journal_t *journal;
 	errcode_t retval;
+	char *recovery_behavior = 0;

 	clear_problem_context(&pctx);

@@ -1629,8 +1644,12 @@ static errcode_t recover_ext3_journal(e2fsck_t ctx)
 		goto errout;

 	retval = -jbd2_journal_recover(journal);
-	if (retval)
+	if (retval) {
+		profile_get_string(ctx->profile, "options", "recovery_error_behavior",
+				0, "continue", &recovery_behavior);
+		set_recovery_error_behavior(ctx, recovery_behavior);
 		goto errout;
+	}

 	if (journal->j_failed_commit) {
 		pctx.ino = journal->j_failed_commit;
@@ -1645,7 +1664,15 @@ errout:
 	jbd2_journal_destroy_revoke(journal);
 	jbd2_journal_destroy_revoke_record_cache();
 	jbd2_journal_destroy_revoke_table_cache();
-	e2fsck_journal_release(ctx, journal, 1, 0);
+	if (retval == 0 || ctx->recovery_error_behavior == RECOVERY_ERROR_CONTINUE)
+		e2fsck_journal_release(ctx, journal, 1, 0);
+	if (retval && ctx->recovery_error_behavior == RECOVERY_ERROR_EXIT) {
+		ctx->fs->flags &= ~EXT2_FLAG_VALID;
+		com_err(ctx->program_name, 0,
+					_("Journal recovery failed "
+					  "on %s\n"), ctx->device_name);
+		fatal_error(ctx, 0);
+	}
 	return retval;
 }

@@ -1697,6 +1724,8 @@ errcode_t e2fsck_run_ext3_journal(e2fsck_t ctx)

 	/* Set the superblock flags */
 	e2fsck_clear_recover(ctx, recover_retval != 0);
+	if (recover_retval != 0 && ctx->recovery_error_behavior == RECOVERY_ERROR_RETRY)
+		ext2fs_set_feature_journal_needs_recovery(ctx->fs->super);

 	/*
 	 * Do one last sanity check, and propagate journal->s_errno to
diff --git a/e2fsck/unix.c b/e2fsck/unix.c
index c5f9e441..25978471 100644
--- a/e2fsck/unix.c
+++ b/e2fsck/unix.c
@@ -1068,6 +1068,8 @@ static errcode_t PRS(int argc, char *argv[], e2fsck_t *ret_ctx)
 	if (c)
 		ctx->options |= E2F_OPT_ICOUNT_FULLMAP;

+	ctx->recovery_error_behavior = RECOVERY_ERROR_CONTINUE;
+
 	if (ctx->readahead_kb == ~0ULL) {
 		profile_get_integer(ctx->profile, "options",
 				    "readahead_mem_pct", 0, -1, &c);
@@ -1776,6 +1778,7 @@ failure:
 				  "doing a read-only filesystem check.\n"));
 			io_channel_flush(ctx->fs->io);
 		} else {
+			int recovery_retry_times = 0;
 			if (ctx->flags & E2F_FLAG_RESTARTED) {
 				/*
 				 * Whoops, we attempted to run the
@@ -1788,7 +1791,15 @@ failure:
 					  "on %s\n"), ctx->device_name);
 				fatal_error(ctx, 0);
 			}
-			retval = e2fsck_run_ext3_journal(ctx);
+			while (recovery_retry_times++ < RECOVERY_TIMES_LIMIT) {
+				retval = e2fsck_run_ext3_journal(ctx);
+				if (retval && ctx->recovery_error_behavior == RECOVERY_ERROR_RETRY) {
+					log_out(ctx, _("Try to recovery Journal "
+						       "again in %s\n"),
+						ctx->device_name);
+				} else
+					break;	
+			}
 			if (retval == EFSBADCRC) {
 				log_out(ctx, _("Journal checksum error "
 					       "found in %s\n"),
-- 
2.23.0

