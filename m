Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902AA77D9C0
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Aug 2023 07:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjHPFV3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Aug 2023 01:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241888AbjHPFVS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Aug 2023 01:21:18 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552EA268F;
        Tue, 15 Aug 2023 22:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.at;
 s=s31663417; t=1692163270; x=1692768070; i=g.ottinger@gmx.at;
 bh=zihyiJ73ADx+UuuJMxXFt7FINHQFNKkDIYeeeLl7Gys=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=UB4rcAlBDsyX9MH45FrGgCo+stOeOOX4CWb98Pk71ahkFzsQB1AupLaa5U9qdWk7+pB0Wi+
 CG8nLi3O5TtgY5FqaEJ6SCAMs5P/U0SHfzJg72iVqAO4UHRQ8ns+N/qPPtTd4WbBT18tteUVL
 wAs0JJ7l9tcxSdk/HHAN0oIDsGcx/09fqo52/d7Szwu8InO/3bzIJSBadVwfQ6zf/KMMtc2sw
 6uVOsNE2M9qvx/VePvWjSr8V6rSa2kRGwvLy5TpyN4u5qRNyCn8cPKpMN82ISYUpmxWv9sDS7
 PyTzpdwY41uaXpSSW9Hv9lDeWOipEzKjqvRh+TXxMsqJ329HPUsA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from f15h-Latitude-E5450.lan ([89.144.221.196]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N9Mta-1pijBa1eDs-015JeV; Wed, 16 Aug 2023 07:21:10 +0200
From:   Georg Ottinger <g.ottinger@gmx.at>
To:     jack@suse.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        g.ottinger@gmx.at
Subject: [PATCH v2] ext2: fix datatype of block number in ext2_xattr_set2()
Date:   Wed, 16 Aug 2023 07:21:04 +0200
Message-Id: <20230816052104.3374-1-g.ottinger@gmx.at>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JxcYQOoSRCKJNW9jHezvOnUVv5Ym/zSkRwGa+ShBlFSn5EuyRq+
 HHtTeFJV5mzJaTx9tWW+iILGsDHlU4tBWYX/nLm18TWU/v8sohjdFnGnGUuzqu6iF2N+Ski
 piShylxLm8wArlH0tNgZF3bMMjzVksgjzeXRG0KkpnUbveH7Omi7OwsOIT8/ro0h95w/1Pe
 oJ7wtYSFtBo6afeyEws2g==
UI-OutboundReport: notjunk:1;M01:P0:yrwRBMUQpHg=;2r7qejm93REDKt+vnWRsxn722Ll
 p41N0Of2yg9cWvGR1ZO74+FvzL+1h+HODR1/HXjhy72w6DObRSCxiW/X0rYnsVaE4eukud6gS
 QRob0R03Ip7tRR/dwfKF4QXxKG6VPyw2xIsz3pDTFtipTKVyLIM6vXSeK731y1GqfhteViLwe
 45fDp3KZ6AhHgz1cNSYfThHn+xSQYBLMkL2enwq5N5pqR2dQAbcOtvdC5oW0IwkHY7ogTlfU4
 ioNdfszsA2k/7kIWk0eOGDKlNkU42DNpWL4WV2Xp5k0rpxpYvW1xhMQ0q5oMd4hsIn081JFS6
 Dt1zvKIJU5u9de1NU3bDR2cwqIVLsDzLOH9hgUol58aXbJV1cByO80JFyzxxJSHRuc2d6x7sg
 IPk0uyS+PCnGCn03Ing2+/57xF45d7aCoVP3U5naEVHipmxfCsyrZg/GETdgZVin6sTN+02MU
 dneVNpYr4ILQ7M2YYZOCjTyRcM+HKo9AAG9BDC+T7897gN2GwotZ0eU9E+Fnf+EVgWZC/74OE
 FY6uHtBI7uoFZuqDHHlCh8nUy0ClcsABA9uKZ9vUIXeXX4kYi2+wHYB2qjXB6HWrgbFkRxqGZ
 qkMki6BpkVCP3EnVRjydMWyrvDZDYHO8lRFcLgfOYlzmwAknICwIy0L6Qx3rMi2443km9H3hx
 nsUorEnXiz4x/CCRNE1/2ob59cCIHJTDbHdQIrtP1Y+WdFCRabBS4hQE8utp2hbP5kIHXpboc
 RWlKQhrKzx0W0JiOU9tYmVZUHDnPpOuPUuX6yfwKPuwXMmrXKCzwUK1xrn066pcqvBeIrbn1F
 mgNwYgLsw1SxZLrUijQi6WyNiJMmPUYKIpuLzeOt1BMB3eTFoThSl7wQuvRHNMQbx2gy+bCzZ
 TJ85Isc51tkvBEtRZaKxYX/g8BGDNFRxW4KuHMNkAhUAq/JHEIAoYPi+gnT/S33rPZcWI+hzl
 2yyRn2SGwKB+E9XlAkmZEGjH98w=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

I run a small server that uses external hard drives for backups. The
backup software I use uses ext2 filesystems with 4KiB block size and
the server is running SELinux and therefore relies on xattr. I recently
upgraded the hard drives from 4TB to 12TB models. I noticed that after
transferring some TBs I got a filesystem error "Freeing blocks not in
datazone - block =3D 18446744071529317386, count =3D 1" and the backup
process stopped. Trying to fix the fs with e2fsck resulted in a
completely corrupted fs. The error probably came from ext2_free_blocks(),
and because of the large number 18e19 this problem immediately looked
like some kind of integer overflow. Whereas the 4TB fs was about 1e9
blocks, the new 12TB is about 3e9 blocks. So, searching the ext2 code,
I came across the line in fs/ext2/xattr.c:745 where ext2_new_block()
is called and the resulting block number is stored in the variable block
as an int datatype. If a block with a block number greater than
INT32_MAX is returned, this variable overflows and the call to
sb_getblk() at line fs/ext2/xattr.c:750 fails, then the call to
ext2_free_blocks() produces the error.

Signed-off-by: Georg Ottinger <g.ottinger@gmx.at>
=2D--
 fs/ext2/xattr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
index 8906ba479..89517937d 100644
=2D-- a/fs/ext2/xattr.c
+++ b/fs/ext2/xattr.c
@@ -742,10 +742,10 @@ ext2_xattr_set2(struct inode *inode, struct buffer_h=
ead *old_bh,
 			/* We need to allocate a new block */
 			ext2_fsblk_t goal =3D ext2_group_first_block_no(sb,
 						EXT2_I(inode)->i_block_group);
-			int block =3D ext2_new_block(inode, goal, &error);
+			ext2_fsblk_t block =3D ext2_new_block(inode, goal, &error);
 			if (error)
 				goto cleanup;
-			ea_idebug(inode, "creating block %d", block);
+			ea_idebug(inode, "creating block %lu", block);

 			new_bh =3D sb_getblk(sb, block);
 			if (unlikely(!new_bh)) {
=2D-
2.17.1

