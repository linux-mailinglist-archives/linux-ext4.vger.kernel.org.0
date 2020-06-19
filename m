Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66C422002C2
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Jun 2020 09:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730300AbgFSHbz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 19 Jun 2020 03:31:55 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17120 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729740AbgFSHby (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 19 Jun 2020 03:31:54 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1592551910; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=nf+zMZcqVESPKOpyQEgib7tOvI3fFyNeyUDKiZvt8baYNoMg61mOCkISex1Hh/yCcsNs9VHyqqqrHJpMGWtXRxiO937KQ5baUNHbhFgizMP1vKGtTUuJPd4havcDAkEXQ+lrYw3PT5Y8Rdgj4I9OYVPPf+OcSGwoy5DYRLTFqak=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1592551910; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=jEfLXFDKGfBQH3Xvttk1mKgp1xzscpj0Mis0Q37GyHo=; 
        b=XTDy1Zw31bizbDeX+4k17bZINFMuLNPvIjdpe0H4hhMag2cZupWV9ZD251kyfkPwm3e++owFmu9g0Peeu7eNa4a/vtKJ8VwmwU2NV4Uoe/+q6LFuVxVXm8W2S3aWIwoAUPX3npGxY2/Z0a5X7S+2XGa6nctflcV7vo/rd8IWyUk=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1592551910;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=jEfLXFDKGfBQH3Xvttk1mKgp1xzscpj0Mis0Q37GyHo=;
        b=Sts9/wLOOt7sk6CEFvYl3lpqhuJxYNQKM7MmvYcqbQ2gQw1lSX3YuDjWbtwzuSeR
        TxAW7CzoFmlcILSyMSzfPQE8U/IEfJeNSmmdAqFBu4Rl/0hgSeZFP45f/RpLi0Q4F4N
        awY+z4Dp8XCC7s7tNGBuOaSL7zf6LihAOIKU6ir4=
Received: from localhost.localdomain (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 1592551908507269.5307956657608; Fri, 19 Jun 2020 15:31:48 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     jack@suse.com
Cc:     linux-ext4@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20200619073144.4701-1-cgxu519@mykernel.net>
Subject: [PATCH] ext2: remove nocheck option
Date:   Fri, 19 Jun 2020 15:31:44 +0800
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Remove useless nocheck option.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/ext2/ext2.h  |  1 -
 fs/ext2/super.c | 10 +---------
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
index 8178bd38a9d6..c7ed9a57791e 100644
--- a/fs/ext2/ext2.h
+++ b/fs/ext2/ext2.h
@@ -374,7 +374,6 @@ struct ext2_inode {
 /*
  * Mount flags
  */
-#define EXT2_MOUNT_CHECK=09=090x000001  /* Do mount-time checks */
 #define EXT2_MOUNT_OLDALLOC=09=090x000002  /* Don't use the new Orlov allo=
cator */
 #define EXT2_MOUNT_GRPID=09=090x000004  /* Create files with directory's g=
roup */
 #define EXT2_MOUNT_DEBUG=09=090x000008  /* Some debugging messages */
diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 4a4ab683250d..dda860562ca3 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -431,7 +431,7 @@ static unsigned long get_sb_block(void **data)
 enum {
 =09Opt_bsd_df, Opt_minix_df, Opt_grpid, Opt_nogrpid,
 =09Opt_resgid, Opt_resuid, Opt_sb, Opt_err_cont, Opt_err_panic,
-=09Opt_err_ro, Opt_nouid32, Opt_nocheck, Opt_debug,
+=09Opt_err_ro, Opt_nouid32, Opt_debug,
 =09Opt_oldalloc, Opt_orlov, Opt_nobh, Opt_user_xattr, Opt_nouser_xattr,
 =09Opt_acl, Opt_noacl, Opt_xip, Opt_dax, Opt_ignore, Opt_err, Opt_quota,
 =09Opt_usrquota, Opt_grpquota, Opt_reservation, Opt_noreservation
@@ -451,8 +451,6 @@ static const match_table_t tokens =3D {
 =09{Opt_err_panic, "errors=3Dpanic"},
 =09{Opt_err_ro, "errors=3Dremount-ro"},
 =09{Opt_nouid32, "nouid32"},
-=09{Opt_nocheck, "check=3Dnone"},
-=09{Opt_nocheck, "nocheck"},
 =09{Opt_debug, "debug"},
 =09{Opt_oldalloc, "oldalloc"},
 =09{Opt_orlov, "orlov"},
@@ -546,12 +544,6 @@ static int parse_options(char *options, struct super_b=
lock *sb,
 =09=09case Opt_nouid32:
 =09=09=09set_opt (opts->s_mount_opt, NO_UID32);
 =09=09=09break;
-=09=09case Opt_nocheck:
-=09=09=09ext2_msg(sb, KERN_WARNING,
-=09=09=09=09"Option nocheck/check=3Dnone is deprecated and"
-=09=09=09=09" will be removed in June 2020.");
-=09=09=09clear_opt (opts->s_mount_opt, CHECK);
-=09=09=09break;
 =09=09case Opt_debug:
 =09=09=09set_opt (opts->s_mount_opt, DEBUG);
 =09=09=09break;
--=20
2.20.1


