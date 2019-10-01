Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3F6CC2E58
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Oct 2019 09:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733118AbfJAHmH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 1 Oct 2019 03:42:07 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38939 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732982AbfJAHmG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 1 Oct 2019 03:42:06 -0400
Received: by mail-pf1-f194.google.com with SMTP id v4so7301149pff.6
        for <linux-ext4@vger.kernel.org>; Tue, 01 Oct 2019 00:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IG/o22FPTmuzsi+5RtU+Zm5XgdntXDau0oWlT14o+EA=;
        b=BEIj0pSG5WVGIxXPxW3D5Kfd/8B0po/MdSLT5syvlQ+fHbe6gUbg7Y1xQ1RYbJ1FYI
         4Bufg81XQ75BjmxdwN/Lfa4Vv8uCKrJnL3jvkVPOmUly8ryJmrO87njFJPmvRGcs2s1+
         nZ0Ixa92AxZ8SIVznaVfPWQIhXyE4aYdFK3Lk47bEHhBIzOh41srEi/bQNO6iVHqE6u1
         stzvq0G/f4X56Hc9rnOvQ1lc2g9zu+DqsREk23gAFENZSEr6LuVn4mDnomo7aHYnNjrg
         mZ+jVNf7XCJThe41n34FpK9ovb2dbEuWS5CpFOBeP8iE4DEfZWBL04i6Df1pZgMfJGH/
         9CIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IG/o22FPTmuzsi+5RtU+Zm5XgdntXDau0oWlT14o+EA=;
        b=JJABDNHvRvxGuSQ04t1Lr+xi7Pg9dRS9UDDJTAKa04ojTCFyolCWb3M9PYOeSCV6tx
         t/E2BU+RZ6BjOV5K9ehu/2Vp95LpGRV3fyNd1PglUjh5d4EQzTzXBM2d4R1Lgg/FwB3S
         FBC3mmqiwik1qtKIgRvc4yHovPXqXn0TZ9L4474oHwsBr2zGe4iU/xA1QaEsBelBtrBg
         qer60rTYVTJFb360V8pYHWxbgqRzwh+GDsMwCleM7PGIkY8i3ScuIvRSIFlJ9KBBnneb
         nkJZJdpANlg1bBqtjAGbIYGt+WNFFtVMfee7P/+6WlMxSO+EjWHQ56YL3mjS2YVYX9c4
         WGFw==
X-Gm-Message-State: APjAAAWA8OKO6j71+bSo5dvop5xlTFhsx1vtJP4uJJUurWK2tK8d+xJu
        Su37Bc4PeS/M88fP4Bd0CXad7IzihJ8=
X-Google-Smtp-Source: APXvYqwMzFoq0u5anKYfPaMDmdfHDBcU76sc/ykGRBksNPmwA1dglWCT03GGeUfHn/LQI97H+JU57g==
X-Received: by 2002:aa7:920d:: with SMTP id 13mr25970072pfo.17.1569915724883;
        Tue, 01 Oct 2019 00:42:04 -0700 (PDT)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id q13sm2287668pjq.0.2019.10.01.00.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 00:42:04 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v3 05/13] jbd2: fast-commit recovery path changes
Date:   Tue,  1 Oct 2019 00:40:54 -0700
Message-Id: <20191001074101.256523-6-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
In-Reply-To: <20191001074101.256523-1-harshadshirwadkar@gmail.com>
References: <20191001074101.256523-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch adds fast-commit recovery path changes for JBD2. If we find
a fast commit block that is valid in our recovery phase call file
system specific routine to handle that block.

We also clear the fast commit flag in jbd2_mark_journal_empty() which
is called after successful recovery as well successful
checkpointing. This allows JBD2 journal to be compatible with older
versions when there are no fast commit blocks.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/jbd2/journal.c    | 12 +++++++++
 fs/jbd2/recovery.c   | 63 +++++++++++++++++++++++++++++++++++++++++---
 include/linux/jbd2.h | 13 +++++++++
 3 files changed, 84 insertions(+), 4 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 14d549445418..e0684212384d 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1635,6 +1635,7 @@ int jbd2_journal_update_sb_log_tail(journal_t *journal, tid_t tail_tid,
 static void jbd2_mark_journal_empty(journal_t *journal, int write_op)
 {
 	journal_superblock_t *sb = journal->j_superblock;
+	bool had_fast_commit = false;
 
 	BUG_ON(!mutex_is_locked(&journal->j_checkpoint_mutex));
 	lock_buffer(journal->j_sb_buffer);
@@ -1648,9 +1649,20 @@ static void jbd2_mark_journal_empty(journal_t *journal, int write_op)
 
 	sb->s_sequence = cpu_to_be32(journal->j_tail_sequence);
 	sb->s_start    = cpu_to_be32(0);
+	if (jbd2_has_feature_fast_commit(journal)) {
+		/*
+		 * When journal is clean, no need to commit fast commit flag and
+		 * make file system incompatible with older kernels.
+		 */
+		jbd2_clear_feature_fast_commit(journal);
+		had_fast_commit = true;
+	}
 
 	jbd2_write_superblock(journal, write_op);
 
+	if (had_fast_commit)
+		jbd2_set_feature_fast_commit(journal);
+
 	/* Log is no longer empty */
 	write_lock(&journal->j_state_lock);
 	journal->j_flags |= JBD2_FLUSHED;
diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index a4967b27ffb6..c1f4c94ed375 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -35,7 +35,6 @@ struct recovery_info
 	int		nr_revoke_hits;
 };
 
-enum passtype {PASS_SCAN, PASS_REVOKE, PASS_REPLAY};
 static int do_one_pass(journal_t *journal,
 				struct recovery_info *info, enum passtype pass);
 static int scan_revoke_records(journal_t *, struct buffer_head *,
@@ -225,8 +224,12 @@ static int count_tags(journal_t *journal, struct buffer_head *bh)
 /* Make sure we wrap around the log correctly! */
 #define wrap(journal, var)						\
 do {									\
-	if (var >= (journal)->j_last)					\
-		var -= ((journal)->j_last - (journal)->j_first);	\
+	unsigned long _wrap_last =					\
+		jbd2_has_feature_fast_commit(journal) ?			\
+			(journal)->j_last_fc : (journal)->j_last;	\
+									\
+	if (var >= _wrap_last)						\
+		var -= (_wrap_last - (journal)->j_first);		\
 } while (0)
 
 /**
@@ -413,6 +416,51 @@ static int jbd2_block_tag_csum_verify(journal_t *j, journal_block_tag_t *tag,
 		return tag->t_checksum == cpu_to_be16(csum32);
 }
 
+static int fc_do_one_pass(journal_t *journal,
+			  struct recovery_info *info, enum passtype pass)
+{
+	unsigned int expected_commit_id = info->end_transaction;
+	unsigned long next_fc_block;
+	struct buffer_head *bh;
+	unsigned int seq;
+	journal_header_t *jhdr;
+	int err = 0;
+
+	next_fc_block = journal->j_first_fc;
+
+	while (next_fc_block <= journal->j_last_fc) {
+		jbd_debug(3, "Fast commit replay: next block %lld",
+			  next_fc_block);
+		err = jread(&bh, journal, next_fc_block);
+		if (err)
+			break;
+
+		jhdr = (journal_header_t *)bh->b_data;
+		seq = be32_to_cpu(jhdr->h_sequence);
+		if (be32_to_cpu(jhdr->h_magic) != JBD2_MAGIC_NUMBER ||
+		    seq != expected_commit_id) {
+			break;
+		}
+		jbd_debug(3, "Processing fast commit blk with seq %d",
+			  seq);
+		if (journal->j_fc_replay_callback) {
+			err = journal->j_fc_replay_callback(
+						journal, bh, pass,
+						next_fc_block -
+						journal->j_first_fc);
+			if (err)
+				break;
+		}
+		next_fc_block++;
+	}
+
+	if (err)
+		jbd_debug(3, "Fast commit replay failed, err = %d\n", err);
+
+	return err;
+}
+
+
 static int do_one_pass(journal_t *journal,
 			struct recovery_info *info, enum passtype pass)
 {
@@ -470,7 +518,7 @@ static int do_one_pass(journal_t *journal,
 				break;
 
 		jbd_debug(2, "Scanning for sequence ID %u at %lu/%lu\n",
-			  next_commit_ID, next_log_block, journal->j_last);
+			  next_commit_ID, next_log_block, journal->j_last_fc);
 
 		/* Skip over each chunk of the transaction looking
 		 * either the next descriptor block or the final commit
@@ -768,6 +816,8 @@ static int do_one_pass(journal_t *journal,
 			if (err)
 				goto failed;
 			continue;
+		case JBD2_FC_BLOCK:
+			continue;
 
 		default:
 			jbd_debug(3, "Unrecognised magic %d, end of scan.\n",
@@ -799,6 +849,11 @@ static int do_one_pass(journal_t *journal,
 				success = -EIO;
 		}
 	}
+
+
+	if (jbd2_has_feature_fast_commit(journal) && pass != PASS_REVOKE)
+		fc_do_one_pass(journal, info, pass);
+
 	if (block_error && success == 0)
 		success = -EIO;
 	return success;
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index c6a2b82de4cf..312103fc9581 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -762,6 +762,8 @@ jbd2_time_diff(unsigned long start, unsigned long end)
 
 #define JBD2_NR_BATCH	64
 
+enum passtype {PASS_SCAN, PASS_REVOKE, PASS_REPLAY};
+
 /**
  * struct journal_s - The journal_s type is the concrete type associated with
  *     journal_t.
@@ -1243,6 +1245,17 @@ struct journal_s
 	 * after every commit operation.
 	 */
 	void (*j_fc_cleanup_callback)(struct journal_s *journal);
+
+	/*
+	 * @j_fc_replay_callback:
+	 *
+	 * File-system specific function that performs replay of a fast
+	 * commit. JBD2 calls this function for each fast commit block found in
+	 * the journal.
+	 */
+	int (*j_fc_replay_callback)(struct journal_s *journal,
+				    struct buffer_head *bh,
+				    enum passtype pass, int off);
 };
 
 #define jbd2_might_wait_for_commit(j) \
-- 
2.23.0.444.g18eeb5a265-goog

