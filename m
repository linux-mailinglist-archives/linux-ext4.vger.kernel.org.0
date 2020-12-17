Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFD02DD655
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Dec 2020 18:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbgLQRgh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Dec 2020 12:36:37 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54764 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728161AbgLQRgg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Dec 2020 12:36:36 -0500
Received: from xps.home (unknown [IPv6:2a01:e35:2fb5:1510:779a:3a80:1322:d34a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aferraris)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id EB43B1F45D17;
        Thu, 17 Dec 2020 17:35:53 +0000 (GMT)
From:   Arnaud Ferraris <arnaud.ferraris@collabora.com>
To:     linux-ext4@vger.kernel.org
Cc:     drosen@google.com, krisman@collabora.com, ebiggers@kernel.org,
        tytso@mit.edu, Arnaud Ferraris <arnaud.ferraris@collabora.com>
Subject: [PATCH v3 08/12] dict: Support comparison with context
Date:   Thu, 17 Dec 2020 18:35:40 +0100
Message-Id: <20201217173544.52953-9-arnaud.ferraris@collabora.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201217173544.52953-1-arnaud.ferraris@collabora.com>
References: <20201217173544.52953-1-arnaud.ferraris@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Gabriel Krisman Bertazi <krisman@collabora.com>

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
---
 e2fsck/pass1b.c       |  2 +-
 e2fsck/pass2.c        |  2 +-
 lib/support/dict.c    | 22 ++++++++++++++++------
 lib/support/dict.h    |  4 +++-
 lib/support/mkquota.c |  2 +-
 5 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/e2fsck/pass1b.c b/e2fsck/pass1b.c
index 3352f9bd..2f8c14c8 100644
--- a/e2fsck/pass1b.c
+++ b/e2fsck/pass1b.c
@@ -104,7 +104,7 @@ static dict_t clstr_dict, ino_dict;
 
 static ext2fs_inode_bitmap inode_dup_map;
 
-static int dict_int_cmp(const void *a, const void *b)
+static int dict_int_cmp(const void* cmp_ctx, const void *a, const void *b)
 {
 	intptr_t	ia, ib;
 
diff --git a/e2fsck/pass2.c b/e2fsck/pass2.c
index 0bcc6f0b..153e05f0 100644
--- a/e2fsck/pass2.c
+++ b/e2fsck/pass2.c
@@ -328,7 +328,7 @@ static short htree_depth(struct dx_dir_info *dx_dir,
 	return depth;
 }
 
-static int dict_de_cmp(const void *a, const void *b)
+static int dict_de_cmp(const void *cmp_ctx, const void *a, const void *b)
 {
 	const struct ext2_dir_entry *de_a, *de_b;
 	int	a_len, b_len;
diff --git a/lib/support/dict.c b/lib/support/dict.c
index 6a5c15ce..f8277c4a 100644
--- a/lib/support/dict.c
+++ b/lib/support/dict.c
@@ -267,6 +267,7 @@ dict_t *dict_create(dictcount_t maxcount, dict_comp_t comp)
 	new->allocnode = dnode_alloc;
 	new->freenode = dnode_free;
 	new->context = NULL;
+	new->cmp_ctx = NULL;
 	new->nodecount = 0;
 	new->maxcount = maxcount;
 	new->nilnode.left = &new->nilnode;
@@ -294,6 +295,14 @@ void dict_set_allocator(dict_t *dict, dnode_alloc_t al,
     dict->context = context;
 }
 
+void dict_set_cmp_context(dict_t *dict, void *cmp_ctx)
+{
+    dict_assert (!dict->cmp_ctx);
+    dict_assert (dict_count(dict) == 0);
+
+    dict->cmp_ctx = cmp_ctx;
+}
+
 #ifdef E2FSCK_NOTUSED
 /*
  * Free a dynamically allocated dictionary object. Removing the nodes
@@ -467,7 +476,7 @@ dnode_t *dict_lookup(dict_t *dict, const void *key)
     /* simple binary search adapted for trees that contain duplicate keys */
 
     while (root != nil) {
-	result = dict->compare(key, root->key);
+	result = dict->compare(dict->cmp_ctx, key, root->key);
 	if (result < 0)
 	    root = root->left;
 	else if (result > 0)
@@ -479,7 +488,8 @@ dnode_t *dict_lookup(dict_t *dict, const void *key)
 		do {
 		    saved = root;
 		    root = root->left;
-		    while (root != nil && dict->compare(key, root->key))
+		    while (root != nil
+			   && dict->compare(dict->cmp_ctx, key, root->key))
 			root = root->right;
 		} while (root != nil);
 		return saved;
@@ -503,7 +513,7 @@ dnode_t *dict_lower_bound(dict_t *dict, const void *key)
     dnode_t *tentative = 0;
 
     while (root != nil) {
-	int result = dict->compare(key, root->key);
+	int result = dict->compare(dict->cmp_ctx, key, root->key);
 
 	if (result > 0) {
 	    root = root->right;
@@ -535,7 +545,7 @@ dnode_t *dict_upper_bound(dict_t *dict, const void *key)
     dnode_t *tentative = 0;
 
     while (root != nil) {
-	int result = dict->compare(key, root->key);
+	int result = dict->compare(dict->cmp_ctx, key, root->key);
 
 	if (result < 0) {
 	    root = root->left;
@@ -580,7 +590,7 @@ void dict_insert(dict_t *dict, dnode_t *node, const void *key)
 
     while (where != nil) {
 	parent = where;
-	result = dict->compare(key, where->key);
+	result = dict->compare(dict->cmp_ctx, key, where->key);
 	/* trap attempts at duplicate key insertion unless it's explicitly allowed */
 	dict_assert (dict->dupes || result != 0);
 	if (result < 0)
@@ -1261,7 +1271,7 @@ static int tokenize(char *string, ...)
     return tokcount;
 }
 
-static int comparef(const void *key1, const void *key2)
+static int comparef(const void *cmp_ctx, const void *key1, const void *key2)
 {
     return strcmp(key1, key2);
 }
diff --git a/lib/support/dict.h b/lib/support/dict.h
index 838079d6..d9462a33 100644
--- a/lib/support/dict.h
+++ b/lib/support/dict.h
@@ -56,7 +56,7 @@ typedef struct dnode_t {
 #endif
 } dnode_t;
 
-typedef int (*dict_comp_t)(const void *, const void *);
+typedef int (*dict_comp_t)(const void *, const void *, const void *);
 typedef dnode_t *(*dnode_alloc_t)(void *);
 typedef void (*dnode_free_t)(dnode_t *, void *);
 
@@ -69,6 +69,7 @@ typedef struct dict_t {
     dnode_alloc_t dict_allocnode;
     dnode_free_t dict_freenode;
     void *dict_context;
+    void *cmp_ctx;
     int dict_dupes;
 #else
     int dict_dummmy;
@@ -88,6 +89,7 @@ typedef struct dict_load_t {
 
 extern dict_t *dict_create(dictcount_t, dict_comp_t);
 extern void dict_set_allocator(dict_t *, dnode_alloc_t, dnode_free_t, void *);
+extern void dict_set_cmp_context(dict_t *, void *);
 extern void dict_destroy(dict_t *);
 extern void dict_free_nodes(dict_t *);
 extern void dict_free(dict_t *);
diff --git a/lib/support/mkquota.c b/lib/support/mkquota.c
index 6f7ae6d6..fbc3833a 100644
--- a/lib/support/mkquota.c
+++ b/lib/support/mkquota.c
@@ -234,7 +234,7 @@ out:
 /* Helper functions for computing quota in memory.                */
 /******************************************************************/
 
-static int dict_uint_cmp(const void *a, const void *b)
+static int dict_uint_cmp(const void *cmp_ctx, const void *a, const void *b)
 {
 	unsigned int	c, d;
 
-- 
2.29.2

