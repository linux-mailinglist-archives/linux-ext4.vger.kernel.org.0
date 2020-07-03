Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B89213A31
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Jul 2020 14:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbgGCMod (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 3 Jul 2020 08:44:33 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17092 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726022AbgGCMod (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 3 Jul 2020 08:44:33 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1593780262; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=awtWHkX2Gtor9cBp6VKzs01aIwf+1O4lmxp3jQQP6oA2sx7SnYKF7SsfQkJmjoYXeJJKDdbZUWYv4/ZZhJGksACPgpwRi7QFy6INCq2X+BUy0sZjYT9fhHi2W6VM9zlT25gG/ZKY1mrUtnnEyFGK0KLLM3lyhk32wZ8u+VKM2U0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1593780262; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=+776UubO9xKJt11T+eSR9elk68neOsQ3ppNGtaERMqQ=; 
        b=os9VZ9upSJo/phguRmS20WaUBhtyCwH8JyopWxYDsqDBjRXkL+bZ2/Cl6fbj9seK559XVQWcUtTm8Yc10MWaFxZzkNZfHawWzMa69ZRzpiOpnt2a5QDCdttJDaTXT/p1NTRIfnCU1HZPW0AFncwekK3zfl8gGNLQ7rs21bBe68Y=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1593780262;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=+776UubO9xKJt11T+eSR9elk68neOsQ3ppNGtaERMqQ=;
        b=TvLIdDv+5UUoIFaKCJwVTRbUNMyRFpkHblhgqY4/JjlwJGJ5upcyY+yBc4mckxMV
        0hohHkwQfCqduIybWP/4MCVpoOuv9HH0Fu6tFl60tettAuwEjpbt6pDtX6wo+5w5p/6
        qjITjachKr4x/CKeOmwEHwo1yYjUjUSCwm8qd9wI=
Received: from localhost.localdomain (113.116.49.35 [113.116.49.35]) by mx.zoho.com.cn
        with SMTPS id 1593780261497449.6164064847354; Fri, 3 Jul 2020 20:44:21 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     jack@suse.cz
Cc:     linux-ext4@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20200703124411.24085-1-cgxu519@mykernel.net>
Subject: [PATCH v2] ext2: fix some incorrect comments in inode.c
Date:   Fri,  3 Jul 2020 20:44:11 +0800
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

There are some incorrect comments in inode.c, so fix them
properly.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
v1->v2:
- Fix incorrect comment for ext2_blks_to_allocate() instead of
deleting it.
- Fix incorrect comment for ext2_alloc_blocks().

 fs/ext2/inode.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index c8b371c82b4f..80662e1f7889 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -356,8 +356,7 @@ static inline ext2_fsblk_t ext2_find_goal(struct inode =
*inode, long block,
  *=09@blks: number of data blocks to be mapped.
  *=09@blocks_to_boundary:  the offset in the indirect block
  *
- *=09return the total number of blocks to be allocate, including the
- *=09direct and indirect blocks.
+ *=09return the number of direct blocks to allocate.
  */
 static int
 ext2_blks_to_allocate(Indirect * branch, int k, unsigned long blks,
@@ -390,11 +389,9 @@ ext2_blks_to_allocate(Indirect * branch, int k, unsign=
ed long blks,
  *=09ext2_alloc_blocks: multiple allocate blocks needed for a branch
  *=09@indirect_blks: the number of blocks need to allocate for indirect
  *=09=09=09blocks
- *
+ *=09@blks: the number of blocks need to allocate for direct blocks
  *=09@new_blocks: on return it will store the new block numbers for
  *=09the indirect blocks(if needed) and the first direct block,
- *=09@blks:=09on return it will store the total number of allocated
- *=09=09direct blocks
  */
 static int ext2_alloc_blocks(struct inode *inode,
 =09=09=09ext2_fsblk_t goal, int indirect_blks, int blks,
--=20
2.20.1


