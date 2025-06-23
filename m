Return-Path: <linux-ext4+bounces-8590-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62761AE374C
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Jun 2025 09:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46D7F189015B
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Jun 2025 07:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2EC221739;
	Mon, 23 Jun 2025 07:47:04 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6262036FE;
	Mon, 23 Jun 2025 07:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750664824; cv=none; b=LqcIqLaO6qoW71gmehjb7W70I1KmwhTwezH2hCchoROnW1Fea2+A4OGzRgJe11TD+ZRP3gcMB+NsugNHiVFgxoS3fkoBgOhb/iUmeyXb28cad3NfvAWdrjHPqUbXmXrR0Lgc6ikH2UXVhnfjmM7OHpGJ0FUl70iY3TfX/818gRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750664824; c=relaxed/simple;
	bh=MJXHq6WyflIQjmrjhMQd4W5AJVA/rdWGX7YSAixl+MI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WnHydSt7GoIIUIeZk2srwDpRVu01f45Bi7MCCzy4tGgPo9D5erq6b8HQhoG+YRYg6n7ojbnJhi01poX/QslO2l+lHeCUPYcRh6m8CIFVnt50i+3yJmKpSA2LYf2Kk5uNTQYGF/MCMmhDzuKgAzSFxxM9M2ZMVDCZPXFvcLwzD7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bQg5q2ghTz10XKG;
	Mon, 23 Jun 2025 15:42:23 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id C0EA31400DC;
	Mon, 23 Jun 2025 15:46:59 +0800 (CST)
Received: from huawei.com (10.175.112.188) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 23 Jun
 2025 15:46:58 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <jack@suse.cz>, <adilger.kernel@dilger.ca>,
	<ojaswin@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH v2 06/16] ext4: fix typo in CR_GOAL_LEN_SLOW comment
Date: Mon, 23 Jun 2025 15:32:54 +0800
Message-ID: <20250623073304.3275702-7-libaokun1@huawei.com>
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

Remove the superfluous "find_".

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ext4.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 29b3817f41a5..294198c05cdd 100644
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


