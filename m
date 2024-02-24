Return-Path: <linux-ext4+bounces-1381-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EC5862544
	for <lists+linux-ext4@lfdr.de>; Sat, 24 Feb 2024 14:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFD66B219E4
	for <lists+linux-ext4@lfdr.de>; Sat, 24 Feb 2024 13:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA9D4C619;
	Sat, 24 Feb 2024 13:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WXUjj7OQ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DEE495CC
	for <linux-ext4@vger.kernel.org>; Sat, 24 Feb 2024 13:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708782506; cv=none; b=S2GyGPUo/H+0w8pXAa5Rf/fXdz135440X7fCOgFIwNVqrEa3XoV0exA+pXZ9lHVZC1HbRkzUU+ACb4HXmxFDhbV3xPfGthkp0aWEe8s5doBBNWIYPRI423zk3utOgEp8aaecKX0AMFHg2WAn4sBUA4U/f9doydINZsJVo9kAQtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708782506; c=relaxed/simple;
	bh=YbDtdnNvghTBaU3RguKiiG1MvBtOLPAJtXljGVNKK3s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=guzHHqXHAzG0cKxXeB9ir99stWE0+6F1m3WTCDQr+uRHr1wA0dUHO9i7Gk68FNUH3h/ak/YfleF6dHttPDYFh2ZBJZw+aFH/cG3nM2Q3opXRMhafYXy8ZlMrpOkjOk7Urp0exw3foN8INHU/f4rCYLhOReich7MRA2BE7y0ld9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WXUjj7OQ; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708782502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fE2FStz/e/B+/GO2DVwjBE8Exn6DtP5fmhDWTzvK8qo=;
	b=WXUjj7OQXTeCrPOVAuYhTE2VpYpH086Palm2FwkMvZIM/OvlnwxsRXhjdlHZyZqrQG5+Vn
	g5HAVBasAaxZyKRA0360h4oSS9K+zb+h4oGRAuaNOG5fyBvnvPsJtqA0g2OgnZh54VF5Xj
	4JuPZtb7c3XQtmxPQJMNxRgtenuOXkI=
From: chengming.zhou@linux.dev
To: jack@suse.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com,
	chengming.zhou@linux.dev,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] ext2: remove SLAB_MEM_SPREAD flag usage
Date: Sat, 24 Feb 2024 13:48:16 +0000
Message-Id: <20240224134816.829424-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Chengming Zhou <zhouchengming@bytedance.com>

The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
its usage so we can delete it from slab. No functional change.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 fs/ext2/super.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 6d8587505cea..7162c61c0402 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -213,8 +213,7 @@ static int __init init_inodecache(void)
 {
 	ext2_inode_cachep = kmem_cache_create_usercopy("ext2_inode_cache",
 				sizeof(struct ext2_inode_info), 0,
-				(SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD|
-					SLAB_ACCOUNT),
+				SLAB_RECLAIM_ACCOUNT|SLAB_ACCOUNT,
 				offsetof(struct ext2_inode_info, i_data),
 				sizeof_field(struct ext2_inode_info, i_data),
 				init_once);
-- 
2.40.1


