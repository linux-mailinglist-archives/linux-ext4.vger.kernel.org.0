Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCF8E1D75
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Oct 2019 15:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406263AbfJWN5W (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 23 Oct 2019 09:57:22 -0400
Received: from sender2-of-o52.zoho.com.cn ([163.53.93.247]:21057 "EHLO
        sender2-of-o52.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405260AbfJWN5W (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 23 Oct 2019 09:57:22 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571839028; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=dOD7L7fshLb4ZxoBS0HWdPcMBSwMQXx2vRxF8Mjd5kE1GjGB5wyHIK85dSa02hHV+VPuIGXD/cLREGuesHhEThPNgYk8bkAbbhUiNJfAAdsYR/qq4v8ROeFPyfnRkdg9B5y/NCSKBzt1BcCv0zXtJq5f/ahp/OrpcVl1qh/nVak=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1571839028; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=r/VPlG00fukPgk0RE7nUzAUnYuC2Vx0+b2N/mY3fB6g=; 
        b=Z+kY+iz/L+JVh0u4ZkfzFCDjxbpQxG75K0VdDwxF/Isvhd+lYgDk2L249K8buOuh4es/9het8Nc5pezB5krr7XgczJ8yLxD+3HELtwqGP5Ag1Di2S+B661rtBcAniqpyKDafs1tcTiwgKCN19bDReBNhFnTFkfu1z8vnn1AueeY=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1571839028;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        l=940; bh=r/VPlG00fukPgk0RE7nUzAUnYuC2Vx0+b2N/mY3fB6g=;
        b=UQJ/TXuckIMyhU0AV+KBbZbdA7dO28nTifmCGLVhItC20SqHADdCEZxaJjxf9KbC
        U8U+8HwjchEmG8/uXRynQRWZesgn1ZOQGILeBL/LjK+IU83DM/f/ANe+Zpag5CpKHoN
        F8a1nsHWYyHqhqeSIS1nnXbSUIKRCpAwhFdpgIFU=
Received: from localhost.localdomain (113.116.156.62 [113.116.156.62]) by mx.zoho.com.cn
        with SMTPS id 1571839025106266.214635017231; Wed, 23 Oct 2019 21:57:05 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     jack@suse.com
Cc:     linux-ext4@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20191023135643.28837-1-cgxu519@mykernel.net>
Subject: [PATCH] ext2: return error when fail to allocating memory in ioctl
Date:   Wed, 23 Oct 2019 21:56:43 +0800
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Currently, we do not check memory allocation
result for ei->i_block_alloc_info in ioctl,
this patch checks it and returns error in
failure case.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/ext2/ioctl.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ext2/ioctl.c b/fs/ext2/ioctl.c
index 1b853fb0b163..32a8d10b579d 100644
--- a/fs/ext2/ioctl.c
+++ b/fs/ext2/ioctl.c
@@ -145,10 +145,13 @@ long ext2_ioctl(struct file *filp, unsigned int cmd, =
unsigned long arg)
 =09=09if (ei->i_block_alloc_info){
 =09=09=09struct ext2_reserve_window_node *rsv =3D &ei->i_block_alloc_info-=
>rsv_window_node;
 =09=09=09rsv->rsv_goal_size =3D rsv_window_size;
+=09=09} else {
+=09=09=09ret =3D -ENOMEM;
 =09=09}
+
 =09=09mutex_unlock(&ei->truncate_mutex);
 =09=09mnt_drop_write_file(filp);
-=09=09return 0;
+=09=09return ret;
 =09}
 =09default:
 =09=09return -ENOTTY;
--=20
2.21.0



