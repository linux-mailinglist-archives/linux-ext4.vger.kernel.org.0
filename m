Return-Path: <linux-ext4+bounces-1402-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E32B5868BD7
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Feb 2024 10:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72949B2959B
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Feb 2024 09:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4025A1386CD;
	Tue, 27 Feb 2024 09:10:16 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0246F137C44;
	Tue, 27 Feb 2024 09:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709025015; cv=none; b=e6N9+5wvspUpso2XECnVAXZYP0j/4RDmOinl10Sj0SvoFd8CQCOUYTXz2YvM80PUcnCZho9NYQvlMUEnbKppVVlVl3znmw9WiAlmCZK37B2ZiN2SOx60xUARy0k01IQlauQYbw+9sfYEKigLvrgtYSg+BvoRDqatspSBLkJ99xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709025015; c=relaxed/simple;
	bh=PhX9SsXv3lhVafDEUUv2mzozNJW2qxHnVj06dy2RHwc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=adxnUTY+KhLRZrcjKau9EpCxgL7lu6z8/ZhQ37L9vvZm3ceCyssI9GGPnhprC0vwrptFpSnOPz2UpVJFdk6MWkiCvl4SnEEc6tTT+c8KgetsyGn6d9oD9iOqpRNdW+UxU2GGGFSMLMGSO1WsP385/80g6LnVVxUrtMVE7y3xARs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4TkWqt2Ry8zNljx;
	Tue, 27 Feb 2024 17:08:42 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id C4B071404F7;
	Tue, 27 Feb 2024 17:10:11 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 27 Feb
 2024 17:10:11 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<ritesh.list@gmail.com>, <ojaswin@linux.ibm.com>, <adobriyan@gmail.com>,
	<linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH v2 9/9] ext4: clean up s_mb_rb_lock to fix build warnings with C=1
Date: Tue, 27 Feb 2024 17:11:48 +0800
Message-ID: <20240227091148.178435-10-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240227091148.178435-1-libaokun1@huawei.com>
References: <20240227091148.178435-1-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500021.china.huawei.com (7.185.36.21)

Running sparse (make C=1) on mballoc.c we get the following warning:

 fs/ext4/mballoc.c:3194:13: warning: context imbalance in
  'ext4_mb_seq_structs_summary_start' - wrong count at exit

This is because __acquires(&EXT4_SB(sb)->s_mb_rb_lock) was called in
ext4_mb_seq_structs_summary_start(), but s_mb_rb_lock was removed in commit
83e80a6e3543 ("ext4: use buckets for cr 1 block scan instead of rbtree"),
so remove the __acquires to silence the warning.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/mballoc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 7ad089df2408..7ae8e04d6ef4 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3192,7 +3192,6 @@ int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset)
 }
 
 static void *ext4_mb_seq_structs_summary_start(struct seq_file *seq, loff_t *pos)
-__acquires(&EXT4_SB(sb)->s_mb_rb_lock)
 {
 	struct super_block *sb = pde_data(file_inode(seq->file));
 	unsigned long position;
-- 
2.31.1


