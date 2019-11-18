Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64D8FFFDC0
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Nov 2019 06:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfKRFLQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 18 Nov 2019 00:11:16 -0500
Received: from sender3-of-o52.zoho.com.cn ([124.251.121.247]:21961 "EHLO
        sender2.zoho.com.cn" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725816AbfKRFLP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 18 Nov 2019 00:11:15 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1574053816; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=nOqkrGkbDhtS3JDMvQRPuCCRI17CD3aKZSTRZtWSBRtIjONCrKc6v+eLP7IuCi+Tkb0VZoRzf+u9HRwRyoZxjpE3o/LBCY/xtjVY9lmLKSyHDBAtPBSmHY/MkEagt4xEyqco26PSMXg93wv5ol1WfKIHQt+zoEOWThlUcRAGN+8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1574053816; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=BsgB+uLSbI/A7RpGrDvhjCegyC49pCxyhfWI2lOuUfk=; 
        b=PTPwfFgv2WlRWueS8Em/r/X8tv6FghRBaJJqvDQHrdYADltuXdTTk+PPpD9x7DXGGxiajBFuHx+ywgo4prEMy5XC3vRT4LdJwBbfwIffx2ETasq8EpSMJaSyDqKAEK4aliVEMaWCccd8f334fuTtopvX2yodxA6oYCsKxH3LQIs=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1574053816;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding;
        l=1765; bh=BsgB+uLSbI/A7RpGrDvhjCegyC49pCxyhfWI2lOuUfk=;
        b=Hd4TEPjE8y+eT9uAecADUdrpdpM8idvHMa1WowClTYYDjvX+VFqMB/ZTpEKHKjQi
        efzGVbutkWe2JrkyEhT91eL6JxU5nE58/YJUeOzq8cRZoz3qf/lUNAW3IQPj19sZVxj
        2ViUFwDHjLT3p5JQPt2yg7VxII6IbzbJfqaDVpmA=
Received: from localhost.localdomain (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 1574053813058511.6204774440098; Mon, 18 Nov 2019 13:10:13 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org
Cc:     darrick.wong@oracle.com, jaegeuk@kernel.org, chao@kernel.org,
        tytso@mit.edu, adilger.kernel@dilger.ca,
        Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20191118050949.15629-1-cgxu519@mykernel.net>
Subject: [RFC PATCH 1/3] ext4: show prjquota info on statfs for a file
Date:   Mon, 18 Nov 2019 13:09:47 +0800
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Currently we replace filesystem statistics using prjquota info
on statfs when specified directory has project id inherit flag.
However, statfs on a file(accurately non-dir) which is under the
project quota dir(with inherit flag) still shows whole filesystem
statistics. In container use case, it will give container user
inconsistent experience and cause confusion about available free
space.

Detail info like below:
We use project quota to limit disk space usage for a container
and run df command inside container.

Run df on a directory:

[root /]# df -h /etc/
Filesystem=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Size=C2=A0 Used Avail Use% Mounted=
 on
kataShared=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.0G=C2=A0=C2=A0 13M 1012M=C2=A0=
=C2=A0 2% /

Run df on a file:

[root /]# df -h /etc/exports
Filesystem=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Size=C2=A0 Used Avail Use% Mounted=
 on
kataShared=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.5T=C2=A0 778M=C2=A0 1.5T=C2=A0=
=C2=A0 1% /

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/ext4/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index dd654e53ba3d..3fba22b54f5c 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5607,7 +5607,8 @@ static int ext4_statfs(struct dentry *dentry, struct =
kstatfs *buf)
 =09buf->f_fsid.val[1] =3D (fsid >> 32) & 0xFFFFFFFFUL;
=20
 #ifdef CONFIG_QUOTA
-=09if (ext4_test_inode_flag(dentry->d_inode, EXT4_INODE_PROJINHERIT) &&
+=09if ((ext4_test_inode_flag(dentry->d_inode, EXT4_INODE_PROJINHERIT) ||
+=09     !S_ISDIR(dentry->d_inode->i_mode)) &&
 =09    sb_has_quota_limits_enabled(sb, PRJQUOTA))
 =09=09ext4_statfs_project(sb, EXT4_I(dentry->d_inode)->i_projid, buf);
 #endif
--=20
2.20.1



