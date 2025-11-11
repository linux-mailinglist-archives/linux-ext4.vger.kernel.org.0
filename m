Return-Path: <linux-ext4+bounces-11775-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 592C0C4E880
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Nov 2025 15:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E218018959C8
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Nov 2025 14:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555FD33CE82;
	Tue, 11 Nov 2025 14:35:36 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814E43328E6;
	Tue, 11 Nov 2025 14:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762871735; cv=none; b=ZxcC6ZYeBBKHoFK7IU4L3ozqONbHW0zfAtXwsSAZdmrITXy4AZR5ZIvtglnHQ/yiNPWASl2OYUYuz14pAZsppHcczzqoavCWUuKWqNTOsC7n0lYd4b8UcI/e9kBlSMTFMTTXWgChcFrSXqeTiu8uMM+MXDcOkU8J5TtOI8LgJ44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762871735; c=relaxed/simple;
	bh=/XgSakDfjLXFQZ0fNtaKp9PDSIuKVtLaor6BRknOcXs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XQ++5JbJSDFKeABABKgODKdco3txuGz6q4ZGsUsbNWbJVOiLx/xzBCWLpuptXZ+TollIcB6gtOk15yQ/7sjfvgWyuS/Bpa7LAoYz6rHBnspjcL/aABUmSAEhC6rVJUtJoAhiHKdZuj25nKUDnSn9K5YOwEXJ0e7lG0teQ6RkO3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d5Tb353PwzKHMdf;
	Tue, 11 Nov 2025 22:35:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id E1C021A018D;
	Tue, 11 Nov 2025 22:35:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP2 (Coremail) with SMTP id Syh0CgBHo3mrSRNpgYWKAQ--.32556S18;
	Tue, 11 Nov 2025 22:35:27 +0800 (CST)
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
Subject: [PATCH v3 14/24] ext4: prepare buddy cache inode for BS > PS with large folios
Date: Tue, 11 Nov 2025 22:26:24 +0800
Message-Id: <20251111142634.3301616-15-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20251111142634.3301616-1-libaokun@huaweicloud.com>
References: <20251111142634.3301616-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBHo3mrSRNpgYWKAQ--.32556S18
X-Coremail-Antispam: 1UD129KBjvJXoW7AFWxXFy3WF4kCw4DtrWxXrb_yoW8JFWfpa
	17GF18Gr18Way5CF4xGFy8Xa4xKa1xWay7JrZ29w1jvF9rWFyFkFsrtry29FW8AFWfAayf
	XF47uw13ur45GaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	x2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdsqAUUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgAJBWkSsIpDTgAAsC

From: Baokun Li <libaokun1@huawei.com>

We use EXT4_BAD_INO for the buddy cache inode number. This inode is not
accessed via __ext4_new_inode() or __ext4_iget(), meaning
ext4_set_inode_mapping_order() is not called to set its folio order range.

However, future block size greater than page size support requires this
inode to support large folios, and the buddy cache code already handles
BS > PS. Therefore, ext4_set_inode_mapping_order() is now explicitly
called for this specific inode to set its folio order range.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/mballoc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 3f10c64ab2b1..102c6439eb11 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3493,6 +3493,8 @@ static int ext4_mb_init_backend(struct super_block *sb)
 	 * this will avoid confusion if it ever shows up during debugging. */
 	sbi->s_buddy_cache->i_ino = EXT4_BAD_INO;
 	EXT4_I(sbi->s_buddy_cache)->i_disksize = 0;
+	ext4_set_inode_mapping_order(sbi->s_buddy_cache);
+
 	for (i = 0; i < ngroups; i++) {
 		cond_resched();
 		desc = ext4_get_group_desc(sb, i, NULL);
-- 
2.46.1


