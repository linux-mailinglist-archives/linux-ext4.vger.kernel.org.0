Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5E510D05F
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Nov 2019 02:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfK2BhL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 28 Nov 2019 20:37:11 -0500
Received: from sender3-of-o52.zoho.com.cn ([124.251.121.247]:21948 "EHLO
        sender3.zoho.com.cn" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726696AbfK2BhL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 28 Nov 2019 20:37:11 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1574991427; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=pYw/w8L5Mimngy+6F+rEdDl9QKmrxy8PKJmq4zZNrlCh8cq0Tyu3ZDlBg1Oqh0fRJ/GnOe08iUn7GmvsKMEcsLVviBjk8gqmSKXValF6dG+hAYchpWXy2YrnFZyXTZ4kpUsG5tXoyQ9czs6U5R2yWNjB3Rkwu/Azc+2RswRCTDY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1574991427; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=6Gd+K7iZkeXmPQdKtVEkuM2BwhHSn2yjXqABVv19SX4=; 
        b=lEqEgnJtbJCuh2Se4G3v/l/9lHuJKV+uI7ArL6Y2CB7bu0SZjP9XQ9B2i760DdkXGKec3QnezSoG5f7IfK6P59y5xSsNuDQD7x2qkQ99cfb2QsXLQPO9+c/rvGiabMo1Pe99CHaLXPnf6csvsXsw5SX8G1qyOd4sgFjGg4mZMjA=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1574991427;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        l=680; bh=6Gd+K7iZkeXmPQdKtVEkuM2BwhHSn2yjXqABVv19SX4=;
        b=bZ1gHvfbs8NwWxX+f5906/spLk0uuiA9yjag06XUDd6Opof6Hg+M+dNidu6qzPln
        KytxXGqHtovbOXJ/sOXuPc6jGGhab54lgzQjZ73mHW5j4/IrOWqRYDBUog626roZE7e
        bdF+B3ilTaWcFnQ5NC1oeaaMtiOgPGNX1/OqRyZI=
Received: from localhost.localdomain (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 1574991425595539.8182833620485; Fri, 29 Nov 2019 09:37:05 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     jack@suse.com
Cc:     linux-ext4@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20191129013636.7624-1-cgxu519@mykernel.net>
Subject: [Resend PATCH] ext2: set proper errno in error case of ext2_fill_super()
Date:   Fri, 29 Nov 2019 09:36:36 +0800
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Set proper errno in the case of failure of
initializing percpu variables.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
Forgot to cc ext4 maillist, so resend it.

 fs/ext2/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 30c630d73f0f..74a9e3e71c13 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -1147,6 +1147,7 @@ static int ext2_fill_super(struct super_block *sb, vo=
id *data, int silent)
 =09=09=09=09ext2_count_dirs(sb), GFP_KERNEL);
 =09}
 =09if (err) {
+=09=09ret =3D err;
 =09=09ext2_msg(sb, KERN_ERR, "error: insufficient memory");
 =09=09goto failed_mount3;
 =09}
--=20
2.20.1



