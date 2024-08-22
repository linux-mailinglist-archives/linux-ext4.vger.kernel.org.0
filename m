Return-Path: <linux-ext4+bounces-3840-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C5595AAFA
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Aug 2024 04:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93BF21F23631
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Aug 2024 02:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F01A1C68F;
	Thu, 22 Aug 2024 02:40:38 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D8615E81;
	Thu, 22 Aug 2024 02:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724294438; cv=none; b=gPSnxG++xc4lotN/h0RYuZdEmrZ1RMtanuyMrXK76mqSXzh9uoKukrnAKkoIg9VNxCZhWBqJ1G1Ew/oupIOE0HccoykiJSuR0yDXaJ5Gihjy5Odpo5oPtKljPwyRrj2MN78vrDOLqQdruphlSR3m2h3syhevAt6kou8AeQSP1xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724294438; c=relaxed/simple;
	bh=pEPVJbDDg+2upk/d72cFGfKPoOE997AF6Zd3b6EdN8w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UNQU7RByR39Ka7Zui87TZyRzY+Nu60R1W50eKmFiISMaePeh5q1DBdlQjLCAh0Rg4ji9knk1jI3G2E7MNTHoNmuMbeVr9Yd8Iwo8k8q6irgRAgRyrl3ciz1tMAxyuxfDSDnMzjq6Fd1JB1mnz5xoJfWkasz/GKWN5QoncgRqYXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wq6r06Sbsz4f3n6n;
	Thu, 22 Aug 2024 10:40:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0BC241A0568;
	Thu, 22 Aug 2024 10:40:32 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCHr4UapcZmqbd1CQ--.38129S6;
	Thu, 22 Aug 2024 10:40:31 +0800 (CST)
From: libaokun@huaweicloud.com
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	ojaswin@linux.ibm.com,
	linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	libaokun@huaweicloud.com,
	Baokun Li <libaokun1@huawei.com>,
	zhanchengbin <zhanchengbin1@huawei.com>
Subject: [PATCH v2 02/25] ext4: prevent partial update of the extents path
Date: Thu, 22 Aug 2024 10:35:22 +0800
Message-Id: <20240822023545.1994557-3-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240822023545.1994557-1-libaokun@huaweicloud.com>
References: <20240822023545.1994557-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHr4UapcZmqbd1CQ--.38129S6
X-Coremail-Antispam: 1UD129KBjvJXoWxWF4xCrWfGw1fZrWDtr17Awb_yoW5GFWUpF
	nIkrn5Gr48Way3uFy3tFWUZFy5Ka1kC3yxWrWxAw13WFy5Zr9YqryxKF15CF95JFW8Wa4f
	XrW8tr1UKw1DGa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmK14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwAKzVCY07xG64k0F24lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I
	3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
	WUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
	wI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcI
	k0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j
	6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUYZ2-UUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgADBWbFpZhEEQAAsP

From: Baokun Li <libaokun1@huawei.com>

In ext4_ext_rm_idx() and ext4_ext_correct_indexes(), there is no proper
rollback of already executed updates when updating a level of the extents
path fails, so we may get an inconsistent extents tree, which may trigger
some bad things in errors=continue mode.

Hence clear the verified bit of modified extents buffers if the tree fails
to be updated in ext4_ext_rm_idx() or ext4_ext_correct_indexes(), which
forces the extents buffers to be checked in ext4_valid_extent_entries(),
ensuring that the extents tree is consistent.

Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
Link: https://lore.kernel.org/r/20230213080514.535568-3-zhanchengbin1@huawei.com/
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Tested-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/extents.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index bff3666c891a..4d589d34b30e 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -1749,12 +1749,23 @@ static int ext4_ext_correct_indexes(handle_t *handle, struct inode *inode,
 			break;
 		err = ext4_ext_get_access(handle, inode, path + k);
 		if (err)
-			break;
+			goto clean;
 		path[k].p_idx->ei_block = border;
 		err = ext4_ext_dirty(handle, inode, path + k);
 		if (err)
-			break;
+			goto clean;
 	}
+	return 0;
+
+clean:
+	/*
+	 * The path[k].p_bh is either unmodified or with no verified bit
+	 * set (see ext4_ext_get_access()). So just clear the verified bit
+	 * of the successfully modified extents buffers, which will force
+	 * these extents to be checked to avoid using inconsistent data.
+	 */
+	while (++k < depth)
+		clear_buffer_verified(path[k].p_bh);
 
 	return err;
 }
@@ -2312,12 +2323,24 @@ static int ext4_ext_rm_idx(handle_t *handle, struct inode *inode,
 			break;
 		err = ext4_ext_get_access(handle, inode, path + k);
 		if (err)
-			break;
+			goto clean;
 		path[k].p_idx->ei_block = path[k + 1].p_idx->ei_block;
 		err = ext4_ext_dirty(handle, inode, path + k);
 		if (err)
-			break;
+			goto clean;
 	}
+	return 0;
+
+clean:
+	/*
+	 * The path[k].p_bh is either unmodified or with no verified bit
+	 * set (see ext4_ext_get_access()). So just clear the verified bit
+	 * of the successfully modified extents buffers, which will force
+	 * these extents to be checked to avoid using inconsistent data.
+	 */
+	while (++k < depth)
+		clear_buffer_verified(path[k].p_bh);
+
 	return err;
 }
 
-- 
2.39.2


