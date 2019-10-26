Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C238E595F
	for <lists+linux-ext4@lfdr.de>; Sat, 26 Oct 2019 11:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbfJZJHn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 26 Oct 2019 05:07:43 -0400
Received: from sender2-of-o52.zoho.com.cn ([163.53.93.247]:21210 "EHLO
        sender2-of-o52.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726057AbfJZJHn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Sat, 26 Oct 2019 05:07:43 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1572080851; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=Sv+TW6OhviS9mjSCPq4jD9QTzqpnWDGQkp8snS/yX+ywsOZwRRdB8XFgVoY1CQJvf5KMT29J/97qcTMlmImZ6PTym0EF+rFKLlM97d526PtvsWSoTZkaGp0pak2aFeLbpToEjW/aGzqeSRmeJWbZ2l3kMHSmDrYZcvfb7zLqVPw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1572080851; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=LU6DDOmihitYkTVww+mLh369eU8sibrZGSH3hAdM0Nc=; 
        b=WhzFYII9sVbNjzwhYub9a6rZKuSgCdd4uLpKqlQQ9OI/jrSFeIflYX13HUL+oplIh9k5EksTC716ZzWJSJENB/MSCMgkPMM850SxSC6JKQS9veoF+RBSGPJvGBezZySwrSL+vS33GWhNlWmmEjUeTTpuSrBI18PAXyPRKUxVdtY=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1572080851;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        l=878; bh=LU6DDOmihitYkTVww+mLh369eU8sibrZGSH3hAdM0Nc=;
        b=TRbyq1LYahhFUL0nwuGVUQ7/sZtVczsPTcF9KixR4jM7T66OggYxmmnUL0jyT0JD
        w6qFr0WJudd6+mcr7bE0tVECLhnjPEg0BF1znMZ0KYUr86fxXIt6BF5Qrt0YORAFLED
        wr7YzTTlGRNKi8NiZKddRvtTCN6nmyxptPzMFwCc=
Received: from localhost.localdomain (116.30.192.119 [116.30.192.119]) by mx.zoho.com.cn
        with SMTPS id 1572080848029478.60393130348143; Sat, 26 Oct 2019 17:07:28 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     jack@suse.com
Cc:     linux-ext4@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20191026090721.23794-1-cgxu519@mykernel.net>
Subject: [PATCH v2] ext2: don't set *count in the case of failure in ext2_try_to_allocate()
Date:   Sat, 26 Oct 2019 17:07:21 +0800
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Currently we set *count to num(value 0) in the failure
of block allocation in ext2_try_to_allocate(). Without
reservation, we reuse *count(value 0) to retry block
allocation and wrong *count will cause only allocating
maximum 1 block even though having sufficent free blocks
in that block group. Finally, it probably cause significant
fragmentation.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
v1->v2:
- Add detail explanation of effect to changelog.

 fs/ext2/balloc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ext2/balloc.c b/fs/ext2/balloc.c
index e0cc55164505..29fc3a5054f8 100644
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
2.21.0



