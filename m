Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E4561F2DD
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbiKGMWm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbiKGMWm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:22:42 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4740B6365
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:22:41 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id y203so10448762pfb.4
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jXoIoNClKEmqFxAE6Ld3vjNDtgFGvZES84QuwnIxgtE=;
        b=fgD/iZ6lwmpoNyZrGPWMFTQ99OfZAwkMQbg8bIoVreTE/nu/4FcS+qGGUF1FXxoOuW
         Xm+LVfpShldCa3ifyQxrDibMCAoZxUcVFy/VDBEpSkTaPBwJ7UQGDRBx1ICdCGFGZ9qd
         Xb9zmxl9Zpv4LinHGZM4+MBFgzQ2W8K2/Bt6FwTNAtDnl3n4bQ3CUSLIJBnR5kWdomeE
         C3Mb0DhecA2wF2lAxLIiAlGyivIbZHQgbgigoxQxqewDwRpy+l2vXqMMTUwe9vzoBuXh
         7YZLb7u93HxpEalsYHH9Av/BQPzjtSJG0pw++qBRQSaOCuBvZ9cZ8zKHGxq+kje0kN3Q
         F7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jXoIoNClKEmqFxAE6Ld3vjNDtgFGvZES84QuwnIxgtE=;
        b=ENpIgxD2H4Qg6K/8AO8sQCX70DpSDpgGDy+L5i+6NgdQe6HwRSIHYNvzEByCZGTbBT
         EMQlVUjWt/rfio/5ISI1QdC+wEFea+Opu+UJC4jQBDQ+sk9OWk6Bl+gnOvfyjD7XK9NG
         AuUBVqJqzqoeCMBhOTuKGyTWtCqtAkh/dLWWmkgACidUgNm4LFQ8bya+3Z5urOqAMwU7
         H99XlKRBsPAbWCCiks7s5dDr3lar2XI6ZY3+K/UiWFIrPYEbX3T5YSeqXayDxjYPrib5
         FJO9dWmMnHkQMigbE+484pLcQGZCoYG1xpFgeus+4ybjefyvZftuzOPMZtErys5VchiU
         3CQw==
X-Gm-Message-State: ACrzQf0bROZQ1AFLJ5DGToVq7btFJYvw8uJhJEK7bxvaByLi9YZZy5Jf
        EKwM93TTi398FLV4SjmYGGuyVn4w8Po=
X-Google-Smtp-Source: AMsMyM54tzpbro4An/Ujti04W2iNDtPqm/1f3EYwYtrcSEPzjXlaTRmzIAf0D1J5rCjzQxytMBfBFQ==
X-Received: by 2002:a62:1d52:0:b0:56b:f472:55e7 with SMTP id d79-20020a621d52000000b0056bf47255e7mr50552192pfd.63.1667823760806;
        Mon, 07 Nov 2022 04:22:40 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id e18-20020a63e012000000b00470275c8d6dsm4034156pgh.10.2022.11.07.04.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:22:40 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFCv1 03/72] blkmap64_ba: Add common helper for bits size calculation
Date:   Mon,  7 Nov 2022 17:50:51 +0530
Message-Id: <728edcaf0eb7fca7e347183799b5dca743236db0.1667822611.git.ritesh.list@gmail.com>
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

Just a quick common helper for bits size calculation.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 lib/ext2fs/blkmap64_ba.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/lib/ext2fs/blkmap64_ba.c b/lib/ext2fs/blkmap64_ba.c
index 5d8f1548..4e7007f0 100644
--- a/lib/ext2fs/blkmap64_ba.c
+++ b/lib/ext2fs/blkmap64_ba.c
@@ -40,6 +40,13 @@ struct ext2fs_ba_private_struct {
 
 typedef struct ext2fs_ba_private_struct *ext2fs_ba_private;
 
+#define ba_bits_size(start, end) ((((end) - (start)) / 8 + 1))
+
+static size_t ba_bitmap_size(ext2fs_generic_bitmap_64 bitmap)
+{
+	return (size_t) ba_bits_size(bitmap->start, bitmap->real_end);
+}
+
 static errcode_t ba_alloc_private_data (ext2fs_generic_bitmap_64 bitmap)
 {
 	ext2fs_ba_private bp;
@@ -56,7 +63,7 @@ static errcode_t ba_alloc_private_data (ext2fs_generic_bitmap_64 bitmap)
 	if (retval)
 		return retval;
 
-	size = (size_t) (((bitmap->real_end - bitmap->start) / 8) + 1);
+	size = ba_bitmap_size(bitmap);
 
 	retval = ext2fs_get_mem(size, &bp->bitarray);
 	if (retval) {
@@ -80,7 +87,7 @@ static errcode_t ba_new_bmap(ext2_filsys fs EXT2FS_ATTR((unused)),
 		return retval;
 
 	bp = (ext2fs_ba_private) bitmap->private;
-	size = (size_t) (((bitmap->real_end - bitmap->start) / 8) + 1);
+	size = ba_bitmap_size(bitmap);
 	memset(bp->bitarray, 0, size);
 
 	return 0;
@@ -115,7 +122,7 @@ static errcode_t ba_copy_bmap(ext2fs_generic_bitmap_64 src,
 
 	dest_bp = (ext2fs_ba_private) dest->private;
 
-	size = (size_t) (((src->real_end - src->start) / 8) + 1);
+	size = ba_bitmap_size(src);
 	memcpy (dest_bp->bitarray, src_bp->bitarray, size);
 
 	return 0;
@@ -145,8 +152,8 @@ static errcode_t ba_resize_bmap(ext2fs_generic_bitmap_64 bmap,
 		return 0;
 	}
 
-	size = ((bmap->real_end - bmap->start) / 8) + 1;
-	new_size = ((new_real_end - bmap->start) / 8) + 1;
+	size = ba_bitmap_size(bmap);
+	new_size = ba_bits_size(new_real_end, bmap->start);
 
 	if (size != new_size) {
 		retval = ext2fs_resize_mem(size, new_size, &bp->bitarray);
@@ -306,8 +313,7 @@ static void ba_clear_bmap(ext2fs_generic_bitmap_64 bitmap)
 {
 	ext2fs_ba_private bp = (ext2fs_ba_private) bitmap->private;
 
-	memset(bp->bitarray, 0,
-	       (size_t) (((bitmap->real_end - bitmap->start) / 8) + 1));
+	memset(bp->bitarray, 0, ba_bitmap_size(bitmap));
 }
 
 #ifdef ENABLE_BMAP_STATS
-- 
2.37.3

