Return-Path: <linux-ext4+bounces-11449-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D232BC3149C
	for <lists+linux-ext4@lfdr.de>; Tue, 04 Nov 2025 14:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D572D46167A
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Nov 2025 13:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C26531E115;
	Tue,  4 Nov 2025 13:44:37 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40699329370
	for <linux-ext4@vger.kernel.org>; Tue,  4 Nov 2025 13:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762263876; cv=none; b=C3VzzKkWGJTJnhFptQFaZKFf2hspFhY9gysyfKXxrMmVfo8EX3DTdOlIlH9u/DaJQDHGQHwH4SRw/ST8rp7ConVClw5RyKh5KnqIdJKpapvJ33Eywsaty9pYdmXsToo26RoGp/I3EtoV0NWOhLGsUqLYdmOdItdkaRKwkiMR8nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762263876; c=relaxed/simple;
	bh=7cGp1ZKuEVxwznhzsIHRjUF/RqlQJP3BOwr5rk/s3aQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FWmcGiOgR+HeRP8A1Ju9IQ4YIqSqnujQJ4hMZA+x8+RYiQP2Qf0+eQ17KcRQy9HnOAPpOiPLf/M/NO5KeEHFSeQPh7nVzR5jbtsILcKVQzweJ1r8m6XyoPJfPez7KA/5Nd/uNe142B14l185b1LWw5suBBTdPtlK1QMuKnPgUEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d18NY1YJTzKHMpN
	for <linux-ext4@vger.kernel.org>; Tue,  4 Nov 2025 21:26:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 0FC841A1341
	for <linux-ext4@vger.kernel.org>; Tue,  4 Nov 2025 21:26:11 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP2 (Coremail) with SMTP id Syh0CgCn_UXv_glpN8K+Cg--.58269S7;
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
Subject: [PATCH v2 4/4] ext4: order mode should not take effect for DIO
Date: Tue,  4 Nov 2025 21:17:50 +0800
Message-Id: <20251104131750.1581541-4-yangerkun@huawei.com>
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
X-CM-TRANSID:Syh0CgCn_UXv_glpN8K+Cg--.58269S7
X-Coremail-Antispam: 1UD129KBjvJXoWxXFy8GrWrKFyrAF1rGw45Wrg_yoW5GF4kpF
	srAFyxGr40qw45u3y8GF4jqry7tw1Ika1DZa4Fqw4Uu343tr1FqFnF9FyrCa45KrWkAan0
	vF15u34jyrn5CrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmEb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
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
	JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1sqXPUUUUU==
Sender: yangerkun@huaweicloud.com
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

Since the size will be updated after the DIO completes, the data
will not be shown to userspace before that.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Signed-off-by: Yang Erkun <yangerkun@huawei.com>
---
 fs/ext4/ext4.h              | 2 ++
 fs/ext4/inode.c             | 5 +++--
 include/trace/events/ext4.h | 1 +
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 96d7d649ccb0..d0331697467d 100644
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


