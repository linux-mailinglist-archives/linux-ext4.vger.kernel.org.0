Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D556EDF53
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Nov 2019 12:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbfKDL4O (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 4 Nov 2019 06:56:14 -0500
Received: from sender3-of-o52.zoho.com.cn ([124.251.121.247]:21985 "EHLO
        sender2.zoho.com.cn" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728346AbfKDL4M (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 4 Nov 2019 06:56:12 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1572867663; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=UsW76rhlBPLUFUKJLgq27iaTcR8khwjKSdGZUsPCyQQe3U8S2AJ8IlzqJiDqa+9emM3PncxECuuxYr3baW8ZdzjypHf9sFu0OKJ3ZxJvRQJlx7geq1rBZbpNEphubQKGLPfsg+rK5Pucxx0MDOANulARkWRuGQ3UpbpsoZBDZAk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1572867663; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=vD2mCFzn5UUpY9L7B2S+YTK+IZxao6tB3UjpLRoC+0I=; 
        b=lLEwjYctF60oFRWW/plD9XiTGvd1XOxHoouf9HDPFAvh92cTnFfhFhhQqJat8CvyQfsGVpz96JkbssQQBGb7EpeJ9uSSaDsbH8ikv8Uv+eUPXH+alPrDbaW3VaVVyChGhm+8DkxRC8vIDYaNl8GRHGh/noybLApPuSfCRzfAgfY=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1572867663;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        l=1502; bh=vD2mCFzn5UUpY9L7B2S+YTK+IZxao6tB3UjpLRoC+0I=;
        b=E3kFSWINHB2yCIbB3PtpKtnO4i3satdUvGSJD1IapUOAbG9Be9adgX84v4iehbPW
        lSZmhrvFMeLK5bDe5QEpuhbeW9t49+XsGyi7USJ982aZ1na/qY5UyqUSY6RgLDuZAvV
        EP9BRRXv+6uO0Ioqx+1CKk+OHpNUER2jvgNp3t98=
Received: from localhost.localdomain (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 1572867662321557.7088117113368; Mon, 4 Nov 2019 19:41:02 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     jack@suse.com
Cc:     linux-ext4@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20191104114036.9893-4-cgxu519@mykernel.net>
Subject: [PATCH 4/5] ext2: code cleanup for ext2_try_to_allocate()
Date:   Mon,  4 Nov 2019 19:40:35 +0800
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191104114036.9893-1-cgxu519@mykernel.net>
References: <20191104114036.9893-1-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Code cleanup by removing duplicated code.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/ext2/balloc.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/fs/ext2/balloc.c b/fs/ext2/balloc.c
index a0c22e166682..9a9bd566243d 100644
--- a/fs/ext2/balloc.c
+++ b/fs/ext2/balloc.c
@@ -710,29 +710,25 @@ ext2_try_to_allocate(struct super_block *sb, int grou=
p,
 =09=09=09=09;
 =09=09}
 =09}
-=09start =3D grp_goal;
=20
-repeat:
-=09if (ext2_set_bit_atomic(sb_bgl_lock(EXT2_SB(sb), group), grp_goal,
-=09=09=09       =09=09=09=09bitmap_bh->b_data)) {
-=09=09/*
-=09=09 * The block was allocated by another thread, or it was
-=09=09 * allocated and then freed by another thread
-=09=09 */
-=09=09start++;
-=09=09grp_goal++;
-=09=09if (start >=3D end)
-=09=09=09goto fail_access;
-=09=09goto repeat;
-=09}
-=09num++;
-=09grp_goal++;
-=09while (num < *count && grp_goal < end
-=09=09&& !ext2_set_bit_atomic(sb_bgl_lock(EXT2_SB(sb), group),
+=09while (num < *count && grp_goal < end) {
+=09=09if (ext2_set_bit_atomic(sb_bgl_lock(EXT2_SB(sb), group),
 =09=09=09=09=09grp_goal, bitmap_bh->b_data)) {
+=09=09=09if (num =3D=3D 0) {
+=09=09=09=09grp_goal++;
+=09=09=09=09continue;
+=09=09=09} else {
+=09=09=09=09break;
+=09=09=09}
+=09=09}
+
 =09=09num++;
 =09=09grp_goal++;
 =09}
+
+=09if (!num)
+=09=09goto fail_access;
+
 =09*count =3D num;
 =09return grp_goal - num;
 fail_access:
--=20
2.20.1



