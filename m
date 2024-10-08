Return-Path: <linux-ext4+bounces-4527-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1901A9947F8
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Oct 2024 14:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF6671F226AA
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Oct 2024 12:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D200F1D90A9;
	Tue,  8 Oct 2024 12:03:31 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA821D6DA3;
	Tue,  8 Oct 2024 12:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728389011; cv=none; b=YpeEo6xxBkZRemlT9xuqwsb83rd9TpqpFNI+TUzb0BF/zefp7epiYvn3UaZnb2otTe5MIvaxI0V+1nsDhI8nGmOjj3vZOCDK+epd0aHIWQw+MaPNJglLJGxghg2tOj9bnWWVfdrM2nWkCff4Z01HJjxVT4dDocC5X7q+GIoQHG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728389011; c=relaxed/simple;
	bh=rI920+A7PTwdpdexWvUgfSuMfU4/CAWs4q8b3iY0JqI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QE9JOTz8/YwSkn+G6keKN+3ZpeqzoxF7AyWfXmls76gSDkOIMw3iAmimSYQlL1Lk6vvuijxKyoj4JQZ5Ao32KmdH5VDJfsPAN9EpyGS2nvEgCuK3z85dxwflFdrjwxm/qdsJZMYk0DPV41CZZi/VJqpgZrSCyYcQrgXIAlIhnKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XNF5l43vFz4f3jsD;
	Tue,  8 Oct 2024 20:03:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5F0E41A08FC;
	Tue,  8 Oct 2024 20:03:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCHusaKHwVnvP0TDg--.64813S4;
	Tue, 08 Oct 2024 20:03:24 +0800 (CST)
From: libaokun@huaweicloud.com
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	libaokun@huaweicloud.com,
	Baokun Li <libaokun1@huawei.com>
Subject: [PATCH] ext4: show the default enabled prefetch_block_bitmaps option
Date: Tue,  8 Oct 2024 20:01:34 +0800
Message-Id: <20241008120134.3758097-1-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHusaKHwVnvP0TDg--.64813S4
X-Coremail-Antispam: 1UD129KBjvdXoW7GryxWr45ur4kKr45Zry7ZFb_yoWktFbEv3
	yxGF48A3W3trsYkF18Cw4rXrWFkrn5A3W3JrsagryruFy5XayFqr4kA3yxuF15WFW5Ja4f
	ArW3XF15WasaqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbs8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4kE6xkIj40Ew7xC0wCY
	1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43
	ZEXa7VUbknY7UUUUU==
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQAKBWcDm4QuOQABsj

From: Baokun Li <libaokun1@huawei.com>

After commit 21175ca434c5 ("ext4: make prefetch_block_bitmaps default"),
we enable 'prefetch_block_bitmaps' by default, but this is not shown in
the '/proc/fs/ext4/sdx/options' procfs interface.

This makes it impossible to distinguish whether the feature is enabled by
default or not, so 'prefetch_block_bitmaps' is shown in the 'options'
procfs interface when prefetch_block_bitmaps is enabled by default.

This makes it easy to notice changes to the default mount options between
versions through the '/proc/fs/ext4/sdx/options' procfs interface.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/super.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index b77acba4a719..c88a47639e9c 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3030,6 +3030,9 @@ static int _ext4_show_options(struct seq_file *seq, struct super_block *sb,
 		SEQ_OPTS_PUTS("mb_optimize_scan=1");
 	}
 
+	if (!test_opt(sb, NO_PREFETCH_BLOCK_BITMAPS))
+		SEQ_OPTS_PUTS("prefetch_block_bitmaps");
+
 	ext4_show_quota_options(seq, sb);
 	return 0;
 }
-- 
2.31.1


