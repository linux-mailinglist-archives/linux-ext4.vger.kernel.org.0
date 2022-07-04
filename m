Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3581564E4B
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Jul 2022 09:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbiGDHIE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 4 Jul 2022 03:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232982AbiGDHHy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 4 Jul 2022 03:07:54 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454902717
        for <linux-ext4@vger.kernel.org>; Mon,  4 Jul 2022 00:07:46 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 9so8146503pgd.7
        for <linux-ext4@vger.kernel.org>; Mon, 04 Jul 2022 00:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z3TRSOORGF8URDv+X6mjTTIhwkPiRvkTKLI2OWvxJts=;
        b=VEw9guESA3cJWUKDv318cg9ZdMA2Q0rYs+cP5zHCYRVS4ZqDOICfipDWPV+gO2Zi9M
         xoHTWsim84hBpN/SRfM4KbklAocpDfnb/2kxeS52hIJYVJYx2aWoC/JDaW3I2cW3iOlc
         nTdL0xOXbHzoV+UzxaXkoMhVcEchhQTHwoM51TR3qMUbHgdhV4owDgmMnQhQ4rtx9G1e
         ogDxfBKtiCyXlfWN9sDbZ7NcHjfSyARjOv5Q4LjmbT+lycmU5KmRL8R0O/1RgC7QdAS/
         RhCWh9ClYchDpzWmbKDHJYg4NBCrvctewLyou2uerh3mEs82BB+tOu1oFCmH/Ro14NuF
         pGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z3TRSOORGF8URDv+X6mjTTIhwkPiRvkTKLI2OWvxJts=;
        b=Z3tw/6F/P/hqHUpst9yw9lZ43fnZx+LXtzaXVm+AFrVz8aoZje4su5Cw+8lU2rPKy5
         yx84+EjNb9R2xVas4snOaCFXYA7QjHIR/R37GZqVVfb09K2QB0sTqpb/LknNcAtpS0rA
         JA7Pd7WM2EgeO0PGnp1AE6rMhqxb4IC+4mLDnVbyI74Cqm/3p7/E6bqEz5X01QIwqIZj
         7ASAMFVsLGiZ4X+WHqC9GMfua5xcmOfPun5USaZV9pQAGjDHtIDE9A4oRNjbR0QLf4GW
         f+GgwO52P7Ts3XV5XbYM3zQeTFcE+kxu7Jy28cj1171fpyhd7awaKe5DDz9eATn4dbh+
         VcBg==
X-Gm-Message-State: AJIora+mkpVvm+9oIoWYpytXEg2pCzs6JTokoVSgC+vT6RKeRtKgeZ6P
        HgnNudOFiN42KjmTgyOY1Jc=
X-Google-Smtp-Source: AGRyM1tZqAYyMAc8StymAKcDVAQo7Mx50z9CE8w3wsrzIP1rZeaJ1Rg6/5uXxbXPxftHEvgCxrOZdQ==
X-Received: by 2002:a63:84c8:0:b0:40c:7d4a:ac66 with SMTP id k191-20020a6384c8000000b0040c7d4aac66mr23632680pgd.424.1656918465768;
        Mon, 04 Jul 2022 00:07:45 -0700 (PDT)
Received: from localhost ([2406:7400:63:cb1d:811:33e9:9bc2:d40])
        by smtp.gmail.com with ESMTPSA id r20-20020a170902be1400b0016b68cf6ae5sm15764160pls.226.2022.07.04.00.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 00:07:45 -0700 (PDT)
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFC 06/13] blkmap64_ba: Implement initial implementation of merge bitmaps
Date:   Mon,  4 Jul 2022 12:36:55 +0530
Message-Id: <2cd087afb18522029158f537edad49cb3f435e88.1656912918.git.ritesh.list@gmail.com>
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

DO NOT MERGE

Adding a basic merge implementation of bitarray for later
adding/supporting test cases w.r.t. libext2fs merge/clone API.

Signed-off-by: Ritesh Harjani <ritesh.list@gmail.com>
---
 lib/ext2fs/blkmap64_ba.c | 53 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/lib/ext2fs/blkmap64_ba.c b/lib/ext2fs/blkmap64_ba.c
index 4e7007f0..9a9f6563 100644
--- a/lib/ext2fs/blkmap64_ba.c
+++ b/lib/ext2fs/blkmap64_ba.c
@@ -12,6 +12,7 @@
 #include "config.h"
 #include <stdio.h>
 #include <string.h>
+#include <assert.h>
 #if HAVE_UNISTD_H
 #include <unistd.h>
 #endif
@@ -476,6 +477,55 @@ static errcode_t ba_find_first_set(ext2fs_generic_bitmap_64 bitmap,
 
 	return ENOENT;
 }
+errcode_t ba_merge_bmap(ext2fs_generic_bitmap_64 src,
+						ext2fs_generic_bitmap_64 dst,
+						ext2fs_generic_bitmap_64 dup,
+						ext2fs_generic_bitmap_64 dup_allowed)
+{
+	ext2fs_ba_private src_bp = (ext2fs_ba_private) src->private;
+	ext2fs_ba_private dst_bp = (ext2fs_ba_private) dst->private;
+
+	const unsigned char *src_pos = src_bp->bitarray;
+	const unsigned char *dst_pos = dst_bp->bitarray;
+	unsigned long count = src->real_end - src->start + 1;
+	unsigned long bitpos = src->start;
+
+	assert(src->start == dst->start);
+	assert(src->end == dst->end);
+	assert(src->real_end == dst->real_end);
+
+	// TODO add full support
+	// For now assuming the pos is aligned addr
+	assert(!(((uintptr_t)src_pos) & 0x07));
+
+	// 8-byte blocks compare
+	while (count >= 64) {
+		const __u64 src_val = *(const __u64 *)src_pos;
+		const __u64 dst_val = *(const __u64 *)dst_pos;
+		const __u64 sd_val = src_val & dst_val;
+
+		// TODO: Not implemented case to handle duplicates/dup_allowed case of EA
+		if (dup || dup_allowed)
+			assert(sd_val == 0);
+
+		*(__u64 *)dst_pos |= src_val;
+
+		src_pos += 8;
+		dst_pos += 8;
+		count -= 64;
+		bitpos += 64;
+	}
+
+	while (count-- > 0) {
+		// TODO: dup case not implemented yet.
+		if (ext2fs_test_bit64(bitpos, src_bp->bitarray))
+			assert(ext2fs_set_bit64(bitpos, dst_bp->bitarray) == 0);
+		bitpos++;
+	}
+
+	return 0;
+}
+
 
 struct ext2_bitmap_ops ext2fs_blkmap64_bitarray = {
 	.type = EXT2FS_BMAP64_BITARRAY,
@@ -494,5 +544,6 @@ struct ext2_bitmap_ops ext2fs_blkmap64_bitarray = {
 	.clear_bmap = ba_clear_bmap,
 	.print_stats = ba_print_stats,
 	.find_first_zero = ba_find_first_zero,
-	.find_first_set = ba_find_first_set
+	.find_first_set = ba_find_first_set,
+	.merge_bmap = ba_merge_bmap,
 };
-- 
2.35.3

