Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2A541528C7
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Feb 2020 11:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbgBEKBv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Feb 2020 05:01:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:48438 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727228AbgBEKBu (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 5 Feb 2020 05:01:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 11429AFF4;
        Wed,  5 Feb 2020 10:01:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C82F61E032D; Wed,  5 Feb 2020 11:01:47 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 1/3] e2fsck: Clarify overflow link count error message
Date:   Wed,  5 Feb 2020 11:01:36 +0100
Message-Id: <20200205100138.30053-2-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200205100138.30053-1-jack@suse.cz>
References: <20200205100138.30053-1-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

When directory link count is set to overflow value (1) but during pass 4
we find out the exact link count would fit, we either silently fix this
(which is not great because e2fsck then reports the fs was modified but
output doesn't indicate why in any way), or we report that link count is
wrong and ask whether we should fix it (in case -n option was
specified). The second case is even more misleading because it suggests
non-trivial fs corruption which then gets silently fixed on the next
run. Similarly to how we fix up other non-problems, just create a new
error message for the case directory link count is not overflown anymore
and always report it to clarify what is going on.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 e2fsck/pass4.c   | 20 ++++++++++++++++----
 e2fsck/problem.c |  5 +++++
 e2fsck/problem.h |  3 +++
 3 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/e2fsck/pass4.c b/e2fsck/pass4.c
index 10be7f87180d..8c2d2f1fca12 100644
--- a/e2fsck/pass4.c
+++ b/e2fsck/pass4.c
@@ -237,6 +237,8 @@ void e2fsck_pass4(e2fsck_t ctx)
 			link_counted = 1;
 		}
 		if (link_counted != link_count) {
+			int fix_nlink = 0;
+
 			e2fsck_read_inode_full(ctx, i, EXT2_INODE(inode),
 					       inode_size, "pass4");
 			pctx.ino = i;
@@ -250,10 +252,20 @@ void e2fsck_pass4(e2fsck_t ctx)
 			pctx.num = link_counted;
 			/* i_link_count was previously exceeded, but no longer
 			 * is, fix this but don't consider it an error */
-			if ((isdir && link_counted > 1 &&
-			     (inode->i_flags & EXT2_INDEX_FL) &&
-			     link_count == 1 && !(ctx->options & E2F_OPT_NO)) ||
-			    fix_problem(ctx, PR_4_BAD_REF_COUNT, &pctx)) {
+			if (isdir && link_counted > 1 &&
+			    (inode->i_flags & EXT2_INDEX_FL) &&
+			    link_count == 1) {
+				if ((ctx->options & E2F_OPT_READONLY) == 0) {
+					fix_nlink =
+						fix_problem(ctx,
+							PR_4_DIR_OVERFLOW_REF_COUNT,
+							&pctx);
+				}
+			} else {
+				fix_nlink = fix_problem(ctx, PR_4_BAD_REF_COUNT,
+						&pctx);
+			}
+			if (fix_nlink) {
 				inode->i_links_count = link_counted;
 				e2fsck_write_inode_full(ctx, i,
 							EXT2_INODE(inode),
diff --git a/e2fsck/problem.c b/e2fsck/problem.c
index c7c0ba986006..cde369d03034 100644
--- a/e2fsck/problem.c
+++ b/e2fsck/problem.c
@@ -2035,6 +2035,11 @@ static struct e2fsck_problem problem_table[] = {
 	  N_("@d exceeds max links, but no DIR_NLINK feature in @S.\n"),
 	  PROMPT_FIX, 0, 0, 0, 0 },
 
+	/* Directory ref count set to overflow but it doesn't have to be */
+	{ PR_4_DIR_OVERFLOW_REF_COUNT,
+	  N_("@d @i %i ref count set to overflow value %Il but could be exact value %N.  "),
+	  PROMPT_FIX, PR_PREEN_OK, 0, 0, 0 },
+
 	/* Pass 5 errors */
 
 	/* Pass 5: Checking group summary information */
diff --git a/e2fsck/problem.h b/e2fsck/problem.h
index c7f65f6dee0f..4185e5175cab 100644
--- a/e2fsck/problem.h
+++ b/e2fsck/problem.h
@@ -1164,6 +1164,9 @@ struct problem_context {
 /* directory exceeds max links, but no DIR_NLINK feature in superblock */
 #define PR_4_DIR_NLINK_FEATURE		0x040006
 
+/* Directory ref count set to overflow but it doesn't have to be */
+#define PR_4_DIR_OVERFLOW_REF_COUNT	0x040007
+
 /*
  * Pass 5 errors
  */
-- 
2.16.4

