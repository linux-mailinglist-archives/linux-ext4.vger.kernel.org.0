Return-Path: <linux-ext4+bounces-11767-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBDBC4E8A4
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Nov 2025 15:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8B043AE5C0
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Nov 2025 14:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C062E3054D7;
	Tue, 11 Nov 2025 14:35:31 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AB02DCC04;
	Tue, 11 Nov 2025 14:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762871731; cv=none; b=SFiHungm8lttJ85UcOldmkSt9QT2z0mickAfNqylWEeCrOJlTUuu2GozBMNNMgc7nxeDCdxpegwt8y/lXdgENsg2ACFNdlBUgVq6T/n2hWNuges83EHDwTRoJcZKkGjYKqmArhtsZ0qcQeR574QOZpoKLQPDoIEXADfLAgtCxsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762871731; c=relaxed/simple;
	bh=Vl0+VBZqNcsOXP3mcTgJrwI+imWYo0ynixfy4j3hsOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HlFTh6YiPawMNv/7WU6UzzSDleOhjtV73jQGnvDWzduuMi+fbzGwndiP7H1+otYVhDKst6meGV2hTNsx8ima90z8Y4TGYPqpxW4It0QT9KMZ6QBSuEfWxMNKiEN3pKVSFQyGgH/gm18JTrgRIOaIQ4hhrHAGq4oXgyrVdsVIgI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d5Tb26clHzKHMbD;
	Tue, 11 Nov 2025 22:35:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 2195C1A0DD7;
	Tue, 11 Nov 2025 22:35:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP2 (Coremail) with SMTP id Syh0CgBHo3mrSRNpgYWKAQ--.32556S8;
	Tue, 11 Nov 2025 22:35:26 +0800 (CST)
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
Subject: [PATCH v3 04/24] ext4: make ext4_punch_hole() support large block size
Date: Tue, 11 Nov 2025 22:26:14 +0800
Message-Id: <20251111142634.3301616-5-libaokun@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgBHo3mrSRNpgYWKAQ--.32556S8
X-Coremail-Antispam: 1UD129KBjvJXoW7WrWxWw4xXryDGw17WF1xZrb_yoW8Xw1kp3
	43G348u3y8WayjkF4Yg3WUZw1xt3Za9w4UXFWUZr4UXr98Ja4Skr12gry0ga1v9rWIyryF
	qrnrtryfZF17A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQ214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUo0PSUUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgAJBWkSsIpDSAAAsE

From: Baokun Li <libaokun1@huawei.com>

When preparing for bs > ps support, clean up unnecessary PAGE_SIZE
references in ext4_punch_hole().

Previously, when a hole extended beyond i_size, we aligned the hole end
upwards to PAGE_SIZE to handle partial folio invalidation. Now that
truncate_inode_pages_range() already handles partial folio invalidation
correctly, this alignment is no longer required.

However, to save pointless tail block zeroing, we still keep rounding up
to the block size here.

In addition, as Honza pointed out, when the hole end equals i_size, it
should also be rounded up to the block size. This patch fixes that as well.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index f7ca48729738..6fec3aa2268a 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4406,10 +4406,10 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 
 	/*
 	 * If the hole extends beyond i_size, set the hole to end after
-	 * the page that contains i_size.
+	 * the block that contains i_size to save pointless tail block zeroing.
 	 */
-	if (end > inode->i_size)
-		end = round_up(inode->i_size, PAGE_SIZE);
+	if (end >= inode->i_size)
+		end = round_up(inode->i_size, sb->s_blocksize);
 	if (end > max_end)
 		end = max_end;
 	length = end - offset;
-- 
2.46.1


