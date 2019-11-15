Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8C4BFE847
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Nov 2019 23:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfKOWtW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 15 Nov 2019 17:49:22 -0500
Received: from sender3-of-o52.zoho.com.cn ([124.251.121.247]:21963 "EHLO
        sender2.zoho.com.cn" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726969AbfKOWtV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 15 Nov 2019 17:49:21 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1573858153; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=eIoiCq65n5TCBlHP8EADRekrKKvTjaPaI8RZOmoFE3SJI3jJQFVzWDUnFmhMJqm3WRadG1Tq+JtDxp3mO/s7svMQ0Ujnd0HidixBJnKVrxOA41P7NYb8QAzBYNnpwl6wYxF8j7mjkKbfkRzWiUeTg9EuLgQFDvuHQszI1ORdpBI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1573858153; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=y1I3TAKhBcX5pmmERDhysK5rgk4VFAEkUHlJcbXlPrc=; 
        b=kcBZCTNq7rYAVOL5CC7oX/E0ISDFm73W9JH10IpQW3zxtXu/xl+oVUAmCKlf67M4mNCeBJ+/KJzyQ/Z3kUUTTrmUOY/xC0u8UMKvAUtNOX6iiwV29Er0V5D6mX/TLhm/dIZhtFyBXKlEJm6ir9hKBd9VQuMH10quGxA5FlPw4CM=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1573858153;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        l=1111; bh=y1I3TAKhBcX5pmmERDhysK5rgk4VFAEkUHlJcbXlPrc=;
        b=L0pTRxrClYgKJz2GLdYFxXXnIgRiRjzFEmXHnCIej2L8VT5bldqrhK1I0PnvXSFU
        bswA7zYT0vx5kw0iGMgaQ/UDUt5CzVuDYmQ3vyQHBEcGlrDSyRPhUiezqgef/Z46gvi
        Ak8en6dCOnpz61BhEfDTXIjjnb88a3GEfZr01w04=
Received: from localhost.localdomain.localdomain (113.116.50.122 [113.116.50.122]) by mx.zoho.com.cn
        with SMTPS id 1573858149835730.0826478198351; Sat, 16 Nov 2019 06:49:09 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     jack@suse.com
Cc:     linux-ext4@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20191115224900.2613-1-cgxu519@mykernel.net>
Subject: [PATCH] ext2: code cleanup for descriptor_loc()
Date:   Sat, 16 Nov 2019 06:49:00 +0800
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Code cleanup by removing unnecessary variable
in descriptor_loc().

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/ext2/super.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 30c630d73f0f..bef607d5db28 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -806,7 +806,6 @@ static unsigned long descriptor_loc(struct super_block =
*sb,
 {
 =09struct ext2_sb_info *sbi =3D EXT2_SB(sb);
 =09unsigned long bg, first_meta_bg;
-=09int has_super =3D 0;
 =09
 =09first_meta_bg =3D le32_to_cpu(sbi->s_es->s_first_meta_bg);
=20
@@ -814,10 +813,8 @@ static unsigned long descriptor_loc(struct super_block=
 *sb,
 =09    nr < first_meta_bg)
 =09=09return (logic_sb_block + nr + 1);
 =09bg =3D sbi->s_desc_per_block * nr;
-=09if (ext2_bg_has_super(sb, bg))
-=09=09has_super =3D 1;
=20
-=09return ext2_group_first_block_no(sb, bg) + has_super;
+=09return ext2_group_first_block_no(sb, bg) + ext2_bg_has_super(sb, bg);
 }
=20
 static int ext2_fill_super(struct super_block *sb, void *data, int silent)
--=20
2.21.0



