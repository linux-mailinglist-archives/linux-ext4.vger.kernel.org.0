Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4C361F2E2
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbiKGMXH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbiKGMXG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:23:06 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEA5633D
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:23:06 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id q1-20020a17090a750100b002139ec1e999so10133320pjk.1
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ohcYnALKAlw5VG/FCKGNphojrvBOufLF01HC/abJirE=;
        b=RU74Gbrm8UAIvnuRDq+dwgTB1o/kvDFIhOIumAj1Wo34vKavre1HCd8z7An7aCQJvF
         O6TkLnBfYpfEgULi0DdeIoNLRaekBA/Wlj2oAoOnJ9oVwT3G9PgFyHK2HsWKHIGyYw75
         EgTR2eltYagv0Fu2kNn/P5rpW96EtRHaCrVIXcmwGxyMsQHY2mDTs47dMTfqJcm80ygP
         LcJv2qzHNbcYc2k/vo6YGL8HZ+C4MN/+xZOOlngypCEKbVJn4DdeCq45lNS3oDfEvWzd
         DUDSUeeej/2WWDxB3XwaXZSHkv7cjnHvHMgX4RQNI+Sk/pfC9TkLp/y4uzHlxdRLX8gu
         ZIeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ohcYnALKAlw5VG/FCKGNphojrvBOufLF01HC/abJirE=;
        b=AytWeNgcGwfT7BsI5km1oMvJ7OKVsv11QGOfSpn8kKigsZCEM6V4xsRjKsKhUJmTMu
         pp626F3pmAYEsfKZa3tHnrBC+2oxB2CeGlL2xmxm8exmDcKv/F/G31QPSfRoRCzuAT5F
         KeGSj83fuoxubvf9og3cKqLDkafRhekHRuyfT9iwtJxDipauBH7hm8nwfcK5/y07fiE5
         b/Gm1Htj3MGymTlmA1mkJaxB1yA25chteUy/67YYf0hea+QNc+BZ+SUPD7OTCqAdupLY
         ZCPRZLfLp3/p9D8Ohe8+DrboJyWtHJsZKYVfpW2bP55eV6BuZ0hLCOSwujm/F2PrqBp9
         Sehg==
X-Gm-Message-State: ACrzQf1K/rZDaYxLEqCZ+V9XEGUERdU9cxMCaxiaxVZS9MjBFdyUa75j
        QTgTqP63giDVxheVnj9BF20=
X-Google-Smtp-Source: AMsMyM59oazQiin2a7AWOtpIHky1oStc8SX/uJtMsoCiVcCYpwGicgi8mzf1czK/qKsyjyGfsYccLw==
X-Received: by 2002:a17:90b:1113:b0:216:616c:5fa0 with SMTP id gi19-20020a17090b111300b00216616c5fa0mr21327182pjb.225.1667823785568;
        Mon, 07 Nov 2022 04:23:05 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id nu14-20020a17090b1b0e00b0020d9c2f6c39sm6095431pjb.34.2022.11.07.04.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:23:04 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFCv1 07/72] libext2fs: Add rbtree bitmap merge logic
Date:   Mon,  7 Nov 2022 17:50:55 +0530
Message-Id: <a5e8718e7e5e178f2c6cdefae918c0b64ebe3c15.1667822611.git.ritesh.list@gmail.com>
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

From: Wang Shilong <wshilong@ddn.com>

This adds rbtree bitmap merge logic.

Signed-off-by: Li Xi <lixi@ddn.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
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
2.37.3

