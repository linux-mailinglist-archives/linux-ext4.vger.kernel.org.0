Return-Path: <linux-ext4+bounces-480-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 211B4816E95
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Dec 2023 13:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3D6E28CC26
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Dec 2023 12:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FAE57575;
	Mon, 18 Dec 2023 12:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYErIuSD"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FF357560;
	Mon, 18 Dec 2023 12:45:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9735CC43391;
	Mon, 18 Dec 2023 12:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702903520;
	bh=f2ehjjORm+uQZf0e8aS+3TjHgMGxdngRVgsuOT7wEuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HYErIuSDVCdccAH8j6Ii0krDyXIqe2uUNtJJ/0GZj2I5RYKu87uSdS9YOjK/yBuWH
	 laggsK4wJWP5XyOWkpcOgzimV+qOxYz1bFhoKxFkZkfRaYmlqRrx1P1W7AHpmsFCBb
	 sOYBt0Crlgo3fm8PPTVE9ES9Ec1RgI2Je+L+86nL6hPN/jUJ2lmlcFsX1iGUKwQSyv
	 JYjBUdszBcFRqmbVrUkY5V2BJdYV5AoMZ7Fe9hHXHRObRN/rKVB5zhuVC0It64itFZ
	 puitz/A1mWo3l8GTlCxPDgDXZCeJrYkzdmsCOM7YBXi0olhEXJB4bfHYgADjqCWoF+
	 B0yjx5G7V+pcA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhang Yi <yi.zhang@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	jack@suse.com,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 04/15] jbd2: increase the journal IO's priority
Date: Mon, 18 Dec 2023 07:44:51 -0500
Message-ID: <20231218124513.1380056-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218124513.1380056-1-sashal@kernel.org>
References: <20231218124513.1380056-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.68
Content-Transfer-Encoding: 8bit

From: Zhang Yi <yi.zhang@huawei.com>

[ Upstream commit 6a3afb6ac6dfab158ebdd4b87941178f58c8939f ]

Current jbd2 only add REQ_SYNC for descriptor block, metadata log
buffer, commit buffer and superblock buffer, the submitted IO could be
throttled by writeback throttle in block layer, that could lead to
priority inversion in some cases. The log IO looks like a kind of high
priority metadata IO, so it should not be throttled by WBT like QOS
policies in block layer, let's add REQ_SYNC | REQ_IDLE to exempt from
writeback throttle, and also add REQ_META together indicates it's a
metadata IO.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20231129114740.2686201-2-yi.zhang@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jbd2/commit.c     |  9 +++++----
 fs/jbd2/journal.c    | 20 +++++++++++---------
 include/linux/jbd2.h |  3 +++
 3 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index f1d9db6686e31..447c6972a6d37 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -123,7 +123,7 @@ static int journal_submit_commit_record(journal_t *journal,
 	struct commit_header *tmp;
 	struct buffer_head *bh;
 	struct timespec64 now;
-	blk_opf_t write_flags = REQ_OP_WRITE | REQ_SYNC;
+	blk_opf_t write_flags = REQ_OP_WRITE | JBD2_JOURNAL_REQ_FLAGS;
 
 	*cbh = NULL;
 
@@ -429,8 +429,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 		 */
 		jbd2_journal_update_sb_log_tail(journal,
 						journal->j_tail_sequence,
-						journal->j_tail,
-						REQ_SYNC);
+						journal->j_tail, 0);
 		mutex_unlock(&journal->j_checkpoint_mutex);
 	} else {
 		jbd2_debug(3, "superblock not updated\n");
@@ -749,6 +748,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 
 			for (i = 0; i < bufs; i++) {
 				struct buffer_head *bh = wbuf[i];
+
 				/*
 				 * Compute checksum.
 				 */
@@ -761,7 +761,8 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 				clear_buffer_dirty(bh);
 				set_buffer_uptodate(bh);
 				bh->b_end_io = journal_end_buffer_io_sync;
-				submit_bh(REQ_OP_WRITE | REQ_SYNC, bh);
+				submit_bh(REQ_OP_WRITE | JBD2_JOURNAL_REQ_FLAGS,
+					  bh);
 			}
 			cond_resched();
 
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 611337b0b5ad4..3df45e4699f10 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1109,8 +1109,7 @@ int __jbd2_update_log_tail(journal_t *journal, tid_t tid, unsigned long block)
 	 * space and if we lose sb update during power failure we'd replay
 	 * old transaction with possibly newly overwritten data.
 	 */
-	ret = jbd2_journal_update_sb_log_tail(journal, tid, block,
-					      REQ_SYNC | REQ_FUA);
+	ret = jbd2_journal_update_sb_log_tail(journal, tid, block, REQ_FUA);
 	if (ret)
 		goto out;
 
@@ -1597,8 +1596,7 @@ static int journal_reset(journal_t *journal)
 		 */
 		jbd2_journal_update_sb_log_tail(journal,
 						journal->j_tail_sequence,
-						journal->j_tail,
-						REQ_SYNC | REQ_FUA);
+						journal->j_tail, REQ_FUA);
 		mutex_unlock(&journal->j_checkpoint_mutex);
 	}
 	return jbd2_journal_start_thread(journal);
@@ -1620,6 +1618,11 @@ static int jbd2_write_superblock(journal_t *journal, blk_opf_t write_flags)
 		return -EIO;
 	}
 
+	/*
+	 * Always set high priority flags to exempt from block layer's
+	 * QOS policies, e.g. writeback throttle.
+	 */
+	write_flags |= JBD2_JOURNAL_REQ_FLAGS;
 	if (!(journal->j_flags & JBD2_BARRIER))
 		write_flags &= ~(REQ_FUA | REQ_PREFLUSH);
 
@@ -1873,7 +1876,7 @@ void jbd2_journal_update_sb_errno(journal_t *journal)
 	jbd2_debug(1, "JBD2: updating superblock error (errno %d)\n", errcode);
 	sb->s_errno    = cpu_to_be32(errcode);
 
-	jbd2_write_superblock(journal, REQ_SYNC | REQ_FUA);
+	jbd2_write_superblock(journal, REQ_FUA);
 }
 EXPORT_SYMBOL(jbd2_journal_update_sb_errno);
 
@@ -2178,8 +2181,7 @@ int jbd2_journal_destroy(journal_t *journal)
 				++journal->j_transaction_sequence;
 			write_unlock(&journal->j_state_lock);
 
-			jbd2_mark_journal_empty(journal,
-					REQ_SYNC | REQ_PREFLUSH | REQ_FUA);
+			jbd2_mark_journal_empty(journal, REQ_PREFLUSH | REQ_FUA);
 			mutex_unlock(&journal->j_checkpoint_mutex);
 		} else
 			err = -EIO;
@@ -2488,7 +2490,7 @@ int jbd2_journal_flush(journal_t *journal, unsigned int flags)
 	 * the magic code for a fully-recovered superblock.  Any future
 	 * commits of data to the journal will restore the current
 	 * s_start value. */
-	jbd2_mark_journal_empty(journal, REQ_SYNC | REQ_FUA);
+	jbd2_mark_journal_empty(journal, REQ_FUA);
 
 	if (flags)
 		err = __jbd2_journal_erase(journal, flags);
@@ -2538,7 +2540,7 @@ int jbd2_journal_wipe(journal_t *journal, int write)
 	if (write) {
 		/* Lock to make assertions happy... */
 		mutex_lock_io(&journal->j_checkpoint_mutex);
-		jbd2_mark_journal_empty(journal, REQ_SYNC | REQ_FUA);
+		jbd2_mark_journal_empty(journal, REQ_FUA);
 		mutex_unlock(&journal->j_checkpoint_mutex);
 	}
 
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index ebb1608d9dcd2..6611af5f1d0c6 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1374,6 +1374,9 @@ JBD2_FEATURE_INCOMPAT_FUNCS(csum2,		CSUM_V2)
 JBD2_FEATURE_INCOMPAT_FUNCS(csum3,		CSUM_V3)
 JBD2_FEATURE_INCOMPAT_FUNCS(fast_commit,	FAST_COMMIT)
 
+/* Journal high priority write IO operation flags */
+#define JBD2_JOURNAL_REQ_FLAGS		(REQ_META | REQ_SYNC | REQ_IDLE)
+
 /*
  * Journal flag definitions
  */
-- 
2.43.0


