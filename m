Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53CB2375A88
	for <lists+linux-ext4@lfdr.de>; Thu,  6 May 2021 20:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234555AbhEFS6V (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 May 2021 14:58:21 -0400
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21375 "EHLO
        sender4-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234197AbhEFS6V (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 May 2021 14:58:21 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1620327428; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=eJ238D6x+o3ynAwkMV3GeeHv6PCL/f0XeLNbqD8QwcyEIS0jDEZ81rWyKp0io6Om4f7b+OHFr3QJvDI4xJzElMGkR7yaV47HYZhZCvAWp9/jpocm2KJz/pOfufV8WsRe+Kf8AfZWXaHEyuCqY0Tk7SlppuQR3vYNmE1IlrORl+w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1620327428; h=Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=S+/94991o1BPiFbH+TJfvpYPY1OSzgLbNS+l1MvqNzI=; 
        b=eD4Zsi28flpyz1s1RcH+Gg3NRLkOdkoCMP/OsZPPI7MX+mvuj6BhM5ykUiJOwAzaZZWhLa6vpZhgQlQ7QHDNjqqwaOz0Gy/UjUn3fKZh9KoNzONQCZRRICKnP7FySHsgwn9/hxwEen72A3LttceWjbLb7C92IEtqYxndly0+Rkk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=anirudhrb.com;
        spf=pass  smtp.mailfrom=mail@anirudhrb.com;
        dmarc=pass header.from=<mail@anirudhrb.com> header.from=<mail@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1620327428;
        s=zoho; d=anirudhrb.com; i=mail@anirudhrb.com;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding;
        bh=S+/94991o1BPiFbH+TJfvpYPY1OSzgLbNS+l1MvqNzI=;
        b=Nh8+nb5lG3a0wqCTMX6dAe2KpiIu1tdCJx4BP7wZlIXXTvP3s2mYprewlfacOEq5
        zZbr/IIRN7r/+EkEnq0PWKcbZSelD6ZkoWPy1LyrCLNbUjWnBRt0/RT7gPFWhfQETTZ
        V9k+OBJR6beL8BA5jR6i5+lRalJWb9Ive1Xj3J/I=
Received: from localhost.localdomain (49.207.210.243 [49.207.210.243]) by mx.zohomail.com
        with SMTPS id 1620327425374247.44938551593918; Thu, 6 May 2021 11:57:05 -0700 (PDT)
From:   Anirudh Rayabharam <mail@anirudhrb.com>
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Dave Kleikamp <shaggy@austin.ibm.com>,
        Alex Tomas <alex@clusterfs.com>, Andrew Morton <akpm@osdl.org>
Cc:     gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Anirudh Rayabharam <mail@anirudhrb.com>,
        syzbot+2dcfeaf8cb49b05e8f1a@syzkaller.appspotmail.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ext4: fix kernel infoleak via ext4_extent_header
Date:   Fri,  7 May 2021 00:26:54 +0530
Message-Id: <20210506185655.7118-1-mail@anirudhrb.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Initialize eh_generation of struct ext4_extent_header to prevent leaking
info to userspace. Fixes KMSAN kernel-infoleak bug reported by syzbot at:
http://syzkaller.appspot.com/bug?id=78e9ad0e6952a3ca16e8234724b2fa92d041b9b8

Reported-by: syzbot+2dcfeaf8cb49b05e8f1a@syzkaller.appspotmail.com
Fixes: a86c61812637 ("[PATCH] ext3: add extent map support")
Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
---

Changes in v2:
Added a "Fixes:" tag.

v1: https://lore.kernel.org/lkml/20210505133011.32484-1-mail@anirudhrb.com/

---
 fs/ext4/extents.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 77c84d6f1af6..677d4821bcc1 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -825,6 +825,7 @@ void ext4_ext_tree_init(handle_t *handle, struct inode *inode)
 	eh->eh_entries = 0;
 	eh->eh_magic = EXT4_EXT_MAGIC;
 	eh->eh_max = cpu_to_le16(ext4_ext_space_root(inode, 0));
+	eh->eh_generation = 0;
 	ext4_mark_inode_dirty(handle, inode);
 }
 
@@ -1090,6 +1091,7 @@ static int ext4_ext_split(handle_t *handle, struct inode *inode,
 	neh->eh_max = cpu_to_le16(ext4_ext_space_block(inode, 0));
 	neh->eh_magic = EXT4_EXT_MAGIC;
 	neh->eh_depth = 0;
+	neh->eh_generation = 0;
 
 	/* move remainder of path[depth] to the new leaf */
 	if (unlikely(path[depth].p_hdr->eh_entries !=
@@ -1167,6 +1169,7 @@ static int ext4_ext_split(handle_t *handle, struct inode *inode,
 		neh->eh_magic = EXT4_EXT_MAGIC;
 		neh->eh_max = cpu_to_le16(ext4_ext_space_block_idx(inode, 0));
 		neh->eh_depth = cpu_to_le16(depth - i);
+		neh->eh_generation = 0;
 		fidx = EXT_FIRST_INDEX(neh);
 		fidx->ei_block = border;
 		ext4_idx_store_pblock(fidx, oldblock);
-- 
2.26.2

