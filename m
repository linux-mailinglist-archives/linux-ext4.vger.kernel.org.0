Return-Path: <linux-ext4+bounces-11644-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 620CDC3FD88
	for <lists+linux-ext4@lfdr.de>; Fri, 07 Nov 2025 13:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0C44334DA91
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Nov 2025 12:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933D7327219;
	Fri,  7 Nov 2025 12:06:49 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D54032720E
	for <linux-ext4@vger.kernel.org>; Fri,  7 Nov 2025 12:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762517209; cv=none; b=CWDC9VpQkrKxqb/Ypp8gE4LRA/GY56PXAjdCYIIqZLXNdCE7Q4WswY72aR+QExbaHy7J7kAu8ohxm/VdSkBIAdFKD8xLgx+6RYy5HNkR8nIgcmVTCL31mgiGXcEpBVO90bafmMqGEF/EK5FZzpwefKZCQyk8m/3wj/kjGjsqCto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762517209; c=relaxed/simple;
	bh=w78AHyO/8iuvgeEw7eYkyY9yUlmOqzHLKrM27I7KeMU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iq1V/v0J2R5Guty7iECLflXxefkrIRj9OTylHuCHh1VLOhf53JwNbl2Xvo1IraKuK1M20FBWANpxVrOV3GE3mXcumwWY+evbWc260KP24jyF3xb7dbx82cj/PPU7NSi6CUs6gSGgR6KeB5BtRw1jNSIl4wy0ASfD1emgrJFo+7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d2yTN3MGGzKHMXZ
	for <linux-ext4@vger.kernel.org>; Fri,  7 Nov 2025 20:06:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 9E0BE1A018D
	for <linux-ext4@vger.kernel.org>; Fri,  7 Nov 2025 20:06:42 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP1 (Coremail) with SMTP id cCh0CgAnTVDO4A1pyNToCw--.7597S4;
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
Subject: [PATCH v3 1/3] ext4: remove useless code in ext4_map_create_blocks
Date: Fri,  7 Nov 2025 19:58:08 +0800
Message-Id: <20251107115810.47199-1-yangerkun@huawei.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAnTVDO4A1pyNToCw--.7597S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Cry8CFWxKry7CF4rZw45GFg_yoW8Wr18p3
	43CFW8Gr1DW34j9ayIkF1UZr13K3W5CrWUCrWxAw1rWayfCr9ayF10yr4SyFZYgFWFq3WY
	qF4Yk348uw4fJrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Eb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4I
	kC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7Iv64x0x7Aq67IIx4CEVc8vx2IErcIF
	xwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCF04k20xvEw4C26cxK6c8Ij2
	8IcwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1xnY5UUUUU==
Sender: yangerkun@huaweicloud.com
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

IO path with EXT4_GET_BLOCKS_PRE_IO means dio within i_size or
dioread_nolock buffer writeback, they all means we need a unwritten
extent(or this extent has already been initialized), and the split won't
zero the range we really write. So this check seems useless. Besides,
even if we repeatedly execute ext4_es_insert_extent, there won't
actually be any issues.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
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


