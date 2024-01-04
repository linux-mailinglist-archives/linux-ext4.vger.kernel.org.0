Return-Path: <linux-ext4+bounces-697-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0906824387
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Jan 2024 15:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 127211C21F34
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Jan 2024 14:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D9A24A0E;
	Thu,  4 Jan 2024 14:17:53 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EE7225D4;
	Thu,  4 Jan 2024 14:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4T5TF40tVfz1vrPK;
	Thu,  4 Jan 2024 22:17:28 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 9F2B1140133;
	Thu,  4 Jan 2024 22:17:41 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 4 Jan
 2024 22:17:41 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <yukuai3@huawei.com>,
	<libaokun1@huawei.com>
Subject: [PATCH v3 2/8] ext4: do not trim the group with corrupted block bitmap
Date: Thu, 4 Jan 2024 22:20:34 +0800
Message-ID: <20240104142040.2835097-3-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240104142040.2835097-1-libaokun1@huawei.com>
References: <20240104142040.2835097-1-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500021.china.huawei.com (7.185.36.21)

Otherwise operating on an incorrupted block bitmap can lead to all sorts
of unknown problems.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/mballoc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index d72b5e3c92ec..a95fa6e2b0f9 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -6757,6 +6757,9 @@ __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
 	bool set_trimmed = false;
 	void *bitmap;
 
+	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(e4b->bd_info)))
+		return 0;
+
 	bitmap = e4b->bd_bitmap;
 	if (start == 0 && max >= ext4_last_grp_cluster(sb, e4b->bd_group))
 		set_trimmed = true;
-- 
2.31.1


