Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2406C564E3F
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Jul 2022 09:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbiGDHHd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 4 Jul 2022 03:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbiGDHHc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 4 Jul 2022 03:07:32 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F104E66
        for <linux-ext4@vger.kernel.org>; Mon,  4 Jul 2022 00:07:31 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d17so8139859pfq.9
        for <linux-ext4@vger.kernel.org>; Mon, 04 Jul 2022 00:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9W3gRWmGUweo497W/5hFRRz/NYJ+5R4fTtzWnF2at2E=;
        b=nKKV59eqrRGyihZiPUos1JCkNwWlbj4nSA4W3XfrejIVu48f7af7Iv/6RrX2YPoOiz
         FUTg69Bed8gQYhkRm/EytrzpAXUo1JNJ7j9uwoUwX4Jf6l76ev7INsw0m3m8oE7qMTP3
         zeGpeSB93C1BVIWy1AxUmGQi7xgv3MNEZqQEDOuMxO3x8jJUswCyXFzKnwPv+3lFKflI
         wTi55zWvn1OZkru297UXm7U2GQmvtdVuS4LpErKr7F67D81m2DgVVn2Xt46/jsBRABbQ
         R+Ss8tW+SxqszH4+J3eu1O7b+8FArwEc+b9MwyVF4xVraRF98XPdTFdx7lCFkGhZjT7S
         XdkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9W3gRWmGUweo497W/5hFRRz/NYJ+5R4fTtzWnF2at2E=;
        b=avmJ6Bm19HYQ/Z6ThIK3WljOUkzCkd898kxfXdRCXO7NXGSrg5jj5xMPdEEvEt3vHB
         a4PpJlJExovZNgljSoDmqwj5eIxrpqmkbnkzb2BCMyWRn/Vffw6gvZ7daSt3Pkh5e5Ce
         cczi+k/wVwSa/PL5Ti18fHD2kDhL5KotQXnASzfJQojqu+wFcaCV1NAdBFvy+gpdT1Vf
         mWj36t8AHnQgQ5H5OZHQHsU52O5RsR+iStcKmI7vT/jSW0Mbp+MdTjswJGOsjf2xXEbN
         6UX3o1ueKTtzlyZQp4EfwEpTNAYHXm8jIsojUfEYID8fnvVfbOyDrigiwXZRbUEy8SN+
         9LxQ==
X-Gm-Message-State: AJIora9/VA3bLZbc41hCufDjXRnEjat7mI7Nv90Jlha79C8ZGSdmo8+h
        cg3wZSah9MDLQfJXrrO/Y7F4BafCSPI=
X-Google-Smtp-Source: AGRyM1vqlzxmTJ/wyfrKcIyV27A65YcXK7dkFb+RHboMZE3nrRG0Kib1ilRc3LsBMiPyo4ob5rcqLA==
X-Received: by 2002:a05:6a00:2407:b0:528:5bbc:aa0d with SMTP id z7-20020a056a00240700b005285bbcaa0dmr7514549pfh.40.1656918451143;
        Mon, 04 Jul 2022 00:07:31 -0700 (PDT)
Received: from localhost ([2406:7400:63:cb1d:811:33e9:9bc2:d40])
        by smtp.gmail.com with ESMTPSA id e7-20020a170902784700b0015eab1b097dsm20317725pln.22.2022.07.04.00.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 00:07:30 -0700 (PDT)
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFC 03/13] blkmap64_ba: Add common helper for bits size calculation
Date:   Mon,  4 Jul 2022 12:36:52 +0530
Message-Id: <2418fae44393d8696cc848b682a24e58d334e1a2.1656912918.git.ritesh.list@gmail.com>
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

Just a quick common helper for bits size calculation.

Signed-off-by: Ritesh Harjani <ritesh.list@gmail.com>
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
2.35.3

