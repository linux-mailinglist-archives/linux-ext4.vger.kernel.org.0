Return-Path: <linux-ext4+bounces-11446-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD430C31383
	for <lists+linux-ext4@lfdr.de>; Tue, 04 Nov 2025 14:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F07B71887672
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Nov 2025 13:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B3E2E3373;
	Tue,  4 Nov 2025 13:26:16 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2C82C0F97
	for <linux-ext4@vger.kernel.org>; Tue,  4 Nov 2025 13:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762262776; cv=none; b=P6dyicLtOtZHKBoOV0+j1GoVD+I3bgK5MNy0qoVt8zzR0WMOltMkvvb8mRcM/AAalRvnrp4evt765CON8CHRpX9UpXos2302EDEZW+XS4e8/e+A629a0mW5mYINHSO2O2RKn46CF5yMMO84PiJbnHIHl4CLEEGh0I+tUtK+++Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762262776; c=relaxed/simple;
	bh=MvyZuTXC9tcU3o+e/22gSJ6ZNTNUxYcgSAyjEK0dKMI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W+dbOwkE+UwlybzrdUrR3PzrXiRlTD5QCEYRal56XKWGhtnNlWfQekEDqH6DbXXOWs9PIwEzqqTFzEf4JabuxOxv6k4CnDfZ3UCcq+HZBiORXBYvPRjfy1OKa3KKMw3TPDIMSwl4HcXpTliCOOyzGV9yRUXiYAtIp6FwAIG/Nvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d18NY1CjbzKHMpN
	for <linux-ext4@vger.kernel.org>; Tue,  4 Nov 2025 21:26:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 042D41A07BB
	for <linux-ext4@vger.kernel.org>; Tue,  4 Nov 2025 21:26:11 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP2 (Coremail) with SMTP id Syh0CgCn_UXv_glpN8K+Cg--.58269S6;
	Tue, 04 Nov 2025 21:26:10 +0800 (CST)
From: Yang Erkun <yangerkun@huawei.com>
To: linux-ext4@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz
Cc: yi.zhang@huawei.com,
	libaokun1@huawei.com,
	yangerkun@huawei.com,
	yangerkun@huaweicloud.com
Subject: [PATCH v2 3/4] ext4: cleanup for ext4_map_blocks
Date: Tue,  4 Nov 2025 21:17:49 +0800
Message-Id: <20251104131750.1581541-3-yangerkun@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20251104131750.1581541-1-yangerkun@huawei.com>
References: <20251104131750.1581541-1-yangerkun@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCn_UXv_glpN8K+Cg--.58269S6
X-Coremail-Antispam: 1UD129KBjvJXoW7tFy5try8Aw48tw45ZFWfGrg_yoW8Xryxp3
	y3Cr1rGr1UWrWY9w4FyF18ZF12kayFk3y8ZFWfAr95Z343Arn3tr1jyF1fCFZ8KrWfJw4U
	XF4jy345CwsYka7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmEb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjsIEF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I
	0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxAIw28IcVAKzI0EY4vE52x082I5MxC2
	0s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20x
	vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8
	JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8ha9DUUUUU==
Sender: yangerkun@huaweicloud.com
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

Retval from ext4_map_create_blocks means we really create some blocks,
cannot happened with m_flags without EXT4_MAP_UNWRITTEN and
EXT4_MAP_MAPPED.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
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


