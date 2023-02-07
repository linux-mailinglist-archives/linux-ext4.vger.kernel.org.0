Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE0668CF9B
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Feb 2023 07:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjBGGmb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Feb 2023 01:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjBGGm3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Feb 2023 01:42:29 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964E812593
        for <linux-ext4@vger.kernel.org>; Mon,  6 Feb 2023 22:42:13 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id mi9so13989900pjb.4
        for <linux-ext4@vger.kernel.org>; Mon, 06 Feb 2023 22:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fc2BIj9mMMJHJr4BR+Ma7Dx3SRjurTtC+ps/u0PeMsE=;
        b=KcG2auQYu4AUIM+/PIuXrGXxLrHzhvohygK6PIV9pCmRzc1LfxxPJhht0QmP4SNDOS
         AxLaCnmLHYc3Iih4XX8esFKd0xrr3exDGrVjW1PFyovKr9Yx0XfR3szCuKgFCGdtz3vt
         QC0uTzXZ76rWtnqmA/fnOWqWqQnJShL9pBdCaD0BP74pKgk4DwBAx0SejI/yAO5ioOEr
         +X9+QijJw1EEPsmHRu6Y7dK+q1fwtMFcX3aDZaPyI0/L+01FB9mqIrZNHe/l+IrCWv7+
         M3gL8BSGgf/nUf/Yna652EEl8GpL1/jxGcg7iZWBlH79vWp7bNZpURIYswffXgKH4S+n
         L1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fc2BIj9mMMJHJr4BR+Ma7Dx3SRjurTtC+ps/u0PeMsE=;
        b=5RsIxwsNoIqQcJWqhBLXjgG+5eU4HxrJGY8BpHsGhx8txJ/d+PpleYT0RNKRng84xR
         1sKc2lSLl1dnECj8FPeQ4BOw18Vb5eAMdoNg3aIyU0edd9gIbB0g659jRJxQWkH+Lsrk
         8ZotM0mofE746kXYfVPRhlLwFq1ngIm2uavuCgQ1pAgc3qEKXJ/qbRGjiDhXyCrCeqif
         kKCa3jHD0TeLVi2ZX0teyASpy7lcYDWXRdLq7j7NVZH/eYo7G4DTXXYAvMIF4Ujab+Dg
         zfEHmh98KI4fqJybSLliBDNzUtF7Q/2xV+N5M1qZ9hV2mPWzenaU9KPcvHhTV4CbNN7h
         +tUw==
X-Gm-Message-State: AO0yUKX/Xyk5KdJIinzcIaH4rWg64xNNdAod8xSjknFeqHjGzw1MnOKc
        DYE22DuBnO3Frlo1IQyiByQm7w==
X-Google-Smtp-Source: AK7set+GIpPxfwQ/AtvLbKatkdifzwFx3YEd+2MGmSP1/q2A/32+qXoQZAOVPA2oQMr5Tq49xZ5PBg==
X-Received: by 2002:a17:902:dacd:b0:198:9683:9f0a with SMTP id q13-20020a170902dacd00b0019896839f0amr2761450plx.30.1675752132949;
        Mon, 06 Feb 2023 22:42:12 -0800 (PST)
Received: from C02GD5ZHMD6R.bytedance.net ([61.213.176.9])
        by smtp.gmail.com with ESMTPSA id t13-20020a170902b20d00b00188c9c11559sm7669949plr.1.2023.02.06.22.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 22:42:12 -0800 (PST)
From:   Jinke Han <hanjinke.666@bytedance.com>
X-Google-Original-From: Jinke Han <hnajinke.666@bytedance>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     jack@suse.cz, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jinke Han <hanjinke.666@bytedance.com>
Subject: [PATCH] ext4: make dioread_nolock consistent in each mapping round
Date:   Tue,  7 Feb 2023 14:42:03 +0800
Message-Id: <20230207064203.72102-1-hanjinke.666@bytedance.com>
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
in ext4_release_io_end. Although this warning is harmless, we'd
better fix it

Signed-off-by: Jinke Han <hanjinke.666@bytedance.com>
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

