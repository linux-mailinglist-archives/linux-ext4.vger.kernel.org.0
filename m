Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F4068D703
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Feb 2023 13:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbjBGMlx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Feb 2023 07:41:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBGMlx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Feb 2023 07:41:53 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7820C9EC9
        for <linux-ext4@vger.kernel.org>; Tue,  7 Feb 2023 04:41:48 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id c10-20020a17090a1d0a00b0022e63a94799so18452828pjd.2
        for <linux-ext4@vger.kernel.org>; Tue, 07 Feb 2023 04:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JUkE3PEGmUh0/Ck4ve86JbwMMrkg50GR2ridXe4qLos=;
        b=Oc7k39fmwpPKDnb/jE8P0pLZs5yoJSaQSywkVaLmc4GRkquIVR+ed18AwzKHWPg80a
         zUj4s6RAmu1KY7Gi3MiYrervURRCqFiZl/kuskzi+NiUWti5ndHEIbZ3Yc7z6S3f9ovR
         q/2yIMygnpqT4925/BE0qzzDK7vLlfiwFOICu0rPcMnF+fUJrbNLRopsvCQrbUj1nmSa
         u2x+8QjgsrlQ0vktHoHOOSZMGf88iZCv6uMeutI6AXdmZJWgFdd5xnF9H5qmprBCqcWo
         TZbhirMA/LLqFu+3KY+YqCXxQcxkv/1iCGp2XoRLYKOhCpEMIIbgksfDCsqlCwYkpMZU
         aLmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JUkE3PEGmUh0/Ck4ve86JbwMMrkg50GR2ridXe4qLos=;
        b=gdatRtuIkEd0oZAmHKixIV7Giu7SUssGbwuZLiggTdq60rth1cUB2MWalyMS/YlrgD
         7Cxl2TTdhBiDbEOBspBMZTDGf0XfBDPa6cG7aS+EfeLfz7Dyjo3cLXKPO4YuqUdYfHdq
         UbIWxepPpseZP5Y+4otaBNFYPTf889vYOecauY/4eh9bp0p9p5xL+t8dT/M6soeep2ym
         9iEfV4pSbmWwumvr2AyFvyDTvh+RHMW2AeVB4M3gH0JSN1KibKMquviR0CSuH3TJDU9X
         0F3CuZRSJa254By9gFwsplc88+gAh0TFry/G8UdZUQ4LTo4ZXx8jN1V0a5clw/FGXOwP
         leVw==
X-Gm-Message-State: AO0yUKW+NhG0xNd+QLqEaxI8NVIu17OQzJ9twgeoJIYRpl9GEcSmaR9F
        cUW8QwYHp0sSs2HEry6tWz8wrFw1HMCTa38+EwY=
X-Google-Smtp-Source: AK7set+1NKJMbBQNTsJLolnySTjZBbxDsam/imqTzQeKfLEUSChZ6p4FU1J4eOFsaK04EdrcAQY9KQ==
X-Received: by 2002:a05:6a21:9993:b0:9d:efc0:92 with SMTP id ve19-20020a056a21999300b0009defc00092mr3889949pzb.58.1675773708032;
        Tue, 07 Feb 2023 04:41:48 -0800 (PST)
Received: from C02GD5ZHMD6R.bytedance.net ([61.213.176.10])
        by smtp.gmail.com with ESMTPSA id t32-20020a056a0013a000b0059428b51220sm9104309pfg.186.2023.02.07.04.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 04:41:47 -0800 (PST)
From:   Jinke Han <hanjinke.666@bytedance.com>
X-Google-Original-From: Jinke Han <hnajinke.666@bytedance>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, Jinke Han <hanjinke.666@bytedance.com>
Subject: [PATCH v2] ext4: make dioread_nolock consistent in each mapping round
Date:   Tue,  7 Feb 2023 20:41:36 +0800
Message-Id: <20230207124136.88222-1-hanjinke.666@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Jinke Han <hanjinke.666@bytedance.com>

When disable and enable dioread_nolock by remount, we may see
dioread_lock in ext4_do_writepages while see dioread_nolock in
mpage_map_one_extent. This inconsistency may triger the warning
in ext4_add_complete_io when the io_end->handle is NULL. Although
this warning is harmless in most cases, there is still a risk of
insufficient log reservation in conversion of unwritten extents.

Signed-off-by: Jinke Han <hanjinke.666@bytedance.com>
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 40579ef513b7..122a22ccddb3 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1568,6 +1568,7 @@ struct mpage_da_data {
 	struct ext4_io_submit io_submit;	/* IO submission data */
 	unsigned int do_map:1;
 	unsigned int scanned_until_end:1;
+	unsigned int dioread_nolock:1;
 };
 
 static void mpage_release_unused_pages(struct mpage_da_data *mpd,
@@ -2391,7 +2392,7 @@ static int mpage_map_one_extent(handle_t *handle, struct mpage_da_data *mpd)
 	struct inode *inode = mpd->inode;
 	struct ext4_map_blocks *map = &mpd->map;
 	int get_blocks_flags;
-	int err, dioread_nolock;
+	int err, dioread_nolock = mpd->dioread_nolock;
 
 	trace_ext4_da_write_pages_extent(inode, map);
 	/*
@@ -2412,7 +2413,6 @@ static int mpage_map_one_extent(handle_t *handle, struct mpage_da_data *mpd)
 	get_blocks_flags = EXT4_GET_BLOCKS_CREATE |
 			   EXT4_GET_BLOCKS_METADATA_NOFAIL |
 			   EXT4_GET_BLOCKS_IO_SUBMIT;
-	dioread_nolock = ext4_should_dioread_nolock(inode);
 	if (dioread_nolock)
 		get_blocks_flags |= EXT4_GET_BLOCKS_IO_CREATE_EXT;
 	if (map->m_flags & BIT(BH_Delay))
@@ -2727,10 +2727,11 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
 	handle_t *handle = NULL;
 	struct inode *inode = mpd->inode;
 	struct address_space *mapping = inode->i_mapping;
-	int needed_blocks, rsv_blocks = 0, ret = 0;
+	int needed_blocks, rsv_blocks = 0, rsv = 0, ret = 0;
 	struct ext4_sb_info *sbi = EXT4_SB(mapping->host->i_sb);
 	struct blk_plug plug;
 	bool give_up_on_write = false;
+	bool dioread_nolock;
 
 	trace_ext4_writepages(inode, wbc);
 
@@ -2783,15 +2784,6 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
 		ext4_journal_stop(handle);
 	}
 
-	if (ext4_should_dioread_nolock(inode)) {
-		/*
-		 * We may need to convert up to one extent per block in
-		 * the page and we may dirty the inode.
-		 */
-		rsv_blocks = 1 + ext4_chunk_trans_blocks(inode,
-						PAGE_SIZE >> inode->i_blkbits);
-	}
-
 	if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX)
 		range_whole = 1;
 
@@ -2837,6 +2829,18 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
 		goto unplug;
 
 	while (!mpd->scanned_until_end && wbc->nr_to_write > 0) {
+		dioread_nolock = ext4_should_dioread_nolock(inode);
+		if (!rsv && dioread_nolock) {
+			/*
+			 * We may need to convert up to one extent per block in
+			 * the page and we may dirty the inode.
+			 */
+			rsv = 1 + ext4_chunk_trans_blocks(inode,
+							PAGE_SIZE >> inode->i_blkbits);
+		}
+		rsv_blocks = dioread_nolock ? rsv : 0;
+		mpd->dioread_nolock = dioread_nolock;
+
 		/* For each extent of pages we use new io_end */
 		mpd->io_submit.io_end = ext4_init_io_end(inode, GFP_KERNEL);
 		if (!mpd->io_submit.io_end) {
-- 
2.20.1

