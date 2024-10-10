Return-Path: <linux-ext4+bounces-4538-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A25A997AE9
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Oct 2024 05:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CEEB1C23A4F
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Oct 2024 03:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2ED18E75A;
	Thu, 10 Oct 2024 02:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KeOhi5Z/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0888E188704;
	Thu, 10 Oct 2024 02:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728529152; cv=none; b=fYvM2XvDZzScsDT0+qAM2mNtF3y3N38LZUpC7xaTn1P7vZLk7Bs6id5dqluKHBgc+YnwQUWDDfWdwzHawjkD5N9MrwmPA60L+ng9BJswG+Ibh+VsYPtr2MZC5xbUgmYe5aqZDv4v+a1JLRkJ2BBnQeLPvVvg1Me0Z23gej1byUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728529152; c=relaxed/simple;
	bh=6KcPaF+1W6KzpMYD4h2jaZLaTzqARo1nCL7ouwgqo0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iX37dWvY3Kt9VIvK9OrzuFm9wDOpNh/8KJFmE09YTwHhfrO8aS68bJiSJ/zSDML304Jzb/7+f9StRLWsOK3tUEILKdvef9c44hh4WF2rZaiA2mp3WCptqFDu8RwS2KabrwgitUa2OLwb2BJ9Oef2+WKUTq8hGliZVAygAoo2Dsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=KeOhi5Z/; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=SDA7Z
	Yp2Z4hIwN64hp5hPfoNZvkXl2fYdBoL9D4Lwy8=; b=KeOhi5Z/9w9u9wV+j494u
	Cb/EKv0t5a2vzErAYjcADhCSpwRzRT162RQxbzSYEGycLGlGV7Msz2sIcp2QmMcR
	+FzkiVTCniaN5U3bcwY7emAEi3yTRE7E6WEiGMEI3EA+EPlO39plvC5fWr1BG9aO
	gmiKHUTqQUsMC41kXm87c4=
Received: from liubaolin-VMware-Virtual-Platform.localdomain (unknown [223.70.253.255])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3_y3wQgdnZpfDAA--.21796S2;
	Thu, 10 Oct 2024 10:58:58 +0800 (CST)
From: Baolin Liu <liubaolin12138@163.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz
Cc: zhangshida@kylinos.cn,
	longzhi@sangfor.com.cn,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Baolin Liu <liubaolin@kylinos.cn>
Subject: [PATCH v1] ext4: fix a assertion failure due to ungranted bh dirting
Date: Thu, 10 Oct 2024 10:58:55 +0800
Message-Id: <20241010025855.2632516-1-liubaolin12138@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_y3wQgdnZpfDAA--.21796S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuF45Jr48uF1fKryrWw13twb_yoW5Gr48pr
	9xKr93KrWjqry2gFZ3KF47ZF1UWa48GrW7GFWfGry5Za45GFnFgFyjqr1DJF1qkrWxAw1r
	XFW8Aryak3WjyrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07joAp5UUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/1tbiMRB0ymcHPNfEFQAAsF

From: Baolin Liu <liubaolin@kylinos.cn>

Since the merge of commit 3910b513fcdf ("ext4: persist the new uptodate
buffers in ext4_journalled_zero_new_buffers"), a new assertion failure
occurred under a old kernel(ext3, data=journal, pagesize=64k) with
corresponding ported patches:
================================================================
Call trace:
  __ext4_handle_dirty_metadata+0x320/0x7e8
  write_end_fn+0x78/0x178
  ext4_journalled_zero_new_buffers+0xd0/0x2c8
  ext4_block_write_begin+0x850/0xc00
  ext4_write_begin+0x334/0xc68
  generic_perform_write+0x1a4/0x380
  ext4_buffered_write_iter+0x180/0x370
  ext4_file_write_iter+0x194/0xfc0
  new_sync_write+0x338/0x4b8
  __vfs_write+0xc4/0xe8
  vfs_write+0x12c/0x3d0
  ksys_write+0xf4/0x230
  sys_write+0x34/0x48
  el0_svc_naked+0x44/0x48
================================================================

which was caused by bh dirting without calling
do_journal_get_write_access().

In the loop for all bhs of a page in ext4_block_write_begin(),
when a err occurred, it will jump out of loop.
But that will leaves some bhs being processed and some not,
which will lead to the asserion failure in calling write_end_fn().

To fixed that, get write access for the rest unprocessed bhs, just
as what write_end_fn do.

Fixes: 3910b513fcdf ("ext4: persist the new uptodate buffers in ext4_journalled_zero_new_buffers")
Reported-and-tested-by: Zhi Long <longzhi@sangfor.com.cn>
Suggested-by: Shida Zhang <zhangshida@kylinos.cn>
Signed-off-by: Baolin Liu <liubaolin@kylinos.cn>
---
 fs/ext4/inode.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 54bdd4884fe6..a72f951288e4 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1102,9 +1102,24 @@ int ext4_block_write_begin(handle_t *handle, struct folio *folio,
 			err = -EIO;
 	}
 	if (unlikely(err)) {
-		if (should_journal_data)
+		if (should_journal_data) {
+			if (bh != head || !block_start) {
+				do {
+					block_end = block_start + bh->b_size;
+
+					if (buffer_new(bh))
+						if (block_end > from && block_start < to)
+							do_journal_get_write_access(handle,
+										    inode, bh);
+
+					block_start = block_end;
+					bh = bh->b_this_page;
+				} while (bh != head);
+			}
+
 			ext4_journalled_zero_new_buffers(handle, inode, folio,
 							 from, to);
+		}
 		else
 			folio_zero_new_buffers(folio, from, to);
 	} else if (fscrypt_inode_uses_fs_layer_crypto(inode)) {
-- 
2.39.2


