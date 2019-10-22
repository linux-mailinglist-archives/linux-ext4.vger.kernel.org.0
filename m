Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACE4E00BD
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Oct 2019 11:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731513AbfJVJ1q (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 22 Oct 2019 05:27:46 -0400
Received: from sender2-of-o52.zoho.com.cn ([163.53.93.247]:21129 "EHLO
        sender2-of-o52.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731397AbfJVJ1q (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 22 Oct 2019 05:27:46 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571736460; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=AwO29ivo4Fow7ulkLO/sTV1SPQf/ID0zdw1eOEzxuQFGVsdKxMUMDfOgkGk7Z9Cx8hcicDwFFVo0yoN9n8hetG7izjtWOY52pKi1I+19Sh0U5g8nQCLAY8hmggD1Rzx+mc0UjcG+wIahdg6pMXZfJ0te2p/wFWT3NaNX1MjkMio=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1571736460; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=Z3nUGkAA3XNVPbgALGAPttn65zEYTMxdYqcinEjIfGQ=; 
        b=IZVzO9QNj+BprBx0Iw2MYQsvcJUumv5wDGKTK9/U9/mnmPPxpOu1N6c8ktMlRi8u9kgIkpe73xNG9Ds7DT4NrrmZy4ubLJFgocVLEpyWMrnt+XZnnTGMp8wZJOQBTv896NhrqxFs09p7vRfWDOnlJiUvh8JRifk6pa/HjjOaM18=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1571736460;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        l=618; bh=Z3nUGkAA3XNVPbgALGAPttn65zEYTMxdYqcinEjIfGQ=;
        b=XZWXQKjE7gO/dxcx+4m6ge0/E9arFpMIMdeILYQ8UXd8DWT4Py5NQfkHDvpa4YoX
        ROJ4wrFqbWQvRIzDHsccixibBrqX8TptXg92AbpDEg/2wcF0cVZezXCDfnvrcdERTix
        q6t2JM6R9lrrVYcMV/k+y+Sed9oqXjmlLLqxPnL8=
Received: from localhost.localdomain (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 157173645815319.38959495323263; Tue, 22 Oct 2019 17:27:38 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     jack@suse.com
Cc:     linux-ext4@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20191022092720.24416-1-cgxu519@mykernel.net>
Subject: [PATCH] ext2: don't set count in the case of failure
Date:   Tue, 22 Oct 2019 17:27:20 +0800
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In the case of failure, the num is still initialized value 0
so we should not set it to *count because it will bring
unexpected side effect to the caller.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/ext2/balloc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ext2/balloc.c b/fs/ext2/balloc.c
index 18e75adcd2f6..cc516c7b7974 100644
--- a/fs/ext2/balloc.c
+++ b/fs/ext2/balloc.c
@@ -736,7 +736,6 @@ ext2_try_to_allocate(struct super_block *sb, int group,
 =09*count =3D num;
 =09return grp_goal - num;
 fail_access:
-=09*count =3D num;
 =09return -1;
 }
=20
--=20
2.20.1



