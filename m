Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDC5D7315
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Oct 2019 12:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730395AbfJOKXs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Oct 2019 06:23:48 -0400
Received: from sender2-of-o52.zoho.com.cn ([163.53.93.247]:21495 "EHLO
        sender2-of-o52.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727810AbfJOKXs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 15 Oct 2019 06:23:48 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571135021; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=KJiBZct1BOB/Fpjavg7Cmt2jiED5pU5iLnrtod1xZwUnCBzmt5RDhEulhYLOiXOwqRwOa2naa+AkuL1zqz2rLB/iZ3nUDFTrDxAvOg/ZCHCDl/7N3lAwdyMN+SWFY0yJqdL5T6NATV6j0apPE1blUcwzv69tEkeOH42pePxZ+nw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1571135021; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=FATWOXUm4rs0okbUs/BsL2xh3aKhLLUWMe1nc/+KuEk=; 
        b=TwYAuZIS6d2k1//oA3aMU+uQf4xXeTMHsnX3K/OpJllctc5shQUmHfHaDOnPZ/boMgpH96yDGxEtiaPTeeou9Q9aKvz6yDjH+bJ0DQ3X/4sfWV+9ATHezBNwyHvqg3WGF1b5MvVwb17M6f1dG41A/J7zc5NS+hROuWYE3CDClfo=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1571135021;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        l=3090; bh=FATWOXUm4rs0okbUs/BsL2xh3aKhLLUWMe1nc/+KuEk=;
        b=byJqoyxxevxZRPzwxnWMwH24gEvtbSe6GDlDvxg5lieWh7oF0x3cj/rfRjno0ol/
        ayKmlcxUOK4LlnaCUMISzjIljZPNguswC795Gzrtn4eyXz+KK4Fm7I8t6I806WUxXYk
        5Goo0ayJXhy8T/HW2qTot13z8ZXShOD5/euBo66c=
Received: from localhost.localdomain (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 1571135019163107.09957209380127; Tue, 15 Oct 2019 18:23:39 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.com
Cc:     linux-ext4@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20191015102327.5333-1-cgxu519@mykernel.net>
Subject: [PATCH v2] ext4: choose hardlimit when softlimit is larger than  hardlimit in ext4_statfs_project()
Date:   Tue, 15 Oct 2019 18:23:27 +0800
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Setting softlimit larger than hardlimit seems meaningless
for disk quota but currently it is allowed. In this case,
there may be a bit of comfusion for users when they run
df comamnd to directory which has project quota.

For example, we set 20M softlimit and 10M hardlimit of
block usage limit for project quota of test_dir(project id 123).

[root@hades mnt_ext4]# repquota -P -a
*** Report for project quotas on device /dev/loop0
Block grace time: 7days; Inode grace time: 7days
                        Block limits                File limits
Project         used    soft    hard  grace    used  soft  hard  grace
----------------------------------------------------------------------
 0        --      13       0       0              2     0     0
 123      --   10237   20480   10240              5   200   100

The result of df command as below:

[root@hades mnt_ext4]# df -h test_dir
Filesystem      Size  Used Avail Use% Mounted on
/dev/loop0       20M   10M   10M  50% /home/cgxu/test/mnt_ext4

Even though it looks like there is another 10M free space to use,
if we write new data to diretory test_dir(inherit project id),
the write will fail with errno(-EDQUOT).

After this patch, the df result looks like below.

[root@hades mnt_ext4]# df -h test_dir
Filesystem      Size  Used Avail Use% Mounted on
/dev/loop0       10M   10M  3.0K 100% /home/cgxu/test/mnt_ext4

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
- Fix a bug in the limit setting logic.

 fs/ext4/super.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index dd654e53ba3d..f24e175ae5e0 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5546,9 +5546,15 @@ static int ext4_statfs_project(struct super_block *s=
b,
 =09=09return PTR_ERR(dquot);
 =09spin_lock(&dquot->dq_dqb_lock);
=20
-=09limit =3D (dquot->dq_dqb.dqb_bsoftlimit ?
-=09=09 dquot->dq_dqb.dqb_bsoftlimit :
-=09=09 dquot->dq_dqb.dqb_bhardlimit) >> sb->s_blocksize_bits;
+=09limit =3D 0;
+=09if (dquot->dq_dqb.dqb_bsoftlimit &&
+=09=09(!limit || dquot->dq_dqb.dqb_bsoftlimit < limit))
+=09=09limit =3D dquot->dq_dqb.dqb_bsoftlimit;
+=09if (dquot->dq_dqb.dqb_bhardlimit &&
+=09=09(!limit || dquot->dq_dqb.dqb_bhardlimit < limit))
+=09=09limit =3D dquot->dq_dqb.dqb_bhardlimit;
+=09limit >>=3D sb->s_blocksize_bits;
+
 =09if (limit && buf->f_blocks > limit) {
 =09=09curblock =3D (dquot->dq_dqb.dqb_curspace +
 =09=09=09    dquot->dq_dqb.dqb_rsvspace) >> sb->s_blocksize_bits;
@@ -5558,9 +5564,14 @@ static int ext4_statfs_project(struct super_block *s=
b,
 =09=09=09 (buf->f_blocks - curblock) : 0;
 =09}
=20
-=09limit =3D dquot->dq_dqb.dqb_isoftlimit ?
-=09=09dquot->dq_dqb.dqb_isoftlimit :
-=09=09dquot->dq_dqb.dqb_ihardlimit;
+=09limit =3D 0;
+=09if (dquot->dq_dqb.dqb_isoftlimit &&
+=09=09(!limit || dquot->dq_dqb.dqb_isoftlimit < limit))
+=09=09limit =3D dquot->dq_dqb.dqb_isoftlimit;
+=09if (dquot->dq_dqb.dqb_ihardlimit &&
+=09=09(!limit || dquot->dq_dqb.dqb_ihardlimit < limit))
+=09=09limit =3D dquot->dq_dqb.dqb_ihardlimit;
+
 =09if (limit && buf->f_files > limit) {
 =09=09buf->f_files =3D limit;
 =09=09buf->f_ffree =3D
--=20
2.20.1



