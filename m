Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 695D4EDF51
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Nov 2019 12:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbfKDL4M (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 4 Nov 2019 06:56:12 -0500
Received: from sender3-of-o52.zoho.com.cn ([124.251.121.247]:21984 "EHLO
        sender2.zoho.com.cn" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728827AbfKDL4M (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 4 Nov 2019 06:56:12 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1572867662; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=G8ajjM/9vPkVyno6masR4w8XKJNd0qlXdvNBd1P4UWsyM5poeGOQeYko5u+ooNDGiH+G7ziT0UbjeipFVSOuYJrQkXqYOLCe6/UfgH9VLG8ZnnwsxvhwKvyWlBaakKpH45rlD04iRfq5jX3tmkZu+xl7ybGwOgICfuzvtNlWg4k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1572867662; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=LcQzffD0A2m7LCciRN8lyQm615vt2s14ntIlVKAf5zA=; 
        b=PiuPqrqqGeyuOv5I2t1MQAITGwLk3b55LFeEqSzIZEJ21dOadhxMlg1biEFr7SMsjxleys2gPwOgMz6wLN6crjGlWcmjRRukRxpdppBvnGXV04/DfOMecIjtJzei0cfuNSh3jHcjXHIUKccrjwNkzaWVHkXBwuztM8HgHSEtYLA=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1572867662;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        l=913; bh=LcQzffD0A2m7LCciRN8lyQm615vt2s14ntIlVKAf5zA=;
        b=YdZHKJSJJVhhqwiumc+1t9v0leVkEx8k9yacdyCClBH8OS0K5FYie1pEtZpDd9XS
        Lpt5SNTmBLcSWcw+pOUxuZPA+z1e0GB/w1Q1130ENj+Q5/kkgLsdt1qhgtsnVC7LiiI
        tjI9ANefV9O5Uz+np2+vr+BL39RAjS7QIrRXbbWc=
Received: from localhost.localdomain (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 1572867661068351.7134233309414; Mon, 4 Nov 2019 19:41:01 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     jack@suse.com
Cc:     linux-ext4@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20191104114036.9893-3-cgxu519@mykernel.net>
Subject: [PATCH 3/5] ext2: skip unnecessary operations in ext2_try_to_allocate()
Date:   Mon,  4 Nov 2019 19:40:34 +0800
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

Move 'repeat' tag to proper place so that we can
skip unnecessary operations in ext2_try_to_allocate().

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/ext2/balloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext2/balloc.c b/fs/ext2/balloc.c
index 994a1fd18e93..a0c22e166682 100644
--- a/fs/ext2/balloc.c
+++ b/fs/ext2/balloc.c
@@ -696,7 +696,6 @@ ext2_try_to_allocate(struct super_block *sb, int group,
=20
 =09BUG_ON(start > EXT2_BLOCKS_PER_GROUP(sb));
=20
-repeat:
 =09if (grp_goal < 0) {
 =09=09grp_goal =3D find_next_usable_block(start, bitmap_bh, end);
 =09=09if (grp_goal < 0)
@@ -713,6 +712,7 @@ ext2_try_to_allocate(struct super_block *sb, int group,
 =09}
 =09start =3D grp_goal;
=20
+repeat:
 =09if (ext2_set_bit_atomic(sb_bgl_lock(EXT2_SB(sb), group), grp_goal,
 =09=09=09       =09=09=09=09bitmap_bh->b_data)) {
 =09=09/*
--=20
2.20.1



