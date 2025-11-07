Return-Path: <linux-ext4+bounces-11646-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C158C3FD8B
	for <lists+linux-ext4@lfdr.de>; Fri, 07 Nov 2025 13:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D4A64E856D
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Nov 2025 12:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9062F327211;
	Fri,  7 Nov 2025 12:06:53 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38DD32720F
	for <linux-ext4@vger.kernel.org>; Fri,  7 Nov 2025 12:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762517213; cv=none; b=u19/ua04rojwxIOwUhxaGAneDm5G8DbtFMor/6xvxcz/5huzDtgnPbPfHDKSFVtnsP68jIuNlc4iBlqovehoPUQGv7/JvGZaC7LXxXEUMDoJr3qNTtekpTe+2YHXC1R1Z9wWvyjSBHLi6Aknt8oDsLeEX5Qi2EewD4CghpIC6kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762517213; c=relaxed/simple;
	bh=LQpPmxmXyWck9yY2x4oMVBhL0o0IIrxPGwse5EbLKNM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ipiwfy4QLPuXy2pOw7lDWxcJ9FkLDZyIdEpLLUZUnhsTFjWll/Vc/ovLvpgvL4DwenlxYOFaab4e5BT+qXJV9VFSZ9LYhtUdJniPRDHnCp85OU/zCSztL9VzCgNfDXR4fsuF5gf2mdYFwV8GPx2xPGnqjg10bioi6GlXmuSeM8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d2yTB5pzYzYQtrf
	for <linux-ext4@vger.kernel.org>; Fri,  7 Nov 2025 20:06:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id C7C791A1023
	for <linux-ext4@vger.kernel.org>; Fri,  7 Nov 2025 20:06:42 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP1 (Coremail) with SMTP id cCh0CgAnTVDO4A1pyNToCw--.7597S6;
	Fri, 07 Nov 2025 20:06:42 +0800 (CST)
From: Yang Erkun <yangerkun@huawei.com>
To: linux-ext4@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz
Cc: yi.zhang@huawei.com,
	libaokun1@huawei.com,
	yangerkun@huawei.com,
	yangerkun@huaweicloud.com
Subject: [PATCH v3 3/3] ext4: cleanup for ext4_map_blocks
Date: Fri,  7 Nov 2025 19:58:10 +0800
Message-Id: <20251107115810.47199-3-yangerkun@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20251107115810.47199-1-yangerkun@huawei.com>
References: <20251107115810.47199-1-yangerkun@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAnTVDO4A1pyNToCw--.7597S6
X-Coremail-Antispam: 1UD129KBjvJXoW7tFy5try8AFWUJF1UKr1Dtrb_yoW8XF4Dp3
	y3Cr1rGr1UWrWY9w4FyF1UZF12kayFk3y8ZFWfZr95Z343Arn3tr1jyF1SkFZ8trWfJw4U
	XF4jyry5CwsYka7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmEb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
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
Reviewed-by: Jan Kara <jack@suse.cz>
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


