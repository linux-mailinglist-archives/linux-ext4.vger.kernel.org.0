Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 628E0D85E3
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Oct 2019 04:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729574AbfJPC0Q (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Oct 2019 22:26:16 -0400
Received: from sender2-of-o52.zoho.com.cn ([163.53.93.247]:21595 "EHLO
        sender2-of-o52.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726534AbfJPC0Q (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 15 Oct 2019 22:26:16 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571192753; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=XlGHH60U4LfVaAfzuhBuHSv1fM50isbht2qJRgjxo7XHU1WrELQyLOAnHVIl8yEgBkFx/PIRR68jtZ4R/k2r0mTMkZKvpUhsxgkWbNh5qOKlkSR3f4DuWMXjLTnO46It48cnv8y9oSgQK3QTNgpJRTU8jwHH9boLX+0PqfnTExY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1571192753; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=Nk0C0V4E9Y4XENGJUxL3tSBz2Pbvt50Yg2mLQYB1Eog=; 
        b=EyVcHX0C+0BbxOc1QkfaajxrzWnuH1CeV1wDiQmpSjoM5kZBmW9hCwZCdUpXXQCHqibJiH6yz4lk8BB59nUCjh9Fo6awdQcs2Jfw2Ma7tC0X7qWx2zQf687DktxEBuW86+enJ6zqcJx/lKr4qCioA2PKGdOcM5U1l1XXyL3YOi8=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1571192753;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        l=3162; bh=Nk0C0V4E9Y4XENGJUxL3tSBz2Pbvt50Yg2mLQYB1Eog=;
        b=MZURaCIKFOJ5+RzvaznPOdLkgV/x0Thei2c8RqN1zWrGMgoIv/NCuktoegpdZaZo
        eYr1X+si9fiXnLw0RVx6EDpJtPXpO/u/FKStdPJAovGVlaCYwhHFfvM2xAf92KAFJxH
        31zQJa8/PK/H5Zd9FUeamEnoAgpBcM4gba9c+AHU=
Received: from localhost.localdomain (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 1571192750752780.5297570380358; Wed, 16 Oct 2019 10:25:50 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.com
Cc:     linux-ext4@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>,
        Jan Kara <jack@suse.cz>
Message-ID: <20191016022501.760-1-cgxu519@mykernel.net>
Subject: [PATCH v3] ext4: choose hardlimit when softlimit is larger than  hardlimit in ext4_statfs_project()
Date:   Wed, 16 Oct 2019 10:25:01 +0800
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
Reviewed-by: Jan Kara <jack@suse.cz>
---
v1->v2:
- Fix a bug in the limit setting logic.
v2->v3:
- Modify coding style.

 fs/ext4/super.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index dd654e53ba3d..0f9a219c0ab4 100644
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
+=09    (!limit || dquot->dq_dqb.dqb_bsoftlimit < limit))
+=09=09limit =3D dquot->dq_dqb.dqb_bsoftlimit;
+=09if (dquot->dq_dqb.dqb_bhardlimit &&
+=09    (!limit || dquot->dq_dqb.dqb_bhardlimit < limit))
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
+=09    (!limit || dquot->dq_dqb.dqb_isoftlimit < limit))
+=09=09limit =3D dquot->dq_dqb.dqb_isoftlimit;
+=09if (dquot->dq_dqb.dqb_ihardlimit &&
+=09    (!limit || dquot->dq_dqb.dqb_ihardlimit < limit))
+=09=09limit =3D dquot->dq_dqb.dqb_ihardlimit;
+
 =09if (limit && buf->f_files > limit) {
 =09=09buf->f_files =3D limit;
 =09=09buf->f_ffree =3D
--=20
2.20.1



