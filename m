Return-Path: <linux-ext4+bounces-8591-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D24AE374D
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Jun 2025 09:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AC971893C14
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Jun 2025 07:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04765221FCA;
	Mon, 23 Jun 2025 07:47:05 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C3D1FCFE7;
	Mon, 23 Jun 2025 07:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750664824; cv=none; b=DPgWzW3G1fXoa/BK2s30wCODCVJEL/p2VVMPZgv76DQXqTfiVxgUk2k2BEA3Dmhj2olZZZVeKffbMg3dyR+VeUN/cwZwBrJ3bCWzCU4tEmNEWHziQpc+MkYLUBM7DZSQVIooJ56HPeYOZzKuVcFX30Fp1VE6rTgp6b2Wu7hqrCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750664824; c=relaxed/simple;
	bh=LPQSuE8BTwF8bSIOyxlSqSDoaQ7gvIZGhzPOCn2C3E4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FFbEbpdWeb4F8vBusHoCQJXaNbQB5c0N2x+GWqHY9XAxoUAIkMGs/ONelSjyShLwJQuMoXJSCl9ioSPiXicZrUsNIh61g5uzw/h2L1BxwFPspAl1NsK2l7NEWQW1GIXqYXUuGHr1btLY8F+Pc+MxQjny4gMH+gWxTR/M5g9whXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4bQg6Z0JFWzPt6h;
	Mon, 23 Jun 2025 15:43:02 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id DFCD81400DC;
	Mon, 23 Jun 2025 15:46:58 +0800 (CST)
Received: from huawei.com (10.175.112.188) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 23 Jun
 2025 15:46:58 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <jack@suse.cz>, <adilger.kernel@dilger.ca>,
	<ojaswin@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH v2 05/16] ext4: get rid of some obsolete EXT4_MB_HINT flags
Date: Mon, 23 Jun 2025 15:32:53 +0800
Message-ID: <20250623073304.3275702-6-libaokun1@huawei.com>
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
index c3f16aba7b79..29b3817f41a5 100644
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


