Return-Path: <linux-ext4+bounces-1248-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5726485687D
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Feb 2024 16:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 131D7292301
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Feb 2024 15:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3879D13472B;
	Thu, 15 Feb 2024 15:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="O/EJRg6V"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBE012BF03;
	Thu, 15 Feb 2024 15:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708012224; cv=none; b=qwTuVPjAeHqU2ehFzWlY8vIMTcPirw1MlpVFAnNpsNtTG7AJ30RgN7UvDfKZX+bwe8yGAmW/byjIxH+R3JxNAUc7Yf9Ysz8LOkoeZ4t48vIHG8g2xh7dI2POjFBx3uIkz9gc/dRiNlCB+GVmP6DDDsOeDI7mEUAHwlzfQ0EzK6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708012224; c=relaxed/simple;
	bh=nRsOhffUEUuRhmS+8HSepxdFjF49Sg5dDRzWq3AYXBE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JJYJ1uPq/keTl2HajSCH4zyigDxc6OQDqdKzwbqZmvqRPCkf7DSE4E4zTO2gvhiJwppqIago4jfeGPPyXlr/olTB1Chqq4xlRonziRru8yOYCIyXFDdFh+sh3ENXz4jdfM9xM4U26oFmGuXkapAR4eYM/rOaBePpphIwc/v8ezw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=O/EJRg6V; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1708012223; x=1739548223;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GOmRYqtgssrc+Ztwxp13mDL5XOVk9YlZb1c27Zd3aaQ=;
  b=O/EJRg6VuRkk0gEkOELFMHYz8MUZ2/N/ODw/BoVaRuNI2L0h2CT6ocEw
   GCLEfS2bJqyFzXWyylqL6tU9dCt08gzUZOtMc2Wdd/9JipyQbvse0Punu
   OBuccVuL2f39HGPu59oC2gnSJHQn8YP0ik7i3+iCkCFR3x3I6V4u1YvqB
   Q=;
X-IronPort-AV: E=Sophos;i="6.06,162,1705363200"; 
   d="scan'208";a="185053725"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 15:50:20 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:31897]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.60.209:2525] with esmtp (Farcaster)
 id 129ec688-a7b3-4980-8268-483dcdf08da3; Thu, 15 Feb 2024 15:50:18 +0000 (UTC)
X-Farcaster-Flow-ID: 129ec688-a7b3-4980-8268-483dcdf08da3
Received: from EX19D001UWA002.ant.amazon.com (10.13.138.236) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 15 Feb 2024 15:50:18 +0000
Received: from EX19MTAUWB001.ant.amazon.com (10.250.64.248) by
 EX19D001UWA002.ant.amazon.com (10.13.138.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 15 Feb 2024 15:50:18 +0000
Received: from dev-dsk-mheyne-1b-c1362c4d.eu-west-1.amazon.com (10.15.57.183)
 by mail-relay.amazon.com (10.250.64.254) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Thu, 15 Feb 2024 15:50:18 +0000
Received: by dev-dsk-mheyne-1b-c1362c4d.eu-west-1.amazon.com (Postfix, from userid 5466572)
	id F14604266; Thu, 15 Feb 2024 15:50:17 +0000 (UTC)
From: Maximilian Heyne <mheyne@amazon.de>
To: 
CC: <ravib@amazon.com>, Maximilian Heyne <mheyne@amazon.de>,
	<stable@vger.kernel.org>, Theodore Ts'o <tytso@mit.edu>, Andreas Dilger
	<adilger.kernel@dilger.ca>, Yongqiang Yang <xiaoqiangnk@gmail.com>,
	<linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] ext4: fix corruption during on-line resize
Date: Thu, 15 Feb 2024 15:50:09 +0000
Message-ID: <20240215155009.94493-1-mheyne@amazon.de>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

We observed a corruption during on-line resize of a file system that is
larger than 16 TiB with 4k block size. With having more then 2^32 blocks
resize_inode is turned off by default by mke2fs. The issue can be
reproduced on a smaller file system for convenience by explicitly
turning off resize_inode. An on-line resize across an 8 GiB boundary (the
size of a meta block group in this setup) then leads to a corruption:

  dev=/dev/<some_dev> # should be >= 16 GiB
  mkdir -p /corruption
  /sbin/mke2fs -t ext4 -b 4096 -O ^resize_inode $dev $((2 * 2**21 - 2**15))
  mount -t ext4 $dev /corruption

  dd if=/dev/zero bs=4096 of=/corruption/test count=$((2*2**21 - 4*2**15))
  sha1sum /corruption/test
  # 79d2658b39dcfd77274e435b0934028adafaab11  /corruption/test

  /sbin/resize2fs $dev $((2*2**21))
  # drop page cache to force reload the block from disk
  echo 1 > /proc/sys/vm/drop_caches

  sha1sum /corruption/test
  # 3c2abc63cbf1a94c9e6977e0fbd72cd832c4d5c3  /corruption/test

2^21 = 2^15*2^6 equals 8 GiB whereof 2^15 is the number of blocks per
block group and 2^6 are the number of block groups that make a meta
block group.

The last checksum might be different depending on how the file is laid
out across the physical blocks. The actual corruption occurs at physical
block 63*2^15 = 2064384 which would be the location of the backup of the
meta block group's block descriptor. During the on-line resize the file
system will be converted to meta_bg starting at s_first_meta_bg which is
2 in the example - meaning all block groups after 16 GiB. However, in
ext4_flex_group_add we might add block groups that are not part of the
first meta block group yet. In the reproducer we achieved this by
substracting the size of a whole block group from the point where the
meta block group would start. This must be considered when updating the
backup block group descriptors to follow the non-meta_bg layout. The fix
is to add a test whether the group to add is already part of the meta
block group or not.

Fixes: 01f795f9e0d67 ("ext4: add online resizing support for meta_bg and 64-bit file systems")
Cc: stable@vger.kernel.org
Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
---
 fs/ext4/resize.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index 4d4a5a32e310..3c0d12382e06 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -1602,7 +1602,8 @@ static int ext4_flex_group_add(struct super_block *sb,
 		int gdb_num = group / EXT4_DESC_PER_BLOCK(sb);
 		int gdb_num_end = ((group + flex_gd->count - 1) /
 				   EXT4_DESC_PER_BLOCK(sb));
-		int meta_bg = ext4_has_feature_meta_bg(sb);
+		int meta_bg = ext4_has_feature_meta_bg(sb) &&
+			      gdb_num >= le32_to_cpu(es->s_first_meta_bg);
 		sector_t padding_blocks = meta_bg ? 0 : sbi->s_sbh->b_blocknr -
 					 ext4_group_first_block_no(sb, 0);
 
-- 
2.40.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879




