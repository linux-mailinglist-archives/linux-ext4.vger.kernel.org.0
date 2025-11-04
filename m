Return-Path: <linux-ext4+bounces-11448-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A35F9C313D1
	for <lists+linux-ext4@lfdr.de>; Tue, 04 Nov 2025 14:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D6C464FB2C1
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Nov 2025 13:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A95322A3E;
	Tue,  4 Nov 2025 13:26:18 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1CA61FFE
	for <linux-ext4@vger.kernel.org>; Tue,  4 Nov 2025 13:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762262778; cv=none; b=lnmYQgJLh1AsgYKJDOjbyvAitEgDYs600dckVbhG38jew6ssngfSTcShwtb1GfP+DsvExpL5CXVEp/muRwXYybL4P3MNndQCfNXLW4YNqgLD3xRfoAKit0GqKefSNhHok/QNIIRv0LWFmaMBRtdI/jxqwrNBfbZElIQ3B9vRB9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762262778; c=relaxed/simple;
	bh=VW/r5ztc9/lTYth/a2Ag2ZmAt0TYfYdxPUylMss2G4g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c+PgM6qJgsuowMA5i0j3/KQOGmH3CLfeqCfJUpdMqMXcxhdmIaryM/LGw+PW595M7LlZ1EIDEg3fslMX4sXLstv3Z5qcaewvuuPWc2xaxIUMJ8vaWhzuqGaiXA/7kMDwAuHF5jK5rsD1ac3deIXY2zcUdY4ptrjzd75yG0D2Sl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d18NX71WZzKHMp3
	for <linux-ext4@vger.kernel.org>; Tue,  4 Nov 2025 21:26:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id CCA311A01A4
	for <linux-ext4@vger.kernel.org>; Tue,  4 Nov 2025 21:26:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP2 (Coremail) with SMTP id Syh0CgCn_UXv_glpN8K+Cg--.58269S4;
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
Subject: [PATCH v2 1/4] ext4: remove useless code in ext4_map_create_blocks
Date: Tue,  4 Nov 2025 21:17:47 +0800
Message-Id: <20251104131750.1581541-1-yangerkun@huawei.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCn_UXv_glpN8K+Cg--.58269S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Cry8CFWxKF13ZryUJrW5Jrb_yoW8XFyDp3
	sxCF48Gr1DWw1j9ayIkF1UXr13K3W5GrWUCrWxAw1rWayfCr9ayF10yF1SyFZYgrWfX3WY
	qF4Yk348uw4xJrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Eb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
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


