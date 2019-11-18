Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4BCFFDC1
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Nov 2019 06:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfKRFLN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 18 Nov 2019 00:11:13 -0500
Received: from sender3-of-o52.zoho.com.cn ([124.251.121.247]:21962 "EHLO
        sender2.zoho.com.cn" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725934AbfKRFLN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 18 Nov 2019 00:11:13 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1574053820; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=O70woNDRmcMXazDUfoFGwElRurDEqQkMMtwkKp5K6lJNE3JlmbUwmddwyfDJ7Kkk5NEvifaMbe3QSg6S5Iv6S1jQYwHVE6d1/0UQ7O/xMDxDChXuolGDg50qnLURp0ieO5L6an++ZJmdOKHov5kAWqEcrQy87VGwPGrP2RT4zGY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1574053820; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=GDu82HfY7CnDAb1EdcuqFswUt9CFFN7VyyP2enB6TlQ=; 
        b=NDFYFZseRQVlvn4/MTP/3tm5xReBr2b8K0fkVe9XORh9WOWXlGgKFK4Poqc0odvNBXvnoxWJupOFspTrPLGsgl5L8vMj4wc2cPV2Dhk2Iwd7ERh1HPNWQtIZLW9WzYmgnq0cqPFlHanvOHDqjAiQQWS1CunrfKkT8g2lzoj2Y0o=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1574053820;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding;
        l=1682; bh=GDu82HfY7CnDAb1EdcuqFswUt9CFFN7VyyP2enB6TlQ=;
        b=SvQFCdziN57bDfl1glECMMWGyxlsxq9Aynk00GSL3RpiZdBV94P6CXT5PQ7cPCMs
        wN/J3OMCE6VSFOTFYPs2cvzwGGBK6Mzzx1e2xeeEmYZ7+14+K4gzJ04m7HZQNDFmtlr
        V4RcyxibAcDC8EEC3xIl29I12Q7l48+i8mv7Tutg=
Received: from localhost.localdomain (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 1574053818929531.7015154867489; Mon, 18 Nov 2019 13:10:18 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org
Cc:     darrick.wong@oracle.com, jaegeuk@kernel.org, chao@kernel.org,
        tytso@mit.edu, adilger.kernel@dilger.ca,
        Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20191118050949.15629-3-cgxu519@mykernel.net>
Subject: [RFC PATCH 3/3] xfs: show prjquota info on statfs for a file
Date:   Mon, 18 Nov 2019 13:09:49 +0800
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191118050949.15629-1-cgxu519@mykernel.net>
References: <20191118050949.15629-1-cgxu519@mykernel.net>
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
 fs/xfs/xfs_super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 8d1df9f8be07..9f4d9e86572a 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1125,7 +1125,8 @@ xfs_fs_statfs(
 =09statp->f_ffree =3D max_t(int64_t, ffree, 0);
=20
=20
-=09if ((ip->i_d.di_flags & XFS_DIFLAG_PROJINHERIT) &&
+=09if (((ip->i_d.di_flags & XFS_DIFLAG_PROJINHERIT) ||
+=09     !S_ISDIR(dentry->d_inode->i_mode)) &&
 =09    ((mp->m_qflags & (XFS_PQUOTA_ACCT|XFS_PQUOTA_ENFD))) =3D=3D
 =09=09=09      (XFS_PQUOTA_ACCT|XFS_PQUOTA_ENFD))
 =09=09xfs_qm_statvfs(ip, statp);
--=20
2.20.1



