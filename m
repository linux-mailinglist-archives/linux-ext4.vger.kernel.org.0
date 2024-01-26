Return-Path: <linux-ext4+bounces-924-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6C783D63A
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Jan 2024 10:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22534283806
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Jan 2024 09:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89172210FF;
	Fri, 26 Jan 2024 08:54:53 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A7E199B4;
	Fri, 26 Jan 2024 08:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706259293; cv=none; b=j4S3iZn6vFnQN1AjmcMBcYmV9D5qx3eK6Gk4lDm1NJKn9AGjiDBeeY/1TlK2mS/XnErp86ZLDSmVnK9GwXChEH044AnB+kUZsD9QAFKDcdfyHTcm0nzAxp7y2yDOXJGm74ga350o/93cRIN9LaDfcPkalubr9jhcR4HhRM8C1UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706259293; c=relaxed/simple;
	bh=Bvhrzw/aqVQw4Wt5qJ2wn3Lt/yDR8XXimpmVzpPt6hE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XoF3u2pjGF4ZHFGcGSyxN4VH9NOAs6xvz9IuZX27SJhLrMLizwNpECdtOaSUs+oDrvXUa6EUfubZBpUmEpxzTUqzTgO1pvEMJ74AkLdO9QYX9Q0/O4qZPj1VK8SkY9RxsE/Uwezq6RCqcdvF5iLXLCwMG2cXox1G017SjgX1C1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TLs29188yzGpq1;
	Fri, 26 Jan 2024 16:54:25 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 1B3961404FC;
	Fri, 26 Jan 2024 16:54:49 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Jan
 2024 16:54:48 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <chengzhihao1@huawei.com>,
	<yukuai3@huawei.com>, <libaokun1@huawei.com>, <stable@kernel.org>
Subject: [PATCH 6/7] ext4: set type of ac_groups_linear_remaining to __u32 to avoid overflow
Date: Fri, 26 Jan 2024 16:57:15 +0800
Message-ID: <20240126085716.1363019-7-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240126085716.1363019-1-libaokun1@huawei.com>
References: <20240126085716.1363019-1-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500021.china.huawei.com (7.185.36.21)

Now ac_groups_linear_remaining is of type __u16 and s_mb_max_linear_groups
is of type unsigned int, so an overflow occurs when setting a value above
65535 through the mb_max_linear_groups sysfs interface. Therefore, the
type of ac_groups_linear_remaining is set to __u32 to avoid overflow.

Fixes: 196e402adf2e ("ext4: improve cr 0 / cr 1 group scanning")
CC: stable@kernel.org
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/mballoc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index d7aeb5da7d86..498af2abc5d8 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -194,8 +194,8 @@ struct ext4_allocation_context {
 
 	__u32 ac_groups_considered;
 	__u32 ac_flags;		/* allocation hints */
+	__u32 ac_groups_linear_remaining;
 	__u16 ac_groups_scanned;
-	__u16 ac_groups_linear_remaining;
 	__u16 ac_found;
 	__u16 ac_cX_found[EXT4_MB_NUM_CRS];
 	__u16 ac_tail;
-- 
2.31.1


