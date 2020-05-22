Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3CC1DDF08
	for <lists+linux-ext4@lfdr.de>; Fri, 22 May 2020 06:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgEVE4C (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 22 May 2020 00:56:02 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17170 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726421AbgEVE4C (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 22 May 2020 00:56:02 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1590122447; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=lJcr7vXpK40LMj5JvsWjdAj6Nq4q7wa1WUgvulpKG6OrsQdKs7ZXO/i+96cyLRk4Lfv5+gzUYOTmF/OCxPA8e3/aiq4/zNAy1GYoo95KuUetd7VydcMbiE/5bnnDsSRCNG0uXroVRGu4b/g+ppmDnOsa4PAWxODJe62N+d9+pPw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1590122447; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=0TUX0uJD+XsSVxCFSykWLZrCh6BscwdhEbIJbkQTBuw=; 
        b=OWwQRR391lz+uSpnNoB72OW4YB2vjPbiLKKFai3xxuKpQ93laaYaCaNpD9lHg1rltPXSg32frSm8eOjOQW+alhB0AJjxqscMPyAH5rHfFbS5LWUz7nem4ouItm01P1tTc6QPqfPd9hLSQpjzS3YTQ2poaRxd+qnH8w7YZGX/ujw=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1590122447;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=0TUX0uJD+XsSVxCFSykWLZrCh6BscwdhEbIJbkQTBuw=;
        b=LZNhGeFLHPmkJE3l9Zt8p1ndm05hH/tFjgmZuy7xAt94mGgAFmdYQS7NVXozJw+r
        vcCOmnfkAhA/HOjqFFKbjrHy9DsHRSVvjAx6tqCf8X7ki6d/9Zx5CmlW/xY9eHezWD9
        oQRuSAPFSunNuicu1hekDQwoPtpYMsfgt0qbZ9Ok=
Received: from localhost.localdomain (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 1590122444475531.2078805086636; Fri, 22 May 2020 12:40:44 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     jack@suse.com
Cc:     linux-ext4@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20200522044035.24190-1-cgxu519@mykernel.net>
Subject: [PATCH 1/2] ext2: fix incorrect i_op for special inode
Date:   Fri, 22 May 2020 12:40:34 +0800
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

We should always set &ext2_special_inode_operations to i_op
for special inode regardless of CONFIG_EXT2_FS_XATTR setting.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/ext2/namei.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/ext2/namei.c b/fs/ext2/namei.c
index ccfbbf59e2fc..1a5421a34ef7 100644
--- a/fs/ext2/namei.c
+++ b/fs/ext2/namei.c
@@ -136,9 +136,7 @@ static int ext2_mknod (struct inode * dir, struct dentr=
y *dentry, umode_t mode,
 =09err =3D PTR_ERR(inode);
 =09if (!IS_ERR(inode)) {
 =09=09init_special_inode(inode, inode->i_mode, rdev);
-#ifdef CONFIG_EXT2_FS_XATTR
 =09=09inode->i_op =3D &ext2_special_inode_operations;
-#endif
 =09=09mark_inode_dirty(inode);
 =09=09err =3D ext2_add_nondir(dentry, inode);
 =09}
--=20
2.20.1


