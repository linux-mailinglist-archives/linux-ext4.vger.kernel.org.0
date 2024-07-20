Return-Path: <linux-ext4+bounces-3341-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAFE938203
	for <lists+linux-ext4@lfdr.de>; Sat, 20 Jul 2024 18:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE5B21C214EC
	for <lists+linux-ext4@lfdr.de>; Sat, 20 Jul 2024 16:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274581487E7;
	Sat, 20 Jul 2024 16:04:47 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B72D1487CC;
	Sat, 20 Jul 2024 16:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721491486; cv=none; b=KsLL3eKTzUgc0h+bM7+IAvHFKlBpOHHi1oT4H91GYZvVNHLNJ7cB8Sx/dknLhzp77jJHoHnL1LFPV35CA0NnCh23Lsz29UDOB5IedXP/kd21oayLNJyTPcrLmDzzUBXIe1ALi4raXKUGyWMY9jzrazd9Xkv/atkRACH5V9kXHoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721491486; c=relaxed/simple;
	bh=nYdDeVRQgWO/lNcngruJzRkh9len6++gm+EoGAAb0I4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XbWaIbo3qxCUae7FMTW6oZ+LLro/ooDMrWWrz/mAS5rjSnR1P/RxKW2ms8jJqBAmjWsXfYRhGc63K/q/VoNVUsCVPRi8gufThMCUp+Gp8NhS7A34HAWxs4CX0quoWR/IKJjwdvuYtls3rO4gY9YX1kGAYjh9rt6S09GWjoLYuok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtp81t1721491473tfa5o7e4
X-QQ-Originating-IP: e7eqQ2g4BBTbaLpJkD+hJApUF2qtaxZ4T4SV2G18Gi4=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 21 Jul 2024 00:04:31 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3741391838611040633
From: WangYuli <wangyuli@uniontech.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org,
	yi.zhang@huawei.com
Cc: jack@suse.cz,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	niecheng1@uniontech.com,
	zhangdandan@uniontech.com,
	guanwentao@uniontech.com,
	WangYuli <wangyuli@uniontech.com>
Subject: [PATCH v2 4.19 2/4] ext4: correct the error path of ext4_write_inline_data_end()
Date: Sun, 21 Jul 2024 00:04:08 +0800
Message-ID: <C932196342E85337+20240720160420.578940-3-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20240720160420.578940-1-wangyuli@uniontech.com>
References: <20240720160420.578940-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

From: Zhang Yi <yi.zhang@huawei.com>

commit 55ce2f649b9e88111270333a8127e23f4f8f42d7 upstream

Current error path of ext4_write_inline_data_end() is not correct.

Firstly, it should pass out the error value if ext4_get_inode_loc()
return fail, or else it could trigger infinite loop if we inject error
here. And then it's better to add inode to orphan list if it return fail
in ext4_journal_stop(), otherwise we could not restore inline xattr
entry after power failure. Finally, we need to reset the 'ret' value if
ext4_write_inline_data_end() return success in ext4_write_end() and
ext4_journalled_write_end(), otherwise we could not get the error return
value of ext4_journal_stop().

Cc: stable@vger.kernel.org
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Link: https://lore.kernel.org/r/20210716122024.1105856-3-yi.zhang@huawei.com
Reviewed-by: Cheng Nie <niecheng1@uniontech.com>
Signed-off-by: Dandan Zhang <zhangdandan@uniontech.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 fs/ext4/inline.c | 15 +++++----------
 fs/ext4/inode.c  |  7 +++++--
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 71bb3cfc5933..de04bd5fb551 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -745,18 +745,13 @@ int ext4_write_inline_data_end(struct inode *inode, loff_t pos, unsigned len,
 	void *kaddr;
 	struct ext4_iloc iloc;
 
-	if (unlikely(copied < len)) {
-		if (!PageUptodate(page)) {
-			copied = 0;
-			goto out;
-		}
-	}
+	if (unlikely(copied < len) && !PageUptodate(page))
+		return 0;
 
 	ret = ext4_get_inode_loc(inode, &iloc);
 	if (ret) {
 		ext4_std_error(inode->i_sb, ret);
-		copied = 0;
-		goto out;
+		return ret;
 	}
 
 	ext4_write_lock_xattr(inode, &no_expand);
@@ -769,7 +764,7 @@ int ext4_write_inline_data_end(struct inode *inode, loff_t pos, unsigned len,
 	(void) ext4_find_inline_data_nolock(inode);
 
 	kaddr = kmap_atomic(page);
-	ext4_write_inline_data(inode, &iloc, kaddr, pos, len);
+	ext4_write_inline_data(inode, &iloc, kaddr, pos, copied);
 	kunmap_atomic(kaddr);
 	SetPageUptodate(page);
 	/* clear page dirty so that writepages wouldn't work for us. */
@@ -778,7 +773,7 @@ int ext4_write_inline_data_end(struct inode *inode, loff_t pos, unsigned len,
 	ext4_write_unlock_xattr(inode, &no_expand);
 	brelse(iloc.bh);
 	mark_inode_dirty(inode);
-out:
+
 	return copied;
 }
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index d8a8e4ee5ff8..44a715e6aae1 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1428,6 +1428,7 @@ static int ext4_write_end(struct file *file,
 			goto errout;
 		}
 		copied = ret;
+		ret = 0;
 	} else
 		copied = block_write_end(file, mapping, pos,
 					 len, copied, page, fsdata);
@@ -1450,13 +1451,14 @@ static int ext4_write_end(struct file *file,
 	if (i_size_changed || inline_data)
 		ext4_mark_inode_dirty(handle, inode);
 
+errout:
 	if (pos + len > inode->i_size && ext4_can_truncate(inode))
 		/* if we have allocated more blocks and copied
 		 * less. We will have blocks allocated outside
 		 * inode->i_size. So truncate them
 		 */
 		ext4_orphan_add(handle, inode);
-errout:
+
 	ret2 = ext4_journal_stop(handle);
 	if (!ret)
 		ret = ret2;
@@ -1538,6 +1540,7 @@ static int ext4_journalled_write_end(struct file *file,
 			goto errout;
 		}
 		copied = ret;
+		ret = 0;
 	} else if (unlikely(copied < len) && !PageUptodate(page)) {
 		copied = 0;
 		ext4_journalled_zero_new_buffers(handle, page, from, to);
@@ -1566,6 +1569,7 @@ static int ext4_journalled_write_end(struct file *file,
 			ret = ret2;
 	}
 
+errout:
 	if (pos + len > inode->i_size && ext4_can_truncate(inode))
 		/* if we have allocated more blocks and copied
 		 * less. We will have blocks allocated outside
@@ -1573,7 +1577,6 @@ static int ext4_journalled_write_end(struct file *file,
 		 */
 		ext4_orphan_add(handle, inode);
 
-errout:
 	ret2 = ext4_journal_stop(handle);
 	if (!ret)
 		ret = ret2;
-- 
2.43.4


