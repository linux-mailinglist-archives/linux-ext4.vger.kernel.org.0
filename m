Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7140877CAEA
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Aug 2023 12:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236338AbjHOKD4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Aug 2023 06:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236342AbjHOKDt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Aug 2023 06:03:49 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D47E65;
        Tue, 15 Aug 2023 03:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.at;
 s=s31663417; t=1692093824; x=1692698624; i=g.ottinger@gmx.at;
 bh=Gpp5wVOly18jXg5JkgsCDiSsaBtHz5ZmdyfKk925lNo=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=U1PTONsmaTUEJKfLQ8rqQAfZfqw2x7PpUo0DlE/zIHn1kYaui6+gfJCjLHyYQrGLEPGt0Ud
 bf9OSj2ZC5ihUsmaFUOk5ELUkebzOF8cSe2AVNiXGpz9qg6xyKhzX08Ns5IzlBd6pIzigSsF2
 c1b5z+FNP5sMzCik6u2epdVlPswhT+M2rnAspFfYIp0w1kBAk0TT2o/dpu3RF3MgDBj+YDOWt
 6RFNw7g8er3r22VrrMdhsO5gvP02pC0FHD9EotxBhyiVT1tz7j8SopNw8SMBGfpftA9lTLsIJ
 piYYxBOAyjafSywQQuzBFtR1p/wXRsaPMWLjfCmIaSATbQG2V5rw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from f15h-Latitude-E5450.lan ([89.144.221.190]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MLR1f-1qDMRf21x5-00IWJR; Tue, 15 Aug 2023 12:03:44 +0200
From:   Georg Ottinger <g.ottinger@gmx.at>
To:     jack@suse.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        g.ottinger@gmx.at
Subject: [PATCH v1] ext2: fix datatype of block number in ext2_xattr_set2()
Date:   Tue, 15 Aug 2023 12:03:40 +0200
Message-Id: <20230815100340.22121-1-g.ottinger@gmx.at>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:T1LK1ieoPzemzU0rSY5G2e0MN0shE+MLQ6+I7jI5YJdFpP2be4/
 T8eAMx1hYst2cQCaN9QTn/zFUd8ElxPHr5VtHunR1ufnPS5rubF2zUKnHsQ8nuu9QLSGa+j
 U6bMTI56nzas+5WX/QQSO3LExb23+j7oedg7Zex3s3c0keOSHxLorx1w5XiEBInk2SqtpZy
 Ux7qNFYNY7p/4wMepZTbw==
UI-OutboundReport: notjunk:1;M01:P0:Dd36tFD1sA8=;MvASvI96fsVNc2pZ+7RfZxZwp2Y
 WI3S1BhrR3Xz5PM4gyOVROc2jqiUvwHhgstojdEvuHqeC/FprUCA4t2nWcbOn0uqsfFRLg00K
 srPVTaDYAHyYTnOJc3eayor6uH9JEfdNCbNL4F+8e3rMap2l846pAy/itHJ1QuAhgnT77hQHy
 q/RzdLthpv3wkoRT3AzSc7lBc0PuJrOQ3h8W1kETVJNdq7WDlfkIQT1qqnvNftlKOo/oayU0y
 VdvXlq44AC9FwnQqueRpPeOj2Yb2Kw8/UOEwg642JVViIc1lZU0fOpy9JC/ZEoi906JAdJO6u
 Udvxpme1pIjNyC4lNwv5s1AzPnh+E/m+Q+QYFlK6tFyKdXth356EJK3wJaHK6JdQd9EtFQR7h
 g9R9Zy6Z6orpH7yBk6Cu5rj87rDXs+DUfuBHP+iieBCbza2nOn6CYg+g2OdReKUf58qKXw9o2
 UcLjGteDlDP3tCXQ61VvzVMpAxFdBDcpKFeBkLdc0JVaXv+ASfVORPVqppsnztp0byHHQSrke
 qIXbxsx8we7KC256xOAoqSnbEmevD2+EuLd32hGmHWBz9k6RSr0nfpLGesmm5byrkmYE6XtX1
 ovk0CMxmr2abTiWUEdWeMNz22R5baX4GLl9NF8htO0a2G9SiyMD9p0lgId7jRC591EqTxrfY0
 V3f4+vaOmoQ/5c4a4UI1qsHT9/QZit3/0DfApkHiatdknsUuQYBZSUyinEtTYg3cviijteb7A
 Q4ZzZPqbSu1JQLdqXOse2i5nQowai/TN1suEizWfYiTxG2eoMEb7dMBLuGZ9Lc0eleb/tzKIA
 IIk6ul4is61ruYJzsTIab1mploIcebW93Gjl6VV1W0AyluR3D36IBjq0rEqSX9lp7QF2sOIQ3
 ZtSu1ofSZEE0SFH2V7AMJ4hLMINuD5o8jBlFPoUg4fJ6F2yxPx8lf8XIKgchEukGEf8tL9Dkk
 soe2hQKi9Tix07ZI9cNjWVwpdjM=
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

