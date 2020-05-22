Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAFF51DDF07
	for <lists+linux-ext4@lfdr.de>; Fri, 22 May 2020 06:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgEVE4A (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 22 May 2020 00:56:00 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17108 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726404AbgEVE4A (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 22 May 2020 00:56:00 -0400
X-Greylist: delayed 906 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 May 2020 00:55:58 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1590122448; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=he6nu6wkE+XYo2JvcvjAilg5UOMSuG+lQgotqaBFg28g8ZGIVL/yMUhtaJkZ1rGl1fmdQH05XmPMau9XePjAGVzTvsEljXrG+WU/9PzwN9MKGjZdLBYatA1bn/UvyeFGwCeDYWyVtgtUQLARsJ/7Krfgd+sHZt+XIlZ4mP5eKJY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1590122448; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=6ampF46FIPZidEcIeoRzm542SN45rKX0OotH3WJOgpM=; 
        b=Z/mJnOZHTRO9Za7PiC9PCiecffdPD80C1wzurDYFLCh/FJLJBv89q/RO0FCC5P+Z8YewgX4qJhXlq13nqn7veT72c9K//nKru3sABA4ooIt0RuZ8LnEmC9binwO6++D7Eg0KHrrUoEIBJmxb7l5LQRL+Niry9hJqUq9/IK/JSTs=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1590122448;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=6ampF46FIPZidEcIeoRzm542SN45rKX0OotH3WJOgpM=;
        b=YLESegDjkXNANSrKu1uo2aEJHJLPCKA1FQhhryGIRyj+ttL8GILXp0Ed2Wp+rPsT
        RmyF3L4EqfYcsVUbgvjG2BEyUX+kPxQu0fykBBszSLeXm78hTNAfwRzwK8ENCVtbk30
        hkrydUSL4P2M62aMq5zyjcHTUGoNqi7jtCjNJb6U=
Received: from localhost.localdomain (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 1590122447860348.83208081168164; Fri, 22 May 2020 12:40:47 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     jack@suse.com
Cc:     linux-ext4@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20200522044035.24190-2-cgxu519@mykernel.net>
Subject: [PATCH 2/2] ext2: code cleanup by removing ifdef macro surrounding
Date:   Fri, 22 May 2020 12:40:35 +0800
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200522044035.24190-1-cgxu519@mykernel.net>
References: <20200522044035.24190-1-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Define ext2_listxattr to NULL when CONFIG_EROFS_FS_XATTR
is not enabled, then we can remove many ugly ifdef macros
in the code.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/ext2/file.c    | 2 --
 fs/ext2/namei.c   | 4 ----
 fs/ext2/symlink.c | 4 ----
 fs/ext2/xattr.h   | 1 +
 4 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/fs/ext2/file.c b/fs/ext2/file.c
index 39c4772e96c9..b4de9a0f170d 100644
--- a/fs/ext2/file.c
+++ b/fs/ext2/file.c
@@ -196,9 +196,7 @@ const struct file_operations ext2_file_operations =3D {
 };
=20
 const struct inode_operations ext2_file_inode_operations =3D {
-#ifdef CONFIG_EXT2_FS_XATTR
 =09.listxattr=09=3D ext2_listxattr,
-#endif
 =09.getattr=09=3D ext2_getattr,
 =09.setattr=09=3D ext2_setattr,
 =09.get_acl=09=3D ext2_get_acl,
diff --git a/fs/ext2/namei.c b/fs/ext2/namei.c
index 1a5421a34ef7..ba3e3e075891 100644
--- a/fs/ext2/namei.c
+++ b/fs/ext2/namei.c
@@ -411,9 +411,7 @@ const struct inode_operations ext2_dir_inode_operations=
 =3D {
 =09.rmdir=09=09=3D ext2_rmdir,
 =09.mknod=09=09=3D ext2_mknod,
 =09.rename=09=09=3D ext2_rename,
-#ifdef CONFIG_EXT2_FS_XATTR
 =09.listxattr=09=3D ext2_listxattr,
-#endif
 =09.getattr=09=3D ext2_getattr,
 =09.setattr=09=3D ext2_setattr,
 =09.get_acl=09=3D ext2_get_acl,
@@ -422,9 +420,7 @@ const struct inode_operations ext2_dir_inode_operations=
 =3D {
 };
=20
 const struct inode_operations ext2_special_inode_operations =3D {
-#ifdef CONFIG_EXT2_FS_XATTR
 =09.listxattr=09=3D ext2_listxattr,
-#endif
 =09.getattr=09=3D ext2_getattr,
 =09.setattr=09=3D ext2_setattr,
 =09.get_acl=09=3D ext2_get_acl,
diff --git a/fs/ext2/symlink.c b/fs/ext2/symlink.c
index 00cdb8679486..948d3a441403 100644
--- a/fs/ext2/symlink.c
+++ b/fs/ext2/symlink.c
@@ -25,16 +25,12 @@ const struct inode_operations ext2_symlink_inode_operat=
ions =3D {
 =09.get_link=09=3D page_get_link,
 =09.getattr=09=3D ext2_getattr,
 =09.setattr=09=3D ext2_setattr,
-#ifdef CONFIG_EXT2_FS_XATTR
 =09.listxattr=09=3D ext2_listxattr,
-#endif
 };
 =20
 const struct inode_operations ext2_fast_symlink_inode_operations =3D {
 =09.get_link=09=3D simple_get_link,
 =09.getattr=09=3D ext2_getattr,
 =09.setattr=09=3D ext2_setattr,
-#ifdef CONFIG_EXT2_FS_XATTR
 =09.listxattr=09=3D ext2_listxattr,
-#endif
 };
diff --git a/fs/ext2/xattr.h b/fs/ext2/xattr.h
index 16272e6ddcf4..7925f596e8e2 100644
--- a/fs/ext2/xattr.h
+++ b/fs/ext2/xattr.h
@@ -100,6 +100,7 @@ static inline void ext2_xattr_destroy_cache(struct mb_c=
ache *cache)
 }
=20
 #define ext2_xattr_handlers NULL
+#define ext2_listxattr NULL
=20
 # endif  /* CONFIG_EXT2_FS_XATTR */
=20
--=20
2.20.1


