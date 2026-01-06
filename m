Return-Path: <linux-ext4+bounces-12584-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B24A4CF6E1E
	for <lists+linux-ext4@lfdr.de>; Tue, 06 Jan 2026 07:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E3B53019BB6
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Jan 2026 06:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178343002B9;
	Tue,  6 Jan 2026 06:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hDZE4tT6"
X-Original-To: linux-ext4@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C998F1E5B73;
	Tue,  6 Jan 2026 06:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767680451; cv=none; b=POfMfauTrDaTPHfll0jkkuZYP6lhdlFdUqJqJBT+Mt+NqMLXStxQf2Z4xjtvKHr496TrlG0UOOYvaWqdnieC70r6C7HyUaTw0kYSs54A9R/YevhFGzKmTBGfUsbDI67PxPNY+K1sVnhYR+K+IAqdFDHVaoEMa/lZUQ9XeK0Luj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767680451; c=relaxed/simple;
	bh=WC+rnQ1X+nMHAkD8JcF3uxEqWTfvpSZRL/5vhy3/fjk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ECpzaSY1xmAAkqKs47D7QkcEt3JjiNr3fRMlTjJijWLDxRJtBlu3VAv66jnZDo4ah300DlLPtl8QmHvxmRRqVftPDq8bYv9ueqjHtY8N3912L8VSlzShlipLyk7FufYXMUvx88vWSwnfKnVuIOQ7y88mkm5phkxb3wE6AMT8PXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hDZE4tT6; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ZN
	J5tcQvIrFkdWp8DCDysE/zLyem/WpP44SjZeHCmTg=; b=hDZE4tT63gSQzCdwbo
	aGW/nudAnl8jGWduOA1ncQib9tB1jikMSWrr3ZMvMlTTyn06Mj6XowHqy8919gDk
	vY+tFOoouE5UUfMkGLse/JuEjpMO+9z8khlppvaGu6X4XSwfeCVt1/2iG5ElHQfC
	bzsupY5j4dJtk++GAbBaERU2E=
Received: from liubaolin-VMware-Virtual-Platform.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgDnJMSmqVxpluOSKA--.192S2;
	Tue, 06 Jan 2026 14:20:26 +0800 (CST)
From: Baolin Liu <liubaolin12138@163.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Baolin Liu <liubaolin@kylinos.cn>
Subject: [PATCH v1] ext4: Remove redundant NULL check after __GFP_NOFAIL
Date: Tue,  6 Jan 2026 14:20:16 +0800
Message-Id: <20260106062016.154573-1-liubaolin12138@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgDnJMSmqVxpluOSKA--.192S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gr1kZF48Jr4rZw4xCF13twb_yoW3Wrb_Ga
	y7Jr1kXrW3Krn29a1kGr1avryqvF1Igr1UZF95Kr93Z34DWr45uFWDZrsxZrZ8ur4xJF1D
	ur4qyr1UAFnagjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbQzV7UUUUU==
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6goG0GlcqaoqaQAA3D

From: Baolin Liu <liubaolin@kylinos.cn>

Remove redundant NULL check after kcalloc() with GFP_NOFS | __GFP_NOFAIL.

Signed-off-by: Baolin Liu <liubaolin@kylinos.cn>
---
 fs/ext4/extents.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 2cf5759ba689..0bee702ca663 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -2944,10 +2944,6 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 	} else {
 		path = kcalloc(depth + 1, sizeof(struct ext4_ext_path),
 			       GFP_NOFS | __GFP_NOFAIL);
-		if (path == NULL) {
-			ext4_journal_stop(handle);
-			return -ENOMEM;
-		}
 		path[0].p_maxdepth = path[0].p_depth = depth;
 		path[0].p_hdr = ext_inode_hdr(inode);
 		i = 0;
-- 
2.39.2


