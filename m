Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B46161F2E3
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbiKGMXO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbiKGMXN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:23:13 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FF462DF
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:23:12 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id f5-20020a17090a4a8500b002131bb59d61so12428563pjh.1
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rg7HbLWHsPCyjYPcF7Zv5a4qGG6YFqdd/e9CXoAgVFc=;
        b=jJ2VwZ0YE3FKUjOuKJ9NmbY/ou6xGILHaN2PLnKiANwK18oGQeUIdu9BT2HLOJR7to
         L+pboosRbflaig8h3OT746kEXycAuNs0Ow6Cf3ShP6DhkXzIbTDasd93Je9KUbABorvm
         dGHLHSSzE3bIh/vUIMzi4X8kAnDiI70vcXUwEukomIvLN+8Plj+X4qGNNh9sAbZkXadw
         jIeuCBZSK3RE8hP9PHSbuIzG9vKx7FhGEoYLlL2a7Br7TA/Y58/OfgprUwomMtoHU4Fz
         HHC6UP05tdcA6k9UC3z1UHlO4ye9sL+q7LFt9Ocdm9Ugb/mKlmQsuh6dAYWPqV7tLXex
         srYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rg7HbLWHsPCyjYPcF7Zv5a4qGG6YFqdd/e9CXoAgVFc=;
        b=2C6GsjvywTW8CV/KF/EP0CfkZZoJqbnt1FMIQ8Ti6QVCWYL8ciAKe75FjUOTCj9l/6
         LuwoBkILZB3inwhnZfs+a+yQjZMYUoYrF48K2FTlMjyS6faqaoK5ZzsiXBaOG5fspUjo
         bhjgKn3wxGBa+qXYZ6y59Dn4YvZ0FRv42h1a+PN8kpx4oxMnpIp0m/rfpKL3GEFGsAgr
         YdZlK8+DdtS5ApwY82502mKldiUQqpGOwu+U19yReTdzuVfvSyqjcZwNFTDMZd8fOqhI
         IJS1WtRw6W1KxYvLzmgUQZGXt3RZozEFHjAv20FSH+e77hS0nA0awFD1eSdaM2YtzOYO
         gyHA==
X-Gm-Message-State: ACrzQf0ui56Z6elyoR2Z5VsQD3OKXd/nizYhYdE77zyrvALchiC2peCV
        Y6jKs9ROJY5iqtYFiurTR18=
X-Google-Smtp-Source: AMsMyM4Z3WUwdoC1VHoeUnZXo7H9+0QvQAixSHnP+LjwooRW0RHa+1Won4KBDFOkN7RC1TmOCIkt5Q==
X-Received: by 2002:a17:90b:a53:b0:215:d767:4863 with SMTP id gw19-20020a17090b0a5300b00215d7674863mr600683pjb.233.1667823791526;
        Mon, 07 Nov 2022 04:23:11 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id b5-20020a170902e94500b00176d218889esm4857443pll.228.2022.11.07.04.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:23:10 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFCv1 08/72] libext2fs: Add bitmaps merge ops
Date:   Mon,  7 Nov 2022 17:50:56 +0530
Message-Id: <e7d44e0d438f26fee254ba005885f8f7eeb56ddb.1667822611.git.ritesh.list@gmail.com>
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

Signed-off-by: Li Xi <lixi@ddn.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
[Note: splitted rb merge tree logic patch such that we
seperate out libext2fs changes from e2fsck specific changes]
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 lib/ext2fs/bitmaps.c      | 10 ++++++++++
 lib/ext2fs/bmap64.h       |  4 ++++
 lib/ext2fs/ext2fs.h       |  8 ++++++++
 lib/ext2fs/gen_bitmap64.c | 29 +++++++++++++++++++++++++++++
 4 files changed, 51 insertions(+)

diff --git a/lib/ext2fs/bitmaps.c b/lib/ext2fs/bitmaps.c
index 8bfa24b1..9437331e 100644
--- a/lib/ext2fs/bitmaps.c
+++ b/lib/ext2fs/bitmaps.c
@@ -45,6 +45,16 @@ errcode_t ext2fs_copy_bitmap(ext2fs_generic_bitmap src,
 {
 	return (ext2fs_copy_generic_bmap(src, dest));
 }
+
+errcode_t ext2fs_merge_bitmap(ext2fs_generic_bitmap src,
+			      ext2fs_generic_bitmap dest,
+			      ext2fs_generic_bitmap dup,
+			      ext2fs_generic_bitmap dup_allowed)
+{
+	return ext2fs_merge_generic_bmap(src, dest, dup,
+					 dup_allowed);
+}
+
 void ext2fs_set_bitmap_padding(ext2fs_generic_bitmap map)
 {
 	ext2fs_set_generic_bmap_padding(map);
diff --git a/lib/ext2fs/bmap64.h b/lib/ext2fs/bmap64.h
index de334548..555193ee 100644
--- a/lib/ext2fs/bmap64.h
+++ b/lib/ext2fs/bmap64.h
@@ -72,6 +72,10 @@ struct ext2_bitmap_ops {
 	void	(*free_bmap)(ext2fs_generic_bitmap_64 bitmap);
 	errcode_t (*copy_bmap)(ext2fs_generic_bitmap_64 src,
 			     ext2fs_generic_bitmap_64 dest);
+	errcode_t (*merge_bmap)(ext2fs_generic_bitmap_64 src,
+				ext2fs_generic_bitmap_64 dest,
+				ext2fs_generic_bitmap_64 dup,
+				ext2fs_generic_bitmap_64 dup_allowed);
 	errcode_t (*resize_bmap)(ext2fs_generic_bitmap_64 bitmap,
 			       __u64 new_end,
 			       __u64 new_real_end);
diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index 443f93d2..54aed5d1 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -870,6 +870,10 @@ extern void ext2fs_free_block_bitmap(ext2fs_block_bitmap bitmap);
 extern void ext2fs_free_inode_bitmap(ext2fs_inode_bitmap bitmap);
 extern errcode_t ext2fs_copy_bitmap(ext2fs_generic_bitmap src,
 				    ext2fs_generic_bitmap *dest);
+extern errcode_t ext2fs_merge_bitmap(ext2fs_generic_bitmap src,
+			      ext2fs_generic_bitmap dest,
+			      ext2fs_generic_bitmap dup,
+			      ext2fs_generic_bitmap dup_allowed);
 extern errcode_t ext2fs_allocate_block_bitmap(ext2_filsys fs,
 					      const char *descr,
 					      ext2fs_block_bitmap *ret);
@@ -1467,6 +1471,10 @@ void ext2fs_set_generic_bmap_padding(ext2fs_generic_bitmap bmap);
 errcode_t ext2fs_resize_generic_bmap(ext2fs_generic_bitmap bmap,
 				     __u64 new_end,
 				     __u64 new_real_end);
+errcode_t ext2fs_merge_generic_bmap(ext2fs_generic_bitmap gen_src,
+                                    ext2fs_generic_bitmap gen_dest,
+				    ext2fs_generic_bitmap gen_dup,
+				    ext2fs_generic_bitmap dup_allowed);
 errcode_t ext2fs_compare_generic_bmap(errcode_t neq,
 				      ext2fs_generic_bitmap bm1,
 				      ext2fs_generic_bitmap bm2);
diff --git a/lib/ext2fs/gen_bitmap64.c b/lib/ext2fs/gen_bitmap64.c
index f7710afd..c31f942f 100644
--- a/lib/ext2fs/gen_bitmap64.c
+++ b/lib/ext2fs/gen_bitmap64.c
@@ -346,6 +346,35 @@ errcode_t ext2fs_copy_generic_bmap(ext2fs_generic_bitmap gen_src,
 	return 0;
 }
 
+errcode_t ext2fs_merge_generic_bmap(ext2fs_generic_bitmap gen_src,
+				    ext2fs_generic_bitmap gen_dest,
+				    ext2fs_generic_bitmap gen_dup,
+				    ext2fs_generic_bitmap gen_dup_allowed)
+{
+	ext2fs_generic_bitmap_64 src = (ext2fs_generic_bitmap_64)gen_src;
+	ext2fs_generic_bitmap_64 dest = (ext2fs_generic_bitmap_64)gen_dest;
+	ext2fs_generic_bitmap_64 dup = (ext2fs_generic_bitmap_64)gen_dup;
+	ext2fs_generic_bitmap_64 dup_allowed = (ext2fs_generic_bitmap_64)gen_dup_allowed;
+
+	if (!src || !dest)
+		return EINVAL;
+
+	if (!EXT2FS_IS_64_BITMAP(src) || !EXT2FS_IS_64_BITMAP(dest) ||
+	    (dup && !EXT2FS_IS_64_BITMAP(dup)) ||
+		(dup_allowed && !EXT2FS_IS_64_BITMAP(dup_allowed)))
+		return EINVAL;
+
+	if (src->bitmap_ops != dest->bitmap_ops ||
+	    (dup && src->bitmap_ops != dup->bitmap_ops) ||
+	    (dup_allowed && src->bitmap_ops != dup_allowed->bitmap_ops))
+		return EINVAL;
+
+	if (src->bitmap_ops->merge_bmap == NULL)
+		return EOPNOTSUPP;
+
+	return src->bitmap_ops->merge_bmap(src, dest, dup, dup_allowed);
+}
+
 errcode_t ext2fs_resize_generic_bmap(ext2fs_generic_bitmap gen_bmap,
 				     __u64 new_end,
 				     __u64 new_real_end)
-- 
2.37.3

