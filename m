Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52474CD15D
	for <lists+linux-ext4@lfdr.de>; Sun,  6 Oct 2019 12:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfJFKq3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 6 Oct 2019 06:46:29 -0400
Received: from sender2-of-o52.zoho.com.cn ([163.53.93.247]:21653 "EHLO
        sender2-of-o52.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726248AbfJFKq3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 6 Oct 2019 06:46:29 -0400
X-Greylist: delayed 916 seconds by postgrey-1.27 at vger.kernel.org; Sun, 06 Oct 2019 06:46:26 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1570357843; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=P+7aT3TSZBXnxh6f7SyVjkTiCD92rbvuWgxsIytoWXuCZO2iqeQPMR/LEWr/o+qzh40pnpY8mFMkdwmrKlgDG4RM5+Uccjzcwvnz0eIFWJfdMQFkuQa4nrIOZhtjBZGPsLsoDwnLk2wbS0aG46lYgGGi/nnTj45c67V8nBuvqac=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1570357843; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=NoGSNU0s/AdxfmdrNPrBvuGX45XVZ4o5yKoJDmyajws=; 
        b=XArQAFzkPz/ecYBJKTONPrv68JOJkqlx6woavMver+c65Y5K8EufRsMfBocPPToOeIyVG4+4y2rLJxCCsl1MegW0E6e9FwGpKsxNWx9DyO3eWTdrgMZibXptoYYUyhBd0iUSSDS2+OnWdVkxn+nl7Bo1imVAqbbhPMMWVfLkOoM=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1570357843;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        l=1808; bh=NoGSNU0s/AdxfmdrNPrBvuGX45XVZ4o5yKoJDmyajws=;
        b=Ebc+3pfQROKvQErkhIJW+6luOUdIzkCNx+bBRtGW3aHxlnSTrvAEyRiZy02sEKzK
        NdM31B5C8sw9cvvbIesT9TR8WAmqEsQukdtp9Rhwqpq/jcx1/QwNTHyBXv2KHSuUD/W
        pgGkrBmuVDr92qWGUZZaGRD7yIQ3n6H+KIvmFjrY=
Received: from localhost.localdomain (116.30.195.234 [116.30.195.234]) by mx.zoho.com.cn
        with SMTPS id 1570357841513677.3525053323079; Sun, 6 Oct 2019 18:30:41 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20191006103028.31299-1-cgxu519@mykernel.net>
Subject: [PATCH] ext4: code cleanup for get_next_id
Date:   Sun,  6 Oct 2019 18:30:28 +0800
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Now the checks in ext4_get_next_id() and dquot_get_next_id()
are almost the same, so just call dquot_get_next_id() instead
of ext4_get_next_id().

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/ext4/super.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index dd654e53ba3d..d1bdffcbfcee 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1374,7 +1374,6 @@ static ssize_t ext4_quota_write(struct super_block *s=
b, int type,
 static int ext4_quota_enable(struct super_block *sb, int type, int format_=
id,
 =09=09=09     unsigned int flags);
 static int ext4_enable_quotas(struct super_block *sb);
-static int ext4_get_next_id(struct super_block *sb, struct kqid *qid);
=20
 static struct dquot **ext4_get_dquots(struct inode *inode)
 {
@@ -1392,7 +1391,7 @@ static const struct dquot_operations ext4_quota_opera=
tions =3D {
 =09.destroy_dquot=09=09=3D dquot_destroy,
 =09.get_projid=09=09=3D ext4_get_projid,
 =09.get_inode_usage=09=3D ext4_get_inode_usage,
-=09.get_next_id=09=09=3D ext4_get_next_id,
+=09.get_next_id=09=09=3D dquot_get_next_id,
 };
=20
 static const struct quotactl_ops ext4_qctl_operations =3D {
@@ -6019,18 +6018,6 @@ static ssize_t ext4_quota_write(struct super_block *=
sb, int type,
 =09}
 =09return len;
 }
-
-static int ext4_get_next_id(struct super_block *sb, struct kqid *qid)
-{
-=09const struct quota_format_ops=09*ops;
-
-=09if (!sb_has_quota_loaded(sb, qid->type))
-=09=09return -ESRCH;
-=09ops =3D sb_dqopt(sb)->ops[qid->type];
-=09if (!ops || !ops->get_next_id)
-=09=09return -ENOSYS;
-=09return dquot_get_next_id(sb, qid);
-}
 #endif
=20
 static struct dentry *ext4_mount(struct file_system_type *fs_type, int fla=
gs,
--=20
2.21.0



