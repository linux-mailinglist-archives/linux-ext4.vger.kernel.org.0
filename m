Return-Path: <linux-ext4+bounces-2295-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0418BB9F3
	for <lists+linux-ext4@lfdr.de>; Sat,  4 May 2024 10:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73A5A1F21E8B
	for <lists+linux-ext4@lfdr.de>; Sat,  4 May 2024 08:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82828171AB;
	Sat,  4 May 2024 08:05:29 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58380111AD;
	Sat,  4 May 2024 08:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714809929; cv=none; b=ExwaOqRG1W2WMXCxUgnqsJyVAa0tqvT/cRQvMTzYlA0ldTNQjDWIP9PRijYf8Lv2zJC3VkO5VUFAEAOWrVIhegF0EFx36pmrtfQZS8CxWInCXa0FuwN4nOcUjbIuz/tcmJqMZxmQ6wQCjiwILqgL3TnJoBWCcUyjX4PJejP1iIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714809929; c=relaxed/simple;
	bh=eGMDMCeJmKfty2SuJuUWgQ5o5s2iOmSw8sf0drDov6s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JP0KnG13ReNPDPOjReta3Y4UQgX393R1tJfdsDmCpHORsltkhFWXOKAh/Og+EyRqJjyltxNkywdD0p+ssWoCRHp0evAd7xPCr+SYbiqalPl1mnk/c48OZOpMRh07Iq3QOuGMlmO0ZjlB/X8iEtOXS66BC2kB906XvUlsfHv1USo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VWgFd5LRxz4f3jXr;
	Sat,  4 May 2024 16:05:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id CD6321A09F0;
	Sat,  4 May 2024 16:05:17 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgCXaBE57DVmKbDhLg--.23467S5;
	Sat, 04 May 2024 16:05:15 +0800 (CST)
From: libaokun@huaweicloud.com
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	libaokun@huaweicloud.com,
	Baokun Li <libaokun1@huawei.com>,
	syzbot+dd43bd0f7474512edc47@syzkaller.appspotmail.com,
	stable@kernel.org
Subject: [PATCH 1/2] ext4: fix mb_cache_entry's e_refcnt leak in ext4_xattr_block_cache_find()
Date: Sat,  4 May 2024 15:55:25 +0800
Message-Id: <20240504075526.2254349-2-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240504075526.2254349-1-libaokun@huaweicloud.com>
References: <20240504075526.2254349-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCXaBE57DVmKbDhLg--.23467S5
X-Coremail-Antispam: 1UD129KBjvJXoWxJrWxXw4DWr45WrWkZrWUJwb_yoW8ZrW8p3
	s7KryIyrWFq34UAayfKr1Iqw18ua1kGF47J3yxKr1UZa47Xwn3Ka4jqrn8XFyqgrWv9wn0
	yF1DK343Aw1rG3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPl14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7M4kE6xkIj40Ew7xC0wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC2
	0s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI
	0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv2
	0xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2js
	IE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZF
	pf9x0JUhTmDUUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/

From: Baokun Li <libaokun1@huawei.com>

Syzbot reports a warning as follows:

============================================
WARNING: CPU: 0 PID: 5075 at fs/mbcache.c:419 mb_cache_destroy+0x224/0x290
Modules linked in:
CPU: 0 PID: 5075 Comm: syz-executor199 Not tainted 6.9.0-rc6-gb947cc5bf6d7
RIP: 0010:mb_cache_destroy+0x224/0x290 fs/mbcache.c:419
Call Trace:
 <TASK>
 ext4_put_super+0x6d4/0xcd0 fs/ext4/super.c:1375
 generic_shutdown_super+0x136/0x2d0 fs/super.c:641
 kill_block_super+0x44/0x90 fs/super.c:1675
 ext4_kill_sb+0x68/0xa0 fs/ext4/super.c:7327
[...]
============================================

This is because when finding an entry in ext4_xattr_block_cache_find(), if
ext4_sb_bread() returns -ENOMEM, the ce's e_refcnt, which has already grown
in the __entry_find(), won't be put away, and eventually trigger the above
issue in mb_cache_destroy() due to reference count leakage.

So call mb_cache_entry_put() on the -ENOMEM error branch as a quick fix.

Reported-by: syzbot+dd43bd0f7474512edc47@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=dd43bd0f7474512edc47
Fixes: fb265c9cb49e ("ext4: add ext4_sb_bread() to disambiguate ENOMEM cases")
Cc: stable@kernel.org
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/xattr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index b67a176bfcf9..9fdd13422073 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -3113,8 +3113,10 @@ ext4_xattr_block_cache_find(struct inode *inode,
 
 		bh = ext4_sb_bread(inode->i_sb, ce->e_value, REQ_PRIO);
 		if (IS_ERR(bh)) {
-			if (PTR_ERR(bh) == -ENOMEM)
+			if (PTR_ERR(bh) == -ENOMEM) {
+				mb_cache_entry_put(ea_block_cache, ce);
 				return NULL;
+			}
 			bh = NULL;
 			EXT4_ERROR_INODE(inode, "block %lu read error",
 					 (unsigned long)ce->e_value);
-- 
2.39.2


