Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1CF61F2DC
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbiKGMWg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbiKGMWf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:22:35 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF729D62
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:22:34 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id c2so10879430plz.11
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PeguO5OJQkOMV7A3vjAm+yi2UDth+yAgHrBJt9W7x20=;
        b=AIi2DCcHrqUqsdTtRq6K37rKo+F7IPFgqVwj1RGbeBIS2Ljqc4aKaNBCOwY7cLB4kY
         Sv0rdX1ZROE6jVBY9iS7+a626GaljeZFvJEvsKUrZvS8J+rF+/zTHogCLQaESGDOCYNG
         vbkls6mAObm3pTFT8nonK2/p02aygel4xgWVwuHNTpFFJc+XNZyi501fmmSsOtXMqHDI
         Ha6lmR1zVBknimeCAdOzZsKiJ77y/Etz2R+VR07t46/OGwvRb5racnqXV88Z7TgrKtpV
         EkGQWiANHuMK5HjNOrz16lMz5Mhv1zJzoVdXhDQuw240nWG00GKqpTxwDaktXMOCGD2x
         6BYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PeguO5OJQkOMV7A3vjAm+yi2UDth+yAgHrBJt9W7x20=;
        b=jhPRCdxyPp08YX5uf36UirpPckR4j0i6cGPq+VSm2goRA7E2MB4PweGeK5uzTxAutA
         P7WDc+ztG39ZFBqx5EPUANPBVXSjxTrq8mxXZlnEVZWZ/p3zrwnQNu7dh37nk/FN76JY
         6yXNNOmJs0ZD64GxSnIovz9UNrCmlCszgI315HooKNVgY3y6UxBn/WUKyPTYJGsmHQTn
         J5URdk8P82hsctb8bABwD1kVjkJcGKsIki6D69Ew48xcQNjCXsISn0ka8ypcNqIPvWSB
         a2U7KFOr7irn11V0ndYxwlYQfKb/ivrd+tp6eUyTCMoYKsVj+yZgr5Zj9aWFaHI/ZqUF
         BaZA==
X-Gm-Message-State: ACrzQf3AWG0KEJae7DdUnadyzicxnyH7NwKI3UqAgPRXQCwGAg8jai6r
        UJ0ZyccBOJ6oaLfTWJs00Kg=
X-Google-Smtp-Source: AMsMyM5cbMZ/iNcTx7Axe+/J1M2V3Jx2DcE5804iD3BK7PHF5DSC8FwAWkqJGp6nYyq9Vd2fcmAi9g==
X-Received: by 2002:a17:902:e74a:b0:186:a094:1d3 with SMTP id p10-20020a170902e74a00b00186a09401d3mr48851963plf.153.1667823754480;
        Mon, 07 Nov 2022 04:22:34 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id y23-20020a17090264d700b0017f92246e4dsm4824708pli.181.2022.11.07.04.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:22:33 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFCv1 02/72] gen_bitmaps: Fix ext2fs_compare_generic_bmap/bitmap logic
Date:   Mon,  7 Nov 2022 17:50:50 +0530
Message-Id: <da2a28305637aef648846f9bf75d269c0f7c6e57.1667822611.git.ritesh.list@gmail.com>
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

Currently this function was not correctly comparing against the right
length of the bitmap. Also when we compare bitarray v/s rbtree bitmap
the value returned by ext2fs_test_generic_bmap() could be different in
these two implementations. Hence only check against boolean value.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 lib/ext2fs/gen_bitmap.c   |  9 ++++++---
 lib/ext2fs/gen_bitmap64.c | 10 +++++++---
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/lib/ext2fs/gen_bitmap.c b/lib/ext2fs/gen_bitmap.c
index 1536d4b3..f7764fca 100644
--- a/lib/ext2fs/gen_bitmap.c
+++ b/lib/ext2fs/gen_bitmap.c
@@ -385,10 +385,13 @@ errcode_t ext2fs_compare_generic_bitmap(errcode_t magic, errcode_t neq,
 		    (size_t) (bm1->end - bm1->start)/8)))
 		return neq;
 
-	for (i = bm1->end - ((bm1->end - bm1->start) % 8); i <= bm1->end; i++)
-		if (ext2fs_fast_test_block_bitmap(gen_bm1, i) !=
-		    ext2fs_fast_test_block_bitmap(gen_bm2, i))
+	for (i = bm1->start; i <= bm1->end; i++) {
+		int ret1, ret2;
+		ret1 = !!ext2fs_fast_test_block_bitmap(gen_bm1, i);
+		ret2 = !!ext2fs_fast_test_block_bitmap(gen_bm2, i);
+		if (ret1 != ret2)
 			return neq;
+	}
 
 	return 0;
 }
diff --git a/lib/ext2fs/gen_bitmap64.c b/lib/ext2fs/gen_bitmap64.c
index c860c10e..f7710afd 100644
--- a/lib/ext2fs/gen_bitmap64.c
+++ b/lib/ext2fs/gen_bitmap64.c
@@ -629,10 +629,14 @@ errcode_t ext2fs_compare_generic_bmap(errcode_t neq,
 	    (bm1->end != bm2->end))
 		return neq;
 
-	for (i = bm1->end - ((bm1->end - bm1->start) % 8); i <= bm1->end; i++)
-		if (ext2fs_test_generic_bmap(gen_bm1, i) !=
-		    ext2fs_test_generic_bmap(gen_bm2, i))
+	for (i = bm1->start; i < bm1->end; i++) {
+		int ret1, ret2;
+		ret1 = !!ext2fs_test_generic_bmap(gen_bm1, i);
+		ret2 = !!ext2fs_test_generic_bmap(gen_bm2, i);
+		if (ret1 != ret2) {
 			return neq;
+		}
+	}
 
 	return 0;
 }
-- 
2.37.3

