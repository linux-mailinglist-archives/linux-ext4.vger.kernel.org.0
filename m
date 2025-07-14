Return-Path: <linux-ext4+bounces-8984-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1EDB03F9E
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Jul 2025 15:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A87B01A6396B
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Jul 2025 13:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BC925743D;
	Mon, 14 Jul 2025 13:18:40 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D422561AE;
	Mon, 14 Jul 2025 13:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499120; cv=none; b=PCjNG32tlHswTFS0I3o5zXZJZjdqJ7Ql3ToVpinSQFe4B+HE5VjJ9RwViEF6ng7RknksIerg1ALbUFsNb3IandW+I3x/OEEkBNym/oovlLo7fNtFwowpK+ElJUDFLXBJ6EHznakaZUUjJjTm/6Enrce0sY5jYkI9GgwvoW8va14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499120; c=relaxed/simple;
	bh=cvcDGHDegoFsLa6WORXBMr6boH8vdKGFBRvDlhOWpzI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i139XNSQXTu0EQiNSISK2ivQg9mIH7cr7uDkLZppLyrA4Uz4KXW/+FOnvzyb+RBMVcOMsU1JROXy/4B4U67Wwfc36A86SCzZKi0FKf2D8foeZnVdHSWW6FJDCKEDbOwKCIHPvDHPyyeO5ELcVrMAuHrx5o9CoZXTPIWYxAzDxmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bgjVs73Gtz13Mkm;
	Mon, 14 Jul 2025 21:15:49 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 7DDF6180B43;
	Mon, 14 Jul 2025 21:18:35 +0800 (CST)
Received: from huawei.com (10.175.112.188) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 14 Jul
 2025 21:18:34 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<linux-kernel@vger.kernel.org>, <ojaswin@linux.ibm.com>,
	<julia.lawall@inria.fr>, <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
	<libaokun1@huawei.com>, <libaokun@huaweicloud.com>
Subject: [PATCH v3 07/17] ext4: fix typo in CR_GOAL_LEN_SLOW comment
Date: Mon, 14 Jul 2025 21:03:17 +0800
Message-ID: <20250714130327.1830534-8-libaokun1@huawei.com>
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

Remove the superfluous "find_".

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ext4.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 4ebc665cf871..0379f2974252 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -157,7 +157,7 @@ enum criteria {
 
 	/*
 	 * Reads each block group sequentially, performing disk IO if
-	 * necessary, to find find_suitable block group. Tries to
+	 * necessary, to find suitable block group. Tries to
 	 * allocate goal length but might trim the request if nothing
 	 * is found after enough tries.
 	 */
-- 
2.46.1


