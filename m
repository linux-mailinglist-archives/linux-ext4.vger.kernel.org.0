Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3987961F347
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbiKGMay (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbiKGM3P (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:29:15 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01956140F6
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:29:14 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id k15so10468929pfg.2
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZnDhELuUV+zsI8HDQ2YNpQ64OU5t0mjR3T71P+XOOb8=;
        b=a8MyoMNnwQNapkVU9vXHl1SynLKNVtf1HlTMYrxAOkJC8GJJeR8lrCFQxXcyvLd50v
         hUFmLWGdlyoIHG7lcNcWilZrQXmLW+wzSPrm6Czl3o6gLAkTyOYZioenwDk0SlWGryaT
         VhITN/gahSiEgoAqbbzZh7X0b2ym1bR/sgn11g54ZWblVJjCf8EjAy8MrBbAOd2dWAKB
         xFoZRrIok1Ix4K2tZ0JsSTdYT9hOuQQYY+nrJuh6AdyGId0AwheOJsfUvs8h3NC1DFIt
         ofgz3+bwQvmORE+20IUYpMmWRxtocOip84nxHPVeKkXJRa6oNUktXdOVChnE1Uqw6V0d
         05HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZnDhELuUV+zsI8HDQ2YNpQ64OU5t0mjR3T71P+XOOb8=;
        b=LewHbNgmx8XUZ0K8j8oC2RX9/ZUHw8xIrxziKLBVtE9bbJS4KjnYLfYNZnlI4VyNpc
         UAvDaZr72UuiH84odFutohg8h5j7LUJXJjXrKj+ffJcshM60D3Yxnp7oTpNPvtYdIiTA
         1I4e/rUegKx+O8yDG+DEh3laah+lo3oRnfTF/Ysu9nFLRyuQe8ORuglq9CjNBQudkBU8
         rT/ZuaB0Qamy52UKf5ebYFtOvk7jmZxYtRGH424rzRTjF7wRbxoA86miu85z/CJe/W7N
         +lPBON+6l2/3zY2C4zTCTvEbboyDzkIJ3+U/i3U2I5VZG6RmhhD25VBpABve0G1N9IJi
         HOiw==
X-Gm-Message-State: ACrzQf1MaB9SX79dcDwyCoqfFj19/t06brqDvJK6+iytWH7cgQXC6jcr
        RbjLFolkc7mnn7SAospDDxs=
X-Google-Smtp-Source: AMsMyM7cgeXY+NWEal5v1KVDsWJHP0aMxV0ltnds59gS2+yMdyWKN05KmRTw+61XgMyHyFlrxMKe2g==
X-Received: by 2002:a05:6a00:ac6:b0:530:3197:48b6 with SMTP id c6-20020a056a000ac600b00530319748b6mr50472097pfl.80.1667824153467;
        Mon, 07 Nov 2022 04:29:13 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id j7-20020a170902758700b0017f7e0f4a4esm4910492pll.35.2022.11.07.04.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:29:12 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>, Sebastien Buisson <sbuisson@ddn.com>,
        Maloo <maloo@whamcloud.com>, Li Dongyang <dongyangli@ddn.com>,
        Andreas Dilger <adilger@whamcloud.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFCv1 67/72] sec: support encrypted files handling in pfsck mode
Date:   Mon,  7 Nov 2022 17:51:55 +0530
Message-Id: <77a302b36f3576b9a9f7ef6e42bc1ef939227090.1667822612.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1667822611.git.ritesh.list@gmail.com>
References: <cover.1667822611.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Sebastien Buisson <sbuisson@ddn.com>

e2fsck needs to be improved in order to support encrypted files
handling in parallel fsck mode. The e2fsck_merge_encrypted_info()
function is added to merge encrypted inodes info collected from
different threads in pass1, so that it can be used in pass2.

Signed-off-by: Sebastien Buisson <sbuisson@ddn.com>
Tested-by: Maloo <maloo@whamcloud.com>
Reviewed-by: Li Dongyang <dongyangli@ddn.com>
Reviewed-by: Andreas Dilger <adilger@whamcloud.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 e2fsck/e2fsck.h          |   2 +
 e2fsck/encrypted_files.c | 139 +++++++++++++++++++++++++++++++++++++++
 e2fsck/pass1.c           |  26 +++++++-
 3 files changed, 164 insertions(+), 3 deletions(-)

diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index 1e82b048..e4fb782a 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -642,6 +642,8 @@ __u32 find_encryption_policy(e2fsck_t ctx, ext2_ino_t ino);
 
 void destroy_encryption_policy_map(e2fsck_t ctx);
 void destroy_encrypted_file_info(e2fsck_t ctx);
+int e2fsck_merge_encrypted_info(e2fsck_t ctx, struct encrypted_file_info *src,
+				struct encrypted_file_info *dest);
 
 /* extents.c */
 errcode_t e2fsck_rebuild_extents_later(e2fsck_t ctx, ext2_ino_t ino);
diff --git a/e2fsck/encrypted_files.c b/e2fsck/encrypted_files.c
index 16be2d6d..53e03a62 100644
--- a/e2fsck/encrypted_files.c
+++ b/e2fsck/encrypted_files.c
@@ -456,3 +456,142 @@ void destroy_encrypted_file_info(e2fsck_t ctx)
 		ctx->encrypted_files = NULL;
 	}
 }
+
+/**
+ * Search policy matching @policy in @info->policies
+ * @ctx: e2fsck context
+ * @info: encrypted_file_info to look into
+ * @policy: the policy we are looking for
+ * @parent: (out) last known parent, useful to insert a new leaf
+ *	    in @info->policies
+ *
+ * Return: id of found policy on success, -1 if no matching policy found.
+ */
+static inline int search_policy(e2fsck_t ctx, struct encrypted_file_info *info,
+				union fscrypt_policy policy,
+				struct rb_node **parent)
+{
+	struct rb_node *n = info->policies.rb_node;
+	struct policy_map_entry *entry;
+
+	while (n) {
+		int res;
+
+		*parent = n;
+		entry = ext2fs_rb_entry(n, struct policy_map_entry, node);
+		res = cmp_fscrypt_policies(ctx, &policy, &entry->policy);
+		if (res < 0)
+			n = n->rb_left;
+		else if (res > 0)
+			n = n->rb_right;
+		else
+			return entry->policy_id;
+	}
+	return -1;
+}
+
+/*
+ * Merge @src encrypted info into @dest
+ */
+int e2fsck_merge_encrypted_info(e2fsck_t ctx, struct encrypted_file_info *src,
+				 struct encrypted_file_info *dest)
+{
+	struct rb_root *src_policies = &src->policies;
+	__u32 *policy_trans;
+	int i, rc = 0;
+
+	if (dest->file_ranges[src->file_ranges_count - 1].last_ino >
+	    src->file_ranges[0].first_ino) {
+		/* Should never get here */
+		fatal_error(ctx, "Encrypted inodes processed out of order");
+	}
+
+	rc = ext2fs_get_array(src->next_policy_id, sizeof(__u32),
+			      &policy_trans);
+	if (rc)
+		return rc;
+
+	/* First, deal with the encryption policy => ID map.
+	 * Compare encryption policies in src with policies already recorded
+	 * in dest. It can be similar policies, but recorded with a different
+	 * id, so policy_trans array converts policy ids in src to ids in dest.
+	 * This loop examines each policy in src->policies rb tree, updates
+	 * policy_trans, and removes the entry from src, so that src->policies
+	 * rb tree is cleaned up at the end of the loop.
+	 */
+	while (!ext2fs_rb_empty_root(src_policies)) {
+		struct policy_map_entry *entry, *newentry;
+		struct rb_node *new, *parent = NULL;
+		int existing_polid;
+
+		entry = ext2fs_rb_entry(src_policies->rb_node,
+					struct policy_map_entry, node);
+		existing_polid = search_policy(ctx, dest,
+					       entry->policy, &parent);
+		if (existing_polid >= 0) {
+			/* The policy in src is already recorded in dest,
+			 * so just update its id.
+			 */
+			policy_trans[entry->policy_id] = existing_polid;
+		} else {
+			/* The policy in src is new to dest, so insert it
+			 * with the next available id (its original id could
+			 * be already used in dest).
+			 */
+			rc = ext2fs_get_mem(sizeof(*newentry), &newentry);
+			if (rc)
+				goto out_merge;
+			newentry->policy_id = dest->next_policy_id++;
+			newentry->policy = entry->policy;
+			ext2fs_rb_link_node(&newentry->node, parent, &new);
+			ext2fs_rb_insert_color(&newentry->node,
+					       &dest->policies);
+			policy_trans[entry->policy_id] = newentry->policy_id;
+		}
+		ext2fs_rb_erase(&entry->node, src_policies);
+		ext2fs_free_mem(&entry);
+	}
+
+	/* Second, deal with the inode number => encryption policy ID map. */
+	if (dest->file_ranges_capacity <
+	    dest->file_ranges_count + src->file_ranges_count) {
+		/* dest->file_ranges is too short, increase its capacity. */
+		size_t new_capacity = dest->file_ranges_count +
+			src->file_ranges_count;
+
+		/* Make sure we at least double the capacity. */
+		if (new_capacity < (dest->file_ranges_capacity * 2))
+			new_capacity = dest->file_ranges_capacity * 2;
+
+		/* We won't need more than the filesystem's inode count. */
+		if (new_capacity > ctx->fs->super->s_inodes_count)
+			new_capacity = ctx->fs->super->s_inodes_count;
+
+		rc = ext2fs_resize_mem(dest->file_ranges_capacity *
+				       sizeof(struct encrypted_file_range),
+				       new_capacity *
+				       sizeof(struct encrypted_file_range),
+				       &dest->file_ranges);
+		if (rc) {
+			fix_problem(ctx, PR_1_ALLOCATE_ENCRYPTED_INODE_LIST,
+				    NULL);
+			/* Should never get here */
+			ctx->flags |= E2F_FLAG_ABORT;
+			goto out_merge;
+		}
+
+		dest->file_ranges_capacity = new_capacity;
+	}
+	/* Copy file ranges from src to dest. */
+	for (i = 0; i < src->file_ranges_count; i++) {
+		/* Make sure to convert policy ids in src. */
+		src->file_ranges[i].policy_id =
+			policy_trans[src->file_ranges[i].policy_id];
+		dest->file_ranges[dest->file_ranges_count++] =
+			src->file_ranges[i];
+	}
+
+out_merge:
+	ext2fs_free_mem(&policy_trans);
+	return rc;
+}
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 7345c96d..e7dc017c 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2411,9 +2411,6 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 		ctx->ea_block_quota_inodes = 0;
 	}
 
-	/* We don't need the encryption policy => ID map any more */
-	destroy_encryption_policy_map(ctx);
-
 	if (ctx->flags & E2F_FLAG_RESTART) {
 		/*
 		 * Only the master copy of the superblock and block
@@ -2703,6 +2700,23 @@ static void e2fsck_pass1_merge_dx_dir(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 	e2fsck_merge_dx_dir(global_ctx, thread_ctx);
 }
 
+static int e2fsck_pass1_merge_encrypted_info(e2fsck_t global_ctx,
+					      e2fsck_t thread_ctx)
+{
+	if (thread_ctx->encrypted_files == NULL)
+		return 0;
+
+	if (global_ctx->encrypted_files == NULL) {
+		global_ctx->encrypted_files = thread_ctx->encrypted_files;
+		thread_ctx->encrypted_files = NULL;
+		return 0;
+	}
+
+	return e2fsck_merge_encrypted_info(global_ctx,
+					   thread_ctx->encrypted_files,
+					   global_ctx->encrypted_files);
+}
+
 static inline errcode_t
 e2fsck_pass1_merge_icount(ext2_icount_t *dest_icount,
 			  ext2_icount_t *src_icount)
@@ -2963,6 +2977,12 @@ static errcode_t e2fsck_pass1_merge_context(e2fsck_t global_ctx,
 
 	e2fsck_pass1_merge_dir_info(global_ctx, thread_ctx);
 	e2fsck_pass1_merge_dx_dir(global_ctx, thread_ctx);
+	retval = e2fsck_pass1_merge_encrypted_info(global_ctx, thread_ctx);
+	if (retval) {
+		com_err(global_ctx->program_name, 0,
+			_("while merging encrypted info\n"));
+		return retval;
+	}
 
 	retval = ext2fs_merge_fs(&(thread_ctx->fs));
 	if (retval) {
-- 
2.37.3

