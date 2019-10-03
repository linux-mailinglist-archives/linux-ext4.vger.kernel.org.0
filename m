Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0A92CB1AD
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Oct 2019 00:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388020AbfJCWF5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Oct 2019 18:05:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:49706 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387717AbfJCWF4 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 3 Oct 2019 18:05:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6BAD9B147;
        Thu,  3 Oct 2019 22:05:52 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 250031E481B; Fri,  4 Oct 2019 00:06:14 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-ext4@vger.kernel.org>
Cc:     Ted Tso <tytso@mit.edu>, Jan Kara <jack@suse.cz>
Subject: [PATCH 09/22] ext4, jbd2: Provide accessor function for handle credits
Date:   Fri,  4 Oct 2019 00:05:55 +0200
Message-Id: <20191003220613.10791-9-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191003215523.7313-1-jack@suse.cz>
References: <20191003215523.7313-1-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Provide accessor function to get number of credits available in a handle
and use it from ext4. Later, computation of available credits won't be
so straightforward.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ext4_jbd2.c  | 13 +++++++------
 fs/ext4/ext4_jbd2.h  |  7 -------
 fs/ext4/xattr.c      |  2 +-
 include/linux/jbd2.h |  6 ++++++
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index 2b98d893cda9..731bbfdbce5b 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -119,8 +119,8 @@ handle_t *__ext4_journal_start_reserved(handle_t *handle, unsigned int line,
 		return ext4_get_nojournal();
 
 	sb = handle->h_journal->j_private;
-	trace_ext4_journal_start_reserved(sb, handle->h_buffer_credits,
-					  _RET_IP_);
+	trace_ext4_journal_start_reserved(sb,
+				jbd2_handle_buffer_credits(handle), _RET_IP_);
 	err = ext4_journal_check_start(sb);
 	if (err < 0) {
 		jbd2_journal_free_reserved(handle);
@@ -138,10 +138,10 @@ int __ext4_journal_ensure_credits(handle_t *handle, int check_cred,
 {
 	if (!ext4_handle_valid(handle))
 		return 0;
-	if (handle->h_buffer_credits >= check_cred)
+	if (jbd2_handle_buffer_credits(handle) >= check_cred)
 		return 0;
 	return ext4_journal_extend(handle,
-				   extend_cred - handle->h_buffer_credits);
+			   extend_cred - jbd2_handle_buffer_credits(handle));
 }
 
 static void ext4_journal_abort_handle(const char *caller, unsigned int line,
@@ -289,7 +289,7 @@ int __ext4_handle_dirty_metadata(const char *where, unsigned int line,
 				       handle->h_type,
 				       handle->h_line_no,
 				       handle->h_requested_credits,
-				       handle->h_buffer_credits, err);
+				       jbd2_handle_buffer_credits(handle), err);
 				return err;
 			}
 			ext4_error_inode(inode, where, line,
@@ -300,7 +300,8 @@ int __ext4_handle_dirty_metadata(const char *where, unsigned int line,
 					 handle->h_type,
 					 handle->h_line_no,
 					 handle->h_requested_credits,
-					 handle->h_buffer_credits, err);
+					 jbd2_handle_buffer_credits(handle),
+					 err);
 		}
 	} else {
 		if (inode)
diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index 1920b976eef1..36aa72599646 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -288,13 +288,6 @@ static inline int ext4_handle_is_aborted(handle_t *handle)
 	return 0;
 }
 
-static inline int ext4_handle_has_enough_credits(handle_t *handle, int needed)
-{
-	if (ext4_handle_valid(handle) && handle->h_buffer_credits < needed)
-		return 0;
-	return 1;
-}
-
 #define ext4_journal_start_sb(sb, type, nblocks)			\
 	__ext4_journal_start_sb((sb), __LINE__, (type), (nblocks), 0)
 
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index b79d8ffd3e9b..48a9dbd27f43 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2314,7 +2314,7 @@ ext4_xattr_set_handle(handle_t *handle, struct inode *inode, int name_index,
 						   flags & XATTR_CREATE);
 		brelse(bh);
 
-		if (!ext4_handle_has_enough_credits(handle, credits)) {
+		if (jbd2_handle_buffer_credits(handle) < credits) {
 			error = -ENOSPC;
 			goto cleanup;
 		}
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 10e6049c0ba9..727ff91d7f3e 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1645,6 +1645,12 @@ static inline tid_t  jbd2_get_latest_transaction(journal_t *journal)
 	return tid;
 }
 
+
+static inline int jbd2_handle_buffer_credits(handle_t *handle)
+{
+	return handle->h_buffer_credits;
+}
+
 #ifdef __KERNEL__
 
 #define buffer_trace_init(bh)	do {} while (0)
-- 
2.16.4

