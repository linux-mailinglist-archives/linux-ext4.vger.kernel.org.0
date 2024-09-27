Return-Path: <linux-ext4+bounces-4353-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D389987E86
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Sep 2024 08:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFE1F1F21A10
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Sep 2024 06:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC7A176FB6;
	Fri, 27 Sep 2024 06:39:33 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F98158557;
	Fri, 27 Sep 2024 06:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727419172; cv=none; b=Ux2Ctv4Nrr7VgD0HWxtElTdsT8Z3GGOzbZEDDHztx56+s3AbwN4X2Wt2Tj5So1CbzSaLHOzcoWl9BOgJ8rv7uCqZcX/S9liyOIENh319DC9LjuFG5fDrGPbi5xhuJWV9SPhK2PWrznMGzNHZBmzu5mbaTuGwbqEGsxmDT1zpaHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727419172; c=relaxed/simple;
	bh=uiMMQvxopeaDfVxhERXqaMFelDtteEisin7Ss13WtfA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Fr9oIEZIVuBwCOkEvTPJLoyP18sZcW3DW0OsDFBkwpkW7O9ECm98otN5jl+DlmoLileN5ocqE26vqPdpKCLmZook3xGe4w1XwgxglKhXHPAK4NVXLDVrs50AG1hyCznE3Oh2j3AAI8r+oMX8edeHPjMePulgsIS3q+iZfz9FdCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XFLR06Y4Bz4f3jXP;
	Fri, 27 Sep 2024 14:39:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3A6F31A018D;
	Fri, 27 Sep 2024 14:39:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDHR8QWU_ZmwM_lCQ--.36079S4;
	Fri, 27 Sep 2024 14:39:20 +0800 (CST)
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
Subject: [PATCH] ext4: fix off by one issue in alloc_flex_gd()
Date: Fri, 27 Sep 2024 14:36:20 +0800
Message-Id: <20240927063620.2630898-1-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHR8QWU_ZmwM_lCQ--.36079S4
X-Coremail-Antispam: 1UD129KBjvJXoWxAw1fJw13ZF47tw13ur15Jwb_yoW5Aw48pF
	93Ka4xGryYgryUGr4UG34vgF18GrykJr17XrWxWw1xXF17ZFsrGr1xKry8CFyUCF95Cr15
	JFs0vF1qyrnrJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9E14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
	AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbknY7UUUUU==
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgAPBWbv1ZsktAABse

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
 fs/ext4/resize.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index e04eb08b9060..397970121d43 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -253,9 +253,9 @@ static struct ext4_new_flex_group_data *alloc_flex_gd(unsigned int flexbg_size,
 	/* Avoid allocating large 'groups' array if not needed */
 	last_group = o_group | (flex_gd->resize_bg - 1);
 	if (n_group <= last_group)
-		flex_gd->resize_bg = 1 << fls(n_group - o_group + 1);
+		flex_gd->resize_bg = 1 << fls(n_group - o_group);
 	else if (n_group - last_group < flex_gd->resize_bg)
-		flex_gd->resize_bg = 1 << max(fls(last_group - o_group + 1),
+		flex_gd->resize_bg = 1 << max(fls(last_group - o_group),
 					      fls(n_group - last_group));
 
 	flex_gd->groups = kmalloc_array(flex_gd->resize_bg,
-- 
2.46.0


