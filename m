Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00490EF494
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Nov 2019 05:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387408AbfKEEv2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 4 Nov 2019 23:51:28 -0500
Received: from sender3-of-o52.zoho.com.cn ([124.251.121.247]:21971 "EHLO
        sender2.zoho.com.cn" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730176AbfKEEv2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 4 Nov 2019 23:51:28 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1572929466; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=DomkhDhM1XEEd/23OBghWc0u5sSw8AhGw6paheV8CXyfRVt+PtJW7smnffptR3OXKZjKGlTta1AusCFUu7B8kkOZSnXmKbl9dVsaDW5Siu21EiHmDwS413vv7EN6kvwCQ2l8Sa+dX/Bl0xxbiNrck5kXScO4m1j8LLS8DWtntBM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1572929466; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=brSRdP5KFqpuH2p9tNPrplZ6xACWkA+oRDVfhtlVNZY=; 
        b=DzvJOETp/hRwhcF9K4RFv+1s87+xHCGlaCsoHzuLcuJOZoVIgakC7JjbAzx0ogyoD9A4LdY0XlNRYXJF5ZCizfiQAscmATAG29rjXJCfTszGcQ+/Ogb7KfNAlnkP8vufQcYnNP52ZHHuDPH8z2McjKvdQ3OFF1NiAg1Erus+uBk=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1572929466;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        l=788; bh=brSRdP5KFqpuH2p9tNPrplZ6xACWkA+oRDVfhtlVNZY=;
        b=Y7B/FOMPO4INjTM96XZGaYcWKBzXzsfuu2XsauUqlPoWwt5fdoDlpODkO5FocbkC
        +I7Q7DrtPL6iuMHbdCkJh6KgSukiuyvKeGtwk8JudTlbcsSPcoMZwZufmjkCsh/vxPJ
        TOxWogqnOcIOPOAWR0ULKIB6D6XPCYnnrb37NrV0=
Received: from localhost.localdomain (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 1572929464784774.4755415872704; Tue, 5 Nov 2019 12:51:04 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     jack@suse.com
Cc:     linux-ext4@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20191105045100.7104-1-cgxu519@mykernel.net>
Subject: [PATCH] ext2: check err when partial != NULL
Date:   Tue,  5 Nov 2019 12:51:00 +0800
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Check err when partial =3D=3D NULL is meaningless because
partial =3D=3D NULL means getting branch successfully without
error.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/ext2/inode.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 7004ce581a32..a16c53655e77 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -701,10 +701,13 @@ static int ext2_get_blocks(struct inode *inode,
 =09=09if (!partial) {
 =09=09=09count++;
 =09=09=09mutex_unlock(&ei->truncate_mutex);
-=09=09=09if (err)
-=09=09=09=09goto cleanup;
 =09=09=09goto got_it;
 =09=09}
+
+=09=09if (err) {
+=09=09=09mutex_unlock(&ei->truncate_mutex);
+=09=09=09goto cleanup;
+=09=09}
 =09}
=20
 =09/*
--=20
2.20.1



