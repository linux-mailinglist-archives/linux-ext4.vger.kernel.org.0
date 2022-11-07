Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5977561F2F2
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbiKGMYP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbiKGMYN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:24:13 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428806247
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:24:13 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id k22so10448240pfd.3
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/wJhWS2aGvLD1Rzy6m9shGLETN6RBjRGDzQAAEc0ebw=;
        b=L9zXQk7s1hKr7oC1W6uzkSPg+65h4hWVhusIgbbV3utkHI7OGzUUibHE2tm6yZjxm6
         K1q/fsDBZxA+xUQxIIGrEFJ/ULylIVupMqvrqkX6seOQ8CQ5G0lAODPThekk7giV+ult
         kjs0cCcUNpimNfL1pEH1iYNNKHqHS52zeSMm5d50wuxT0zG8JwJLLVb9Dobi9byBmxh3
         ovhOHqoiB3FEcAD7MiZNvyx/UebBP+0Ar11OD3krGfRyjJNGGNaedZ/aCNtuXk26C/vT
         FdSLzXz1c4GJio0iQdtM3cuIkahC+0poJZJ+rWw0xB1GR68LDbDTcrkbjHSFBuOkYuUR
         +zqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/wJhWS2aGvLD1Rzy6m9shGLETN6RBjRGDzQAAEc0ebw=;
        b=CAeJzfgBxUfhd7zJu0Me87he4/C9GcGhXUXY68+3GddBFW45qLpMlQUcIypGraw7PB
         o8pQwtovnFF/EdpbNcObuR7S1QtjS6KLEEUYOlwsH+hBBqr3Bn2215KmoV2oUPy90TBN
         f0csjjijG/d8hDokt0L12oAB+F8aZmoCX1lJ5cNLKDVC/IqcLZzpQbsacAKbODvhoZCX
         8rOfc0IO7wMvmCRiDmvt2PERMLSMbgYlnwkAxZ65/n4C9R9mYTGVu06RFkeEUYDqtQ1J
         3rGcjVBW2H7alIWvbk0Uk2TRdC+bMtD+C/Td3G5GkACAbORdi/cu4NBoKUsjz/xyx7d2
         RyFw==
X-Gm-Message-State: ACrzQf1tx4iTUsnKmKQn6ExYBAyN824NMLOcFTB042Qw23emBaOaJaHR
        nW+uaYyMmqz/PzUirxbTucQ=
X-Google-Smtp-Source: AMsMyM6Gyd/1MaafB2gAV1PG0XNj6aF/w4NBWJ7iJ/3C/ea7Jyd/uo774MPJuKwj2rluqYmT2Wvwyg==
X-Received: by 2002:a65:4d07:0:b0:46f:ed91:a50d with SMTP id i7-20020a654d07000000b0046fed91a50dmr27395440pgt.343.1667823852789;
        Mon, 07 Nov 2022 04:24:12 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id q66-20020a17090a17c800b0021282014066sm6103510pja.9.2022.11.07.04.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:24:12 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFCv1 18/72] libext2fs: Add support to get average group count
Date:   Mon,  7 Nov 2022 17:51:06 +0530
Message-Id: <7e4f563719aee1970dd1058ca45b0609ae4c7c5f.1667822611.git.ritesh.list@gmail.com>
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

number of threads in pfsck should not exceed flex bg numbers.
This patch adds the support in libext2fs to calculate
ext2fs_get_avg_group() which returns an average group
count which each thread has to scan.

fs->fs_num_threads will be set by the client, in this case e2fsck.
No. of threads will be passed along with -m option while running e2fsck.
That will also set fs->fs_num_threads, which will help in controlling
the amount of memory consumed to maintain in memory data structures (per
thread) in case of multiple parallel threads (pfsck) to avoid oom.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 lib/ext2fs/ext2fs.h | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index b1505f95..6b4926ce 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -279,10 +279,11 @@ struct struct_ext2_filsys {
 	int				cluster_ratio_bits;
 	__u16				default_bitmap_type;
 	__u16				pad;
+	__u32				fs_num_threads;
 	/*
 	 * Reserved for future expansion
 	 */
-	__u32				reserved[5];
+	__u32				reserved[4];
 
 	/*
 	 * Reserved for the use of the calling application.
@@ -2231,6 +2232,35 @@ ext2fs_orphan_block_tail(ext2_filsys fs, char *buf)
 		sizeof(struct ext4_orphan_block_tail));
 }
 
+static dgrp_t ext2fs_get_avg_group(ext2_filsys fs)
+{
+#ifdef HAVE_PTHREAD
+	dgrp_t average_group;
+	unsigned flexbg_size;
+
+	if (fs->fs_num_threads <= 1)
+		return fs->group_desc_count;
+
+	average_group = fs->group_desc_count / fs->fs_num_threads;
+	if (average_group <= 1)
+		return 1;
+
+	if (ext2fs_has_feature_flex_bg(fs->super)) {
+		int times = 1;
+
+		flexbg_size = 1 << fs->super->s_log_groups_per_flex;
+		if (average_group % flexbg_size) {
+			times = average_group / flexbg_size;
+			average_group = times * flexbg_size;
+		}
+	}
+
+	return average_group;
+#else
+	return fs->group_desc_count;
+#endif
+}
+
 #undef _INLINE_
 #endif
 
-- 
2.37.3

