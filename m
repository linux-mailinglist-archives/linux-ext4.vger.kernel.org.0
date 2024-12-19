Return-Path: <linux-ext4+bounces-5757-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E3C9F7312
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Dec 2024 04:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F198C1893222
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Dec 2024 03:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF7986358;
	Thu, 19 Dec 2024 03:02:29 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539B267A0D;
	Thu, 19 Dec 2024 03:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734577349; cv=none; b=XSTys6EXYNeu+MS+V/rni9TI1HonQoyFAoLWAIFjcR2fRdoUSVpmtx2ST6Oqd193IfvlA6qjc6v1N6OoluI1y6Liq9bFl0qC0aEskDzbWxa9GsyaUxGkcAC4SRp299Xu+ciCbNnMJ56IbAtZK1LLczOY+fIAnlPoieEYKHmh+zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734577349; c=relaxed/simple;
	bh=vz/EyrA1zAvl4TvtFV1uyrhlBtXhbu1yV2u2FzRGu+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MQeJPKmova77l/zks5Mw8qU8fRzP8RD+xFWqKDXHIg6HU/72GflsmxoTi3Hp/pPevguwQHy82R1in+KoPWprwjsxjf7/Kvd2ahBKy+KBtABfTSr7+I7GSd8SNpPFEjpk5aTfTIfCEL/4SDFid+J7S0GMFNZ4sUmXnPRex1vjpxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YDFhD4jv4z4f3kFN;
	Thu, 19 Dec 2024 11:02:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 2D52B1A018C;
	Thu, 19 Dec 2024 11:02:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP3 (Coremail) with SMTP id _Ch0CgDHpMG9jGNnctd0Ew--.54838S8;
	Thu, 19 Dec 2024 11:02:24 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] ext4: calculate rec_len of ".." with correct name length 2
Date: Thu, 19 Dec 2024 19:00:27 +0800
Message-Id: <20241219110027.1440876-7-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241219110027.1440876-1-shikemeng@huaweicloud.com>
References: <20241219110027.1440876-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgDHpMG9jGNnctd0Ew--.54838S8
X-Coremail-Antispam: 1UD129KBjvdXoWrKFWUXry3KryUXF45ZF13Arb_yoWfWwc_Ca
	yDAFnrXFW3A34xK345ArWYq3Z0gan5Cw1DZF95GFyvgFn0vFy5Aan8ZrsIy342gry5tr98
	Cw10qrn0qrW3ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbS8YFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl82
	xGYIkIc2x26280x7IE14v26r126s0DM28IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC
	64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM2
	8EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq
	3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jstxDUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

The rec_len of directory ".." should be ext4_dir_rec_len(2, NULL) instead
of ext4_dir_rec_len(1, NULL). Although ext4_dir_rec_len return the same
number either with name_len 1 or name_len 2, it's better use the right
name_len to make code more intuitive.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index aee1858e6482..24cdeb2aa0d5 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2925,7 +2925,7 @@ struct ext4_dir_entry_2 *ext4_init_dot_dotdot(struct inode *inode,
 	de->name_len = 2;
 	if (!dotdot_real_len)
 		de->rec_len = ext4_rec_len_to_disk(blocksize -
-					(csum_size + ext4_dir_rec_len(1, NULL)),
+					(csum_size + ext4_dir_rec_len(2, NULL)),
 					blocksize);
 	else
 		de->rec_len = ext4_rec_len_to_disk(
-- 
2.30.0


