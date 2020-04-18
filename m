Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC9F81AF5E3
	for <lists+linux-ext4@lfdr.de>; Sun, 19 Apr 2020 01:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725827AbgDRXcl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 18 Apr 2020 19:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgDRXcl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 18 Apr 2020 19:32:41 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC994C061A0C
        for <linux-ext4@vger.kernel.org>; Sat, 18 Apr 2020 16:32:40 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d24so2498018pll.8
        for <linux-ext4@vger.kernel.org>; Sat, 18 Apr 2020 16:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=OhFS9SxCHCF1ndKjiMqjkbrt3aphkAFP9TvmLujy6Tc=;
        b=NP4KFYHjnDxFUUxIVrjqQp9hc+qep5LClIXaJjfHYqVD9Xs+azQr0L1l+28QF7ttgj
         ufbsGhWjbRlPFRr/tzyvm4ow4rA3RWB6DKjvvVKF9cAV5lK1zWGLJzT6AxMXd88aYrOQ
         Vtr/1nTF9MVpwspxMXoDnj5rS3CRf1+ulF5s1w19oGkmkvrboeAU3i+7FFQJISCZ91yy
         9tUd0VpzWVB0etCqH540X/8msjLhyi12BZKqbAlnC+KtwCJaLWpgVSeINL1HedIGiheU
         f49NKp5XvrweGyegDL97dY51ATOuw3ubUCwQZc65nEUW/+dOqXc/8AILzczNKujRUHbw
         cZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=OhFS9SxCHCF1ndKjiMqjkbrt3aphkAFP9TvmLujy6Tc=;
        b=casQXMdHfYamSfOuNIAxURWwKYfXRYklSfpkQmLGkETnFuRA/Ed+c7pBzX0POBkcQa
         eGGX4t1pVBb/0t1L1C4yXuWH8cDLFQsMjXHV3xgBrUE4UAx0LQRKQ0eI+9lbvsV6ijkx
         ScKfFhjwO6RObY4Q/oKC38kZtPKktQx6aNJnNGEGFnknQo6WGNlADRfE8HnzQ8FdNxgw
         V+/yvTULJrTAgZ+yr2iOqa+jWfZDVPixKdNGKzkWEJdwpO4uwDkrWOVkw13VGEAEdTup
         VJcW+vaFeTORGq0gDmiVi5Yn3SBFKRnAbz2Tm/eXubutyAuMNqJR9hQMZWyW9V2f98uV
         RuxA==
X-Gm-Message-State: AGi0PuaE4s6zevrnNHVgNwzfnBknDZftJTicKcMhH2v0nbCubomqlvAB
        FklCIEEx6jepKg/k+h24BlNOOgA/
X-Google-Smtp-Source: APiQypLxVCeKXYFcCR/e8vqvCf16XYvtV7Z5aseUYs6/CAT8PeqRWHkFScrYak/uZ6DlPMhkkVDM8A==
X-Received: by 2002:a17:902:8a8f:: with SMTP id p15mr10267763plo.45.1587252760101;
        Sat, 18 Apr 2020 16:32:40 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id mu15sm9699551pjb.30.2020.04.18.16.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 16:32:39 -0700 (PDT)
Date:   Sun, 19 Apr 2020 07:32:31 +0800
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     riteshh@linux.ibm.com
Subject: [PATCH] ext4: validate fiemap iomap begin offset and length value
Message-ID: <20200418233231.z767yvfiupy7hwgp@xzhoux.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Sometimes crazy userspace values can be here causing overflow issue.

After moved ext4_fiemap to using the iomap framework in
  commit d3b6f23f7167 ("ext4: move ext4_fiemap to use iomap framework")
we can hit the WARN_ON at fs/iomap/apply.c:51, then get an EIO error
running xfstests generic/009 (and some others) on ext4 based overlayfs.

The minimal reproducer is:
-------------------------------------
fallocate -l 256M test.img
mkfs.ext4 -Fq -b 4096 -I 256 test.img
mkdir -p test
mount -o loop test.img test || exit
pushd test
rm -rf l u w m
mkdir -p l u w m
mount -t overlay -o lowerdir=l,upperdir=u,workdir=w overlay m || exit
xfs_io -f -c "pwrite 0 4096" -c "fiemap"  m/tf
umount m
rm -rf l u w m
popd
umount -d test
rm -rf test test.img
-------------------------------------

Because we run fiemap command wo/ the offset and length parameters,
xfs_io set values based on fs blocksize etc which is got from
the mounted fs. These values xfs_io passed are way larger on overlayfs
than ext4 directly. So we can't reproduce this directly on ext4 or xfs.
I tried to call ioctl directly with large length value but failed to
reproduce this.

I did not try to get what values xfs_io exactly passing in, but I
confirmed that overflowed value when it made into _ext4_fiemap.
It's a length of 0x7fffffffffffffff which will mess up the calculation
of map.m_lblk and map.m_len, make map.m_len to be 0, then hit WARN_ON
and get EIO in iomap_apply.

Fixing this by ensuring the offset and length values wont exceed
EXT4_MAX_LOGICAL_BLOCK. Also make sure that the length would not
be zero because of crazy overflowed values.

This patch has been tested with LTP/xfstests showing no new issue.

Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
Fixes: d3b6f23f7167 ("ext4: move ext4_fiemap to use iomap framework")
---
 fs/ext4/inode.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index e416096..3620417 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3523,6 +3523,8 @@ static int ext4_iomap_begin_report(struct inode *inode, loff_t offset,
 	int ret;
 	bool delalloc = false;
 	struct ext4_map_blocks map;
+	ext4_lblk_t last_lblk;
+	ext4_lblk_t lblk;
 	u8 blkbits = inode->i_blkbits;
 
 	if ((offset >> blkbits) > EXT4_MAX_LOGICAL_BLOCK)
@@ -3540,9 +3542,18 @@ static int ext4_iomap_begin_report(struct inode *inode, loff_t offset,
 	/*
 	 * Calculate the first and last logical block respectively.
 	 */
-	map.m_lblk = offset >> blkbits;
-	map.m_len = min_t(loff_t, (offset + length - 1) >> blkbits,
-			  EXT4_MAX_LOGICAL_BLOCK) - map.m_lblk + 1;
+	lblk = offset >> blkbits;
+	last_lblk = (offset + length - 1) >> blkbits;
+
+	if (last_lblk >= EXT4_MAX_LOGICAL_BLOCK)
+		last_lblk = EXT4_MAX_LOGICAL_BLOCK - 1;
+	if (lblk >= EXT4_MAX_LOGICAL_BLOCK)
+		lblk = EXT4_MAX_LOGICAL_BLOCK - 1;
+
+	map.m_lblk = lblk;
+	map.m_len = last_lblk - lblk + 1;
+	if (map.m_len == 0 )
+		map.m_len = 1;
 
 	/*
 	 * Fiemap callers may call for offset beyond s_bitmap_maxbytes.
-- 
1.8.3.1
