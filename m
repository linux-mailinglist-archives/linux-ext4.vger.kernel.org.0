Return-Path: <linux-ext4+bounces-3784-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9DC957AE5
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Aug 2024 03:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE2102842D2
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Aug 2024 01:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C341C6B4;
	Tue, 20 Aug 2024 01:25:27 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA72B134D1
	for <linux-ext4@vger.kernel.org>; Tue, 20 Aug 2024 01:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724117127; cv=none; b=FKLug6+wicDFa3gcFGXnSKRd3GJm8BVFFyG/X8mChRtdNfutvKaLQ9kllL2vFy+lK5iwnopJcjyJqH+NmkeIMJ3tUwblo2lFw00b6k7YXr+aS+A6zlLfIT05+cooX9BmsPVozuf7OmytarLaW+2TLtfXSXZZgBuX2LGWQ4ZbWCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724117127; c=relaxed/simple;
	bh=DYyMNUOnBT5/6z6kbTnsRCs4U/AcnV9tLSWgqdb35GQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kKrHn26sHphCchukFuKGanTycjPeqgf8fqZPZM94+7VBZzcyC+CcmXVURMpYPpMQ2O+07VxBN+nNI/a1ghuWxyN95Qt8vNbVjyjlnFbrRAGYZD6gO2pj9IpFtzQp3EVwsC/VkYu1SLFy90uMgrFFO5GbI1C1FJ7iLuopPO8ouqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WnsDn72RYzpStQ;
	Tue, 20 Aug 2024 09:23:53 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 3E8F8140135;
	Tue, 20 Aug 2024 09:25:23 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Tue, 20 Aug
 2024 09:25:22 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <tytso@mit.edu>, <adilger.kernel@dilger.ca>
CC: <lizetao1@huawei.com>, <linux-ext4@vger.kernel.org>
Subject: [PATCH -next] ext4: Remove redundant null pointer check
Date: Tue, 20 Aug 2024 09:32:50 +0800
Message-ID: <20240820013250.4121848-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd500012.china.huawei.com (7.221.188.25)

Since the ext4_find_extent() does not return a null pointer, the check for
the null pointer here is redundant. Drop null pointer check for clean
code.

No functional change intended.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 fs/ext4/extents.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index e067f2dd0335..12f0771d57d2 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -6112,7 +6112,7 @@ int ext4_ext_clear_bb(struct inode *inode)
 			break;
 		if (ret > 0) {
 			path = ext4_find_extent(inode, map.m_lblk, NULL, 0);
-			if (!IS_ERR_OR_NULL(path)) {
+			if (!IS_ERR(path)) {
 				for (j = 0; j < path->p_depth; j++) {
 
 					ext4_mb_mark_bb(inode->i_sb,
-- 
2.34.1


