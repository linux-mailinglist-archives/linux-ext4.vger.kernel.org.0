Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 857D620ABF0
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Jun 2020 07:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgFZFuV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 26 Jun 2020 01:50:21 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17150 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728012AbgFZFuV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 26 Jun 2020 01:50:21 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1593150613; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=BZ9Jp6Rww9yaIclh4XgDQB+LOPTZl7Xhwpbejbem/4bp5odHa4rDcES55auBIcU9+Usbpq/j3R1VQeDMcejjoVNQwtWbKmD0ccAzvMDrXLdzDVxaQwSNIeYy0/SdnzhVchkHfMi4KXdVc9+UY1y4Jjhg9bPHKZgYW87/C5t4Xvs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1593150613; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=Q/wZPfYcGHuLtlPMV76jVmP66spWX1/75D/PQMqytOc=; 
        b=cWgkAyo9yh/0SIVPOUbYrNvFk2kzXpuYtxiyecB+iYp84sSzID1eqsi9xBlc9VQnmp4VH+i8E9h6Kn5G4/0CyavRqWng/0StU2Bkpg05runP0Ajqx700FBeyMk3mXVorctHVklSWN9A4Q2k30wrEVLyMakUWTzK4XOfoZL+lK1o=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1593150613;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=Q/wZPfYcGHuLtlPMV76jVmP66spWX1/75D/PQMqytOc=;
        b=SW2jVGfhfR3/J1VuIkjWj32xxhJFiTFLuhDw57hCq//RXtuw3ErluDeDLpD7T6kc
        FbIpDo3gMteQ84x8YtfCOkkSDjxrXBPYJ133Aau8zeKI0QHvff4DD50QzzqX7VFDNn5
        RBlJYWJ1ElzPe9zIyWieH2kLpSIoWPufWB6OWds4=
Received: from localhost.localdomain (116.30.194.71 [116.30.194.71]) by mx.zoho.com.cn
        with SMTPS id 1593150610473828.0364217997824; Fri, 26 Jun 2020 13:50:10 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     jack@suse.com
Cc:     linux-ext4@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20200626054959.114177-1-cgxu519@mykernel.net>
Subject: [PATCH] ext2: initialize quota info in ext2_xattr_set()
Date:   Fri, 26 Jun 2020 13:49:59 +0800
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In order to correctly account/limit space usage, should initialize
quota info before calling quota related functions.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/ext2/xattr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
index 943cc469f42f..913e5c4921ec 100644
--- a/fs/ext2/xattr.c
+++ b/fs/ext2/xattr.c
@@ -437,6 +437,9 @@ ext2_xattr_set(struct inode *inode, int name_index, con=
st char *name,
 =09name_len =3D strlen(name);
 =09if (name_len > 255 || value_len > sb->s_blocksize)
 =09=09return -ERANGE;
+=09error =3D dquot_initialize(inode);
+=09if (error)
+=09=09return error;
 =09down_write(&EXT2_I(inode)->xattr_sem);
 =09if (EXT2_I(inode)->i_file_acl) {
 =09=09/* The inode already has an extended attribute block. */
--=20
2.26.2


