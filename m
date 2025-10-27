Return-Path: <linux-ext4+bounces-11100-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C48A8C0D9DB
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Oct 2025 13:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E2D54043F2
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Oct 2025 12:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41E530FF3B;
	Mon, 27 Oct 2025 12:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="K1ixiGC9"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02CA30FC12
	for <linux-ext4@vger.kernel.org>; Mon, 27 Oct 2025 12:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761568261; cv=none; b=m04iu9ZvSk7wdA/pS5sOu1HDbBOsnDhAMfy09B5/8xuY+TCu44zoixmhIYtk40v4jhixPYEg4dc6zSWcjQ441G4ofbp7k2TNxZRtdbp131n8V9PfIz++sFzCRPR5nT36oqNHCFn9n8xeUZoV1c8d1yKZtZAwuAa6joYS1aBY0lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761568261; c=relaxed/simple;
	bh=jeTBdHrGT6BjFw6RUsYkd7i2EysCy+55HMzhRT3A0uY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SIqtSawktoUlEXtEvvh+/uz0ldebLpWU9sng3TUGcTCqcInZn7MlZnIlcNi7aUtrBSb09JpFTGjqCmp8/RLbRgzsCzEm3J9crQF5/beFZQopVEn79EE53ofhSzEch4eUT3lkghuunfobdsAkTBfJXPZ+ppICIiasgDQlBv1Amp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=K1ixiGC9; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=LDu+0+aAkX5XJzQBlCTSv2aiqtrawIsBf+w0Wn6Wez0=;
	b=K1ixiGC9sxr0gVvnw9EHI6pjz+0xFemReooC0Nfoe2bNPFul5uF8xyR/8pE81SzdSdeqmq1zP
	sPpB5C8g/v4n0TgiJ5Yl3NPHWZuZqZZ67B5go2Y3uucezPKGmlkw7gKG+D9QN0dxTocoK66biYv
	3GWo7CrFZf+mLAB/6jzvGx0=
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cwCX44XxlzKm6m;
	Mon, 27 Oct 2025 20:30:28 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id 3FCEB180042;
	Mon, 27 Oct 2025 20:30:56 +0800 (CST)
Received: from syn-076-053-033-115.biz.spectrum.com (10.50.87.129) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 27 Oct 2025 20:30:55 +0800
From: Yang Erkun <yangerkun@huawei.com>
To: <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<jack@suse.cz>
CC: <yi.zhang@huawei.com>, <libaokun1@huawei.com>, <yangerkun@huawei.com>,
	<yangerkun@huaweicloud.com>
Subject: [PATCH 4/4] ext4: order mode should not take effect for DIO
Date: Mon, 27 Oct 2025 20:23:03 +0800
Message-ID: <20251027122303.1146352-4-yangerkun@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20251027122303.1146352-1-yangerkun@huawei.com>
References: <20251027122303.1146352-1-yangerkun@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf100006.china.huawei.com (7.202.181.220)

Since the size will be updated after the DIO completes, the data
will not be shown to userspace before that.

Signed-off-by: Yang Erkun <yangerkun@huawei.com>
---
 fs/ext4/ext4.h              | 2 ++
 fs/ext4/inode.c             | 5 +++--
 include/trace/events/ext4.h | 1 +
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 5a035d0e2761..bad43d047224 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -715,6 +715,8 @@ enum {
 #define EXT4_GET_BLOCKS_METADATA_NOFAIL		0x0020
 	/* Don't normalize allocation size (used for fallocate) */
 #define EXT4_GET_BLOCKS_NO_NORMALIZE		0x0040
+	/* Get blocks from DIO */
+#define EXT4_GET_BLOCKS_DIO			0x0080
 	/* Convert written extents to unwritten */
 #define EXT4_GET_BLOCKS_CONVERT_UNWRITTEN	0x0100
 	/* Write zeros to newly created written extents */
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 3d8ada26d5cd..168dbcc9e921 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -818,6 +818,7 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 		if (map->m_flags & EXT4_MAP_NEW &&
 		    !(map->m_flags & EXT4_MAP_UNWRITTEN) &&
 		    !(flags & EXT4_GET_BLOCKS_ZERO) &&
+		    !(flags & EXT4_GET_BLOCKS_DIO) &&
 		    !ext4_is_quota_file(inode) &&
 		    ext4_should_order_data(inode)) {
 			loff_t start_byte =
@@ -3729,9 +3730,9 @@ static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
 	 * happening and thus expose allocated blocks to direct I/O reads.
 	 */
 	else if (((loff_t)map->m_lblk << blkbits) >= i_size_read(inode))
-		m_flags = EXT4_GET_BLOCKS_CREATE;
+		m_flags = EXT4_GET_BLOCKS_CREATE | EXT4_GET_BLOCKS_DIO;
 	else if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
-		m_flags = EXT4_GET_BLOCKS_IO_CREATE_EXT;
+		m_flags = EXT4_GET_BLOCKS_IO_CREATE_EXT | EXT4_GET_BLOCKS_DIO;
 
 	if (flags & IOMAP_ATOMIC)
 		ret = ext4_map_blocks_atomic_write(handle, inode, map, m_flags,
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index ada2b9223df5..de6d848f2e37 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -43,6 +43,7 @@ struct partial_cluster;
 	{ EXT4_GET_BLOCKS_CONVERT,		"CONVERT" },		\
 	{ EXT4_GET_BLOCKS_METADATA_NOFAIL,	"METADATA_NOFAIL" },	\
 	{ EXT4_GET_BLOCKS_NO_NORMALIZE,		"NO_NORMALIZE" },	\
+	{ EXT4_GET_BLOCKS_DIO,			"DIO" },		\
 	{ EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,	"CONVERT_UNWRITTEN" },  \
 	{ EXT4_GET_BLOCKS_ZERO,			"ZERO" },		\
 	{ EXT4_GET_BLOCKS_IO_SUBMIT,		"IO_SUBMIT" },		\
-- 
2.39.2


