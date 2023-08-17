Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEAE77FECA
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Aug 2023 22:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354795AbjHQT7r (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Aug 2023 15:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354787AbjHQT7j (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Aug 2023 15:59:39 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E58230C6;
        Thu, 17 Aug 2023 12:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.at;
 s=s31663417; t=1692302375; x=1692907175; i=g.ottinger@gmx.at;
 bh=F0+bYSh/OCnZnYisS3APrmj3Se/Izflu2CtxIYEs6ps=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=GBle3Nvm3F+RgCdJL+aRi74UQPpl9ruzfG5erjEkredEHFZP8hZQhablwEytLw0/doKPYfr
 K20p1JFT2ETx7/jK5S+DNcU1clWmobUIexMWfWNh1yrX5qWnfNyTjW9voaXTlGAHze7uOmDPj
 v84/e950iBztqJ2LhGzUbX9/wvOA36HwHf/X/C1u1s8b/YD2AXh4xq8ZQhzPZhTHsXUbEJ+KB
 O3T5OI4gK1QCSpVN0ghHwzoAbG+p7E+o5LZPvAEmFgoA2NOCPvTM9fbQhEsC6WmcASOvFDtKl
 sYfkGAgFkSbgIx6HF3XcAF/i6Ni7HNQjCMWgedkwypjVxYOtZ9tQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from f15h-Latitude-E5450.lan ([85.236.235.138]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MWASe-1qGeTN2LgA-00XcER; Thu, 17 Aug 2023 21:59:35 +0200
From:   Georg Ottinger <g.ottinger@gmx.at>
To:     jack@suse.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        g.ottinger@gmx.at
Subject: [PATCH v1] ext2: improve consistency of ext2_fsblk_t datatype usage
Date:   Thu, 17 Aug 2023 21:59:25 +0200
Message-Id: <20230817195925.10268-1-g.ottinger@gmx.at>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:73pd2Bi2MuF34WuyYd1DUoYfiP24w2dyLn62SQge5GdB6taZrJU
 gG33doCiWBZQug0kB00IkYzpiL3hAuBs4ggbnnCiUBToVtJbJXBI8vL+4bQ49PAB1fK59LH
 MYGLcNNr4pTEBsBhAR+KZ4uLU3MGIwXcfDSEi50RmQzBuzm3ghqweBHBsgzfuZZUZtFsMPz
 2CdYZyxkuTth/Qia+ElnQ==
UI-OutboundReport: notjunk:1;M01:P0:ToTDyyS4D0o=;ZH9XbcVJLVo5mlELH7bTfk/sJf7
 IcKmzw3GleI1EjeZbvxuA2tD9DYyv2d5GwhVqWdNomKemv5y4Lpd/qI8go/r0chYOWoqK9k/4
 XXut1P8TFffwATAl/Ffyk60KLPtVBxsdK7f30mCqJzFcwtGsULc12D03xXiRVts/nV/ggS11b
 d1FsFfttbb2UblqSncrDAmz35scWFVBSPQbEyG9upakCDqqkiJ+ZTds3q7MKkMBrkU1/gQq9R
 WmW/+jyQKj0EGjucBhjTT5q2Iw+cw6Wt1qGXP9/j9Dm87vEwQ2bcyal6NzX0NmjjD6U1M0lLY
 v5aZ+kwyJw6dzYzMYaTBzI5X/fIuaCN+gCegJ1wljbzb5D6Bip5RTxUt0amlDVKMVCQNtBZ6O
 5oP00xwaJ7bzYWlZu5qPKA0JeZ+SHJcgFhSEaI21h935wA9mo7vnXbT/k4fa/GzUW6CKzlW6L
 b5AgK0lvy7OR1Z6wNhDCzqRekW6Y9PM3YURcfm2XDG44xDfQHAec7EBlZWifV/nfV1vqnQzpD
 741I0u9vdaclwDVjJ3mpRdYnnLyvDFO10n+Rlj+UFb0ypX5nAgQgXIlvzYD/Lgn6+9kjRpzhh
 RVSnsFbYRmr9x919WwTY/tHhylsenDzTfVvJufsZ7MClMTW4VkMW87dd+tdI3Bto7Ju9FHePE
 /3TmHx9XsRRCpyxa8PDFW0CY0l3ikGIEwfN+0njc9yCeTFRJcTdwG5VRreMDStcYAxxBXEit6
 l4DuFYaaHmjuOQKWyu0tl/RnfP48VdREbC4rmR3r5htQ3kS9IVgZYobod2A5abQNCkAufhYRS
 P6gnd9wlVBkatoS/vHMQ5rhfcz0s1gWa4vkTiYyEH7uV/p/V3GqI/K0xutTTqdbXrXIHo8xcH
 zXQDMo/tw5xakDlFQ4a5kLlFrmM56sv6tUF30FC4ApA7CdX6wfUKgnGK2luoJ8qufg2Y01RaQ
 pxbnzLg6cwKQOKt77y8fA/JVY9w=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The ext2 block allocation/deallocation functions and their respective
calls use a mixture of unsigned long and ext2_fsblk_t datatypes to
index the desired ext2 block. This commit replaces occurrences of
unsigned long with ext2_fsblk_t, covering the functions
ext2_new_block(), ext2_new_blocks(), ext2_free_blocks(),
ext2_free_data() and ext2_free_branches(). This commit is rather
conservative, and only replaces unsigned long with ext2_fsblk_t if
the variable is used to index a specific ext2 block.

Signed-off-by: Georg Ottinger <g.ottinger@gmx.at>
=2D--
 fs/ext2/balloc.c | 4 ++--
 fs/ext2/ext2.h   | 6 +++---
 fs/ext2/inode.c  | 6 +++---
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/ext2/balloc.c b/fs/ext2/balloc.c
index eca60b747..9db13852c 100644
=2D-- a/fs/ext2/balloc.c
+++ b/fs/ext2/balloc.c
@@ -474,7 +474,7 @@ void ext2_discard_reservation(struct inode *inode)
  * @block:		start physical block to free
  * @count:		number of blocks to free
  */
-void ext2_free_blocks (struct inode * inode, unsigned long block,
+void ext2_free_blocks (struct inode * inode, ext2_fsblk_t block,
 		       unsigned long count)
 {
 	struct buffer_head *bitmap_bh =3D NULL;
@@ -1431,7 +1431,7 @@ ext2_fsblk_t ext2_new_blocks(struct inode *inode, ex=
t2_fsblk_t goal,
 	return 0;
 }

-ext2_fsblk_t ext2_new_block(struct inode *inode, unsigned long goal, int =
*errp)
+ext2_fsblk_t ext2_new_block(struct inode *inode, ext2_fsblk_t goal, int *=
errp)
 {
 	unsigned long count =3D 1;

diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
index 35a041c47..83fd85bb1 100644
=2D-- a/fs/ext2/ext2.h
+++ b/fs/ext2/ext2.h
@@ -695,12 +695,12 @@ static inline struct ext2_inode_info *EXT2_I(struct =
inode *inode)
 /* balloc.c */
 extern int ext2_bg_has_super(struct super_block *sb, int group);
 extern unsigned long ext2_bg_num_gdb(struct super_block *sb, int group);
-extern ext2_fsblk_t ext2_new_block(struct inode *, unsigned long, int *);
-extern ext2_fsblk_t ext2_new_blocks(struct inode *, unsigned long,
+extern ext2_fsblk_t ext2_new_block(struct inode *, ext2_fsblk_t, int *);
+extern ext2_fsblk_t ext2_new_blocks(struct inode *, ext2_fsblk_t,
 				unsigned long *, int *);
 extern int ext2_data_block_valid(struct ext2_sb_info *sbi, ext2_fsblk_t s=
tart_blk,
 				 unsigned int count);
-extern void ext2_free_blocks (struct inode *, unsigned long,
+extern void ext2_free_blocks (struct inode *, ext2_fsblk_t,
 			      unsigned long);
 extern unsigned long ext2_count_free_blocks (struct super_block *);
 extern unsigned long ext2_count_dirs (struct super_block *);
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 75983215c..72916c929 100644
=2D-- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -1082,8 +1082,8 @@ static Indirect *ext2_find_shared(struct inode *inod=
e,
  */
 static inline void ext2_free_data(struct inode *inode, __le32 *p, __le32 =
*q)
 {
-	unsigned long block_to_free =3D 0, count =3D 0;
-	unsigned long nr;
+	ext2_fsblk_t block_to_free =3D 0, count =3D 0;
+	ext2_fsblk_t nr;

 	for ( ; p < q ; p++) {
 		nr =3D le32_to_cpu(*p);
@@ -1123,7 +1123,7 @@ static inline void ext2_free_data(struct inode *inod=
e, __le32 *p, __le32 *q)
 static void ext2_free_branches(struct inode *inode, __le32 *p, __le32 *q,=
 int depth)
 {
 	struct buffer_head * bh;
-	unsigned long nr;
+	ext2_fsblk_t nr;

 	if (depth--) {
 		int addr_per_block =3D EXT2_ADDR_PER_BLOCK(inode->i_sb);
=2D-
2.17.1

