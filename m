Return-Path: <linux-ext4+bounces-222-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B0D7FD5FD
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Nov 2023 12:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3452D2832A8
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Nov 2023 11:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A7B1D536;
	Wed, 29 Nov 2023 11:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B16137
	for <linux-ext4@vger.kernel.org>; Wed, 29 Nov 2023 03:48:34 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SgHdm6khBz4f3k5m
	for <linux-ext4@vger.kernel.org>; Wed, 29 Nov 2023 19:48:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id CD2991A01E7
	for <linux-ext4@vger.kernel.org>; Wed, 29 Nov 2023 19:48:31 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgDnNw4FJWdl3TsMCQ--.42586S5;
	Wed, 29 Nov 2023 19:48:31 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH v2 2/2] jbd2: increase the journal IO's priority
Date: Wed, 29 Nov 2023 19:47:40 +0800
Message-Id: <20231129114740.2686201-2-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231129114740.2686201-1-yi.zhang@huaweicloud.com>
References: <20231129114740.2686201-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDnNw4FJWdl3TsMCQ--.42586S5
X-Coremail-Antispam: 1UD129KBjvJXoW3Jw17XFWUZr1DKr1fZr1kZrb_yoW7AryUpr
	yUK348A34vvryUZF1xXFs8XFWj9FW0kFyUKr1DC3Wkta1Utrnrtw1UtwnxtFy8AFyUK345
	JF1UC34DGw1jkrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9v14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
	W8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbec_DUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

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
---
 fs/jbd2/commit.c     |  9 +++++----
 fs/jbd2/journal.c    | 20 +++++++++++---------
 include/linux/jbd2.h |  3 +++
 3 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 8d6f934c3d95..9bdb377a348f 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -119,7 +119,7 @@ static int journal_submit_commit_record(journal_t *journal,
 	struct commit_header *tmp;
 	struct buffer_head *bh;
 	struct timespec64 now;
-	blk_opf_t write_flags = REQ_OP_WRITE | REQ_SYNC;
+	blk_opf_t write_flags = REQ_OP_WRITE | JBD2_JOURNAL_REQ_FLAGS;
 
 	*cbh = NULL;
 
@@ -395,8 +395,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 		 */
 		jbd2_journal_update_sb_log_tail(journal,
 						journal->j_tail_sequence,
-						journal->j_tail,
-						REQ_SYNC);
+						journal->j_tail, 0);
 		mutex_unlock(&journal->j_checkpoint_mutex);
 	} else {
 		jbd2_debug(3, "superblock not updated\n");
@@ -715,6 +714,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 
 			for (i = 0; i < bufs; i++) {
 				struct buffer_head *bh = wbuf[i];
+
 				/*
 				 * Compute checksum.
 				 */
@@ -727,7 +727,8 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 				clear_buffer_dirty(bh);
 				set_buffer_uptodate(bh);
 				bh->b_end_io = journal_end_buffer_io_sync;
-				submit_bh(REQ_OP_WRITE | REQ_SYNC, bh);
+				submit_bh(REQ_OP_WRITE | JBD2_JOURNAL_REQ_FLAGS,
+					  bh);
 			}
 			cond_resched();
 
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index e7aa47a02d4d..19c69229ac6e 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1100,8 +1100,7 @@ int __jbd2_update_log_tail(journal_t *journal, tid_t tid, unsigned long block)
 	 * space and if we lose sb update during power failure we'd replay
 	 * old transaction with possibly newly overwritten data.
 	 */
-	ret = jbd2_journal_update_sb_log_tail(journal, tid, block,
-					      REQ_SYNC | REQ_FUA);
+	ret = jbd2_journal_update_sb_log_tail(journal, tid, block, REQ_FUA);
 	if (ret)
 		goto out;
 
@@ -1768,8 +1767,7 @@ static int journal_reset(journal_t *journal)
 		 */
 		jbd2_journal_update_sb_log_tail(journal,
 						journal->j_tail_sequence,
-						journal->j_tail,
-						REQ_SYNC | REQ_FUA);
+						journal->j_tail, REQ_FUA);
 		mutex_unlock(&journal->j_checkpoint_mutex);
 	}
 	return jbd2_journal_start_thread(journal);
@@ -1791,6 +1789,11 @@ static int jbd2_write_superblock(journal_t *journal, blk_opf_t write_flags)
 		return -EIO;
 	}
 
+	/*
+	 * Always set high priority flags to exempt from block layer's
+	 * QOS policies, e.g. writeback throttle.
+	 */
+	write_flags |= JBD2_JOURNAL_REQ_FLAGS;
 	if (!(journal->j_flags & JBD2_BARRIER))
 		write_flags &= ~(REQ_FUA | REQ_PREFLUSH);
 
@@ -2045,7 +2048,7 @@ void jbd2_journal_update_sb_errno(journal_t *journal)
 	jbd2_debug(1, "JBD2: updating superblock error (errno %d)\n", errcode);
 	sb->s_errno    = cpu_to_be32(errcode);
 
-	jbd2_write_superblock(journal, REQ_SYNC | REQ_FUA);
+	jbd2_write_superblock(journal, REQ_FUA);
 }
 EXPORT_SYMBOL(jbd2_journal_update_sb_errno);
 
@@ -2166,8 +2169,7 @@ int jbd2_journal_destroy(journal_t *journal)
 				++journal->j_transaction_sequence;
 			write_unlock(&journal->j_state_lock);
 
-			jbd2_mark_journal_empty(journal,
-					REQ_SYNC | REQ_PREFLUSH | REQ_FUA);
+			jbd2_mark_journal_empty(journal, REQ_PREFLUSH | REQ_FUA);
 			mutex_unlock(&journal->j_checkpoint_mutex);
 		} else
 			err = -EIO;
@@ -2468,7 +2470,7 @@ int jbd2_journal_flush(journal_t *journal, unsigned int flags)
 	 * the magic code for a fully-recovered superblock.  Any future
 	 * commits of data to the journal will restore the current
 	 * s_start value. */
-	jbd2_mark_journal_empty(journal, REQ_SYNC | REQ_FUA);
+	jbd2_mark_journal_empty(journal, REQ_FUA);
 
 	if (flags)
 		err = __jbd2_journal_erase(journal, flags);
@@ -2514,7 +2516,7 @@ int jbd2_journal_wipe(journal_t *journal, int write)
 	if (write) {
 		/* Lock to make assertions happy... */
 		mutex_lock_io(&journal->j_checkpoint_mutex);
-		jbd2_mark_journal_empty(journal, REQ_SYNC | REQ_FUA);
+		jbd2_mark_journal_empty(journal, REQ_FUA);
 		mutex_unlock(&journal->j_checkpoint_mutex);
 	}
 
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 52772c826c86..0fc6c1f51262 100644
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
2.39.2


