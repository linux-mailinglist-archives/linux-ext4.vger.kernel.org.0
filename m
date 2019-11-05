Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0148DEFCCF
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Nov 2019 12:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730943AbfKEL7o (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 5 Nov 2019 06:59:44 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40332 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfKEL7o (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 5 Nov 2019 06:59:44 -0500
Received: by mail-pf1-f196.google.com with SMTP id r4so15138774pfl.7
        for <linux-ext4@vger.kernel.org>; Tue, 05 Nov 2019 03:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IalHleKHLFMzSLg0SYJL+fw2PdceORLMv9WENP/4q30=;
        b=vE2uEZ+MnatULuVJetsFF5gEPeIzWNhZ95NapXKd4imaR/SqowpoGqqjFw/tVbdzG+
         CI9snjgoCBDH8YMPrANIklT8ADrrEDUFXSrgLVl7M6uqnYJ+SeRINsjiuMH/3MzZjCRC
         x7uAmLnMEuClE+Mrfc8NKFi41jLNmE9Xy9bFj/+QshX8tGHRTNr6Z7FGBGPEAEIXws4E
         GP31NNnaNH0ktW/lhL1GcZhQzUoURdnz5KyqharDQ7f30iaEiHD+Nps2dz+FrrSgCIL6
         tP9Meg4BlA0z0xswlmititxW6GAK5DkszjR9AKm43+GAfOyovCMgq1ySEK+5f/D4iKkG
         NVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IalHleKHLFMzSLg0SYJL+fw2PdceORLMv9WENP/4q30=;
        b=kjCvWtYY1xdv2vxR+q9Gx9icPJp5PeHt8J6t5FELuyesqPQ7QY1Qn/Slk7geFn2JJP
         aRgVl2rSyP8n/o8ky4eFZKbLXJ78dQclaxho6Gip38wuGwu9zGahdwBNY8LvoDfII5i7
         p+d3G2g59BNN37E41LzpjYMayT+VONFSv8NEPK/9PAnnBcqN6fCvxjLSnNNf0U4w0Vm+
         rlxA8qVJHupxspAVOQ13kYlEA0jYioaFz4KJvZ/g+0nFbV88vNn6qbGM5lv+vTKh0orX
         Py5pNVestgjLtztO4pSkwjU10ZvuQP73qzwdHkPxAqrw5PedT/qkrmZ6ZxcSCfM6/hUZ
         jdQg==
X-Gm-Message-State: APjAAAVHN7cILgukhuTHFmRVVosuiuxEx9VfsMM+K9G8F0lPU6f8swVJ
        8OTz9/hC9lWrOg8rV3hlOGtB
X-Google-Smtp-Source: APXvYqx42HPFhiqLRP7eQKgRiEHCLM07ajKcCvwhrVhnYOxkKyej9oG0EDT/Nx1XkNh3zvuThXkgwA==
X-Received: by 2002:a65:4183:: with SMTP id a3mr36366936pgq.440.1572955183724;
        Tue, 05 Nov 2019 03:59:43 -0800 (PST)
Received: from poseidon.bobrowski.net ([114.78.226.167])
        by smtp.gmail.com with ESMTPSA id 31sm18822992pgy.63.2019.11.05.03.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 03:59:43 -0800 (PST)
Date:   Tue, 5 Nov 2019 22:59:37 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        riteshh@linux.ibm.com
Subject: [PATCH v7 03/11] ext4: iomap that extends beyond EOF should be
 marked dirty
Message-ID: <8b43ee9ee94bee5328da56ba0909b7d2229ef150.1572949325.git.mbobrowski@mbobrowski.org>
References: <cover.1572949325.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1572949325.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch addresses what Dave Chinner had discovered and fixed within
commit: 7684e2c4384d. This changes does not have any user visible
impact for ext4 as none of the current users of ext4_iomap_begin()
that extend files depend on IOMAP_F_DIRTY.

When doing a direct IO that spans the current EOF, and there are
written blocks beyond EOF that extend beyond the current write, the
only metadata update that needs to be done is a file size extension.

However, we don't mark such iomaps as IOMAP_F_DIRTY to indicate that
there is IO completion metadata updates required, and hence we may
fail to correctly sync file size extensions made in IO completion when
O_DSYNC writes are being used and the hardware supports FUA.

Hence when setting IOMAP_F_DIRTY, we need to also take into account
whether the iomap spans the current EOF. If it does, then we need to
mark it dirty so that IO completion will call generic_write_sync() to
flush the inode size update to stable storage correctly.

Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/inode.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index f33fa86fff67..b422d9b8c0bd 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3565,8 +3565,14 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 			return ret;
 	}
 
+	/*
+	 * Writes that span EOF might trigger an I/O size update on completion,
+	 * so consider them to be dirty for the purposes of O_DSYNC, even if
+	 * there is no other metadata changes being made or are pending here.
+	 */
 	iomap->flags = 0;
-	if (ext4_inode_datasync_dirty(inode))
+	if (ext4_inode_datasync_dirty(inode) ||
+	    offset + length > i_size_read(inode))
 		iomap->flags |= IOMAP_F_DIRTY;
 	iomap->bdev = inode->i_sb->s_bdev;
 	iomap->dax_dev = sbi->s_daxdev;
-- 
2.20.1

