Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24FEEEDF52
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Nov 2019 12:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbfKDL4N (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 4 Nov 2019 06:56:13 -0500
Received: from sender3-of-o52.zoho.com.cn ([124.251.121.247]:21922 "EHLO
        sender2.zoho.com.cn" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727663AbfKDL4N (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 4 Nov 2019 06:56:13 -0500
X-Greylist: delayed 906 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Nov 2019 06:56:09 EST
ARC-Seal: i=1; a=rsa-sha256; t=1572867659; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=rY0x6zTB1/c6EuqPvJdRCRxK2Zmh5ahjD6H0UhscfMqrQgG/JnFwr/GD1YbAEUEYWSTYscE/j4tV/afSiL3HGYLWZVU4EtP9oPH4FfoWge1R2VCn/+hxyAhVUVCOTVgp/07DZP8VYCNdcfTwYIC45tcfApYyfN+ExR38mnvPzG8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1572867659; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=m6R7At4+C/REK1yLQtQ2YRUko1s/FbpG1OERsvSbHl0=; 
        b=JszRGn+O6CaXfIjFC1tCBx04qZqb7g1MSdQVik8EunfaP5Uti7c9V2jNAasnbsxxUjecoGNe+yg9cltkb8ckhCWpxMLrM1TypURh5ZUZVydQxGM7hwSzSqVKzyvq4Z9wBqKMZ9vYsAEbdBrtvRQKN5/BZ2fpi+ctcbJpuTB431s=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1572867659;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        l=1133; bh=m6R7At4+C/REK1yLQtQ2YRUko1s/FbpG1OERsvSbHl0=;
        b=gxwq13VVxOr6+wye9SLbLj4GowWQl4UTkyAF74g2WI6Fqr53C0ZWAnl/G4Fpkxbz
        seGIOXtzs5516O3kbs9YGYU5EaFazN6p37JToyk+7I+vKNyj6pntrWFuhQ/3rvy6BOH
        r9scbX+HDuw/FxaWNJctJL+L0E3Dz7ekv/Y5ljUA=
Received: from localhost.localdomain (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 15728676574231004.4041585412566; Mon, 4 Nov 2019 19:40:57 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     jack@suse.com
Cc:     linux-ext4@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20191104114036.9893-1-cgxu519@mykernel.net>
Subject: [PATCH 1/5] ext2: introduce new helper ext2_group_last_block_no()
Date:   Mon,  4 Nov 2019 19:40:32 +0800
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Introduce new helper ext2_group_last_block_no() to calculate
last block num for specific block group, we can replace open
coded logic by calling this common helper.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/ext2/ext2.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
index 10ab238de9a6..8178bd38a9d6 100644
--- a/fs/ext2/ext2.h
+++ b/fs/ext2/ext2.h
@@ -813,6 +813,18 @@ ext2_group_first_block_no(struct super_block *sb, unsi=
gned long group_no)
 =09=09le32_to_cpu(EXT2_SB(sb)->s_es->s_first_data_block);
 }
=20
+static inline ext2_fsblk_t
+ext2_group_last_block_no(struct super_block *sb, unsigned long group_no)
+{
+=09struct ext2_sb_info *sbi =3D EXT2_SB(sb);
+
+=09if (group_no =3D=3D sbi->s_groups_count - 1)
+=09=09return le32_to_cpu(sbi->s_es->s_blocks_count) - 1;
+=09else
+=09=09return ext2_group_first_block_no(sb, group_no) +
+=09=09=09EXT2_BLOCKS_PER_GROUP(sb) - 1;
+}
+
 #define ext2_set_bit=09__test_and_set_bit_le
 #define ext2_clear_bit=09__test_and_clear_bit_le
 #define ext2_test_bit=09test_bit_le
--=20
2.20.1



