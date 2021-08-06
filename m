Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6773E27E9
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Aug 2021 11:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244733AbhHFJ6t (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 6 Aug 2021 05:58:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20602 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229725AbhHFJ6s (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 6 Aug 2021 05:58:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628243912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kwMtnQY6UKaiQTPRCO07B2I5ui8niDVeQX2+LY+2ao8=;
        b=ZGzyBQjakiolykq7BLCUhS1J/74r7ckwXjLQRgtq6CtKqtALm3kIbZnhrZbI5gUnwOL3ZQ
        AltzcNFf5YlhtAH897Kh4sefvlPmf7abXrzOXUqRkOUfiWyXY5MMVH2VEnjFsiNFYsFwf9
        woyLiIqRekmi+7xNqoFVDcovPJmyO+M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-VxOex-sTMVWXvNsqKqOOOg-1; Fri, 06 Aug 2021 05:58:30 -0400
X-MC-Unique: VxOex-sTMVWXvNsqKqOOOg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8C0887D542;
        Fri,  6 Aug 2021 09:58:29 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.193.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0B50D1B5C0;
        Fri,  6 Aug 2021 09:58:28 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH 4/7] e2fsprogs: remove augmented rbtree functionality
Date:   Fri,  6 Aug 2021 11:58:17 +0200
Message-Id: <20210806095820.83731-4-lczerner@redhat.com>
In-Reply-To: <20210806095820.83731-1-lczerner@redhat.com>
References: <20210806095820.83731-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Rbtree code was originally taken from linux kernel. This includes the
augmented rbtree functionality, however this was never intended to be
used and is not used still. Just remove it.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 lib/ext2fs/rbtree.c | 68 ---------------------------------------------
 lib/ext2fs/rbtree.h |  8 ------
 2 files changed, 76 deletions(-)

diff --git a/lib/ext2fs/rbtree.c b/lib/ext2fs/rbtree.c
index 5b92099d..74426fa6 100644
--- a/lib/ext2fs/rbtree.c
+++ b/lib/ext2fs/rbtree.c
@@ -280,74 +280,6 @@ void ext2fs_rb_erase(struct rb_node *node, struct rb_root *root)
 		__rb_erase_color(child, parent, root);
 }
 
-static void ext2fs_rb_augment_path(struct rb_node *node, rb_augment_f func, void *data)
-{
-	struct rb_node *parent;
-
-up:
-	func(node, data);
-	parent = ext2fs_rb_parent(node);
-	if (!parent)
-		return;
-
-	if (node == parent->rb_left && parent->rb_right)
-		func(parent->rb_right, data);
-	else if (parent->rb_left)
-		func(parent->rb_left, data);
-
-	node = parent;
-	goto up;
-}
-
-/*
- * after inserting @node into the tree, update the tree to account for
- * both the new entry and any damage done by rebalance
- */
-void ext2fs_rb_augment_insert(struct rb_node *node, rb_augment_f func, void *data)
-{
-	if (node->rb_left)
-		node = node->rb_left;
-	else if (node->rb_right)
-		node = node->rb_right;
-
-	ext2fs_rb_augment_path(node, func, data);
-}
-
-/*
- * before removing the node, find the deepest node on the rebalance path
- * that will still be there after @node gets removed
- */
-struct rb_node *ext2fs_rb_augment_erase_begin(struct rb_node *node)
-{
-	struct rb_node *deepest;
-
-	if (!node->rb_right && !node->rb_left)
-		deepest = ext2fs_rb_parent(node);
-	else if (!node->rb_right)
-		deepest = node->rb_left;
-	else if (!node->rb_left)
-		deepest = node->rb_right;
-	else {
-		deepest = ext2fs_rb_next(node);
-		if (deepest->rb_right)
-			deepest = deepest->rb_right;
-		else if (ext2fs_rb_parent(deepest) != node)
-			deepest = ext2fs_rb_parent(deepest);
-	}
-
-	return deepest;
-}
-
-/*
- * after removal, update the tree to account for the removed entry
- * and any rebalance damage.
- */
-void ext2fs_rb_augment_erase_end(struct rb_node *node, rb_augment_f func, void *data)
-{
-	if (node)
-		ext2fs_rb_augment_path(node, func, data);
-}
-
 /*
  * This function returns the first node (in sort order) of the tree.
  */
diff --git a/lib/ext2fs/rbtree.h b/lib/ext2fs/rbtree.h
index dfeeb234..f718ad24 100644
--- a/lib/ext2fs/rbtree.h
+++ b/lib/ext2fs/rbtree.h
@@ -151,14 +151,6 @@ static inline void ext2fs_rb_clear_node(struct rb_node *node)
 extern void ext2fs_rb_insert_color(struct rb_node *, struct rb_root *);
 extern void ext2fs_rb_erase(struct rb_node *, struct rb_root *);
 
-typedef void (*rb_augment_f)(struct rb_node *node, void *data);
-
-extern void ext2fs_rb_augment_insert(struct rb_node *node,
-			      rb_augment_f func, void *data);
-extern struct rb_node *ext2fs_rb_augment_erase_begin(struct rb_node *node);
-extern void ext2fs_rb_augment_erase_end(struct rb_node *node,
-				 rb_augment_f func, void *data);
-
 /* Find logical next and previous nodes in a tree */
 extern struct rb_node *ext2fs_rb_next(struct rb_node *);
 extern struct rb_node *ext2fs_rb_prev(struct rb_node *);
-- 
2.31.1

