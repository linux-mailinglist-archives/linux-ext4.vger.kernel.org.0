Return-Path: <linux-ext4+bounces-1136-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B717F84B486
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Feb 2024 13:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA2CB1C23D54
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Feb 2024 12:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C71D1332A8;
	Tue,  6 Feb 2024 12:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="GYpnH/eD"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137021CFB2;
	Tue,  6 Feb 2024 12:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221113; cv=none; b=b2AvxcQ8qWZbCyJt1P1KFzWBYomE9CTFovqIrr2c5H4z+VBUuJHSY1yWt7JJ2z82ZPnD8ExEBWb0ZKOsN2gDfVTVNjkziYr7bRlGu82aUVp7GaCQHA4ESjOq4+YQLfwyx/jyfzM4kg6V11SIaBMXMc6kPKRRcFUigW9sczeJZTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221113; c=relaxed/simple;
	bh=OQelbDLj+bOqEsxF27nP9h9zyIA5fWUq7YJwu9ZforE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iAhkOUwc/AZfyo+FGZlLe6q/JtJnDfd/a0yy+dcOFhqHb5oJIMmh4CnjxrSYLhKwPMzSw0NFs5gr4ZHQZjLHC0GvTA1y+/xenJNoLWsa9Y4Q4LT+yMOthnSbPw9Kn0I+8z4Ojgm0vyqVz/jYqK7vg3Ut3lzc8f5BHTUiXLkFxAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=GYpnH/eD; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1707221111; x=1738757111;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gl74gCBZa9uoUIx5/l/r/zJQe58dVCOTIWPMT3ZpBb4=;
  b=GYpnH/eDCxGpPjmlDwvV8Ko/OpMqq1TQiF37NHOrXzuF7pDzFgCtlfsD
   A9mVXjRqrCPoYtfBndw3b8P+tszEqc+oOBDbb/NKNhTxgDgpQziYAVFR6
   pDk+Wvhqg5cGer/w3lOk9xNnfawYKT8miuHGhAH7xWk8E/CqGbR0at++m
   k=;
X-IronPort-AV: E=Sophos;i="6.05,247,1701129600"; 
   d="scan'208";a="379254368"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 12:05:08 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:31351]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.177:2525] with esmtp (Farcaster)
 id c9cfb521-cea1-4196-a5b8-62dd92c7f18e; Tue, 6 Feb 2024 12:05:07 +0000 (UTC)
X-Farcaster-Flow-ID: c9cfb521-cea1-4196-a5b8-62dd92c7f18e
Received: from EX19D001UWB002.ant.amazon.com (10.13.138.54) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 6 Feb 2024 12:05:07 +0000
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.204) by
 EX19D001UWB002.ant.amazon.com (10.13.138.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 6 Feb 2024 12:05:06 +0000
Received: from dev-dsk-mheyne-1b-c1362c4d.eu-west-1.amazon.com (10.15.57.183)
 by mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Tue, 6 Feb 2024 12:05:06 +0000
Received: by dev-dsk-mheyne-1b-c1362c4d.eu-west-1.amazon.com (Postfix, from userid 5466572)
	id 436D196C; Tue,  6 Feb 2024 12:05:06 +0000 (UTC)
From: Maximilian Heyne <mheyne@amazon.de>
To: 
CC: <ravib@amazon.com>, Maximilian Heyne <mheyne@amazon.de>, Theodore Ts'o
	<tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
	<linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] ext4: fix corruption during on-line resize
Date: Tue, 6 Feb 2024 12:05:04 +0000
Message-ID: <20240206120504.122870-1-mheyne@amazon.de>
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

Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
---
 fs/ext4/resize.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index 4d4a5a32e310..3433e83bb7a3 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -1602,7 +1602,9 @@ static int ext4_flex_group_add(struct super_block *sb,
 		int gdb_num = group / EXT4_DESC_PER_BLOCK(sb);
 		int gdb_num_end = ((group + flex_gd->count - 1) /
 				   EXT4_DESC_PER_BLOCK(sb));
-		int meta_bg = ext4_has_feature_meta_bg(sb);
+		unsigned long metagroup = group / EXT4_DESC_PER_BLOCK(sb);
+		int meta_bg = ext4_has_feature_meta_bg(sb) &&
+			      metagroup >= le32_to_cpu(es->s_first_meta_bg);
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




