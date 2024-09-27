Return-Path: <linux-ext4+bounces-4361-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F95988657
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Sep 2024 15:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB60B1F21D70
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Sep 2024 13:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953AF18CBE5;
	Fri, 27 Sep 2024 13:36:40 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E24A2557A;
	Fri, 27 Sep 2024 13:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727444200; cv=none; b=PkS0tjDYNAlbbh/X8WsSl4AR1JeoHmC6EqwR687PjQ6vfJkYtGSqj74nAlnnvVsU2gdilgGCqnUCYw8vqzTR6O06AC63QBhvR/Yc+ZOkZywqnEwL8SsLpTnH164wKXZ5kxgfIeIhyvSOaxlIk8MhZSc8z9l6XuJ8sn8Aku3UjY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727444200; c=relaxed/simple;
	bh=5A8etmnAU5wkjbE9afxfjFjhlVofqfZ0nleGHfKmEuw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=aPq+Ewj0R0QUUOIbikZaNwN8Bn8vplBhXLPBo4SbYLQ5GfBuiDlbqmldasgjPGhFsMVPMeOSwugFw9srIVnve5BC2fBMMGGXUgHIQcoGgHIR+xAQu0B/G3YmqzSLVUTCnGZ4KWlG5b4B9/0oyCmsz/2E/QTU0zEq1cGbfSN2REg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XFWhH1tLZz4f3l1v;
	Fri, 27 Sep 2024 21:36:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 488C91A08FC;
	Fri, 27 Sep 2024 21:36:32 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAHPMjatPZm9X0BCg--.27083S4;
	Fri, 27 Sep 2024 21:36:28 +0800 (CST)
From: libaokun@huaweicloud.com
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	libaokun@huaweicloud.com,
	Baokun Li <libaokun1@huawei.com>,
	Wesley Hershberger <wesley.hershberger@canonical.com>,
	=?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Eric Sandeen <sandeen@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] ext4: fix off by one issue in alloc_flex_gd()
Date: Fri, 27 Sep 2024 21:33:29 +0800
Message-Id: <20240927133329.1015041-1-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAHPMjatPZm9X0BCg--.27083S4
X-Coremail-Antispam: 1UD129KBjvJXoWxAw1fJw13ZF47tw13ur15Jwb_yoWrAF45pF
	9xK3s3GryYgrW7Gr47G34qqF1rG3s7Ar12qrWxWw1xZF17ZF43Gr1xKrW8CFyUGFZ5Cr15
	Jws0vFn0yrnrtaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9K14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwAKzVCY07xG64k0F24lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUO73vUUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgATBWb2bRwQYQABsF

From: Baokun Li <libaokun1@huawei.com>

Wesley reported an issue:

==================================================================
EXT4-fs (dm-5): resizing filesystem from 7168 to 786432 blocks
------------[ cut here ]------------
kernel BUG at fs/ext4/resize.c:324!
CPU: 9 UID: 0 PID: 3576 Comm: resize2fs Not tainted 6.11.0+ #27
RIP: 0010:ext4_resize_fs+0x1212/0x12d0
Call Trace:
 __ext4_ioctl+0x4e0/0x1800
 ext4_ioctl+0x12/0x20
 __x64_sys_ioctl+0x99/0xd0
 x64_sys_call+0x1206/0x20d0
 do_syscall_64+0x72/0x110
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
==================================================================

While reviewing the patch, Honza found that when adjusting resize_bg in
alloc_flex_gd(), it was possible for flex_gd->resize_bg to be bigger than
flexbg_size.

The reproduction of the problem requires the following:

 o_group = flexbg_size * 2 * n;
 o_size = (o_group + 1) * group_size;
 n_group: [o_group + flexbg_size, o_group + flexbg_size * 2)
 o_size = (n_group + 1) * group_size;

Take n=0,flexbg_size=16 as an example:

              last:15
|o---------------|--------------n-|
o_group:0    resize to      n_group:30

The corresponding reproducer is:

img=test.img
truncate -s 600M $img
mkfs.ext4 -F $img -b 1024 -G 16 8M
dev=`losetup -f --show $img`
mkdir -p /tmp/test
mount $dev /tmp/test
resize2fs $dev 248M

Delete the problematic plus 1 to fix the issue, and add a WARN_ON_ONCE()
to prevent the issue from happening again.

Reported-by: Wesley Hershberger <wesley.hershberger@canonical.com>
Closes: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2081231
Reported-by: Stéphane Graber <stgraber@stgraber.org>
Closes: https://lore.kernel.org/all/20240925143325.518508-1-aleksandr.mikhalitsyn@canonical.com/
Tested-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Tested-by: Eric Sandeen <sandeen@redhat.com>
Fixes: 665d3e0af4d3 ("ext4: reduce unnecessary memory allocation in alloc_flex_gd()")
Cc: stable@vger.kernel.org
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
Changes since v1:
 * Add missing WARN_ON_ONCE().
 * Correct the comment of alloc_flex_gd().

 fs/ext4/resize.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index e04eb08b9060..a2704f064361 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -230,8 +230,8 @@ struct ext4_new_flex_group_data {
 #define MAX_RESIZE_BG				16384
 
 /*
- * alloc_flex_gd() allocates a ext4_new_flex_group_data with size of
- * @flexbg_size.
+ * alloc_flex_gd() allocates an ext4_new_flex_group_data that satisfies the
+ * resizing from @o_group to @n_group, its size is typically @flexbg_size.
  *
  * Returns NULL on failure otherwise address of the allocated structure.
  */
@@ -239,25 +239,27 @@ static struct ext4_new_flex_group_data *alloc_flex_gd(unsigned int flexbg_size,
 				ext4_group_t o_group, ext4_group_t n_group)
 {
 	ext4_group_t last_group;
+	unsigned int max_resize_bg;
 	struct ext4_new_flex_group_data *flex_gd;
 
 	flex_gd = kmalloc(sizeof(*flex_gd), GFP_NOFS);
 	if (flex_gd == NULL)
 		goto out3;
 
-	if (unlikely(flexbg_size > MAX_RESIZE_BG))
-		flex_gd->resize_bg = MAX_RESIZE_BG;
-	else
-		flex_gd->resize_bg = flexbg_size;
+	max_resize_bg = umin(flexbg_size, MAX_RESIZE_BG);
+	flex_gd->resize_bg = max_resize_bg;
 
 	/* Avoid allocating large 'groups' array if not needed */
 	last_group = o_group | (flex_gd->resize_bg - 1);
 	if (n_group <= last_group)
-		flex_gd->resize_bg = 1 << fls(n_group - o_group + 1);
+		flex_gd->resize_bg = 1 << fls(n_group - o_group);
 	else if (n_group - last_group < flex_gd->resize_bg)
-		flex_gd->resize_bg = 1 << max(fls(last_group - o_group + 1),
+		flex_gd->resize_bg = 1 << max(fls(last_group - o_group),
 					      fls(n_group - last_group));
 
+	if (WARN_ON_ONCE(flex_gd->resize_bg > max_resize_bg))
+		flex_gd->resize_bg = max_resize_bg;
+
 	flex_gd->groups = kmalloc_array(flex_gd->resize_bg,
 					sizeof(struct ext4_new_group_data),
 					GFP_NOFS);
-- 
2.39.2


