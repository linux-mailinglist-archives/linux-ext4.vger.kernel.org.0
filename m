Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF4D6564E3E
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Jul 2022 09:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbiGDHHj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 4 Jul 2022 03:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232620AbiGDHHi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 4 Jul 2022 03:07:38 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E4E26FD
        for <linux-ext4@vger.kernel.org>; Mon,  4 Jul 2022 00:07:36 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id e132so8152975pgc.5
        for <linux-ext4@vger.kernel.org>; Mon, 04 Jul 2022 00:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AkxvBqKQryD8JuZC09E0gSv5R5ME0HZkZNSHZol3Gyw=;
        b=OudxUgU4+dChHPE/OeNxppyDLFVHLUVQpYPQafV9bftjyZGETFSqyxPo5rSEHKtIsC
         qFnkCPsQeAjz3Ll9KLIWJzFBDt8Khyauwavir+95dvI/9kO0m0kblNQJej/yc9LKm1vq
         RL7SgfmqvNzoWc4fmf55Oi7mFvPrIiXyOdouZw63k52rDrhs9z5A3Sl7Rwk6rISon3Bg
         5V3syutxd0EXFBLraHplddKb0J0BX5gtGXKnuKvHRsBDW8t7/Y886ytNj8OHuOaZWYVg
         9ss0yMLxSfz6oQyAGkYM5of2GcRuiFRijg05mSZkQP95Ms0b6oqp2eI6bgIuTztLtTzl
         irzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AkxvBqKQryD8JuZC09E0gSv5R5ME0HZkZNSHZol3Gyw=;
        b=TUUR6om0xln6pfVfqq/B+q5JOv9Vklw8IoDT70EB5ELaZPl1ivY0WUJEZmSjSnaYyM
         gm5u5+y2P5O5zxEIszq83Fj84G4uTMgPxNo6Vi576PE6C9QdVvUuK8yoqNotfV3c9N57
         nD0LAhp+i220VEsdzoltt/bn80PcJcPyf7a90O63wbCABBeHFaDoSfXxVfpgxjaAX3c/
         wcstY1Ic0E9R0BCQ2RkSL/6OkhHnXx373BghbHYD/gd8YuzgspWBsM7WnDviwBbFaJov
         5KB9nrKZAwG82dctti4iUVDweHRV3eNee1oU6YfG0OgXJfJKYafNcJytfYrQNR4EfOU0
         pASA==
X-Gm-Message-State: AJIora/fAuY5KpLAwuS7gIYnL4zUrfFYuXZffFl4aufNbkhCbyfFcYG7
        937S4AmOD/6UWFGTNSlj09OcpUcyVNc=
X-Google-Smtp-Source: AGRyM1uPQQ4LLW/fdXFhasJ+5LdK5d/sjS86Th2wlpIpSkamnBun6YG3Q5RtUBJ7UGtUOuxtOYW/tg==
X-Received: by 2002:a63:8b43:0:b0:40d:1d04:bd7e with SMTP id j64-20020a638b43000000b0040d1d04bd7emr24500101pge.573.1656918455981;
        Mon, 04 Jul 2022 00:07:35 -0700 (PDT)
Received: from localhost ([2406:7400:63:cb1d:811:33e9:9bc2:d40])
        by smtp.gmail.com with ESMTPSA id x19-20020a056a00189300b0051b4e53c487sm20426432pfh.45.2022.07.04.00.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 00:07:35 -0700 (PDT)
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Wang Shilong <wshilong@ddn.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFC 04/13] ext2fs/bitmaps: Add merge bitmaps library abstraction changes
Date:   Mon,  4 Jul 2022 12:36:53 +0530
Message-Id: <0a6548f624347a8b9898150f9e5505031fe5a6ab.1656912918.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1656912918.git.ritesh.list@gmail.com>
References: <cover.1656912918.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

Add merge bitmaps library abstraction changes.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Ritesh Harjani <ritesh.list@gmail.com>
---
 lib/ext2fs/bitmaps.c      |  9 +++++++++
 lib/ext2fs/bmap64.h       |  5 +++++
 lib/ext2fs/ext2fs.h       |  8 ++++++++
 lib/ext2fs/gen_bitmap64.c | 29 +++++++++++++++++++++++++++++
 4 files changed, 51 insertions(+)

diff --git a/lib/ext2fs/bitmaps.c b/lib/ext2fs/bitmaps.c
index 834a3962..23072a11 100644
--- a/lib/ext2fs/bitmaps.c
+++ b/lib/ext2fs/bitmaps.c
@@ -45,6 +45,15 @@ errcode_t ext2fs_copy_bitmap(ext2fs_generic_bitmap src,
 {
 	return (ext2fs_copy_generic_bmap(src, dest));
 }
+
+errcode_t ext2fs_merge_bitmap(ext2fs_generic_bitmap src,
+							  ext2fs_generic_bitmap dst,
+							  ext2fs_generic_bitmap dup,
+							  ext2fs_generic_bitmap dup_allowed)
+{
+	return ext2fs_merge_generic_bmap(src, dst, dup, dup_allowed);
+}
+
 void ext2fs_set_bitmap_padding(ext2fs_generic_bitmap map)
 {
 	ext2fs_set_generic_bmap_padding(map);
diff --git a/lib/ext2fs/bmap64.h b/lib/ext2fs/bmap64.h
index de334548..4c254892 100644
--- a/lib/ext2fs/bmap64.h
+++ b/lib/ext2fs/bmap64.h
@@ -100,6 +100,11 @@ struct ext2_bitmap_ops {
 	 * May be NULL, in which case a generic function is used. */
 	errcode_t (*find_first_set)(ext2fs_generic_bitmap_64 bitmap,
 				    __u64 start, __u64 end, __u64 *out);
+
+	errcode_t (*merge_bmap)(ext2fs_generic_bitmap_64 src,
+							ext2fs_generic_bitmap_64 dest,
+							ext2fs_generic_bitmap_64 dup,
+							ext2fs_generic_bitmap_64 dup_allowed);
 };
 
 extern struct ext2_bitmap_ops ext2fs_blkmap64_bitarray;
diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index 68f9c1fe..c18849d7 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -867,6 +867,10 @@ extern void ext2fs_free_block_bitmap(ext2fs_block_bitmap bitmap);
 extern void ext2fs_free_inode_bitmap(ext2fs_inode_bitmap bitmap);
 extern errcode_t ext2fs_copy_bitmap(ext2fs_generic_bitmap src,
 				    ext2fs_generic_bitmap *dest);
+extern errcode_t ext2fs_merge_bitmap(ext2fs_generic_bitmap src,
+							  ext2fs_generic_bitmap dst,
+							  ext2fs_generic_bitmap dup,
+							  ext2fs_generic_bitmap dup_allowed);
 extern errcode_t ext2fs_allocate_block_bitmap(ext2_filsys fs,
 					      const char *descr,
 					      ext2fs_block_bitmap *ret);
@@ -1455,6 +1459,10 @@ errcode_t ext2fs_alloc_generic_bmap(ext2_filsys fs, errcode_t magic,
 				    ext2fs_generic_bitmap *ret);
 errcode_t ext2fs_copy_generic_bmap(ext2fs_generic_bitmap src,
 				   ext2fs_generic_bitmap *dest);
+extern errcode_t ext2fs_merge_generic_bmap(ext2fs_generic_bitmap gen_src,
+							  ext2fs_generic_bitmap gen_dst,
+							  ext2fs_generic_bitmap gen_dup,
+							  ext2fs_generic_bitmap gen_dup_allowed);
 void ext2fs_clear_generic_bmap(ext2fs_generic_bitmap bitmap);
 errcode_t ext2fs_fudge_generic_bmap_end(ext2fs_generic_bitmap bitmap,
 					errcode_t neq,
diff --git a/lib/ext2fs/gen_bitmap64.c b/lib/ext2fs/gen_bitmap64.c
index 90c700ca..eea100b0 100644
--- a/lib/ext2fs/gen_bitmap64.c
+++ b/lib/ext2fs/gen_bitmap64.c
@@ -346,6 +346,35 @@ errcode_t ext2fs_copy_generic_bmap(ext2fs_generic_bitmap gen_src,
 	return 0;
 }
 
+errcode_t ext2fs_merge_generic_bmap(ext2fs_generic_bitmap gen_src,
+							  ext2fs_generic_bitmap gen_dst,
+							  ext2fs_generic_bitmap gen_dup,
+							  ext2fs_generic_bitmap gen_dup_allowed)
+{
+	ext2fs_generic_bitmap_64 src = (ext2fs_generic_bitmap_64) gen_src;
+	ext2fs_generic_bitmap_64 dst = (ext2fs_generic_bitmap_64) gen_dst;
+	ext2fs_generic_bitmap_64 dup = (ext2fs_generic_bitmap_64) gen_dup;
+	ext2fs_generic_bitmap_64 dup_allowed = (ext2fs_generic_bitmap_64) gen_dup_allowed;
+
+	if (!src || !dst)
+		return EINVAL;
+
+	if (!EXT2FS_IS_64_BITMAP(src) || !EXT2FS_IS_64_BITMAP(dst) ||
+	   (dup && !EXT2FS_IS_64_BITMAP(dup)) ||
+	   (dup_allowed && !EXT2FS_IS_64_BITMAP(dup_allowed)))
+		return EINVAL;
+
+	if (src->bitmap_ops != dst->bitmap_ops ||
+		(dup && dup->bitmap_ops != src->bitmap_ops) ||
+		(dup_allowed && dup_allowed->bitmap_ops != src->bitmap_ops))
+		return EINVAL;
+
+	if (!src->bitmap_ops->merge_bmap)
+		return EOPNOTSUPP;
+
+	return src->bitmap_ops->merge_bmap(src, dst, dup, dup_allowed);
+}
+
 errcode_t ext2fs_resize_generic_bmap(ext2fs_generic_bitmap gen_bmap,
 				     __u64 new_end,
 				     __u64 new_real_end)
-- 
2.35.3

