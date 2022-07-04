Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B135C564E46
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Jul 2022 09:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbiGDHHp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 4 Jul 2022 03:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbiGDHHm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 4 Jul 2022 03:07:42 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78176271E
        for <linux-ext4@vger.kernel.org>; Mon,  4 Jul 2022 00:07:41 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id a15so1720541pjs.0
        for <linux-ext4@vger.kernel.org>; Mon, 04 Jul 2022 00:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rHjB8NkCalfqthCh/ZcteQS9lRQhjIFdpZj41bFLeZk=;
        b=HcJOUjDIroufAspILNCRTxIyN4Lan8Qc8rRE5KGArGP9t1s1hiXUA0uIT0JVbELf2g
         rKFuMVuNiar1WKkDlZbl+nPxXkEQ5kWBcpIFJApmbUv2mtDf7k0wdcHKpHkp1vAOT9vb
         G30BDAk/83KkiTu9m4DY23nm6CDsFxV1ksoAtqoByEmR8OGUy9ll/jQP4LurYxdTaG7j
         IkktWiymTrbky30XsAy5ScwJZWmolL7C0m3cdhX9D+hnR9YoWj0pqZoLTjOFjGz54r00
         W+g8QIXy9Vl6+fTR1ygIquu+4CC+XREtVBzKZ6zQiVgHBcP5uPg+0g1FkkbseQ8gMqXA
         /zMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rHjB8NkCalfqthCh/ZcteQS9lRQhjIFdpZj41bFLeZk=;
        b=pO3jyKFxikzBGNIad9+75uHWipTgI6sv8nggE3zi53Se8MjvlKC+RF10ay/hSEaj2C
         G4oGNmQR4Q9HmHbd2kmUbpkgSNDFFbq8pEcYwicfmYT6iThvjCewJXyICO6ZJtb43Zti
         YC7xGdZ/TY8FHG1wewoZ45A72QkCHTrLTwTi7oDU0E/1Ze4ugZ3Q0PRd+o1vCaEwS4/2
         Ejd0aJpzGVRLmoWtFFme62WhLfYl+xLH23O2Qsdqsa3CxvNMlBRYEbGAm6x24KX7ERl/
         vQlyWGEFfGaEM148aML+hgn3Z8445ZkA9nqIghP42t2OMs6X7yKVXXXTfkohYKy3tVIh
         zXrQ==
X-Gm-Message-State: AJIora/ysCUYdyTyWlbuUk+Nogp8uwDwAIGZbvH6xUFhoaoBI2xzJPhx
        67cVAVODQDrQsv5jpgNwgYA=
X-Google-Smtp-Source: AGRyM1sFPdbvEzg/74AE40Q9As7UeN1HKsf358bazHPlwLQXYI8kkt2lsfxfBoA5jVTZb71yWgYdyQ==
X-Received: by 2002:a17:902:ef4f:b0:16b:8744:6c5f with SMTP id e15-20020a170902ef4f00b0016b87446c5fmr32582664plx.60.1656918460863;
        Mon, 04 Jul 2022 00:07:40 -0700 (PDT)
Received: from localhost ([2406:7400:63:cb1d:811:33e9:9bc2:d40])
        by smtp.gmail.com with ESMTPSA id a3-20020a1709027e4300b0016bb24f5d19sm8024619pln.209.2022.07.04.00.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 00:07:40 -0700 (PDT)
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Wang Shilong <wshilong@ddn.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFC 05/13] libext2fs: blkmap64_rb: Add rbtree bmap merge logic changes
Date:   Mon,  4 Jul 2022 12:36:54 +0530
Message-Id: <bb03a40f73af19434792a87a1ee32613d8c00c32.1656912918.git.ritesh.list@gmail.com>
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

Add rbtree bmap merge logic changes.

Signed-off-by: Ritesh Harjani <ritesh.list@gmail.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 lib/ext2fs/blkmap64_rb.c | 65 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/lib/ext2fs/blkmap64_rb.c b/lib/ext2fs/blkmap64_rb.c
index 0df58dc7..d7c88aef 100644
--- a/lib/ext2fs/blkmap64_rb.c
+++ b/lib/ext2fs/blkmap64_rb.c
@@ -977,11 +977,76 @@ static void rb_print_stats(ext2fs_generic_bitmap_64 bitmap EXT2FS_ATTR((unused))
 }
 #endif
 
+static errcode_t rb_merge_bmap(ext2fs_generic_bitmap_64 src,
+			       ext2fs_generic_bitmap_64 dest,
+			       ext2fs_generic_bitmap_64 dup,
+			       ext2fs_generic_bitmap_64 dup_allowed)
+{
+	struct ext2fs_rb_private *src_bp, *dest_bp, *dup_bp = NULL;
+	struct bmap_rb_extent *src_ext;
+	struct rb_node *src_node;
+	errcode_t retval = 0;
+	int dup_found = 0;
+	__u64 i;
+
+	src_bp = (struct ext2fs_rb_private *) src->private;
+	dest_bp = (struct ext2fs_rb_private *) dest->private;
+	if (dup)
+		dup_bp = (struct ext2fs_rb_private *)dup->private;
+	src_bp->rcursor = NULL;
+	dest_bp->rcursor = NULL;
+
+	src_node = ext2fs_rb_first(&src_bp->root);
+	while (src_node) {
+		src_ext = node_to_extent(src_node);
+		retval = rb_test_clear_bmap_extent(dest,
+					src_ext->start + src->start,
+					src_ext->count);
+		if (retval) {
+			rb_insert_extent(src_ext->start, src_ext->count,
+					 dest_bp);
+			goto next;
+		}
+
+		/* unlikely case, do it one by one block */
+		for (i = src_ext->start;
+		     i < src_ext->start + src_ext->count; i++) {
+			retval = rb_test_clear_bmap_extent(dest, i + src->start, 1);
+			if (retval) {
+				rb_insert_extent(i, 1, dest_bp);
+				continue;
+			}
+			if (dup_allowed) {
+				retval = rb_test_clear_bmap_extent(dup_allowed,
+							i + src->start, 1);
+				/* not existed in dup_allowed */
+				if (retval) {
+					dup_found = 1;
+					if (dup_bp)
+						rb_insert_extent(i, 1, dup_bp);
+				} /* else we conside it not duplicated */
+			} else {
+				if (dup_bp)
+					rb_insert_extent(i, 1, dup_bp);
+				dup_found = 1;
+			}
+		}
+next:
+		src_node = ext2fs_rb_next(src_node);
+	}
+
+	if (dup_found && dup)
+		return EEXIST;
+
+	return 0;
+}
+
 struct ext2_bitmap_ops ext2fs_blkmap64_rbtree = {
 	.type = EXT2FS_BMAP64_RBTREE,
 	.new_bmap = rb_new_bmap,
 	.free_bmap = rb_free_bmap,
 	.copy_bmap = rb_copy_bmap,
+	.merge_bmap = rb_merge_bmap,
 	.resize_bmap = rb_resize_bmap,
 	.mark_bmap = rb_mark_bmap,
 	.unmark_bmap = rb_unmark_bmap,
-- 
2.35.3

