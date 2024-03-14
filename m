Return-Path: <linux-ext4+bounces-1647-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5E487BE87
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Mar 2024 15:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2CADB22B0E
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Mar 2024 14:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27437351B;
	Thu, 14 Mar 2024 14:07:59 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054226FE03;
	Thu, 14 Mar 2024 14:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710425279; cv=none; b=SFsGN1NnTnUf+KMwtIMVPYdPkqK9RG44/2Vxo0UdlJfEhHfNQEdOZQP8xs/2ciK122DlGWYIIAYU/367CY7KhCyOd4tys7q4zs7iX/swXECU/eL53AHB4Dh/S2wbThlFJ8gp9ZmpYoR4nVCYUZq+/BZzriG5hOaMU6O5dL6SoM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710425279; c=relaxed/simple;
	bh=HUFyIyn2aR8nI6S7apzAbeRc6aQE+WXtA2u1lyTifaI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mk8inwzKbc4GY6U8YaI9yf6c+HgkHrFeMxKLNPr0kmi8Cr893a01hwBwjQwLVWU+vLed+uQB7981HkYjmtVxkutKiCl1lR87pyyJEdXB85ySQG4bMnaTuw3B25/cB7apuLSAaGQcNEc+np3rUv2sH4j/EH+tshTQpq0chLyqlVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4TwTgX6hNnzNm2C;
	Thu, 14 Mar 2024 22:06:00 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id DE9C614011B;
	Thu, 14 Mar 2024 22:07:47 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 14 Mar
 2024 22:07:47 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<ritesh.list@gmail.com>, <ojaswin@linux.ibm.com>, <adobriyan@gmail.com>,
	<linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH v3 8/9] ext4: set the type of max_zeroout to unsigned int to avoid overflow
Date: Thu, 14 Mar 2024 22:09:05 +0800
Message-ID: <20240314140906.3064072-9-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240314140906.3064072-1-libaokun1@huawei.com>
References: <20240314140906.3064072-1-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500021.china.huawei.com (7.185.36.21)

The max_zeroout is of type int and the s_extent_max_zeroout_kb is of
type uint, and the s_extent_max_zeroout_kb can be freely modified via
the sysfs interface. When the block size is 1024, max_zeroout may
overflow, so declare it as unsigned int to avoid overflow.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/extents.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index e57054bdc5fd..e067f2dd0335 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3402,9 +3402,10 @@ static int ext4_ext_convert_to_initialized(handle_t *handle,
 	struct ext4_extent *ex, *abut_ex;
 	ext4_lblk_t ee_block, eof_block;
 	unsigned int ee_len, depth, map_len = map->m_len;
-	int allocated = 0, max_zeroout = 0;
 	int err = 0;
 	int split_flag = EXT4_EXT_DATA_VALID2;
+	int allocated = 0;
+	unsigned int max_zeroout = 0;
 
 	ext_debug(inode, "logical block %llu, max_blocks %u\n",
 		  (unsigned long long)map->m_lblk, map_len);
-- 
2.31.1


