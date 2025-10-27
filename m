Return-Path: <linux-ext4+bounces-11098-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EAEC0D9CC
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Oct 2025 13:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 231BC4FC5D5
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Oct 2025 12:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EA430DEBD;
	Mon, 27 Oct 2025 12:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ZEK/Up4S"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A92B30F95C
	for <linux-ext4@vger.kernel.org>; Mon, 27 Oct 2025 12:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761568260; cv=none; b=E20Y9sZAD02uObsWIY+6Tw/WOAx9hUi8u/AHVT/kS+/jMQw2Gr0ZMWJicm/i/tE6IZH/RyNfV+0hTjw8/1ahrr2tO5spj/2H7Voz/YC0lr18GRPSeqTEYwr9ZEyLrA7GZOfSUEZMkyeSznww7c8i14aw8xpqI5AtFoWeH2fqrrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761568260; c=relaxed/simple;
	bh=I/tHzv2NLHQiL+QFNpPLdVLBdX8OuwtmIh7uXri+Yc8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bKRJL6PAhcvww6QpE3WJQCvBLrO/DwCrRe8PJcA0EfpubdRJJYcb7rghe0um/XjY6eQqySdqGrlg+SwRucGqZcVi4QE0l+eRBrS0mJVxxANwxeRDcLWklaORUgBqzLBBQ6p69+Z+fcEhMP7mJQtMkkkp4dCCpBsaHQhZjelpx0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ZEK/Up4S; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Ua8TTldf9Lr3gHRTWel2zmH1miuj/Sg0cVx6uEwwm64=;
	b=ZEK/Up4SOgitim4vTGY3pSYorJXdX6l968afq6RvFRIIPutyuT46ms9SWVWk4VCMYVcnE7Ddx
	AyFtvp39xlVDZ+yDL4PQ0xRKnnY5deTnza08vKIoAFLdnAdBgVePtph3ekL+OEQwoAzVlrKMCAb
	HntjwEnHx7cG9pKC6QAAQZk=
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4cwCX32zxQzLlSH;
	Mon, 27 Oct 2025 20:30:27 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id 1EC511A016C;
	Mon, 27 Oct 2025 20:30:55 +0800 (CST)
Received: from syn-076-053-033-115.biz.spectrum.com (10.50.87.129) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 27 Oct 2025 20:30:54 +0800
From: Yang Erkun <yangerkun@huawei.com>
To: <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<jack@suse.cz>
CC: <yi.zhang@huawei.com>, <libaokun1@huawei.com>, <yangerkun@huawei.com>,
	<yangerkun@huaweicloud.com>
Subject: [PATCH 1/4] ext4: remove useless code in ext4_map_create_blocks
Date: Mon, 27 Oct 2025 20:23:00 +0800
Message-ID: <20251027122303.1146352-1-yangerkun@huawei.com>
X-Mailer: git-send-email 2.39.2
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

IO path with EXT4_GET_BLOCKS_PRE_IO means dio within i_size or
dioread_nolock buffer writeback, they all means we need a unwritten
extent(or this extent has already been initialized), and the split won't
zero the range we really write. So this check seems useless. Besides,
even if we repeatedly execute ext4_es_insert_extent, there won't
actually be any issues.

Signed-off-by: Yang Erkun <yangerkun@huawei.com>
---
 fs/ext4/inode.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index e99306a8f47c..e8bac93ca668 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -583,7 +583,6 @@ static int ext4_map_query_blocks(handle_t *handle, struct inode *inode,
 static int ext4_map_create_blocks(handle_t *handle, struct inode *inode,
 				  struct ext4_map_blocks *map, int flags)
 {
-	struct extent_status es;
 	unsigned int status;
 	int err, retval = 0;
 
@@ -644,16 +643,6 @@ static int ext4_map_create_blocks(handle_t *handle, struct inode *inode,
 			return err;
 	}
 
-	/*
-	 * If the extent has been zeroed out, we don't need to update
-	 * extent status tree.
-	 */
-	if (flags & EXT4_GET_BLOCKS_PRE_IO &&
-	    ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es)) {
-		if (ext4_es_is_written(&es))
-			return retval;
-	}
-
 	status = map->m_flags & EXT4_MAP_UNWRITTEN ?
 			EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
 	ext4_es_insert_extent(inode, map->m_lblk, map->m_len, map->m_pblk,
-- 
2.39.2


