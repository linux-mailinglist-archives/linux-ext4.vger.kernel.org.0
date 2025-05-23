Return-Path: <linux-ext4+bounces-8178-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E14AC1F37
	for <lists+linux-ext4@lfdr.de>; Fri, 23 May 2025 11:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B41061C020E2
	for <lists+linux-ext4@lfdr.de>; Fri, 23 May 2025 09:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1E82253EE;
	Fri, 23 May 2025 09:03:17 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F94E223DEF;
	Fri, 23 May 2025 09:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747990997; cv=none; b=ubynRO7wl+F0Gq70D9DLiF/LGiWxJjMVqTp/PsKZ8gId3PTja1LQxrzVrAmm8YJBxFqaOHBuwHWznBbemcuFNyGZvrmesuOTZ0wdYwh5oxky9TH4gKG7BJbBw4gfd5X7L1lZ3SgazZzLBKaKBb3fh0CbZHSx8O0bJFG5aBv+Y6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747990997; c=relaxed/simple;
	bh=Hz+Kab1dpqfojfrajVO6nWb6x5jC0sCgaFKb3n05n/A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s3KASlT4idGAAim34nO47iFDSUBOKeC46hdczHVxaSyc9lVga7nqTCfIBDEV0D56tAZ37bdqo2ldbbn+TLUHNHpZ8RQ6ZuY8MhKj0vTcj6i1SSg4D3M04wxxBQ+WRdj1+lnSj5bavg62BDTKK/u0IKeC+XCaraE2bHyobvsN27A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4b3fLv07pFz4f3jdk;
	Fri, 23 May 2025 17:02:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 21C861A06DD;
	Fri, 23 May 2025 17:03:12 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCH61_MOTBocBILNQ--.27999S7;
	Fri, 23 May 2025 17:03:11 +0800 (CST)
From: libaokun@huaweicloud.com
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	libaokun1@huawei.com,
	libaokun@huaweicloud.com
Subject: [PATCH 3/4] ext4: get rid of some obsolete EXT4_MB_HINT flags
Date: Fri, 23 May 2025 16:58:20 +0800
Message-Id: <20250523085821.1329392-4-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250523085821.1329392-1-libaokun@huaweicloud.com>
References: <20250523085821.1329392-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCH61_MOTBocBILNQ--.27999S7
X-Coremail-Antispam: 1UD129KBjvJXoW7AF4ruryDCryfZrykJr17trb_yoW8WryxpF
	srJF95KryIqw18uws7XwnxKw47G3yIk34DZrn0qw1F9as8Jrn5JFn2gr10v3WFv3ykAr98
	XFyq939rGr1Uu3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPv14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0F24lc7CjxV
	Aaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2Iq
	xVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r
	1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY
	6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
	AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuY
	vjfUOnmRUUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQARBWgwLIEFbAABsI

From: Baokun Li <libaokun1@huawei.com>

Since nobody has used these EXT4_MB_HINT flags for ages,
let's remove them.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/ext4.h              | 6 ------
 include/trace/events/ext4.h | 3 ---
 2 files changed, 9 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 16c14dd09df6..f6d01702423d 100644
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


