Return-Path: <linux-ext4+bounces-8986-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 925F4B03F97
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Jul 2025 15:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1FD74A1579
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Jul 2025 13:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9456B2580F9;
	Mon, 14 Jul 2025 13:18:41 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F6A25392D;
	Mon, 14 Jul 2025 13:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499121; cv=none; b=T8szNkjUxeJ3iqB9MCwDoaoHRzLhZbyyqDdHq0qmH3smN84v1bxAYzpA/YwR1G65/xjcGkQrcagkxUBbUta6xQ1ohyUc9UJ8lfEcq8SjU2J6Oma8rISkW6ij2jtcC9RW2x0BdDBJ+PegEfR0SiNZIF9tjdJpAr+8mEBThZmQrjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499121; c=relaxed/simple;
	bh=lljnkuKc04lOY0n4mHEyd6ao08zitQ2BV9p916AKCQs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cWgkmAF6M4Hpl7+RyRGOfIxj03sTYus7cqsTDlQQITKYfuT92OQosvUS/zXv3nnW9tffs2GgnjRnf3xQtjYOAWxq9t5vUcot2AzSVVy9PHaE4bvpp1ES5e1aOp09cpQ/q2xSQFDEfWKWzh4RatWdEEaf+QNNd87G4wqoNOZwN9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bgjWh40vwz2TT31;
	Mon, 14 Jul 2025 21:16:32 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 7BD4E1800B2;
	Mon, 14 Jul 2025 21:18:34 +0800 (CST)
Received: from huawei.com (10.175.112.188) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 14 Jul
 2025 21:18:33 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<linux-kernel@vger.kernel.org>, <ojaswin@linux.ibm.com>,
	<julia.lawall@inria.fr>, <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
	<libaokun1@huawei.com>, <libaokun@huaweicloud.com>
Subject: [PATCH v3 06/17] ext4: get rid of some obsolete EXT4_MB_HINT flags
Date: Mon, 14 Jul 2025 21:03:16 +0800
Message-ID: <20250714130327.1830534-7-libaokun1@huawei.com>
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

Since nobody has used these EXT4_MB_HINT flags for ages,
let's remove them.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ext4.h              | 6 ------
 include/trace/events/ext4.h | 3 ---
 2 files changed, 9 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index ad97c693d56a..4ebc665cf871 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -185,14 +185,8 @@ enum criteria {
 
 /* prefer goal again. length */
 #define EXT4_MB_HINT_MERGE		0x0001
-/* blocks already reserved */
-#define EXT4_MB_HINT_RESERVED		0x0002
-/* metadata is being allocated */
-#define EXT4_MB_HINT_METADATA		0x0004
 /* first blocks in the file */
 #define EXT4_MB_HINT_FIRST		0x0008
-/* search for the best chunk */
-#define EXT4_MB_HINT_BEST		0x0010
 /* data is being allocated */
 #define EXT4_MB_HINT_DATA		0x0020
 /* don't preallocate (for tails) */
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index 156908641e68..33b204165cc0 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -23,10 +23,7 @@ struct partial_cluster;
 
 #define show_mballoc_flags(flags) __print_flags(flags, "|",	\
 	{ EXT4_MB_HINT_MERGE,		"HINT_MERGE" },		\
-	{ EXT4_MB_HINT_RESERVED,	"HINT_RESV" },		\
-	{ EXT4_MB_HINT_METADATA,	"HINT_MDATA" },		\
 	{ EXT4_MB_HINT_FIRST,		"HINT_FIRST" },		\
-	{ EXT4_MB_HINT_BEST,		"HINT_BEST" },		\
 	{ EXT4_MB_HINT_DATA,		"HINT_DATA" },		\
 	{ EXT4_MB_HINT_NOPREALLOC,	"HINT_NOPREALLOC" },	\
 	{ EXT4_MB_HINT_GROUP_ALLOC,	"HINT_GRP_ALLOC" },	\
-- 
2.46.1


