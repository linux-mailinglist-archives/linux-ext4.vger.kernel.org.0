Return-Path: <linux-ext4+bounces-8981-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C14B03F8A
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Jul 2025 15:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3705D16BCA7
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Jul 2025 13:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B1A253B52;
	Mon, 14 Jul 2025 13:18:37 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346EB24A06E;
	Mon, 14 Jul 2025 13:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499117; cv=none; b=ehs2hure6pNeWA1HHhcePMWFStwtmtrpF0HJpxu4T6dVqZ1VqBfkOxMs287Km2Ea9ZbxmDRKZ9e+VnkzTZudCm8sgm4v48xS3iKYBY5SkEXuNqEAtwQ49yH29Lwy/GSHgi0otG9SKB3qWJDrUbDRi0LInCfW7Fn9BPBoONPPUAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499117; c=relaxed/simple;
	bh=qT8ji9P4W0ZmRATvMr/WmpW4YqF/L+hpzvAaZZrkZ+0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S4gDMbM7e4oAmEf0+UU4fIRRHPJGWBuKKjCfsRToLpuBHmg4uzpwuFciCxv38nQUELPT9BMRdxdjIi+d9j+9sMNP0E9Fct49ZI6wfxHbX165Hr4FDJ0EyyjKS15ZmryPrWUhR8XhcqiGHYWmMBf/jNISKiIJr62lRQjcqCTnAGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bgjWd3mP1z2TT0R;
	Mon, 14 Jul 2025 21:16:29 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 7340E1A0188;
	Mon, 14 Jul 2025 21:18:31 +0800 (CST)
Received: from huawei.com (10.175.112.188) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 14 Jul
 2025 21:18:30 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<linux-kernel@vger.kernel.org>, <ojaswin@linux.ibm.com>,
	<julia.lawall@inria.fr>, <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
	<libaokun1@huawei.com>, <libaokun@huaweicloud.com>
Subject: [PATCH v3 03/17] ext4: remove unnecessary s_mb_last_start
Date: Mon, 14 Jul 2025 21:03:13 +0800
Message-ID: <20250714130327.1830534-4-libaokun1@huawei.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250714130327.1830534-1-libaokun1@huawei.com>
References: <20250714130327.1830534-1-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500013.china.huawei.com (7.185.36.188)

Since stream allocation does not use ac->ac_f_ex.fe_start, it is set to -1
by default, so the no longer needed sbi->s_mb_last_start is removed.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ext4.h    | 1 -
 fs/ext4/mballoc.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 8750ace12935..b83095541c98 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1631,7 +1631,6 @@ struct ext4_sb_info {
 	unsigned int s_max_dir_size_kb;
 	/* where last allocation was done - for stream allocation */
 	unsigned long s_mb_last_group;
-	unsigned long s_mb_last_start;
 	unsigned int s_mb_prefetch;
 	unsigned int s_mb_prefetch_limit;
 	unsigned int s_mb_best_avail_max_trim_order;
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index f56ac477c464..e3a5103e1620 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2171,7 +2171,6 @@ static void ext4_mb_use_best_found(struct ext4_allocation_context *ac,
 	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC) {
 		spin_lock(&sbi->s_md_lock);
 		sbi->s_mb_last_group = ac->ac_f_ex.fe_group;
-		sbi->s_mb_last_start = ac->ac_f_ex.fe_start;
 		spin_unlock(&sbi->s_md_lock);
 	}
 	/*
-- 
2.46.1


