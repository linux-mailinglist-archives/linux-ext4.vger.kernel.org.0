Return-Path: <linux-ext4+bounces-8586-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B04AE374F
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Jun 2025 09:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8ABF3AAF97
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Jun 2025 07:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935F91FF1A0;
	Mon, 23 Jun 2025 07:47:01 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D575872625;
	Mon, 23 Jun 2025 07:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750664821; cv=none; b=BagN769DEnCpL9fg1lb3VVdY2Xv6T5InRj+G9AS0torZpQEpAvy/NbOtsNDK/VbHXVBbaefF6M+wvxxeJxw73MHF/iGZ1iofUmiEGuhbejoOzKug9sS+p3uzkHpzeF5RF4AL924cMA0d6fvSDQojCQFKvaoVYch9WwBnO4PmsCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750664821; c=relaxed/simple;
	bh=Dn8aKeCp2MqLWglq2wjerggE0C1t22uLrSme0DTgoeE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dG74/hzxuYMe3+2QGNYEiCFzSQWsGsU6laANvzDtwZQJDDDCft672EPI+kUfrdjCjV7G8xF1X+1C+9E5kjbueg90ij7mx/iO+1uA+Hqe/U3YHUYSLV+leoBVOi/IwJTnlTNTFa0z8ZfXvpz22ytBwZlRdGW9hS0Z9TQl0dyQNn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4bQgD717Ssz2QVJ9;
	Mon, 23 Jun 2025 15:47:51 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 6228418005F;
	Mon, 23 Jun 2025 15:46:56 +0800 (CST)
Received: from huawei.com (10.175.112.188) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 23 Jun
 2025 15:46:55 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <jack@suse.cz>, <adilger.kernel@dilger.ca>,
	<ojaswin@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH v2 02/16] ext4: remove unnecessary s_mb_last_start
Date: Mon, 23 Jun 2025 15:32:50 +0800
Message-ID: <20250623073304.3275702-3-libaokun1@huawei.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250623073304.3275702-1-libaokun1@huawei.com>
References: <20250623073304.3275702-1-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500013.china.huawei.com (7.185.36.188)

ac->ac_g_ex.fe_start is only used in ext4_mb_find_by_goal(), but STREAM
ALLOC is activated after ext4_mb_find_by_goal() fails, so there's no need
to update ac->ac_g_ex.fe_start, remove the unnecessary s_mb_last_start.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/ext4.h    | 1 -
 fs/ext4/mballoc.c | 2 --
 2 files changed, 3 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 9df74123e7e6..cfb60f8fbb63 100644
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
index 336d65c4f6a2..5cdae3bda072 100644
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
@@ -2849,7 +2848,6 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 		/* TBD: may be hot point */
 		spin_lock(&sbi->s_md_lock);
 		ac->ac_g_ex.fe_group = sbi->s_mb_last_group;
-		ac->ac_g_ex.fe_start = sbi->s_mb_last_start;
 		spin_unlock(&sbi->s_md_lock);
 	}
 
-- 
2.46.1


