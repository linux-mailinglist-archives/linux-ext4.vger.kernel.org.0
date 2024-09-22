Return-Path: <linux-ext4+bounces-4256-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 320E197E05C
	for <lists+linux-ext4@lfdr.de>; Sun, 22 Sep 2024 08:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E35D92814A3
	for <lists+linux-ext4@lfdr.de>; Sun, 22 Sep 2024 06:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5614D8B9;
	Sun, 22 Sep 2024 06:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="oltgBHBY"
X-Original-To: linux-ext4@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA66936C;
	Sun, 22 Sep 2024 06:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726987421; cv=none; b=n/xtOlJBkB8Zfoo0VgW3M2kVqUlbaI/JLyxL7awAdF6ssLidlMKrKTw4kP/7SJL8GrVACzmpaGyEn3icz8NmUI7CKWFFAOtwe2xojr/mCuX1X3M0AXgwPziQqBBpZJtxoR3RAMzg00jqfA9KwiPNf++bJUJISejjzheTFVIjOaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726987421; c=relaxed/simple;
	bh=xi0Mj3BHyk/+gZCsFUtoUEc3poWGKYyP5uYQ4e63+B0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6xTmVPU2SmD6cCCjRIYP6rdNND8fp+fXATv4hXMHWVH8FW9A7wuAeANU1nMp4v3v8Qxp5WtX2ZFZxLtCwuCyvAPPrG2hDY325cQYE5fWqiHaZ+0femJTUVWbyWXBZg01TnbZOFRECXArqsCBE+rn4bpWfsKoCpWEeXVApfe9pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=oltgBHBY; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=gKbH5mnZTMhCwIfpq6td43lHTDTQMFxZnIWMkbj6e+w=;
	b=oltgBHBYXxQyFXs0q98Yrtd0EVaa4xPX1/9Ov5BvKeGf+6Q+Kfq/tFvNJbvJbn
	m9ITwuAWtJrLI8HiIWjwkUG/ifJZizOGvbYSfTw8NxQjuA5GAax4/r4vSRjeGYwy
	StqZUjf38+ceS4+p8AgVwqWz6mb5MaghM4hrIAIauIkJ8=
Received: from localhost (unknown [36.33.37.137])
	by gzga-smtp-mta-g3-4 (Coremail) with SMTP id _____wD3_3NpvO9mL2ZAFQ--.51857S2;
	Sun, 22 Sep 2024 14:42:49 +0800 (CST)
Date: Sun, 22 Sep 2024 14:42:49 +0800
From: Qianqiang Liu <qianqiang.liu@163.com>
To: tytso@mit.edu
Cc: adilger.kernel@dilger.ca,
	syzbot <syzbot+f792df426ff0f5ceb8d1@syzkaller.appspotmail.com>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, qianqiang.liu@163.com
Subject: [PATCH] ext4: fix out-of-bounds issue in ext4_xattr_set_entry
Message-ID: <Zu+8aQBJgMn7xVws@thinkpad.lan>
References: <Zu+vI3EipxSsPOMe@thinkpad.lan>
 <66efba95.050a0220.3195df.008c.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66efba95.050a0220.3195df.008c.GAE@google.com>
X-CM-TRANSID:_____wD3_3NpvO9mL2ZAFQ--.51857S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr1kurWUKw47AryxWFy8Krg_yoW8tF1fpa
	n8GryxArW8XryqyFW3KF1UAw1UWrs5Gr4UWrWfJr1UZFyxJw48XF9YgryDXFWqgrWjkF98
	CF1DJrn8Ww15Z37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UT6wXUUUUU=
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiYBRiambvta5peAAAs-

syzbot has found an out-of-bounds issue in ext4_xattr_set_entry:

==================================================================
BUG: KASAN: out-of-bounds in ext4_xattr_set_entry+0x8ce/0x1f60 fs/ext4/xattr.c:1781
Read of size 18446744073709551572 at addr ffff888036426850 by task syz-executor264/5095

CPU: 0 UID: 0 PID: 5095 Comm: syz-executor264 Not tainted 6.11.0-syzkaller-03917-ga940d9a43e62 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 __asan_memmove+0x29/0x70 mm/kasan/shadow.c:94
 ext4_xattr_set_entry+0x8ce/0x1f60 fs/ext4/xattr.c:1781
[...]
==================================================================

This issue is caused by a negative size in memmove.
We need to check for this.

Fixes: dec214d00e0d ("ext4: xattr inode deduplication")
Reported-by: syzbot+f792df426ff0f5ceb8d1@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f792df426ff0f5ceb8d1
Tested-by: syzbot+f792df426ff0f5ceb8d1@syzkaller.appspotmail.com
Signed-off-by: Qianqiang Liu <qianqiang.liu@163.com>
---
 fs/ext4/xattr.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 46ce2f21fef9..336badb46246 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1776,7 +1776,14 @@ static int ext4_xattr_set_entry(struct ext4_xattr_info *i,
 	} else if (s->not_found) {
 		/* Insert new name. */
 		size_t size = EXT4_XATTR_LEN(name_len);
-		size_t rest = (void *)last - (void *)here + sizeof(__u32);
+		size_t rest;
+
+		if (last < here) {
+			ret = -ENOSPC;
+			goto out;
+		} else {
+			rest = (void *)last - (void *)here + sizeof(__u32);
+		}
 
 		memmove((void *)here + size, here, rest);
 		memset(here, 0, size);
-- 
2.34.1

-- 
Best,
Qianqiang Liu


