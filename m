Return-Path: <linux-ext4+bounces-6237-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4898BA1C6FA
	for <lists+linux-ext4@lfdr.de>; Sun, 26 Jan 2025 09:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2E8F3A1EE7
	for <lists+linux-ext4@lfdr.de>; Sun, 26 Jan 2025 08:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA38145A11;
	Sun, 26 Jan 2025 08:27:38 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902F733998
	for <linux-ext4@vger.kernel.org>; Sun, 26 Jan 2025 08:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737880058; cv=none; b=jcRSbvufGy0kGQ7XzhzP1Q6lNCMiswKuWNC8IcBksg/20uC2izh4IIWpIJl9uLMs1YSf4ifbB8nbUqkyJLMKlJ2r0k5v5GKkn5bD/Qy3YkBnCFTu/TjGri9ci8I7c1ZrHvAw7R2sRWLsbe2pvdbDh3DM9RZGLcFGqXgqKieYH8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737880058; c=relaxed/simple;
	bh=6koAJ0Rq9dwXN3O8L+bgcLlTqFU3+lTkyHizGndtDf8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oYDLrzAGgeJra+KnIOIraYbegE8YoifTv6qp3qTKKoydBFH0Ps33kRVKhbOsTBpbgCycK2ei7NsKHKB2HO1/3gybxVmVSChkqWi1a98YDUaElLUjt2T5H6uLqoE5ltwjtp60JWC3PFg+/k02d2nolc/eyKVmriVZQt2I1XgA1rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Ygl1X1Hf3z11PFW;
	Sun, 26 Jan 2025 16:23:28 +0800 (CST)
Received: from kwepemd200022.china.huawei.com (unknown [7.221.188.232])
	by mail.maildlp.com (Postfix) with ESMTPS id 61B56180105;
	Sun, 26 Jan 2025 16:27:33 +0800 (CST)
Received: from huawei.com (10.175.101.107) by kwepemd200022.china.huawei.com
 (7.221.188.232) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sun, 26 Jan
 2025 16:27:32 +0800
From: Ye Bin <yebin10@huawei.com>
To: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>
CC: <jack@suse.cz>, <zhangxiaoxu5@huawei.com>
Subject: [PATCH 1/2] ext4: introduce ITAIL helper
Date: Sun, 26 Jan 2025 16:27:30 +0800
Message-ID: <20250126082731.2037385-2-yebin10@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250126082731.2037385-1-yebin10@huawei.com>
References: <20250126082731.2037385-1-yebin10@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd200022.china.huawei.com (7.221.188.232)

Introduce ITAIL helper to get the bound of xattr in inode.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/xattr.c | 10 +++++-----
 fs/ext4/xattr.h |  3 +++
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 7647e9f6e190..0e4494863d15 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -649,7 +649,7 @@ ext4_xattr_ibody_get(struct inode *inode, int name_index, const char *name,
 		return error;
 	raw_inode = ext4_raw_inode(&iloc);
 	header = IHDR(inode, raw_inode);
-	end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
+	end = ITAIL(inode, raw_inode);
 	error = xattr_check_inode(inode, header, end);
 	if (error)
 		goto cleanup;
@@ -793,7 +793,7 @@ ext4_xattr_ibody_list(struct dentry *dentry, char *buffer, size_t buffer_size)
 		return error;
 	raw_inode = ext4_raw_inode(&iloc);
 	header = IHDR(inode, raw_inode);
-	end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
+	end = ITAIL(inode, raw_inode);
 	error = xattr_check_inode(inode, header, end);
 	if (error)
 		goto cleanup;
@@ -879,7 +879,7 @@ int ext4_get_inode_usage(struct inode *inode, qsize_t *usage)
 			goto out;
 		raw_inode = ext4_raw_inode(&iloc);
 		header = IHDR(inode, raw_inode);
-		end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
+		end = ITAIL(inode, raw_inode);
 		ret = xattr_check_inode(inode, header, end);
 		if (ret)
 			goto out;
@@ -2235,7 +2235,7 @@ int ext4_xattr_ibody_find(struct inode *inode, struct ext4_xattr_info *i,
 	header = IHDR(inode, raw_inode);
 	is->s.base = is->s.first = IFIRST(header);
 	is->s.here = is->s.first;
-	is->s.end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
+	is->s.end = ITAIL(inode, raw_inode);
 	if (ext4_test_inode_state(inode, EXT4_STATE_XATTR)) {
 		error = xattr_check_inode(inode, header, is->s.end);
 		if (error)
@@ -2786,7 +2786,7 @@ int ext4_expand_extra_isize_ea(struct inode *inode, int new_extra_isize,
 	 */
 
 	base = IFIRST(header);
-	end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
+	end = ITAIL(inode, raw_inode);
 	min_offs = end - base;
 	total_ino = sizeof(struct ext4_xattr_ibody_header) + sizeof(u32);
 
diff --git a/fs/ext4/xattr.h b/fs/ext4/xattr.h
index b25c2d7b5f99..d331bd636480 100644
--- a/fs/ext4/xattr.h
+++ b/fs/ext4/xattr.h
@@ -67,6 +67,9 @@ struct ext4_xattr_entry {
 		((void *)raw_inode + \
 		EXT4_GOOD_OLD_INODE_SIZE + \
 		EXT4_I(inode)->i_extra_isize))
+#define ITAIL(inode, raw_inode) \
+	((void *)raw_inode + \
+	 EXT4_SB(inode->i_sb)->s_inode_size)
 #define IFIRST(hdr) ((struct ext4_xattr_entry *)((hdr)+1))
 
 /*
-- 
2.34.1


