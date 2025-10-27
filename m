Return-Path: <linux-ext4+bounces-11099-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA58DC0D954
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Oct 2025 13:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EFD1189785C
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Oct 2025 12:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3439C3101A5;
	Mon, 27 Oct 2025 12:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="yo9svdE2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7169E30FF3B
	for <linux-ext4@vger.kernel.org>; Mon, 27 Oct 2025 12:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761568260; cv=none; b=tKrMlUt6k51crRwXD9Db2QGQTzeSMNEQWa9hF3wiyU/2LyWkIIoepRblLHkER6BVZP/zkxDpFwWa3H0C8ysukXieE1Kt+zfjRYq/XZDLY4SMd/WwS+1OoS1emHne8zjbWHWlBMnQWNC3WiFga2MZsUxOZgMQOXsxGBJ6ktuKkcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761568260; c=relaxed/simple;
	bh=skLKl7aqfW4fbKsOK+CajLaubp/LPg23+JnVxQHXksQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P8ILgt9nyprXT5DhttLk+EgXPyTG0ks/3Fw7TXpz8n2dDP+iBtBxLyWat8zjaFRmWARD6HrTd7k4M0TtSfhVhmi09HroeD4OQUFXisNxpaQhwcugnG5lzvm80COe/XJ4hPEA1nEQ7THqDIvh6GnexhBVlznDXgy/GWCD5lTQiFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=yo9svdE2; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=YlIJbN2leSvHMe27fR1NAfrMTd/aleJjh8WMk5EH0Nk=;
	b=yo9svdE2ALBc/z4Ti1MUT+9PvFhkuhcVrHQKSvAf/KV4yg+AbX2Qb3YZUZ5xr94eyNS6U9B0i
	IJ0hcenws70ssutKnyFgABM958FWHvZaa1i/odqFk43E7cceZCB93958T5KlpccXe0fuslMe67P
	sSicEf6HqCE8uyd27ZnFgl8=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4cwCX36NZNzRhRJ;
	Mon, 27 Oct 2025 20:30:27 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id D7554180237;
	Mon, 27 Oct 2025 20:30:55 +0800 (CST)
Received: from syn-076-053-033-115.biz.spectrum.com (10.50.87.129) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 27 Oct 2025 20:30:55 +0800
From: Yang Erkun <yangerkun@huawei.com>
To: <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<jack@suse.cz>
CC: <yi.zhang@huawei.com>, <libaokun1@huawei.com>, <yangerkun@huawei.com>,
	<yangerkun@huaweicloud.com>
Subject: [PATCH 3/4] ext4: cleanup for ext4_map_blocks
Date: Mon, 27 Oct 2025 20:23:02 +0800
Message-ID: <20251027122303.1146352-3-yangerkun@huawei.com>
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

Retval from ext4_map_create_blocks means we really create some blocks,
cannot happened with m_flags without EXT4_MAP_UNWRITTEN and
EXT4_MAP_MAPPED.

Signed-off-by: Yang Erkun <yangerkun@huawei.com>
---
 fs/ext4/inode.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index e8bac93ca668..3d8ada26d5cd 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -799,7 +799,13 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 	down_write(&EXT4_I(inode)->i_data_sem);
 	retval = ext4_map_create_blocks(handle, inode, map, flags);
 	up_write((&EXT4_I(inode)->i_data_sem));
-	if (retval > 0 && map->m_flags & EXT4_MAP_MAPPED) {
+
+	if (retval < 0)
+		ext_debug(inode, "failed with err %d\n", retval);
+	if (retval <= 0)
+		return retval;
+
+	if (map->m_flags & EXT4_MAP_MAPPED) {
 		ret = check_block_validity(inode, map);
 		if (ret != 0)
 			return ret;
@@ -828,12 +834,8 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 				return ret;
 		}
 	}
-	if (retval > 0 && (map->m_flags & EXT4_MAP_UNWRITTEN ||
-				map->m_flags & EXT4_MAP_MAPPED))
-		ext4_fc_track_range(handle, inode, map->m_lblk,
-					map->m_lblk + map->m_len - 1);
-	if (retval < 0)
-		ext_debug(inode, "failed with err %d\n", retval);
+	ext4_fc_track_range(handle, inode, map->m_lblk, map->m_lblk +
+			    map->m_len - 1);
 	return retval;
 }
 
-- 
2.39.2


