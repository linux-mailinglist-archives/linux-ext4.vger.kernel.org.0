Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7022CEDF56
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Nov 2019 12:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbfKDL4X (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 4 Nov 2019 06:56:23 -0500
Received: from sender3-of-o52.zoho.com.cn ([124.251.121.247]:21932 "EHLO
        sender2.zoho.com.cn" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728871AbfKDL4X (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 4 Nov 2019 06:56:23 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1572867664; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=F7putwOGu/cvO5j65ILWAUK1N7Ka672NOZ3+qRvuOKcwzz/EDdI2BfYBH0h6n0cm17ijCTVK1gOLL+3NidMvM1O2sn1jchTolrwQPoZnqQwCJ5XuCbFChxz9mRTqZAS+sB6f8M6eHxGqQzWEwBb4wGeIklAljBtZdXzdjsOnYo8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1572867664; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=MScuvJamY4B9PODRGlsGY+0SFH7BZjXZFmDqK8i2d/8=; 
        b=f1PMr3m1bzReeK54z84ca3mzvQkLrv0oMuE+pOLUHq3d2V32Cl5eVJ94ey4VyDrIRrTCXkBh91mMvkRBwNoxyvNTT6xVyeC3FRuAYVRBeb/79VfQTzTg28AJ+eIOH+I12pkeBbJsN/0FWgvrl9Zsklm8t/oIrWk2fG5Esz94/kE=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1572867664;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        l=725; bh=MScuvJamY4B9PODRGlsGY+0SFH7BZjXZFmDqK8i2d/8=;
        b=TfTM1pRLbSwJ/p8s/3HiTo/5uZPweTrZwVALkf60QrGeGIgCW0JK/6RIt/4Gt8V9
        HK2GstLcHmHEfYghZxhon2H5sMHaipdpAbnWrhba/TqftMeReo5ZpsXMs+WIOxJ+MSb
        7z+0SljjdcAJbu/dESDmmFGv+HdKSk7oywA0Y1Vc=
Received: from localhost.localdomain (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 1572867663706905.0393051105115; Mon, 4 Nov 2019 19:41:03 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     jack@suse.com
Cc:     linux-ext4@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20191104114036.9893-5-cgxu519@mykernel.net>
Subject: [PATCH 5/5] ext2: fix improper function comment
Date:   Mon,  4 Nov 2019 19:40:36 +0800
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

Just fix a improper function comment.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/ext2/balloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext2/balloc.c b/fs/ext2/balloc.c
index 9a9bd566243d..4180467122d0 100644
--- a/fs/ext2/balloc.c
+++ b/fs/ext2/balloc.c
@@ -749,7 +749,7 @@ ext2_try_to_allocate(struct super_block *sb, int group,
  *=09=09but we will shift to the place where start_block is,
  *=09=09then start from there, when looking for a reservable space.
  *
- * =09@size: the target new reservation window size
+ *=09@sb: the super block.
  *
  * =09@group_first_block: the first block we consider to start
  *=09=09=09the real search from
--=20
2.20.1



