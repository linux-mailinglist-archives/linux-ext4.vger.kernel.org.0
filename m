Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB9921206D
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Jul 2020 11:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgGBJ5A (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 2 Jul 2020 05:57:00 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17035 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726089AbgGBJ5A (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 2 Jul 2020 05:57:00 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1593683809; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=gMBLrAphsYQ31KK/4lyoZoIdmCb/n1cU21y8gOW3QNmQWqZKSkbnEsEmr4divBl/NMDQ1i5vNjWxIPbE2xamsfl41bZDfTzWHTgHEXuZvUw0MajN/WVUHM+oQuYzx090AN1oXDqLF2kXlfuUlI5hO2RV6+svgAwSrDRsrwfiXW0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1593683809; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=Z1ka1j05ciHgcPs3j7u1x6fnqixZkAqedO9cZgmJrmU=; 
        b=TWADfK3g3da6VHVS/YzK1UrkzTjP0oXTegQL7SE5pYY2a2vVRvZjlB87HUaZItqNjr3Z6LdRTt3y3XqOXbLayE5ckji5n9KiiW8f9BzPBrxXRpIxeYxFZepj6ldinHQtqyslTjZHr6ta5JVAtHnB9S/heuqi7EGkv0vEujFrEd8=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1593683809;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=Z1ka1j05ciHgcPs3j7u1x6fnqixZkAqedO9cZgmJrmU=;
        b=VQ5M0PTw7uKA9gS3igKrVzWTJL+Uzw9Ld1J1I4Hs34CUBjwhJabU3EdOOB50gOQV
        rEdRyD1/TwLKZ+VGPF4NWswEkAf9Yu8yS8DBeglyrdX5ne3LKy2IVF6580WRSF5EmbP
        D5+TXqxWYmeQwnAFmIpx/1FEMy96RUF1XjMud6bk=
Received: from localhost.localdomain (113.116.50.61 [113.116.50.61]) by mx.zoho.com.cn
        with SMTPS id 15936838075831016.6098749097517; Thu, 2 Jul 2020 17:56:47 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     jack@suse.cz
Cc:     linux-ext4@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20200702095636.29246-1-cgxu519@mykernel.net>
Subject: [PATCH] ext2: delete incorrect comment for ext2_blks_to_allocate()
Date:   Thu,  2 Jul 2020 17:56:36 +0800
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

ext2_blks_to_allocate() only counts direct blocks need to be allocated,
return value does not include indirect blocks.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/ext2/inode.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index c8b371c82b4f..4df849e694dd 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -355,9 +355,6 @@ static inline ext2_fsblk_t ext2_find_goal(struct inode =
*inode, long block,
  *=09@k: number of blocks need for indirect blocks
  *=09@blks: number of data blocks to be mapped.
  *=09@blocks_to_boundary:  the offset in the indirect block
- *
- *=09return the total number of blocks to be allocate, including the
- *=09direct and indirect blocks.
  */
 static int
 ext2_blks_to_allocate(Indirect * branch, int k, unsigned long blks,
--=20
2.20.1


