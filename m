Return-Path: <linux-ext4+bounces-1644-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 727A287BE7E
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Mar 2024 15:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0404284D97
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Mar 2024 14:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185F271B28;
	Thu, 14 Mar 2024 14:07:57 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009166FBB8;
	Thu, 14 Mar 2024 14:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710425276; cv=none; b=U+HWEr4YhF4FDRP6QJHjGansOKUg+FY2wKEKnYRBrdfAAG/tc55Fa8KCFKNdRAaMviaDrGVuhZXsG1huh2Wudyc0Zyr+/3JsBEKgHRq7Z2ZPY9iBNwLxRZ4lp47QiwU3IsN5PoKRi2EwaWFcgBT2tybTqrDCzzJ8Hcamr5pcUqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710425276; c=relaxed/simple;
	bh=Z1PfTQCHqpaHAw0hjUIVt4fpmIlFDfWjpJ3N+/nqPNo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RbUInEbsi4kLesiBbWW9djbP8yAX4HKUUD3AwDZ/mtEwBYxWSuCUi1ZOuaF3ZYbkK8Lr6i13nq8n4ZJk88gXU72sDFrp/Yxkv/MZpjQZrzR+/gREzwBxABNq1y/7aIEh5SPtVY2E0stSNeJ/8/+TpVVuvz9W6qk4GP+wa4fyg7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4TwTfk52fLz1QBPq;
	Thu, 14 Mar 2024 22:05:18 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 5130C1400DB;
	Thu, 14 Mar 2024 22:07:47 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 14 Mar
 2024 22:07:46 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<ritesh.list@gmail.com>, <ojaswin@linux.ibm.com>, <adobriyan@gmail.com>,
	<linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <libaokun1@huawei.com>, <stable@kernel.org>
Subject: [PATCH v3 7/9] ext4: set type of ac_groups_linear_remaining to __u32 to avoid overflow
Date: Thu, 14 Mar 2024 22:09:04 +0800
Message-ID: <20240314140906.3064072-8-libaokun1@huawei.com>
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

Now ac_groups_linear_remaining is of type __u16 and s_mb_max_linear_groups
is of type unsigned int, so an overflow occurs when setting a value above
65535 through the mb_max_linear_groups sysfs interface. Therefore, the
type of ac_groups_linear_remaining is set to __u32 to avoid overflow.

Fixes: 196e402adf2e ("ext4: improve cr 0 / cr 1 group scanning")
CC: stable@kernel.org
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/mballoc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index 56938532b4ce..7bfc5fb5a128 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -193,8 +193,8 @@ struct ext4_allocation_context {
 	ext4_grpblk_t	ac_orig_goal_len;
 
 	__u32 ac_flags;		/* allocation hints */
+	__u32 ac_groups_linear_remaining;
 	__u16 ac_groups_scanned;
-	__u16 ac_groups_linear_remaining;
 	__u16 ac_found;
 	__u16 ac_cX_found[EXT4_MB_NUM_CRS];
 	__u16 ac_tail;
-- 
2.31.1


