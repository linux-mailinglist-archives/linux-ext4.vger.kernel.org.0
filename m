Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF4438D511
	for <lists+linux-ext4@lfdr.de>; Sat, 22 May 2021 12:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbhEVKWl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 22 May 2021 06:22:41 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5735 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbhEVKWk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 22 May 2021 06:22:40 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FnKD63zqNzqV3p;
        Sat, 22 May 2021 18:17:42 +0800 (CST)
Received: from dggeme752-chm.china.huawei.com (10.3.19.98) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sat, 22 May 2021 18:21:15 +0800
Received: from huawei.com (10.175.127.227) by dggeme752-chm.china.huawei.com
 (10.3.19.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 22
 May 2021 18:21:14 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH 2/2] ext4: correct the cache_nr in tracepoint ext4_es_shrink_exit
Date:   Sat, 22 May 2021 18:30:45 +0800
Message-ID: <20210522103045.690103-3-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210522103045.690103-1-yi.zhang@huawei.com>
References: <20210522103045.690103-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme752-chm.china.huawei.com (10.3.19.98)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The cache_cnt parameter of tracepoint ext4_es_shrink_exit means the
remaining cache count after shrink, but now it is the cache count before
shrink, fix it by read sbi->s_extent_cache_cnt again.

Fixes: 1ab6c4997e04 ("fs: convert fs shrinkers to new scan/count API")
Cc: stable@vger.kernel.org # 3.12+
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents_status.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index db3cd70a72e4..9a3a8996aacf 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -1576,6 +1576,7 @@ static unsigned long ext4_es_scan(struct shrinker *shrink,
 
 	nr_shrunk = __es_shrink(sbi, nr_to_scan, NULL);
 
+	ret = percpu_counter_read_positive(&sbi->s_es_stats.es_stats_shk_cnt);
 	trace_ext4_es_shrink_scan_exit(sbi->s_sb, nr_shrunk, ret);
 	return nr_shrunk;
 }
-- 
2.25.4

