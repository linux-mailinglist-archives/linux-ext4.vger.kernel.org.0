Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC55564E40
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Jul 2022 09:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbiGDHHY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 4 Jul 2022 03:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiGDHHW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 4 Jul 2022 03:07:22 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F0DBD7
        for <linux-ext4@vger.kernel.org>; Mon,  4 Jul 2022 00:07:21 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id o18so7817067plg.2
        for <linux-ext4@vger.kernel.org>; Mon, 04 Jul 2022 00:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RYM4b6lt8jh5/3brBWmnUhsaWASumVZ8o9hRWq/JLgg=;
        b=hHrp1FTUtlaRKLKOWvaxvyzLaj7/iDF9Jma+T3CbR3wfJdPdHtKpAlIosL77te+LIv
         9xvw8nO3mEM7KBtv5EUZ4c/7hlRsVYjJLqt+Oob55U/2QIPWFAPSqS5DktYi5/cckVA1
         epLs2GVN26TfLgSxTTqk1gADHKTySr3CKx9hswYh1PVE5BduBPFKs5sxJOveRflLe/M6
         /ycGCLQLpVyl9VPO8oa50PmmPVWyn6agC2xoJ9F6CN4lRiNy2zyU/Q6KeA0E+chazZjo
         EAb7zKAQCt/Oh75sGIQdKrtWhSZZrH+kLWT6v8JzB9Ax53tKyNScXJ8tH7Ao03+kWTmL
         ZD3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RYM4b6lt8jh5/3brBWmnUhsaWASumVZ8o9hRWq/JLgg=;
        b=0i6GJhLcdAuuCE9ieqystfTR/j9ENAIOPddM1qaEHW4qztFHioBc0tXgGbhiN8XE5r
         6aotNztFXiVeFN/k5aSYVNMeu5jHENSx1WjLsuyNRcDB5U88qpmABzDKpK0GfqezLtsf
         aUCbfEXjYxgym3qYeQwK1O/IMSViEUmgp7oWHTCVSH12KmHog0jY1OzZTV9L959faH0r
         JyV5Qtai4WgRDpXQLzw6H7ptQqm/1xEtFZYS1NrYQQZNuXhgur94SAwy/AF8Zf+SdIb9
         ks5fH2WkPQ5gGhT8fT8i9WpIyI0n+AwKQZmSPZv6tyE9pExrNLfUbAfgo2/1QFuwQUnQ
         B9AA==
X-Gm-Message-State: AJIora/uR3gsxQGz2A4+u0f5k4UXaft/Du50Ugb2IT7T1NR8y+iJ9A6B
        qv198p+7Edl0Gwh78M0oVgLX9WGEtak=
X-Google-Smtp-Source: AGRyM1vCzNkrEoZlfhDjsbkJA0KP1CeemWzdKNUaGUbVXQ0tJ2Htz9wdOs3cZGMGu/axcV67obuclg==
X-Received: by 2002:a17:90a:66c1:b0:1e8:43ae:f7c0 with SMTP id z1-20020a17090a66c100b001e843aef7c0mr32464061pjl.245.1656918441382;
        Mon, 04 Jul 2022 00:07:21 -0700 (PDT)
Received: from localhost ([2406:7400:63:cb1d:811:33e9:9bc2:d40])
        by smtp.gmail.com with ESMTPSA id n10-20020a170902e54a00b0016191b843e2sm20346532plf.235.2022.07.04.00.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 00:07:21 -0700 (PDT)
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFC 01/13] gen_bitmaps: Fix ext2fs_compare_generic_bmap/bitmap logic
Date:   Mon,  4 Jul 2022 12:36:50 +0530
Message-Id: <39eb8ba0a5a0adb7250a595e33460b16d6c5066f.1656912918.git.ritesh.list@gmail.com>
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

Currently this function was not correctly comparing against the right
length of the bitmap. Also when we compare bitarray v/s rbtree bitmap
the value returned by ext2fs_test_generic_bmap() could be different in
these two implementations. Hence only check against boolean value.

Signed-off-by: Ritesh Harjani <ritesh.list@gmail.com>
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
index d9809084..90c700ca 100644
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
2.35.3

