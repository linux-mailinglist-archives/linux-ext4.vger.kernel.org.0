Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABC36BDE4B
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Mar 2023 02:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjCQBwT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Mar 2023 21:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCQBwT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Mar 2023 21:52:19 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE71B22111
        for <linux-ext4@vger.kernel.org>; Thu, 16 Mar 2023 18:52:16 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32H1qDHr031596
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Mar 2023 21:52:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1679017934; bh=9Fc3z1wx9HRZ98NfjO0FfH5e1OIvOjratNA/m+uy4I8=;
        h=From:To:Cc:Subject:Date;
        b=QVXhXKJhCLuXlholrH23QwHz+8VTo5RpDn7xzj68cOMC6VCDFqLE5p/hd8za5JR0o
         1HdDdmyYmZQwP9bOsf13Pm+b94/Og4A3X1Ah6+W7TreKcE44OFij+dJhEOSvToOjnU
         6Y//b+mEr+Qrm2y8sggE5CY6ogP6BpY9rV0J8fdBr8acccJXvTgk9QaWj/hb2fyEH5
         Z5OXuJzSBAQxkTWnnOWDHKT3n/SXTQlC5F/bK3x8cE5Ii0L4JZM7dXdJx1QhE+2o3G
         h/ZQ719sAXOQwScTdCoEGmilEhkRF/uNqsdS2xpwzIosGQitm4oMy/smAh4H4zdSSK
         Zg+3n6oTt8Zzw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 0F87415C33A7; Thu, 16 Mar 2023 21:52:13 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] ext4: convert some BUG_ON's in mballoc to use WARN_RATELIMITED instead
Date:   Thu, 16 Mar 2023 21:52:10 -0400
Message-Id: <20230317015210.3178317-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In cases where we have an obvious way of continuing, let's use
WARN_RATELIMITED() instead of BUG_ON().

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/mballoc.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index ddea281b6467..63a68cee36c6 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1487,7 +1487,13 @@ ext4_mb_load_buddy_gfp(struct super_block *sb, ext4_group_t group,
 			put_page(page);
 		page = find_or_create_page(inode->i_mapping, pnum, gfp);
 		if (page) {
-			BUG_ON(page->mapping != inode->i_mapping);
+			if (WARN_RATELIMIT(page->mapping != inode->i_mapping,
+	"ext4: bitmap's paging->mapping != inode->i_mapping\n")) {
+				/* should never happen */
+				unlock_page(page);
+				ret = -EINVAL;
+				goto err;
+			}
 			if (!PageUptodate(page)) {
 				ret = ext4_mb_init_cache(page, NULL, gfp);
 				if (ret) {
@@ -1523,7 +1529,13 @@ ext4_mb_load_buddy_gfp(struct super_block *sb, ext4_group_t group,
 			put_page(page);
 		page = find_or_create_page(inode->i_mapping, pnum, gfp);
 		if (page) {
-			BUG_ON(page->mapping != inode->i_mapping);
+			if (WARN_RATELIMIT(page->mapping != inode->i_mapping,
+	"ext4: buddy bitmap's page->mapping != inode->i_mapping\n")) {
+				/* should never happen */
+				unlock_page(page);
+				ret = -EINVAL;
+				goto err;
+			}
 			if (!PageUptodate(page)) {
 				ret = ext4_mb_init_cache(page, e4b->bd_bitmap,
 							 gfp);
@@ -2221,7 +2233,9 @@ void ext4_mb_simple_scan_group(struct ext4_allocation_context *ac,
 			continue;
 
 		buddy = mb_find_buddy(e4b, i, &max);
-		BUG_ON(buddy == NULL);
+		if (WARN_RATELIMIT(buddy == NULL,
+			 "ext4: mb_simple_scan_group: mb_find_buddy failed, (%d)\n", i))
+			continue;
 
 		k = mb_find_next_zero_bit(buddy, max, 0);
 		if (k >= max) {
@@ -4228,15 +4242,14 @@ static void ext4_discard_allocated_blocks(struct ext4_allocation_context *ac)
 		if (ac->ac_f_ex.fe_len == 0)
 			return;
 		err = ext4_mb_load_buddy(ac->ac_sb, ac->ac_f_ex.fe_group, &e4b);
-		if (err) {
+		if (WARN_RATELIMIT(err,
+				   "ext4: mb_load_buddy failed (%d)", err))
 			/*
 			 * This should never happen since we pin the
 			 * pages in the ext4_allocation_context so
 			 * ext4_mb_load_buddy() should never fail.
 			 */
-			WARN(1, "mb_load_buddy failed (%d)", err);
 			return;
-		}
 		ext4_lock_group(ac->ac_sb, ac->ac_f_ex.fe_group);
 		mb_free_blocks(ac->ac_inode, &e4b, ac->ac_f_ex.fe_start,
 			       ac->ac_f_ex.fe_len);
-- 
2.31.0

