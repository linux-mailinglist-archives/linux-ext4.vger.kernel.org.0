Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7DD61F2EF
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbiKGMYN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbiKGMYK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:24:10 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC7E1AD9C
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:24:07 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id v3so10308774pgh.4
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cMMzTstL0mOBrRKHUSn6nbcgtNZIGsnpHy2V81lrAT0=;
        b=azffTayYehRK4m66YqKjjkG9YPDNTT/hTpl6ajfD/tNP4GT1wWNy5BBhIhm8IEhPIf
         eJCbq1Lk8BUgsZEdP55RxhiXZPrXogNekXG9popw44LAwFhSxXZOlvwp6kNh+sbikpoY
         IlFkm4JkqAOk0JHeNF4Bj8YWPH0Iu3a9tmCUl68gILZloOZSuK9cFFS2kGOeH3CM4LDs
         1qo9Wlp50xVpYNU1fVzE4LQ/nKEWqt/3UlZBFz36v/jkWIZDCgDFfwexo7nMExsGDFRU
         CgqLuLqoQzIizOV7uP47/TWh1rV41k9DzYpAzuFDg8iJNkakgT4dAEftUauiKs3lH1No
         emoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cMMzTstL0mOBrRKHUSn6nbcgtNZIGsnpHy2V81lrAT0=;
        b=oURjR/g0QAD/PH10iS5jLbQKtijYcBci+dGj3eaVGX9doa/soZTij8BvvkmClVXanc
         Qxh7E+Kmbi9XwRc3gEGqDYnode2eltMx6Taq+LgNhxWO6ymCUf23CI3RSs4alN7bnxLc
         vBmXymyy3Yrd+g2QHZJ3BsLLv1DO9+iK40CejXbA893FFyllhTDpYPGHQPqq7sKn3rLT
         9DaTBQla5aGFGiTNubvd5dbTcJfWSPnf+arLO+3f1aK5Ql4PGgCR0aSF3NwoRjHAzFIO
         F7LMFFehKsnCmmWh7SyaYUCmmthn2iLCykdY5oU4n5gh8vj4DPAodfxmMpyryy9tz2Ae
         v5IQ==
X-Gm-Message-State: ACrzQf12Vo8rSuT8BkZC+D0syqAofWJbEb3V0XWiPYNt7SJ4IPxAXXfB
        sexRtsNe4R6LJ9g+1fUBcOI=
X-Google-Smtp-Source: AMsMyM4JzDscFprK/IIqtU/7byc++IuGcQBdOnzNhlCxjYWGCre4TQPz3tEgg/xS6qc6W9penG+HRw==
X-Received: by 2002:a05:6a00:248c:b0:56d:b13b:e672 with SMTP id c12-20020a056a00248c00b0056db13be672mr35312925pfv.47.1667823846543;
        Mon, 07 Nov 2022 04:24:06 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id l15-20020a170903244f00b001869d71228bsm4884357pls.170.2022.11.07.04.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:24:05 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFCv1 17/72] libext2fs: Add support for ext2fs_test_block_bitmap_range2_valid()
Date:   Mon,  7 Nov 2022 17:51:05 +0530
Message-Id: <9015303c19c1b3474d880409db60627b0a9de37f.1667822611.git.ritesh.list@gmail.com>
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

This adds the support in libext2fs to query whether the block range is
valid or not (within range) given the block bitmap.
Also to avoid duplicate warning messages in case of invalid blocks.

This will be later used in pass1 of e2fsck is_blocks_used() function to
check whether the given block range is valid or not to avoid duplicate
warning resulting from ext2fs_test_block_bitmap_range2()

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 lib/ext2fs/bitops.h       |  2 ++
 lib/ext2fs/gen_bitmap64.c | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/lib/ext2fs/bitops.h b/lib/ext2fs/bitops.h
index 505b3c9c..1facc8dd 100644
--- a/lib/ext2fs/bitops.h
+++ b/lib/ext2fs/bitops.h
@@ -120,6 +120,8 @@ extern int ext2fs_test_block_bitmap_range(ext2fs_block_bitmap bitmap,
 extern void ext2fs_set_bitmap_padding(ext2fs_generic_bitmap map);
 extern __u32 ext2fs_get_generic_bitmap_start(ext2fs_generic_bitmap bitmap);
 extern __u32 ext2fs_get_generic_bitmap_end(ext2fs_generic_bitmap bitmap);
+extern int ext2fs_test_block_bitmap_range2_valid(ext2fs_block_bitmap bitmap,
+						blk64_t block, unsigned int num);
 
 /* 64-bit versions */
 
diff --git a/lib/ext2fs/gen_bitmap64.c b/lib/ext2fs/gen_bitmap64.c
index c31f942f..a9637cb5 100644
--- a/lib/ext2fs/gen_bitmap64.c
+++ b/lib/ext2fs/gen_bitmap64.c
@@ -731,6 +731,39 @@ int ext2fs_test_block_bitmap_range2(ext2fs_block_bitmap gen_bmap,
 	return bmap->bitmap_ops->test_clear_bmap_extent(bmap, block, num);
 }
 
+int ext2fs_test_block_bitmap_range2_valid(ext2fs_block_bitmap bitmap,
+					  blk64_t block, unsigned int num)
+{
+	ext2fs_generic_bitmap_64 bmap = (ext2fs_generic_bitmap_64)bitmap;
+	__u64	end = block + num;
+
+	if (!bmap)
+		return 0;
+
+	if (EXT2FS_IS_32_BITMAP(bmap)) {
+		if ((block & ~0xffffffffULL) ||
+		    ((block+num-1) & ~0xffffffffULL)) {
+			return 0;
+		}
+	}
+
+	if (!EXT2FS_IS_64_BITMAP(bmap))
+		return 0;
+
+	/* convert to clusters if necessary */
+	block >>= bmap->cluster_bits;
+	end += (1 << bmap->cluster_bits) - 1;
+	end >>= bmap->cluster_bits;
+	num = end - block;
+
+	if ((block < bmap->start) || (block > bmap->end) ||
+	    (block+num-1 > bmap->end))
+		return 0;
+
+	return 1;
+}
+
+
 void ext2fs_mark_block_bitmap_range2(ext2fs_block_bitmap gen_bmap,
 				     blk64_t block, unsigned int num)
 {
-- 
2.37.3

