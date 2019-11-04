Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7FCEEDF55
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Nov 2019 12:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbfKDL4T (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 4 Nov 2019 06:56:19 -0500
Received: from sender3-of-o52.zoho.com.cn ([124.251.121.247]:21931 "EHLO
        sender2.zoho.com.cn" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728346AbfKDL4S (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 4 Nov 2019 06:56:18 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1572867660; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=q9LnFowmEN9JUzdmDLuiwIKCyMLD9ZOsmu9uoms84WLi7MhgLYhCAMuSIgiLvIQyXUtS/rBmH0wL3u36EK6XM/4CdwWgz+GJU+y3EQXmJjWeOl/jSXGA7CFrcxuPh5f4ppOvbAZRAkJnN62NqxBtC1wjJcpmnhw8Ct1U7zue24w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1572867660; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=CMQuzlno95XbIzQ1wuAOAASx9zQo5tfKqr71pMmWDvU=; 
        b=L6aZvMXH75RhqFFBQ/Bi0oPbKgy3vqszOd6J9n7bImXlySQ0uYYGrZVJp+dnaTUAy8Pk3Wn26v4eseKVG8D2BGnwxhun6SAwhIn2vO+z4u1HzBZwqZzkq9qsWAjF+2WgzZUbDGSDbWUxHf/trXMEOFP2TTKeROIPWsd6YZRst3A=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1572867660;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        l=4212; bh=CMQuzlno95XbIzQ1wuAOAASx9zQo5tfKqr71pMmWDvU=;
        b=e+DcnTCMLMiccl3Vf9f5FH/oc7FibsSfSt0WehQzSya6nA8xiyVLr7uoTjTkqa4r
        KNuwMtzVbNpPZIZ6wMHcS/GnmY6e8t23b2hHb9d+H/JOxSqByvT5nxiLP6PXTCeJN77
        n1+V7MA43OMPJ1dDV5gORl0YR6eMYgHN30WHxxrM=
Received: from localhost.localdomain (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 15728676596340.035362748932016075; Mon, 4 Nov 2019 19:40:59 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     jack@suse.com
Cc:     linux-ext4@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20191104114036.9893-2-cgxu519@mykernel.net>
Subject: [PATCH 2/5] ext2: code cleanup by calling ext2_group_last_block_no()
Date:   Mon,  4 Nov 2019 19:40:33 +0800
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191104114036.9893-1-cgxu519@mykernel.net>
References: <20191104114036.9893-1-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Call common helper ext2_group_last_block_no() to
calculate group last block number.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/ext2/balloc.c | 16 ++++++++--------
 fs/ext2/super.c  |  8 +-------
 2 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/fs/ext2/balloc.c b/fs/ext2/balloc.c
index 19bce75d207b..994a1fd18e93 100644
--- a/fs/ext2/balloc.c
+++ b/fs/ext2/balloc.c
@@ -269,7 +269,7 @@ goal_in_my_reservation(struct ext2_reserve_window *rsv,=
 ext2_grpblk_t grp_goal,
 =09ext2_fsblk_t group_first_block, group_last_block;
=20
 =09group_first_block =3D ext2_group_first_block_no(sb, group);
-=09group_last_block =3D group_first_block + EXT2_BLOCKS_PER_GROUP(sb) - 1;
+=09group_last_block =3D ext2_group_last_block_no(sb, group);
=20
 =09if ((rsv->_rsv_start > group_last_block) ||
 =09    (rsv->_rsv_end < group_first_block))
@@ -666,22 +666,22 @@ ext2_try_to_allocate(struct super_block *sb, int grou=
p,
 =09=09=09unsigned long *count,
 =09=09=09struct ext2_reserve_window *my_rsv)
 {
-=09ext2_fsblk_t group_first_block;
+=09ext2_fsblk_t group_first_block =3D ext2_group_first_block_no(sb, group)=
;
+=09ext2_fsblk_t group_last_block =3D ext2_group_last_block_no(sb, group);
        =09ext2_grpblk_t start, end;
 =09unsigned long num =3D 0;
=20
 =09/* we do allocation within the reservation window if we have a window *=
/
 =09if (my_rsv) {
-=09=09group_first_block =3D ext2_group_first_block_no(sb, group);
 =09=09if (my_rsv->_rsv_start >=3D group_first_block)
 =09=09=09start =3D my_rsv->_rsv_start - group_first_block;
 =09=09else
 =09=09=09/* reservation window cross group boundary */
 =09=09=09start =3D 0;
 =09=09end =3D my_rsv->_rsv_end - group_first_block + 1;
-=09=09if (end > EXT2_BLOCKS_PER_GROUP(sb))
+=09=09if (end > group_last_block - group_first_block + 1)
 =09=09=09/* reservation window crosses group boundary */
-=09=09=09end =3D EXT2_BLOCKS_PER_GROUP(sb);
+=09=09=09end =3D group_last_block - group_first_block + 1;
 =09=09if ((start <=3D grp_goal) && (grp_goal < end))
 =09=09=09start =3D grp_goal;
 =09=09else
@@ -691,7 +691,7 @@ ext2_try_to_allocate(struct super_block *sb, int group,
 =09=09=09start =3D grp_goal;
 =09=09else
 =09=09=09start =3D 0;
-=09=09end =3D EXT2_BLOCKS_PER_GROUP(sb);
+=09=09end =3D group_last_block - group_first_block + 1;
 =09}
=20
 =09BUG_ON(start > EXT2_BLOCKS_PER_GROUP(sb));
@@ -907,7 +907,7 @@ static int alloc_new_reservation(struct ext2_reserve_wi=
ndow_node *my_rsv,
 =09spinlock_t *rsv_lock =3D &EXT2_SB(sb)->s_rsv_window_lock;
=20
 =09group_first_block =3D ext2_group_first_block_no(sb, group);
-=09group_end_block =3D group_first_block + (EXT2_BLOCKS_PER_GROUP(sb) - 1)=
;
+=09group_end_block =3D ext2_group_last_block_no(sb, group);
=20
 =09if (grp_goal < 0)
 =09=09start_block =3D group_first_block;
@@ -1114,7 +1114,7 @@ ext2_try_to_allocate_with_rsv(struct super_block *sb,=
 unsigned int group,
 =09 * first block is the block number of the first block in this group
 =09 */
 =09group_first_block =3D ext2_group_first_block_no(sb, group);
-=09group_last_block =3D group_first_block + (EXT2_BLOCKS_PER_GROUP(sb) - 1=
);
+=09group_last_block =3D ext2_group_last_block_no(sb, group);
=20
 =09/*
 =09 * Basically we will allocate a new block from inode's reservation
diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 30c630d73f0f..4cd401a2f207 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -702,13 +702,7 @@ static int ext2_check_descriptors(struct super_block *=
sb)
 =09for (i =3D 0; i < sbi->s_groups_count; i++) {
 =09=09struct ext2_group_desc *gdp =3D ext2_get_group_desc(sb, i, NULL);
 =09=09ext2_fsblk_t first_block =3D ext2_group_first_block_no(sb, i);
-=09=09ext2_fsblk_t last_block;
-
-=09=09if (i =3D=3D sbi->s_groups_count - 1)
-=09=09=09last_block =3D le32_to_cpu(sbi->s_es->s_blocks_count) - 1;
-=09=09else
-=09=09=09last_block =3D first_block +
-=09=09=09=09(EXT2_BLOCKS_PER_GROUP(sb) - 1);
+=09=09ext2_fsblk_t last_block =3D ext2_group_last_block_no(sb, i);
=20
 =09=09if (le32_to_cpu(gdp->bg_block_bitmap) < first_block ||
 =09=09    le32_to_cpu(gdp->bg_block_bitmap) > last_block)
--=20
2.20.1



