Return-Path: <linux-ext4+bounces-11668-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E22FFC40788
	for <lists+linux-ext4@lfdr.de>; Fri, 07 Nov 2025 15:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E96B73B961B
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Nov 2025 14:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E8C336EE6;
	Fri,  7 Nov 2025 14:51:38 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6CE334C08;
	Fri,  7 Nov 2025 14:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762527098; cv=none; b=iL4BUpKRHUKEVNQ9XPykG+8z8TfE9gYVhx9YUxSzx0jDQMaTVzm89j5mVNpFqODgR21Lw7pcEjuO4uzhinx+4X7Mcsc8ZQeCunQbsmdBRATm36WZ6m2le9wQkeQXommspEulzDXg3x+VYTPftEJMK0lbtOeLwVJwrJ+JUB160k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762527098; c=relaxed/simple;
	bh=+SP5V5FeeB9v98P67CAYO1+av7JpqIZe3ORwtcBUT/k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NBwDBpA7xydEyXDwlXM1Ic3JIir1BXs16dnGCBCYQ7iwA00fd9gDlTv9tgxkHPG1LV5sGG3MA2zGT+Q2ht586CXJh4KoIABeolGyccDo0EmVDdbQoK6EjJG+m8wJRwqTDjIuIKkAHD2YEbcPd+AGoF33vV+UhxCYd0cpgDvCWwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d327P5HW8zKHMgh;
	Fri,  7 Nov 2025 22:51:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 13B561A1A40;
	Fri,  7 Nov 2025 22:51:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP2 (Coremail) with SMTP id Syh0CgDnPUZoBw5pRwgbDA--.60770S14;
	Fri, 07 Nov 2025 22:51:23 +0800 (CST)
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
	libaokun@huaweicloud.com
Subject: [PATCH v2 10/24] ext4: add EXT4_LBLK_TO_PG and EXT4_PG_TO_LBLK for block/page conversion
Date: Fri,  7 Nov 2025 22:42:35 +0800
Message-Id: <20251107144249.435029-11-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20251107144249.435029-1-libaokun@huaweicloud.com>
References: <20251107144249.435029-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgDnPUZoBw5pRwgbDA--.60770S14
X-Coremail-Antispam: 1UD129KBjvJXoW7tF4DJrW7uF1DWw17GFW7Jwb_yoW8Jw1xpr
	sxWFyrGr1Fvry8ur1IgFy0vryfGa93GayUX39FvrZ09FyxKr1fWrs0gr93JFyjg3yrJFWq
	qFyFkryxWr13G3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQa14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr0_
	Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8c
	xan2IY04v7M4kE6xkIj40Ew7xC0wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdsqAUUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQAFBWkNxrUVHwAAsc

From: Baokun Li <libaokun1@huawei.com>

As BS > PS support is coming, all block number to page index (and
vice-versa) conversions must now go via bytes. Added EXT4_LBLK_TO_PG()
and EXT4_PG_TO_LBLK() macros to simplify these conversions and handle
both BS <= PS and BS > PS scenarios cleanly.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index c00ce6db69f0..4bc0b2b7288a 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -370,6 +370,12 @@ struct ext4_io_submit {
 	(round_up((offset), i_blocksize(inode)) >> (inode)->i_blkbits)
 #define EXT4_LBLK_TO_B(inode, lblk) ((loff_t)(lblk) << (inode)->i_blkbits)
 
+/* Translate a block number to a page index */
+#define EXT4_LBLK_TO_PG(inode, lblk)	(EXT4_LBLK_TO_B((inode), (lblk)) >> \
+					 PAGE_SHIFT)
+/* Translate a page index to a block number */
+#define EXT4_PG_TO_LBLK(inode, pnum)	(((loff_t)(pnum) << PAGE_SHIFT) >> \
+					 (inode)->i_blkbits)
 /* Translate a block number to a cluster number */
 #define EXT4_B2C(sbi, blk)	((blk) >> (sbi)->s_cluster_bits)
 /* Translate a cluster number to a block number */
-- 
2.46.1


