Return-Path: <linux-ext4+bounces-11969-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B9CC7816C
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Nov 2025 10:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 66B6534A80A
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Nov 2025 09:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F4030100C;
	Fri, 21 Nov 2025 09:16:51 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5572E8B66;
	Fri, 21 Nov 2025 09:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763716608; cv=none; b=k10+YQjHZgC7FQ9U33R82EL1iuN2Ip9Zs3HFu3liIW/xGPnRAnKgN71rfVvkPEiKDvFn+HWH4w/wA/kqfWFWvrJtBDDBRSU8wLM1kPSYVKG9RRGJ1mz99IA/pSolT/9c39UxZwpQnApUBQE2+uChopMnmkOP8nCvAVuhTy0kjbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763716608; c=relaxed/simple;
	bh=XgQvpJ6GqS3mrzphP4vfzaJL3vWA0LYD80eFbI67RuI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HJFokTMRqbrc9ZVV0uChqsWBnknLrpz/k7X1EYc+kccDXOB7MuNZtJEUEcdZNWD1JT9N3N7j0qLngGKKLT+Yv/YekJuZhPLCoUkpIUDEIOIOBnXcPsUH9jAVu3pWOEwvmhD0Ts96vpfctPXu7Um1m4K2hE09W0/srOtqVShC+s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dCV274p6dzYQvGT;
	Fri, 21 Nov 2025 17:15:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id E72231A0BC1;
	Fri, 21 Nov 2025 17:16:42 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP2 (Coremail) with SMTP id Syh0CgBHpXv4LSBpaLMDBg--.2072S8;
	Fri, 21 Nov 2025 17:16:42 +0800 (CST)
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
Subject: [PATCH v4 04/24] ext4: make ext4_punch_hole() support large block size
Date: Fri, 21 Nov 2025 17:06:34 +0800
Message-Id: <20251121090654.631996-5-libaokun@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgBHpXv4LSBpaLMDBg--.2072S8
X-Coremail-Antispam: 1UD129KBjvJXoW7WrWxWw4xXryDGw17WF1xZrb_yoW8Xw1kpr
	y3G348urWUWayqkF4jg3W8Zw1xtana9w4UXFWUZr4UJr98Ja4Skr12gry0qa1vyrZ2yryF
	qrsrtryfZF13A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgATBWkf34sfEwAAs6

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
index c956aff677ac..d11df0f4c546 100644
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


