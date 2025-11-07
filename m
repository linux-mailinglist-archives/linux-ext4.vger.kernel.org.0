Return-Path: <linux-ext4+bounces-11657-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D2629C406FE
	for <lists+linux-ext4@lfdr.de>; Fri, 07 Nov 2025 15:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BC3DE4F00D3
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Nov 2025 14:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA4632E68C;
	Fri,  7 Nov 2025 14:51:32 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466E532D0C4;
	Fri,  7 Nov 2025 14:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762527092; cv=none; b=bYnMp6dHKSmwIxdlrYD9wUhrFEDkEtXag9xvbZpXhSIVHMqFViwYuH8c6QkaXB1OZkTkTvnPB/0Tbg2w6QkQRXBzY49N/lQPLn9go4y4oCKhVCIA0z2p7sThpGK1iLc7/TgwRt1yM9fp/xDII6V68RJaCbPOXaWiQaH/FfOugZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762527092; c=relaxed/simple;
	bh=coloHHUVpE1OdVGl8F/8XrI+nLfYZeeDwL4Rwf5j15Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IZV21Yi1vjtZo/q41Cff1dpOZqil9rhIo4+RADBTUYjaxf9M0Rn+cCgb/SC5748nQKcRYmv8ufWZmoNTuwYENNX/SUoD6Fai6+Nd1DCStRoyqZh3qUUrGMHRqQW13TMgaMmkiy5REsARCkIKUDuEy9pU1HFXSzHidMQ4G7H1qn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d327D62BRzYQv49;
	Fri,  7 Nov 2025 22:51:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 08E791A0EE8;
	Fri,  7 Nov 2025 22:51:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP2 (Coremail) with SMTP id Syh0CgDnPUZoBw5pRwgbDA--.60770S26;
	Fri, 07 Nov 2025 22:51:24 +0800 (CST)
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
Subject: [PATCH v2 22/24] ext4: support verifying data from large folios with fs-verity
Date: Fri,  7 Nov 2025 22:42:47 +0800
Message-Id: <20251107144249.435029-23-libaokun@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgDnPUZoBw5pRwgbDA--.60770S26
X-Coremail-Antispam: 1UD129KBjvJXoW7tw1kXFW3KF17AFWkAw1UWrg_yoW8Xry7pa
	90kry8Gws5Z3yvgw4ktF4UZry5tay8tFWUAa1DZ343Za4kZw1FvF1qya1FqFnrtrZ7Xr4S
	qF4Iyr1akwnrAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	x2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdsqAUUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgAFBWkNxrAU4QABsk

From: Baokun Li <libaokun1@huawei.com>

Eric Biggers already added support for verifying data from large folios
several years ago in commit 5d0f0e57ed90 ("fsverity: support verifying
data from large folios").

With ext4 now supporting large block sizes, the fs-verity tests
`kvm-xfstests -c ext4/64k -g verity -x encrypt` pass without issues.

Therefore, remove the restriction and allow LBS to be enabled together
with fs-verity.

Cc: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/inode.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 517701024d18..b95826e4a419 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5152,8 +5152,6 @@ static bool ext4_should_enable_large_folio(struct inode *inode)
 
 	if (!S_ISREG(inode->i_mode))
 		return false;
-	if (ext4_has_feature_verity(sb))
-		return false;
 	if (ext4_has_feature_encrypt(sb))
 		return false;
 
@@ -5175,7 +5173,8 @@ void ext4_set_inode_mapping_order(struct inode *inode)
 		return;
 
 	if (test_opt(inode->i_sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA ||
-	    ext4_test_inode_flag(inode, EXT4_INODE_JOURNAL_DATA))
+	    ext4_test_inode_flag(inode, EXT4_INODE_JOURNAL_DATA) ||
+	    ext4_has_feature_verity(inode->i_sb))
 		max_order = EXT4_SB(inode->i_sb)->s_min_folio_order;
 	else
 		max_order = EXT4_MAX_PAGECACHE_ORDER(inode);
-- 
2.46.1


