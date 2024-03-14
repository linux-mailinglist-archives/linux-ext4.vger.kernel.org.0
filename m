Return-Path: <linux-ext4+bounces-1646-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EAA87BE85
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Mar 2024 15:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F2C31C217E4
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Mar 2024 14:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8315873516;
	Thu, 14 Mar 2024 14:07:59 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B59971B43;
	Thu, 14 Mar 2024 14:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710425279; cv=none; b=fws0i2xgLc8UDQ7c7PIZaF7eMVWksJH2qbqI6hseTBOgYO68ss6fU4vFsH3ePLyvJ5myFqIbHj8q5SW9KR8ZQP6saq4c3ov7aw5MuftOWQCsFzDJV3w/sCShAq7MgUT6oacW00lGRuyDdQA06tZ4ItooCwTpnIROMN6mpjh6E6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710425279; c=relaxed/simple;
	bh=P7knyHnbZndkT96HWjKBGpGhwkiQR62ld119bnhrD7E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nQ7jUGWUPmDuED21i4Ztomv3k+ssI2CXWW88JJbotEh9+6lLD17ZBvXxKTls2mp+4Lf0f+RiSc7PShfuzkUieME3v7RrEixSk2a6C9rFIWqV+8E6Jx+ucBSmtTGAo5xfvuJnb6nRZYs80xvqagRY4e2Vww3F5UxZXx7AqXeZWZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TwTgY6b3Lz1xr7B;
	Thu, 14 Mar 2024 22:06:01 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 7195C1A016C;
	Thu, 14 Mar 2024 22:07:48 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 14 Mar
 2024 22:07:47 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<ritesh.list@gmail.com>, <ojaswin@linux.ibm.com>, <adobriyan@gmail.com>,
	<linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH v3 9/9] ext4: clean up s_mb_rb_lock to fix build warnings with C=1
Date: Thu, 14 Mar 2024 22:09:06 +0800
Message-ID: <20240314140906.3064072-10-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240314140906.3064072-1-libaokun1@huawei.com>
References: <20240314140906.3064072-1-libaokun1@huawei.com>
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
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/mballoc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 48afe5aa228c..b3d616f055b0 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3190,7 +3190,6 @@ int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset)
 }
 
 static void *ext4_mb_seq_structs_summary_start(struct seq_file *seq, loff_t *pos)
-__acquires(&EXT4_SB(sb)->s_mb_rb_lock)
 {
 	struct super_block *sb = pde_data(file_inode(seq->file));
 	unsigned long position;
-- 
2.31.1


