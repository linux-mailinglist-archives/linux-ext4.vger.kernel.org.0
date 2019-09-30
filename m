Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11C2FC1F6E
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Sep 2019 12:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730841AbfI3Kne (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 Sep 2019 06:43:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:57680 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730818AbfI3KnY (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 30 Sep 2019 06:43:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EE44EAF68;
        Mon, 30 Sep 2019 10:43:20 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id DB08B1E4827; Mon, 30 Sep 2019 12:43:39 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-ext4@vger.kernel.org>
Cc:     Ted Tso <tytso@mit.edu>, Jan Kara <jack@suse.cz>
Subject: [PATCH 08/19] ocfs2: Use accessor function for h_buffer_credits
Date:   Mon, 30 Sep 2019 12:43:26 +0200
Message-Id: <20190930104339.24919-8-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190930103544.11479-1-jack@suse.cz>
References: <20190930103544.11479-1-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Use the jbd2 accessor function for h_buffer_credits.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ocfs2/alloc.c   | 32 ++++++++++++++++----------------
 fs/ocfs2/journal.c |  4 ++--
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
index 0c335b51043d..913bf24f406f 100644
--- a/fs/ocfs2/alloc.c
+++ b/fs/ocfs2/alloc.c
@@ -2288,9 +2288,9 @@ static int ocfs2_extend_rotate_transaction(handle_t *handle, int subtree_depth,
 	int ret = 0;
 	int credits = (path->p_tree_depth - subtree_depth) * 2 + 1 + op_credits;
 
-	if (handle->h_buffer_credits < credits)
+	if (jbd2_handle_buffer_credits(handle) < credits)
 		ret = ocfs2_extend_trans(handle,
-					 credits - handle->h_buffer_credits);
+				credits - jbd2_handle_buffer_credits(handle));
 
 	return ret;
 }
@@ -2367,7 +2367,7 @@ static int ocfs2_rotate_tree_right(handle_t *handle,
 				   struct ocfs2_path *right_path,
 				   struct ocfs2_path **ret_left_path)
 {
-	int ret, start, orig_credits = handle->h_buffer_credits;
+	int ret, start, orig_credits = jbd2_handle_buffer_credits(handle);
 	u32 cpos;
 	struct ocfs2_path *left_path = NULL;
 	struct super_block *sb = ocfs2_metadata_cache_get_super(et->et_ci);
@@ -3148,7 +3148,7 @@ static int ocfs2_rotate_tree_left(handle_t *handle,
 				  struct ocfs2_path *path,
 				  struct ocfs2_cached_dealloc_ctxt *dealloc)
 {
-	int ret, orig_credits = handle->h_buffer_credits;
+	int ret, orig_credits = jbd2_handle_buffer_credits(handle);
 	struct ocfs2_path *tmp_path = NULL, *restart_path = NULL;
 	struct ocfs2_extent_block *eb;
 	struct ocfs2_extent_list *el;
@@ -3386,8 +3386,8 @@ static int ocfs2_merge_rec_right(struct ocfs2_path *left_path,
 							right_path);
 
 		ret = ocfs2_extend_rotate_transaction(handle, subtree_index,
-						      handle->h_buffer_credits,
-						      right_path);
+					jbd2_handle_buffer_credits(handle),
+					right_path);
 		if (ret) {
 			mlog_errno(ret);
 			goto out;
@@ -3548,8 +3548,8 @@ static int ocfs2_merge_rec_left(struct ocfs2_path *right_path,
 							right_path);
 
 		ret = ocfs2_extend_rotate_transaction(handle, subtree_index,
-						      handle->h_buffer_credits,
-						      left_path);
+					jbd2_handle_buffer_credits(handle),
+					left_path);
 		if (ret) {
 			mlog_errno(ret);
 			goto out;
@@ -3623,7 +3623,7 @@ static int ocfs2_merge_rec_left(struct ocfs2_path *right_path,
 		    le16_to_cpu(el->l_next_free_rec) == 1) {
 			/* extend credit for ocfs2_remove_rightmost_path */
 			ret = ocfs2_extend_rotate_transaction(handle, 0,
-					handle->h_buffer_credits,
+					jbd2_handle_buffer_credits(handle),
 					right_path);
 			if (ret) {
 				mlog_errno(ret);
@@ -3669,7 +3669,7 @@ static int ocfs2_try_to_merge_extent(handle_t *handle,
 	if (ctxt->c_split_covers_rec && ctxt->c_has_empty_extent) {
 		/* extend credit for ocfs2_remove_rightmost_path */
 		ret = ocfs2_extend_rotate_transaction(handle, 0,
-				handle->h_buffer_credits,
+				jbd2_handle_buffer_credits(handle),
 				path);
 		if (ret) {
 			mlog_errno(ret);
@@ -3725,7 +3725,7 @@ static int ocfs2_try_to_merge_extent(handle_t *handle,
 
 		/* extend credit for ocfs2_remove_rightmost_path */
 		ret = ocfs2_extend_rotate_transaction(handle, 0,
-					handle->h_buffer_credits,
+					jbd2_handle_buffer_credits(handle),
 					path);
 		if (ret) {
 			mlog_errno(ret);
@@ -3755,7 +3755,7 @@ static int ocfs2_try_to_merge_extent(handle_t *handle,
 
 		/* extend credit for ocfs2_remove_rightmost_path */
 		ret = ocfs2_extend_rotate_transaction(handle, 0,
-				handle->h_buffer_credits,
+				jbd2_handle_buffer_credits(handle),
 				path);
 		if (ret) {
 			mlog_errno(ret);
@@ -3799,7 +3799,7 @@ static int ocfs2_try_to_merge_extent(handle_t *handle,
 		if (ctxt->c_split_covers_rec) {
 			/* extend credit for ocfs2_remove_rightmost_path */
 			ret = ocfs2_extend_rotate_transaction(handle, 0,
-					handle->h_buffer_credits,
+					jbd2_handle_buffer_credits(handle),
 					path);
 			if (ret) {
 				mlog_errno(ret);
@@ -5358,7 +5358,7 @@ static int ocfs2_truncate_rec(handle_t *handle,
 	if (ocfs2_is_empty_extent(&el->l_recs[0]) && index > 0) {
 		/* extend credit for ocfs2_remove_rightmost_path */
 		ret = ocfs2_extend_rotate_transaction(handle, 0,
-				handle->h_buffer_credits,
+				jbd2_handle_buffer_credits(handle),
 				path);
 		if (ret) {
 			mlog_errno(ret);
@@ -5427,8 +5427,8 @@ static int ocfs2_truncate_rec(handle_t *handle,
 	}
 
 	ret = ocfs2_extend_rotate_transaction(handle, 0,
-					      handle->h_buffer_credits,
-					      path);
+					jbd2_handle_buffer_credits(handle),
+					path);
 	if (ret) {
 		mlog_errno(ret);
 		goto out;
diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
index 930e3d388579..019aaf2a3f8a 100644
--- a/fs/ocfs2/journal.c
+++ b/fs/ocfs2/journal.c
@@ -419,7 +419,7 @@ int ocfs2_extend_trans(handle_t *handle, int nblocks)
 	if (!nblocks)
 		return 0;
 
-	old_nblocks = handle->h_buffer_credits;
+	old_nblocks = jbd2_handle_buffer_credits(handle);
 
 	trace_ocfs2_extend_trans(old_nblocks, nblocks);
 
@@ -460,7 +460,7 @@ int ocfs2_allocate_extend_trans(handle_t *handle, int thresh)
 
 	BUG_ON(!handle);
 
-	old_nblks = handle->h_buffer_credits;
+	old_nblks = jbd2_handle_buffer_credits(handle);
 	trace_ocfs2_allocate_extend_trans(old_nblks, thresh);
 
 	if (old_nblks < thresh)
-- 
2.16.4

