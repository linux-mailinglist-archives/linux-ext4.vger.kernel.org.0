Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81067BD14A
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Oct 2023 01:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345001AbjJHXlU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 8 Oct 2023 19:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345000AbjJHXlS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 8 Oct 2023 19:41:18 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938E1B3
        for <linux-ext4@vger.kernel.org>; Sun,  8 Oct 2023 16:41:16 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1d544a4a2f2so2743569fac.3
        for <linux-ext4@vger.kernel.org>; Sun, 08 Oct 2023 16:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1696808476; x=1697413276; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WhYJRI062pcX8jyWpJ2qutO3TNLI93kE5AesIBQ7T3Q=;
        b=qfXMJSRjstnQQ9O3qQKeqa0wLdMd5xQf8I7gXIpk2V15FiFipYnG7y/ol6PmF3OFjd
         fHSt4C7f2lTyHpXI5ssrIa3MyInD5XSG3VG5EX9NwXK88tQUVMVRA0zP6L2F8FHLjU0M
         r5veBrNYhgbU32AH4X1BaK/KdTmyXkL0fmPzqXmWGjbi6i5VTcXy1LXmwnjnEXZWQPRn
         aAhlz+NldE06xnnRjvUj9CE1c4eKEw5MTvm0J/uQMewP3w7bZ59DTRN/91c1BtjZHof7
         jr7e/E2xpLHBs1uM3rxb0TqVXwNUg/gN0+NSx4v7u2yW7KN/LonlQ4BfpomfB67JUmla
         UiWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696808476; x=1697413276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WhYJRI062pcX8jyWpJ2qutO3TNLI93kE5AesIBQ7T3Q=;
        b=tFlRwhwAtoRynWGZEv55855QOM6Z4mKWiNWIbG/6gr9mmJvJrRxcEt9AQiOH3NyKhi
         KACQME1ffO5sJ8d8X9pZ/tLKA8U1GGFTU30dY3xQCViasSP1+9jMR3nWrx4dzeCdhFme
         GNskVO0HF3d+L6yXlUntwhR3YvEJAMdz24EKPGEv/WSn9kWZw+flrS9YvUdek4lpIThu
         sUDRKB1Nv0eG5L2H3tXyOroHTElYJ1pB7fEvyNUAgzKODsnCBB7uS9CEG7d1APoyTbwf
         V84Ka4tIVPRYN+XDEqO6NBplTYZqaNHECwhnT7RIqe9Ns68/IlgC7wXF43DC+3rIyUpT
         44rw==
X-Gm-Message-State: AOJu0YwAXO63uHypFlEPtKrbkolJsmGDKyqjYwO6dup1rjbQ2gVmj2Cv
        FnFPJH5lh5soTZXV5O3Glyarrg==
X-Google-Smtp-Source: AGHT+IEzdfSk/TfN3oKWe+ZCwTpXTbsQop8JnwDS51200ueprTMLUFr7+5xNPnWdiMt6htdwMZNbVg==
X-Received: by 2002:a05:6870:2050:b0:1dd:67a6:ed75 with SMTP id l16-20020a056870205000b001dd67a6ed75mr16462942oad.44.1696808475832;
        Sun, 08 Oct 2023 16:41:15 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id x14-20020aa784ce000000b0068fb5e44827sm5000804pfn.67.2023.10.08.16.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 16:41:15 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qpdOb-00BI8g-18;
        Mon, 09 Oct 2023 10:41:13 +1100
Date:   Mon, 9 Oct 2023 10:41:13 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: [RFC PATCH 6/5] xfs: detect block devices requiring provisioning
Message-ID: <ZSM+Ge1YTtx935W9@dread.disaster.area>
References: <20231007012817.3052558-1-sarthakkukreti@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007012817.3052558-1-sarthakkukreti@chromium.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

Block device provisioning detection infrastructure.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 fs/xfs/xfs_buf.c   |  2 ++
 fs/xfs/xfs_buf.h   |  1 +
 fs/xfs/xfs_mount.h | 11 ++++++++++-
 fs/xfs/xfs_super.c |  4 ++++
 4 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index c1ece4a08ff4..f37edae6e68e 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -2014,6 +2014,8 @@ xfs_alloc_buftarg(
 	btp->bt_bdev = bdev;
 	btp->bt_daxdev = fs_dax_get_by_bdev(bdev, &btp->bt_dax_part_off,
 					    mp, ops);
+	if (bdev_max_provision_sectors(bdev))
+		btp->bt_needs_provisioning = true;
 
 	/*
 	 * Buffer IO error rate limiting. Limit it to no more than 10 messages
diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
index df8f47953bb4..1719a8fce49f 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -106,6 +106,7 @@ typedef struct xfs_buftarg {
 	size_t			bt_meta_sectormask;
 	size_t			bt_logical_sectorsize;
 	size_t			bt_logical_sectormask;
+	bool			bt_needs_provisioning;
 
 	/* LRU control structures */
 	struct shrinker		bt_shrinker;
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index d19cca099bc3..f1eec563c61d 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -407,6 +407,13 @@ __XFS_HAS_FEAT(nouuid, NOUUID)
 #define XFS_OPSTATE_WARNED_LARP		9
 /* Mount time quotacheck is running */
 #define XFS_OPSTATE_QUOTACHECK_RUNNING	10
+/*
+ * If the block device underlying either the data or rt volume needs
+ * provisioning to guarantee space availability, this flag will be set.
+ * Operations that need to check, issue or free provisioning trigger off
+ * this flag.
+ */
+#define XFS_OPSTATE_PROVISION_BLOCKS	11
 
 #define __XFS_IS_OPSTATE(name, NAME) \
 static inline bool xfs_is_ ## name (struct xfs_mount *mp) \
@@ -434,6 +441,7 @@ __XFS_IS_OPSTATE(quotacheck_running, QUOTACHECK_RUNNING)
 #else
 # define xfs_is_quotacheck_running(mp)	(false)
 #endif
+__XFS_IS_OPSTATE(provisioning_blocks, PROVISION_BLOCKS)
 
 static inline bool
 xfs_should_warn(struct xfs_mount *mp, long nr)
@@ -452,7 +460,8 @@ xfs_should_warn(struct xfs_mount *mp, long nr)
 	{ (1UL << XFS_OPSTATE_WARNED_SCRUB),		"wscrub" }, \
 	{ (1UL << XFS_OPSTATE_WARNED_SHRINK),		"wshrink" }, \
 	{ (1UL << XFS_OPSTATE_WARNED_LARP),		"wlarp" }, \
-	{ (1UL << XFS_OPSTATE_QUOTACHECK_RUNNING),	"quotacheck" }
+	{ (1UL << XFS_OPSTATE_QUOTACHECK_RUNNING),	"quotacheck" }, \
+	{ (1UL << XFS_OPSTATE_PROVISION_BLOCKS),	"provision" }
 
 /*
  * Max and min values for mount-option defined I/O
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 819a3568b28f..a5b15ddfb31e 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -471,11 +471,15 @@ xfs_open_devices(
 	mp->m_ddev_targp = xfs_alloc_buftarg(mp, ddev);
 	if (!mp->m_ddev_targp)
 		goto out_close_rtdev;
+	if (mp->m_ddev_targp->bt_needs_provisioning)
+		xfs_set_provisioning_blocks(mp);
 
 	if (rtdev) {
 		mp->m_rtdev_targp = xfs_alloc_buftarg(mp, rtdev);
 		if (!mp->m_rtdev_targp)
 			goto out_free_ddev_targ;
+		if (mp->m_rtdev_targp->bt_needs_provisioning)
+			xfs_set_provisioning_blocks(mp);
 	}
 
 	if (logdev && logdev != ddev) {
