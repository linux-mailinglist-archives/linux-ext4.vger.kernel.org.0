Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 335BC373C6A
	for <lists+linux-ext4@lfdr.de>; Wed,  5 May 2021 15:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbhEENbc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 May 2021 09:31:32 -0400
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21395 "EHLO
        sender4-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbhEENbc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 May 2021 09:31:32 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1620221430; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=cMazpHma65TSqD7qq8XBIzStM7ip2vILomjQD5sFvmMilQrBislWMCky3ct1/tDQ/p36gAsviNtEaZDnmQi7X4Fx4czWYYdCQbQt9CmTJERx+6dETsCFGHQZQd2Q5gQtaDzKCIklji9FltEL+fD+1Kcn2fTvfcMMgFIDVzEWoM8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1620221430; h=Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=9uG1f+RLlDAAS4typJtcpWBOatS43T1L//FcR3zSh2o=; 
        b=cUiOmCU1I5Z+EGeBuga0Xd0p3SRw2buLByl4Z5GjprpYYPgd5P9HQ99lEiaqHi75ZwlNHf1ISK/Lr+BH6i/iMlLx8q6C6ymg/fX5tKq2IYSNfh3fmD3c4s2yZva8QLpqeSvvn8WrMGO2O1+wcVuHVfLjFlBBuGxO+Bn3GXSC14g=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=anirudhrb.com;
        spf=pass  smtp.mailfrom=mail@anirudhrb.com;
        dmarc=pass header.from=<mail@anirudhrb.com> header.from=<mail@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1620221430;
        s=zoho; d=anirudhrb.com; i=mail@anirudhrb.com;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding;
        bh=9uG1f+RLlDAAS4typJtcpWBOatS43T1L//FcR3zSh2o=;
        b=I5CqSRLnEGVbnGZJsH7vsSDC6J6p1d1FtIReuoUqvffwYK99riwYu9nXc9D+3vjZ
        uRg6HGsQqCW9OdeISRDDmpotX12ASLl/RCENXHdyIZeQC8q0/j1ECyYXEZTS0nY0zOh
        9mT7e59xvTr97sM2cypWQmgXCMLuSRg1tf8YJnxk=
Received: from localhost.localdomain (49.207.214.47 [49.207.214.47]) by mx.zohomail.com
        with SMTPS id 1620221421007420.2082576559726; Wed, 5 May 2021 06:30:21 -0700 (PDT)
From:   Anirudh Rayabharam <mail@anirudhrb.com>
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Anirudh Rayabharam <mail@anirudhrb.com>,
        syzbot+2dcfeaf8cb49b05e8f1a@syzkaller.appspotmail.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ext4: fix kernel infoleak via ext4_extent_header
Date:   Wed,  5 May 2021 19:00:10 +0530
Message-Id: <20210505133011.32484-1-mail@anirudhrb.com>
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
Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
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

