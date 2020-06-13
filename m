Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F781F848C
	for <lists+linux-ext4@lfdr.de>; Sat, 13 Jun 2020 20:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgFMSIM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 13 Jun 2020 14:08:12 -0400
Received: from mout.web.de ([212.227.17.11]:41823 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbgFMSIL (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sat, 13 Jun 2020 14:08:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1592071684;
        bh=k9d9hnXuse+jsz5uM/GvN9PsPqTCtT8JfXbci4vUQoI=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=CsX6HCEUezqYtb+eNNHFOc+FycMzhRxQ3pxkJ9gAS/8ZO2zU4fl5jOuP+DcuJum7l
         44r7T7N6gPPwdmlBGELDD7uA40YDFQTCFy2LkLVxcJHaR+oQqG+mm0dCpszOda0F54
         KGPTpoDcR5ECAE5N/EUIeGKuGwMp3ATOXcmXF+N8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.51.155]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MuVGC-1iu7z41Y9K-00rXGX; Sat, 13
 Jun 2020 20:08:04 +0200
To:     linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Theodore Ts'o <tytso@mit.edu>
Cc:     kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] ext4: Delete unnecessary checks before brelse()
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <0d713702-072f-a89c-20ec-ca70aa83a432@web.de>
Date:   Sat, 13 Jun 2020 20:07:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ifHTnBihTZc70KcqZuk18YkTaNBylLGEHU9jBbOuRs6qliSG9Ex
 eu3xTVdsdygkUocDLA5boMrEMwY3Ik2Jxzx4R8p2138W/Iu1y+GROK/VQry8AK2Gx4aWgTr
 n5Xa9hyAy+cDKMkut2+N4LsKNKlSUiujk/s8NbyslPS9RcoMAMddsHScZzhxSL43GK+y4++
 EfCLSv9U6aHGBG7t0n7pA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8zwRtvnSsNA=:FB4hNqSSbyAZkKshdQwb0U
 HOiLLiLNnJJn2Z8+vEz/oIK/XeezPkygB+vLecj4SwBe8cYGyYsyEzOXlrIKVTUVu6N2ZugZB
 ahP+EKzRtMHa1BerIJvP+hSkYRoCHhlQaAGOloyS5PudCoiLWfWMM4S9HnV7ecnEFZNamaQCe
 aNJZJWeHoxnWj3OYY2DU4IaTh3MMZNr3AOWdGuUKvaKg9if8sZe0kMmaS4PXiwzEPLP7PqXyL
 KXzY4BZH7mBqO65n574jqgraIYfYvqmOyPnrFNOxgp4j91HGl9HWBMa2G1c/leqm8iwzrX71P
 C9ugWrlLadeaszMki5rRE6Ckquj6nlEgWW1CJjxbkzm8ThpILvLctIHT1Kow+RRDIXPEk2g1H
 8bsBd2bOI6O237+wSodYk0/EA98OlyNB+9qT3EtsPw4x6cqzbTxb8vnSy0nOiURyoYssQD/Hq
 P8yVyjLC8/Ow6ASW/a6/pMPRUpctHlZ9g7PX3g5hCD1lZN+xFHkxYe/H25amkUtOPCGTOW7ZY
 FXkoEdDyn+ajVYvHCFrf6ulYhMKTaSXoDR6rBrLi0UVwmBDPguLa9+cr5z5hrXU8ooECwyBbP
 WACNh7ISh5SC99cbwf+aq/u4pq6WPjDSlLSy3+14tGCBG/Vw7EJTOUS+QYrlUWOL6D664aJfS
 T3a0SFCo3XHtrTjsouK6pX+QdoKBjpqmeBFGooAO0rNcaMqr1iyEM94Zp7e89Dr5R+DNpKkaU
 BVoLOGvF/1y/1/qQRBaIMNg7u3KQL1ND+rojYuAbnWlxdMe2LZQDm2dNrxm5zSD7bTDO+Sbd7
 3CgutMtNwYQUH6oCKjKqujmN2bXSK690pRh5k+Jj1bHiiq4opXZvZjKRRSej6n/m3tkTRQoWe
 f0Vme6232WrX20jojDcmnScT8yIYWzCyzkMy9IMR+4h2e35rvtSai+JPoLkJ5DH5c72IUDE67
 fc4jPyK+Hhh88jeXu8m4OMCkUnV6yoqRHknqNf//hGmj9egp3ITAwNZV+sgcqFe7dggbsGgEK
 PjG8T/dhc5+Wf7TgxMomHXn545WL+eMgzOXQdtvHGvWkWgE92blAMkyWhNAbYk0MsyB24CYQ2
 2nfNjV8dVCCfGXu5IesrUnSgZNU6LXM/XlqeDgDKuGJZZAW9WnbDZ9BJ9lUUBU1E+e/EHsdUX
 kpbLXgy9FnBBAJIrPWegEp9MRmhnXuLNq/3PH5tgopphdzfUKWGLFauid8ijFTt6WPptk92uF
 QmOhMuw1i3IOhacKv
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 13 Jun 2020 19:12:24 +0200

The brelse() function tests whether its argument is NULL
and then returns immediately.
Thus remove the tests which are not needed around the shown calls.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/ext4/extents.c | 6 ++----
 fs/ext4/xattr.c   | 3 +--
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 221f240eae60..315276d50aa8 100644
=2D-- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -693,10 +693,8 @@ void ext4_ext_drop_refs(struct ext4_ext_path *path)
 		return;
 	depth =3D path->p_depth;
 	for (i =3D 0; i <=3D depth; i++, path++) {
-		if (path->p_bh) {
-			brelse(path->p_bh);
-			path->p_bh =3D NULL;
-		}
+		brelse(path->p_bh);
+		path->p_bh =3D NULL;
 	}
 }

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 9b29a40738ac..eb997ce21be3 100644
=2D-- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1354,8 +1354,7 @@ static int ext4_xattr_inode_write(handle_t *handle, =
struct inode *ea_inode,

 	block =3D 0;
 	while (wsize < bufsize) {
-		if (bh !=3D NULL)
-			brelse(bh);
+		brelse(bh);
 		csize =3D (bufsize - wsize) > blocksize ? blocksize :
 								bufsize - wsize;
 		bh =3D ext4_getblk(handle, ea_inode, block, 0);
=2D-
2.27.0

