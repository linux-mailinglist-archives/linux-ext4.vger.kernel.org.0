Return-Path: <linux-ext4+bounces-6155-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 064DDA1786E
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2025 08:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C408D1883CBD
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2025 07:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5ED61B0415;
	Tue, 21 Jan 2025 07:16:39 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAF61494D9;
	Tue, 21 Jan 2025 07:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737443799; cv=none; b=DgSSuIuVTU/qSE3ebxfluSGJj8E/qVN3ntOFyVfWxmwCKPj1ladxTobZN8kRkl0mv5sxl3Jt/dDliZMCYJVHTmddcS8b7Gl9dHEc+yHQSfwUNUTKwH+mvBQvL8WbY3ryJ2eNtsNT33W9x0N31rbjFNDt0nNm4SiYRLHynuSA+aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737443799; c=relaxed/simple;
	bh=8LZEGmtoNBa8NKJDXUkSmn4UUWqFvEX9ES/yP4+IGzc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CQeY3uKug0i1jTuNT4ewbYdwWCk2r52NoO4eQeDO+LytI6RLvW123RoZKW+hvuMbAPv2br0q7rzPxRXnzXFWKsdEdGR8PyX8KX/LHbchaPnlkeInW5h8G35IJ8V2vAlQBIrVmSmbImjfHQVJ7DuJTSLqqDEY11CrAmvqjIrqUDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YcdmL4yffz4f3jqx;
	Tue, 21 Jan 2025 15:16:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1ECC91A0EDC;
	Tue, 21 Jan 2025 15:16:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgD3W2DNSY9n3Gg+Bg--.34135S5;
	Tue, 21 Jan 2025 15:16:33 +0800 (CST)
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
Subject: [PATCH v2 1/8] ext4: replace opencoded ext4_end_io_end() in ext4_put_io_end()
Date: Tue, 21 Jan 2025 15:10:43 +0800
Message-Id: <20250121071050.3991249-2-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250121071050.3991249-1-libaokun@huaweicloud.com>
References: <20250121071050.3991249-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3W2DNSY9n3Gg+Bg--.34135S5
X-Coremail-Antispam: 1UD129KBjvdXoW7GF43CF1fAFW8Ar15Cw4Uurg_yoWkurb_Zr
	yfWrn7Cr4ayw1Ika47Aa17Xr1jkFn5Gr1ruF1rZrsIq3W3A34DtF1kArZ8Ar47WF47Aa1U
	Cr4kAw1fXF1jqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbgxFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY02
	0Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
	wVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4kE6xkIj40Ew7xC0wCY1x0262
	kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
	6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw
	0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvE
	c7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x
	0JUho7_UUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgALBWeKD3kBggAKse

From: Baokun Li <libaokun1@huawei.com>

This reduces duplicate code and ensures that a “potential data loss”
warning is available if the unwritten conversion fails.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/page-io.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 69b8a7221a2b..f53b018ea259 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -299,18 +299,13 @@ void ext4_put_io_end_defer(ext4_io_end_t *io_end)
 
 int ext4_put_io_end(ext4_io_end_t *io_end)
 {
-	int err = 0;
-
 	if (refcount_dec_and_test(&io_end->count)) {
-		if (io_end->flag & EXT4_IO_END_UNWRITTEN) {
-			err = ext4_convert_unwritten_io_end_vec(io_end->handle,
-								io_end);
-			io_end->handle = NULL;
-			ext4_clear_io_unwritten_flag(io_end);
-		}
+		if (io_end->flag & EXT4_IO_END_UNWRITTEN)
+			return ext4_end_io_end(io_end);
+
 		ext4_release_io_end(io_end);
 	}
-	return err;
+	return 0;
 }
 
 ext4_io_end_t *ext4_get_io_end(ext4_io_end_t *io_end)
-- 
2.39.2


