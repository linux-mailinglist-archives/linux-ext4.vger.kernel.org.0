Return-Path: <linux-ext4+bounces-12382-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D36A1CC6B11
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Dec 2025 10:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4B1E03015AE6
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Dec 2025 09:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344FA3396E4;
	Wed, 17 Dec 2025 09:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="QxSJOl4Z"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2825E33A70E
	for <linux-ext4@vger.kernel.org>; Wed, 17 Dec 2025 09:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765962275; cv=none; b=RbbdQugwYhUUeNDgGWxEbSUaGmPOFjOmK2sa6ZaF7ytA0236K9dRAb6JlgkLpsEtrMAAVG77M2T1k817VJBWEkXRwUNs3HKVuHKR74khmBH5Q8VhxJSPwe1zsOrzHJWdrOyRgj18upPgbI4qik7iZzoiY7WPM2DQoq78M4hy7uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765962275; c=relaxed/simple;
	bh=KXLkz36nSdQD8DQl++MSH4Y9rbpCX9vflRWtk6bDpBc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=upNaX+goZUfdQz3Mi9DO6KCbTHKCrTpPIl4DV7usAbJhAeKKvs9tApe/sii5PwBF24EjhhyM0+TLdLKpPaGZABoV0h2XHJWZbLs1gK45/mgwuJyUXBHhHd/KXMttlI6gMUuwVdMB+KDlViHyn2H5wbHKjhIgER7MAP84SkOZE2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=QxSJOl4Z; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ScKYrLOcjnEQ5LUSGMxUpJrE0mfRH9U0uz/5AiYDvL0=;
	b=QxSJOl4ZVqeB/J/fOxZTIkSSsMYxnryi8Wproh6WtW+EXVN0hJYC7KQAhg0qwjrSoA7h7Xea9
	LVijoNE32mGLr73gr0tpq3bipjBcCSd08XxpLAlXfHGNRQItOqt26yWs0FNe/izxpPTfWgwkJfC
	Kmk0HOr+x+nUKPOS0p53yN8=
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4dWSTH0knGz1K968;
	Wed, 17 Dec 2025 17:01:23 +0800 (CST)
Received: from kwepemf200016.china.huawei.com (unknown [7.202.181.9])
	by mail.maildlp.com (Postfix) with ESMTPS id AEF031A0174;
	Wed, 17 Dec 2025 17:04:23 +0800 (CST)
Received: from huawei.com (10.113.213.244) by kwepemf200016.china.huawei.com
 (7.202.181.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 17 Dec
 2025 17:04:23 +0800
From: Wang Jianjian <wangjianjian3@huawei.com>
To: <tytso@mit.edu>
CC: <linux-ext4@vger.kernel.org>, <wangjianjian0@foxmail.com>, Wang Jianjian
	<wangjianjian3@huawei.com>
Subject: [PATCH] ext4,fiemap: Add inode offset for xattr fiemap
Date: Wed, 17 Dec 2025 16:47:08 +0800
Message-ID: <20251217084708.494396-1-wangjianjian3@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf200016.china.huawei.com (7.202.181.9)

For xattr in inode, need add inode offset in this block?
Also, there is one problem, if we have xattrs both in inode
and block, current implementation will only return xattr inode fiemap.
Is this by design?

Signed-off-by: Wang Jianjian <wangjianjian3@huawei.com>
---
 fs/ext4/extents.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 2cf5759ba689..a16bfc75345d 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -5043,6 +5043,7 @@ static int ext4_iomap_xattr_fiemap(struct inode *inode, struct iomap *iomap)
 		if (error)
 			return error;
 		physical = (__u64)iloc.bh->b_blocknr << blockbits;
+		physical += iloc.offset;
 		offset = EXT4_GOOD_OLD_INODE_SIZE +
 				EXT4_I(inode)->i_extra_isize;
 		physical += offset;
-- 
2.34.1


