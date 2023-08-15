Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0EDB77CAB3
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Aug 2023 11:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236209AbjHOJqf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Aug 2023 05:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236249AbjHOJqN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Aug 2023 05:46:13 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68EA127;
        Tue, 15 Aug 2023 02:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.at;
 s=s31663417; t=1692092762; x=1692697562; i=g.ottinger@gmx.at;
 bh=Gpp5wVOly18jXg5JkgsCDiSsaBtHz5ZmdyfKk925lNo=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=WVGZgbH1JrOtdjqc4wHVJi1wf43jtfFYMsjLN38m4SGlAtOIaPHFJp5cl5GhuajglNMxj3c
 e4OeSZSkgDmBYV52Sz0+zG7Nwu4mN/lEw6/6bhWJTi5th31K3DMvzR3BvMoA1XSA1ach7U802
 dxKMLVv5mqBNuWtO2azPWEEsnieBQtCcwYWBWgJqBjYP6Y0rCnLUCqt8za6HHzYVT/6CwEzP6
 qLS8t6SaMrm3JYYFmH3DEZynGSoZiYHLuHowq/9OxzNinl5ESRyKut1Xti3TejwVR+LZ0ohBi
 VO2rK8J2ZxYd7GJ93EY74vaMVeVU0CLLQiz9FO3ibnySwQinQ+8w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from f15h-Latitude-E5450.lan ([89.144.221.190]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MtOGa-1pdT5I2IyE-00utuL; Tue, 15 Aug 2023 11:46:02 +0200
From:   Georg Ottinger <g.ottinger@gmx.at>
To:     jack@suse.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        g.ottinger@gmx.at
Subject: [PATCH] ext2: fix datatype of block number in ext2_xattr_set2()
Date:   Tue, 15 Aug 2023 11:45:57 +0200
Message-Id: <20230815094557.19940-1-g.ottinger@gmx.at>
X-Mailer: git-send-email 2.17.1
X-Provags-ID: V03:K1:fnwD2vatic2mVIE5NYIWabGSOoRnNYQ714fNZNTts7lI6p2JipU
 Tg2jRRDL+LzhivGhjSoF+pnZJNKv3ZulAgoG0lnn4fqc8cvMdByOHQ1Nk0XQIqsYd4FUh57
 ctJ6APcASVXEWPPXosMxBdmoJYRLuktAn+uWp6nhkbiM574Jw+c5qXKW8GouvdAmcBZmoQ8
 L5EJAKIoINO2BoZ03ERZg==
UI-OutboundReport: notjunk:1;M01:P0:cSRbbpTuyEM=;1rE9PZkZt3z4c7IAe6AU5zjrSSk
 MAbGg9Vt5PslkzpGDETkvb70uFjfWcBlq29xbyI0NIV7hEJ0EpvcPU5KRsJnzvNIFLhdMqXNl
 gvhpFonLutKlPPJZP1VfIOz6hFhP81S/kujLMFbA4m+O3iE+I/otSAsROx0n94iKY9lwpqAW8
 PTUa8TWkBSF4LZP9vWvkZgaHb1AVEcLI9vuaPB9GGjvB4fSgTKXG/mxnimvBtGbiYjJZ8Y2Nt
 QRoFbaaoQk+QpDhJbanZkgDB7+3YdO1mk8H1L4cQ2E6QlEdFtzs0KH27KFLfvFwv7rOce58oV
 bdBo3uhKPxVeeJ0ihsRTfwP5M1a5YnfArgnihpl7GhINOAyDuCaHlh9PJXKteZcPhQRtXWglG
 PT+7VKGm0aHGNyf0mkUA4N/dwspf3FCV50pbk0PHdXmV1pyUO5gdWg/wYHRjSEmo8aAR7zmQ2
 6DzGXLaqG4cQu1bmmP6dlT/MZ1aJ0U5TVpU0PBpi3CGaDF33hfdSZcHV/hDzwr/CJkkqvlkK2
 +SI/DnwGKeSbnHTidsrXZyu1aQD0r3ako3gzH6TcIjc7HDzdr5d8MMz4mCUYS48xAx0Hko4hd
 /dybgnZuQ7oCkzKN3HaHhcebqe95MiLNeZdWaSc6QNObfk30Pj1+GDxm3YdqYM7Momqw3kAii
 7qQzkDgb3m1m5zdMXOVvou3NK7hxPY97tKw0L1ahMYqw9SIpmYmxyqy+Iv5ASCUlAaz/eDDvo
 ElOEkdU80fTH6OC+xfHFSyVuqq62ykBUHf+RtdX01BPdJDAzEw8jD9uDLu6EolrGiMGzT5yTj
 PqW17drJ9b5+dU+69gOXqZ79V0lYNIlkS5WKtj4XJw954JXLRnSmuojd2bl3gkdFiNiv/u3pR
 8SMdqKhFZO1T+DvDcFJFfiEWdf1yd6sv275Iw9kJ+8POwdVLiWpJdQ5MlYjpCD4r8nG64/Lk+
 49zjMClXPX7rBcflA2cRnLSN+rc=
Content-Transfer-Encoding: quoted-printable
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
 fs/ext2/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
index 8906ba479..5e13f7ea1 100644
=2D-- a/fs/ext2/xattr.c
+++ b/fs/ext2/xattr.c
@@ -742,7 +742,7 @@ ext2_xattr_set2(struct inode *inode, struct buffer_hea=
d *old_bh,
 			/* We need to allocate a new block */
 			ext2_fsblk_t goal =3D ext2_group_first_block_no(sb,
 						EXT2_I(inode)->i_block_group);
-			int block =3D ext2_new_block(inode, goal, &error);
+			ext2_fsblk_t block =3D ext2_new_block(inode, goal, &error);
 			if (error)
 				goto cleanup;
 			ea_idebug(inode, "creating block %d", block);
=2D-
2.17.1

