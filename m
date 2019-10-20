Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9014DE11C
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Oct 2019 01:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfJTXYR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 20 Oct 2019 19:24:17 -0400
Received: from sender2-of-o52.zoho.com.cn ([163.53.93.247]:21094 "EHLO
        sender2-of-o52.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726571AbfJTXYR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 20 Oct 2019 19:24:17 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571613847; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=IKw61n8RUVV3SJy7bpTgxYSRpE8BtzPqgoHW3Z+xquF/UgXeowpMI/iBDrCNRgiByEyHblRk9VbwcuEJGd/YVyQS1T6clHwA2lqbLEH1So+PiKVRitbtoP+EJu69pe0yf8/CYhdWTwz7PcPB9MC7FPn+dtIEMdyrIBZKWlUYzLY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1571613847; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=dbGY4v0z9eA3KrWPShono8ze+OJ6dMWLikgIR6C4ORE=; 
        b=Xdm5vCGA+dii/aH6y2LgMh1kaVnPAdgUoA6lcXBn3520yGP8x3g+/eLL3xC9dac+burYnwgz7vOibCjozxnkShzERqULQ7BYZ0MOFOeNM4P6Z/hAfauxLgh0i9SeDF68NVfh4E4TBXUn5Ov82ADgeSqxbGNIuWNnfJAG7FwyQRI=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1571613847;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        l=826; bh=dbGY4v0z9eA3KrWPShono8ze+OJ6dMWLikgIR6C4ORE=;
        b=a82uRtpURqh8lPkv0zxNfJi/3ffrD2NeAEeVJuLIwiZfdjDUfdljjKPrjJrMZrKF
        bAz/g5hZ+oTbuuDWkVsOMSJx5Y6TB6kAZzbbazmvoDepIxywJm8ar4oU18toP5RjJRa
        Y0DW8fvxVKN8+s2hHMSGrnC3RelkC4KXcTEqiyQA=
Received: from localhost.localdomain (113.116.159.252 [113.116.159.252]) by mx.zoho.com.cn
        with SMTPS id 1571613844227650.9484105065934; Mon, 21 Oct 2019 07:24:04 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     jack@suse.com
Cc:     linux-ext4@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20191020232326.84881-1-cgxu519@mykernel.net>
Subject: [PATCH] ext2: adjust block num when retry allocation
Date:   Mon, 21 Oct 2019 07:23:26 +0800
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Set block num to original *count in a case
of retrying allocation in case num < *count

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
Hi Jan,

This patch is only compile-tested, I'm not sure if this
kind of unexpected condition which causes reallocation
will actually happen but baesd on the code the fix seems
correct and better.

 fs/ext2/balloc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ext2/balloc.c b/fs/ext2/balloc.c
index e0cc55164505..924c1c765306 100644
--- a/fs/ext2/balloc.c
+++ b/fs/ext2/balloc.c
@@ -1404,6 +1404,7 @@ ext2_fsblk_t ext2_new_blocks(struct inode *inode, ext=
2_fsblk_t goal,
 =09=09 * use.  So we may want to selectively mark some of the blocks
 =09=09 * as free
 =09=09 */
+=09=09num =3D *count;
 =09=09goto retry_alloc;
 =09}
=20
--=20
2.21.0



