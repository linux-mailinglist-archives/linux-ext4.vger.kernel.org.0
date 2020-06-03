Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0A61ECBB8
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jun 2020 10:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbgFCIov (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 Jun 2020 04:44:51 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17141 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725854AbgFCIov (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 3 Jun 2020 04:44:51 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1591173882; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=DMCes2hKHfmrpBgmHO5vNWKxI9foSlu4gfRF76nyBT6meEQTK8eX2asgBTUAsMUxF3PybSrOgnccsByBmJJSrKPVaDPZuvJlP1JdPa/Qugu24FHQWKA1ZAXKOeHFDrO1wnv080sLGuPCecJEegLm77YL3qyt0V5nrgShCqlpA2U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1591173882; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=dOnotvF97+vjFLmZhdKmcUk4BU3ZedAnmV6Txn6xxAU=; 
        b=XPbgeeXLkHQfnUw6IHRfF65GHNxa7jFWyd++U45JO9z/52D3uRRIwJz6U40oS7EJTy3aAGu2SoqRIMlTB4eLXEDbgzVfMOP1S5Cy+tLtf387jPzpVeFpIZTgiRFN4eC0x3kyDLqubFh64lb/1SDFsSxrgQGRy60WG1kTOs7YwiY=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1591173882;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=dOnotvF97+vjFLmZhdKmcUk4BU3ZedAnmV6Txn6xxAU=;
        b=Ph9LhjZXig4osbVSi1srjcBZk5e4z4wD/uBdDSWLFcoZCa/9dkpsrW8JQWtDHTl7
        A6Ir0dJv1ksSGnCr2DNxe+rqkh818ZlKekAq4evEAHV0a1MtmzydMXMpbUYxa3WQRLf
        5fCrxQQAZwaWVGKpKw6hi0vKG0OaWhS1OmR+kyys=
Received: from localhost.localdomain (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 15911738790561007.8362167889828; Wed, 3 Jun 2020 16:44:39 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     jack@suse.com
Cc:     linux-ext4@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20200603084429.25344-1-cgxu519@mykernel.net>
Subject: [PATCH] ext2: fix improper assignment for e_value_offs
Date:   Wed,  3 Jun 2020 16:44:29 +0800
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In the process of changing value for existing EA,
there is an improper assignment of e_value_offs(setting to 0),
because it will be reset to incorrect value in the following
loop(shifting EA values before target). Delayed assignment
can avoid this issue.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/ext2/xattr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
index 943cc469f42f..c802ea682e7f 100644
--- a/fs/ext2/xattr.c
+++ b/fs/ext2/xattr.c
@@ -588,7 +588,6 @@ ext2_xattr_set(struct inode *inode, int name_index, con=
st char *name,
 =09=09=09/* Remove the old value. */
 =09=09=09memmove(first_val + size, first_val, val - first_val);
 =09=09=09memset(first_val, 0, size);
-=09=09=09here->e_value_offs =3D 0;
 =09=09=09min_offs +=3D size;
=20
 =09=09=09/* Adjust all value offsets. */
@@ -600,6 +599,8 @@ ext2_xattr_set(struct inode *inode, int name_index, con=
st char *name,
 =09=09=09=09=09=09cpu_to_le16(o + size);
 =09=09=09=09last =3D EXT2_XATTR_NEXT(last);
 =09=09=09}
+
+=09=09=09here->e_value_offs =3D 0;
 =09=09}
 =09=09if (value =3D=3D NULL) {
 =09=09=09/* Remove the old name. */
--=20
2.20.1


