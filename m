Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01DEBCB1B5
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Oct 2019 00:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388107AbfJCWGD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Oct 2019 18:06:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:49710 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387716AbfJCWF4 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 3 Oct 2019 18:05:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 97997B15E;
        Thu,  3 Oct 2019 22:05:52 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 66B0A1E481A; Fri,  4 Oct 2019 00:06:14 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-ext4@vger.kernel.org>
Cc:     Ted Tso <tytso@mit.edu>, Jan Kara <jack@suse.cz>
Subject: [PATCH 22/22] jbd2: Provide trace event for handle restarts
Date:   Fri,  4 Oct 2019 00:06:08 +0200
Message-Id: <20191003220613.10791-22-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191003215523.7313-1-jack@suse.cz>
References: <20191003215523.7313-1-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Provide trace event for handle restarts to ease debugging.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/transaction.c       |  8 +++++++-
 include/trace/events/jbd2.h | 16 +++++++++++++++-
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 66fad49d45df..624c33028663 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -732,6 +732,7 @@ int jbd2__journal_restart(handle_t *handle, int nblocks, int revoke_records,
 	journal_t *journal;
 	tid_t		tid;
 	int		need_to_start;
+	int		ret;
 
 	/* If we've had an abort of any type, don't even think about
 	 * actually doing the restart! */
@@ -757,7 +758,12 @@ int jbd2__journal_restart(handle_t *handle, int nblocks, int revoke_records,
 		DIV_ROUND_UP(revoke_records,
 			     journal->j_revoke_records_per_block);
 	handle->h_revoke_credits = revoke_records;
-	return start_this_handle(journal, handle, gfp_mask);
+	ret = start_this_handle(journal, handle, gfp_mask);
+	trace_jbd2_handle_restart(journal->j_fs_dev->bd_dev,
+				 ret ? 0 : handle->h_transaction->t_tid,
+				 handle->h_type, handle->h_line_no,
+				 handle->h_total_credits);
+	return ret;
 }
 EXPORT_SYMBOL(jbd2__journal_restart);
 
diff --git a/include/trace/events/jbd2.h b/include/trace/events/jbd2.h
index 2310b259329f..d16a32867f3a 100644
--- a/include/trace/events/jbd2.h
+++ b/include/trace/events/jbd2.h
@@ -133,7 +133,7 @@ TRACE_EVENT(jbd2_submit_inode_data,
 		  (unsigned long) __entry->ino)
 );
 
-TRACE_EVENT(jbd2_handle_start,
+DECLARE_EVENT_CLASS(jbd2_handle_start_class,
 	TP_PROTO(dev_t dev, unsigned long tid, unsigned int type,
 		 unsigned int line_no, int requested_blocks),
 
@@ -161,6 +161,20 @@ TRACE_EVENT(jbd2_handle_start,
 		  __entry->type, __entry->line_no, __entry->requested_blocks)
 );
 
+DEFINE_EVENT(jbd2_handle_start_class, jbd2_handle_start,
+	TP_PROTO(dev_t dev, unsigned long tid, unsigned int type,
+		 unsigned int line_no, int requested_blocks),
+
+	TP_ARGS(dev, tid, type, line_no, requested_blocks)
+);
+
+DEFINE_EVENT(jbd2_handle_start_class, jbd2_handle_restart,
+	TP_PROTO(dev_t dev, unsigned long tid, unsigned int type,
+		 unsigned int line_no, int requested_blocks),
+
+	TP_ARGS(dev, tid, type, line_no, requested_blocks)
+);
+
 TRACE_EVENT(jbd2_handle_extend,
 	TP_PROTO(dev_t dev, unsigned long tid, unsigned int type,
 		 unsigned int line_no, int buffer_credits,
-- 
2.16.4

