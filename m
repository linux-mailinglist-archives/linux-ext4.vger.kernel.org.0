Return-Path: <linux-ext4+bounces-11972-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D073CC7818F
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Nov 2025 10:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F3FD4E98E8
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Nov 2025 09:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A8834027D;
	Fri, 21 Nov 2025 09:16:55 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4DB2DF146;
	Fri, 21 Nov 2025 09:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763716609; cv=none; b=BEccCUScZkDsDmpTjwzsLBhiZB45UWlfM8LQDtCjL1P7evnfpAtj9UXfNxSSC5ass52su5skqNcESRtUNBmD16vbSaMtUQevHkdi/FFTS2PP8xNKpIuRu7FxWVgvXP2omtNTuw8b/Bw2TZ/wRhbxaQC4zmhGaQco78ezRIbIBPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763716609; c=relaxed/simple;
	bh=nbLlr4pz10EzMDk4blvgn3Zk/K6kyFcZwM8fWlL40uw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F+ns7JhiN2jtaL6GxRZumM4i9cAU+Mesy9khbou2VE+lv1/peN4CXSQrJHBc5HnguiO7C6Qqe20y+okzoB+V9zgiKBwXw8nDMPJwXACGLfsqeyq4VUCoBhnel1xTzBZbXHw28J7HCfS4KfHwE6osSQsVXeFfobBrmemDv3zAIjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dCV276tQdzYQvGn;
	Fri, 21 Nov 2025 17:15:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 3A8251A084B;
	Fri, 21 Nov 2025 17:16:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP2 (Coremail) with SMTP id Syh0CgBHpXv4LSBpaLMDBg--.2072S12;
	Fri, 21 Nov 2025 17:16:43 +0800 (CST)
From: libaokun@huaweicloud.com
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	kernel@pankajraghav.com,
	mcgrof@kernel.org,
	ebiggers@kernel.org,
	willy@infradead.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	chengzhihao1@huawei.com,
	libaokun1@huawei.com,
	libaokun@huaweicloud.com,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v4 08/24] ext4: support large block size in ext4_readdir()
Date: Fri, 21 Nov 2025 17:06:38 +0800
Message-Id: <20251121090654.631996-9-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20251121090654.631996-1-libaokun@huaweicloud.com>
References: <20251121090654.631996-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBHpXv4LSBpaLMDBg--.2072S12
X-Coremail-Antispam: 1UD129KBjvJXoW7KF15KF1fWw1rZry8CrWktFb_yoW8Gw1rpa
	9Ig3WvkFy09r40939rtFy7ZFWY9a97GFWUWrWYy345W3s3X3sakr9xtF1jvF1DW3yxAa4f
	ZF12kFy3GF15J3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQa14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr0_
	Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8c
	xan2IY04v7M4kE6xkIj40Ew7xC0wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdsqAUUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQATBWkf35kfFAAAss

From: Baokun Li <libaokun1@huawei.com>

In ext4_readdir(), page_cache_sync_readahead() is used to readahead mapped
physical blocks. With LBS support, this can lead to a negative right shift.

To fix this, the page index is now calculated by first converting the
physical block number (pblk) to a file position (pos) before converting
it to a page index. Also, the correct number of pages to readahead is now
passed.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/ext4/dir.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
index d4164c507a90..256fe2c1d4c1 100644
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -192,13 +192,13 @@ static int ext4_readdir(struct file *file, struct dir_context *ctx)
 			continue;
 		}
 		if (err > 0) {
-			pgoff_t index = map.m_pblk >>
-					(PAGE_SHIFT - inode->i_blkbits);
+			pgoff_t index = map.m_pblk << inode->i_blkbits >>
+					PAGE_SHIFT;
 			if (!ra_has_index(&file->f_ra, index))
 				page_cache_sync_readahead(
 					sb->s_bdev->bd_mapping,
-					&file->f_ra, file,
-					index, 1);
+					&file->f_ra, file, index,
+					1 << EXT4_SB(sb)->s_min_folio_order);
 			file->f_ra.prev_pos = (loff_t)index << PAGE_SHIFT;
 			bh = ext4_bread(NULL, inode, map.m_lblk, 0);
 			if (IS_ERR(bh)) {
-- 
2.46.1


