Return-Path: <linux-ext4+bounces-2500-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 642A88C527F
	for <lists+linux-ext4@lfdr.de>; Tue, 14 May 2024 13:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2E20B21E6E
	for <lists+linux-ext4@lfdr.de>; Tue, 14 May 2024 11:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A66313D8B9;
	Tue, 14 May 2024 11:25:20 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E2713D51B;
	Tue, 14 May 2024 11:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715685920; cv=none; b=M2BI4FcXflT7/kZbwesceR4URpDBE7//hCj7/l/zs7bthE1/4ERwvFgFXUrHb0ZFD/KFnK8efdyxcZ3uKl31CmpvitOU0+0O+zbvIkBqEpXlEFEUHU3m/1RAaxfd6dB8N15i09ZSBIjB/jhyI5ZZBpjZJFiVsg8cHdDu/gsqz9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715685920; c=relaxed/simple;
	bh=3U1k4waxp5/LZuCnfI6UdBvof2msFTphvCORu3dLY6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X99oEbT+Im1yCh5sd2YJHMtafNcVj+bDFnXhRUHeAO33frjpZN4Dxgp4e/M5OzlezmEjQf/MrBtuTo0KPmIqXvvtU5TzOuiNBodBg8AiTtBP0DRk2Ku6jpP341ReJrHqZLIxuRxMi8sQfF3U51CpO5woQG37P/Xr44XOFW8i6Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VdvCj0scgz4f3n5m;
	Tue, 14 May 2024 19:25:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 40E341A01A7;
	Tue, 14 May 2024 19:25:15 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP3 (Coremail) with SMTP id _Ch0CgCHSKAXSkNm4rTMMQ--.61831S8;
	Tue, 14 May 2024 19:25:15 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	jack@suse.com,
	yi.zhang@huaweicloud.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/9] jbd2: use bh_in instead of jh2bh(jh_in) to simplify code
Date: Tue, 14 May 2024 19:24:35 +0800
Message-Id: <20240514112438.1269037-7-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240514112438.1269037-1-shikemeng@huaweicloud.com>
References: <20240514112438.1269037-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgCHSKAXSkNm4rTMMQ--.61831S8
X-Coremail-Antispam: 1UD129KBjvdXoW7Xr1DuF1xCw4fGF1kCrW5GFg_yoWDXFb_ZF
	Wvyw1kXwsIvFsrJw4rCw12gr1j9w1rCw1ku3Z7tFyDCFnIvrn7A3ZxKrZ2yrnrWw4IyrW5
	XFn7uF4Fya47tjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbTxFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2
	IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28E
	F7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr
	1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMx
	C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
	wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
	vE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v2
	0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
	W8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbmZX7UUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

We save jh2bh(jh_in) to bh_in, so use bh_in directly instead of
jh2bh(jh_in) to simplify the code.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/journal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index c98c06f3113a..71568cb82db7 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -360,8 +360,8 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
 		new_folio = virt_to_folio(jh_in->b_frozen_data);
 		new_offset = offset_in_folio(new_folio, jh_in->b_frozen_data);
 	} else {
-		new_folio = jh2bh(jh_in)->b_folio;
-		new_offset = offset_in_folio(new_folio, jh2bh(jh_in)->b_data);
+		new_folio = bh_in->b_folio;
+		new_offset = offset_in_folio(new_folio, bh_in->b_data);
 	}
 
 	mapped_data = kmap_local_folio(new_folio, new_offset);
-- 
2.30.0


