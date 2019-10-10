Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E12C4D1FEE
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Oct 2019 07:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbfJJFPH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Oct 2019 01:15:07 -0400
Received: from sender2-of-o52.zoho.com.cn ([163.53.93.247]:21338 "EHLO
        sender2-of-o52.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726065AbfJJFPG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 10 Oct 2019 01:15:06 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1570684489; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=I+0u4qaXnsIOBwPodn0HCCNGHmbC4h3J9j/iLw4q0FlL/xg+VStMSOSO4FA/KbW/3EiLUc5xVUyXRKU3NDhM2q5dNOYYLv9f+re+LBlwYb9o42V6XJrZDzr/e03+aTEnZ0hG/biAE76tKmT9ML7iyfAcAbz1fxBhtjX2MxNlGoY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1570684489; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=57k/DfEojH8J7KZq4dnoQZxo7kGlpuPxep7Jg8y5XQM=; 
        b=XKxtZ2JqV7d8rtegeqBRWc7l8ReyLDQShLawbMyqPXy4qfBTmJ8foyhbqkDOI/i5/M5XQ/uxvtpn+zZpBFTjVI32QFr66n6xrbnWj0/CXTxXCkAJTnCu73osmj4vEaslyPRJr7yBwTBtfLpYMvQ/oEVcPhVB7qgoNjeFkPC+HeM=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1570684489;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        l=2799; bh=57k/DfEojH8J7KZq4dnoQZxo7kGlpuPxep7Jg8y5XQM=;
        b=ThSxGUtino07ywuAgQw2jr4+mYQYkTwzaQEvHDtFqPrHcRWuCQolg2knl+2NAIHL
        tFDs2FuOriRiw8Y4sI4fxLJd7fChzqyrF1CRYzCOSm57XPhQ6dKIPW+FpGmxXosoZZx
        nydB2uJmjmph6idjirUZDWwIzYXtGDd2IQUmdQ5s=
Received: from localhost.localdomain (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 1570684486856354.78702537373726; Thu, 10 Oct 2019 13:14:46 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20191010051426.1087-1-cgxu519@mykernel.net>
Subject: [PATCH] ext4: choose hardlimit when softlimit is larger than hardlimit in ext4_statfs_project()
Date:   Thu, 10 Oct 2019 13:14:26 +0800
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
 fs/ext4/super.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index dd654e53ba3d..08d4f993b365 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5546,9 +5546,11 @@ static int ext4_statfs_project(struct super_block *s=
b,
 =09=09return PTR_ERR(dquot);
 =09spin_lock(&dquot->dq_dqb_lock);
=20
-=09limit =3D (dquot->dq_dqb.dqb_bsoftlimit ?
-=09=09 dquot->dq_dqb.dqb_bsoftlimit :
-=09=09 dquot->dq_dqb.dqb_bhardlimit) >> sb->s_blocksize_bits;
+=09limit =3D ((dquot->dq_dqb.dqb_bhardlimit &&
+=09=09(dquot->dq_dqb.dqb_bhardlimit < dquot->dq_dqb.dqb_bsoftlimit)) ?
+=09=09dquot->dq_dqb.dqb_bhardlimit :
+=09=09dquot->dq_dqb.dqb_bsoftlimit) >> sb->s_blocksize_bits;
+
 =09if (limit && buf->f_blocks > limit) {
 =09=09curblock =3D (dquot->dq_dqb.dqb_curspace +
 =09=09=09    dquot->dq_dqb.dqb_rsvspace) >> sb->s_blocksize_bits;
@@ -5558,9 +5560,11 @@ static int ext4_statfs_project(struct super_block *s=
b,
 =09=09=09 (buf->f_blocks - curblock) : 0;
 =09}
=20
-=09limit =3D dquot->dq_dqb.dqb_isoftlimit ?
-=09=09dquot->dq_dqb.dqb_isoftlimit :
-=09=09dquot->dq_dqb.dqb_ihardlimit;
+=09limit =3D (dquot->dq_dqb.dqb_ihardlimit &&
+=09=09(dquot->dq_dqb.dqb_ihardlimit < dquot->dq_dqb.dqb_isoftlimit)) ?
+=09=09dquot->dq_dqb.dqb_ihardlimit :
+=09=09dquot->dq_dqb.dqb_isoftlimit;
+
 =09if (limit && buf->f_files > limit) {
 =09=09buf->f_files =3D limit;
 =09=09buf->f_ffree =3D
--=20
2.20.1



