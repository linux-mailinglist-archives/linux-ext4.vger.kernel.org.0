Return-Path: <linux-ext4+bounces-9272-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC69DB1BEC6
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Aug 2025 04:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E52B118A7AF5
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Aug 2025 02:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7900119DF4F;
	Wed,  6 Aug 2025 02:29:18 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAD62AD32;
	Wed,  6 Aug 2025 02:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754447358; cv=none; b=ScWFDdvEC+fI5Mn4nwWRBYaXzrDOEazEpZav9QdRecr2upJKdpvds1yzlaNeFc3LOwdapJvS7kHAZr6k8F+BuNxtDgTESctriGMBAllXZSbCDPQhSZ2T6L6mI2lK1I+IVExdAYUVisE6LKroV8T/YAStzftv+ut07zWMGDfxDDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754447358; c=relaxed/simple;
	bh=tuiKuVXfRNv3YbDvL1tWkve++ax6VByUxv8HgesmuX4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bQTQCmgCWrJQDOCwM71Bb0iS/FzMqJmkJzmMoQCsWWaKEsi9gEbmU+UoM48EEEPrrVhUSzKOtexSBpNFTzqY+I/h/QnJE58XeLLVH27eZY1A3wlYqtESerDzvxHMXz+rHF57LTKIKbVE90QhyjTUp9sWMzqwf5Sw6/MpWkchDkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201608.home.langchao.com
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id 202508061028518107;
        Wed, 06 Aug 2025 10:28:51 +0800
Received: from localhost.localdomain.com (10.94.12.223) by
 jtjnmail201608.home.langchao.com (10.100.2.8) with Microsoft SMTP Server id
 15.1.2507.57; Wed, 6 Aug 2025 10:28:51 +0800
From: chuguangqing <chuguangqing@inspur.com>
To: <tytso@mit.edu>, <adilger.kernel@dilger.ca>
CC: <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>, chuguangqing
	<chuguangqing@inspur.com>
Subject: [PATCH 1/1] fs: ext4: change GFP_KERNEL to GFP_NOFS to avoid deadlock
Date: Wed, 6 Aug 2025 10:28:49 +0800
Message-ID: <20250806022849.1415-2-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250806022849.1415-1-chuguangqing@inspur.com>
References: <20250806022849.1415-1-chuguangqing@inspur.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 202580610285149447baf58fa2f123de416f2ba6c8108
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The parent function ext4_xattr_inode_lookup_create already uses GFP_NOFS for memory alloction, so the function ext4_xattr_inode_cache_find should use same gfp_flag.

Signed-off-by: chuguangqing <chuguangqing@inspur.com>
---
 fs/ext4/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 5a6fe1513fd2..7743d81b2f21 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1530,7 +1530,7 @@ ext4_xattr_inode_cache_find(struct inode *inode, const void *value,
 	WARN_ON_ONCE(ext4_handle_valid(journal_current_handle()) &&
 		     !(current->flags & PF_MEMALLOC_NOFS));
 
-	ea_data = kvmalloc(value_len, GFP_KERNEL);
+	ea_data = kvmalloc(value_len, GFP_NOFS);
 	if (!ea_data) {
 		mb_cache_entry_put(ea_inode_cache, ce);
 		return NULL;
-- 
2.43.5


