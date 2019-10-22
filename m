Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0DEEDFE07
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Oct 2019 09:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387861AbfJVHLR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 22 Oct 2019 03:11:17 -0400
Received: from sender2-of-o52.zoho.com.cn ([163.53.93.247]:21168 "EHLO
        sender2-of-o52.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387912AbfJVHLQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 22 Oct 2019 03:11:16 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571728272; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=GOgEZxHbe+RqhFIqjm9mXRMvNJ7Pjhu8fwcp0ax3WXdCO+P1ybVP4CeN9/D/5KMA/2m1ECDJTl1xQ54wywwxCMJl6ysvQ+g+1S7B3FrwqQN/Prsd2P9Mj9tjTT2gmS6uk6JpIdJSgwuFGGfJVFL3bS4aGUDCWC6PxP8dBTfDi/k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1571728272; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=CWCXedvo8wRxfe1bBXXQ8gL71I2q+SfMrFF94IqQN/0=; 
        b=WBKvKBgvIKA7w2+NF2wBFIsmZymnP4q5EB1IAeqrXR7ogwX9p/PMCsSZA4quoDGLLDm9+i9oqNndmIQdg9aMGGJPUmHaGBaFf5gzDUHKXwFVnanoFKWScsgWuuOdcbl+7EIb1oPeUzzXEYWuW1KLDCiPEezz7eCntAquBfJSLVE=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1571728272;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        l=709; bh=CWCXedvo8wRxfe1bBXXQ8gL71I2q+SfMrFF94IqQN/0=;
        b=Q+Z79IGUAdZ/WztR3nrIXtQANjG9CjOkN7rE36eAxgWB+ip+DdwejcOnBLpgbJlG
        KF1pSSapUCvG6LwpLCLJ/AKUkFz5ZlIFyJggo6hnWIJi3BXMHLPrl8HB+FjCFxXJH3r
        Gl6+FCD1oM5fi48/JdkFb7ud7X0n3SxizHd9hMWI=
Received: from localhost.localdomain (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 1571728269864160.1340497698369; Tue, 22 Oct 2019 15:11:09 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     jack@suse.com
Cc:     linux-ext4@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20191022071045.7311-1-cgxu519@mykernel.net>
Subject: [PATCH] ext2: add missing brelse in ext2_new_blocks()
Date:   Tue, 22 Oct 2019 15:10:45 +0800
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

There is a missing brelse of bitmap_bh in the
case of retry.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/ext2/balloc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ext2/balloc.c b/fs/ext2/balloc.c
index 924c1c765306..e8eedad479a7 100644
--- a/fs/ext2/balloc.c
+++ b/fs/ext2/balloc.c
@@ -1313,6 +1313,7 @@ ext2_fsblk_t ext2_new_blocks(struct inode *inode, ext=
2_fsblk_t goal,
 =09if (free_blocks > 0) {
 =09=09grp_target_blk =3D ((goal - le32_to_cpu(es->s_first_data_block)) %
 =09=09=09=09EXT2_BLOCKS_PER_GROUP(sb));
+=09=09brelse(bitmap_bh);
 =09=09bitmap_bh =3D read_block_bitmap(sb, group_no);
 =09=09if (!bitmap_bh)
 =09=09=09goto io_error;
--=20
2.20.1



