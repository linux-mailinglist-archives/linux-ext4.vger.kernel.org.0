Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F19ABA68CF
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Sep 2019 14:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbfICMoR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 3 Sep 2019 08:44:17 -0400
Received: from mout.web.de ([212.227.17.12]:59177 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728996AbfICMoR (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 3 Sep 2019 08:44:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1567514650;
        bh=OB42t441CkjUlM1xTY9OGP06693iK0948hcgi9EiEaI=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=piNmEVL1DWo/PMf5GIczGhNf0CJqcg8I50t6Sc8YLLKwEFeRrUGF6jPArwPAOPmvp
         8pVrwi4hbiiwhjF8meDrwiFKEYIyI8qIqD/nlPHxyMb5bALS5bddLi4R3laNjDq5Ux
         pE5V+DqdlzJf8XApYOxc+O3VVlNS4SmzsJfr9f2A=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.133.43]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MEVhF-1hynZo3b7B-00Fk6p; Tue, 03
 Sep 2019 14:44:09 +0200
To:     linux-ext4@vger.kernel.org, Jan Kara <jack@suse.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] ext2: Delete an unnecessary check before brelse()
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <51dea296-2207-ebc0-bac3-13f3e5c3b235@web.de>
Date:   Tue, 3 Sep 2019 14:44:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fDKb4hhNMYZ9p7iiL29GGAMRQGX7LPMidSNO+OnTKZ78fOm7c6J
 BFisXkPeKxMsK37Ku8FRDkpbsPvtUV/gfS05RjhPaHadUTHkfS1RdjYf2kAe5pehUXYY8N2
 sbnFXk7D8AQcYWDMsN7sF6upjqh5VMmWwdy0XRusMVOlgL+dH9ndq6/5/KE55/nVTkolY9J
 IBrF1kj+0beDEtnNUMKgQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:1WAao00adBI=:5FDVXGdCEhCxWD/GZiDAbj
 qlo/6vlG2hkOkp30I9oWBPMrMfm2Ips+u0YbLNbCcux4zyLTVUVek44zn+cgAsZBRjcxMGkyY
 hJkKF+4K3aVqP2swznTj0kpHRHlEM4YGoorQLTiQKCiVONgS+Uz2J2HlwwME18amYaRe/rFKX
 tbvdpWBQDBtqzCmqY8IRRdMbV2cfFlVmv1bRUYxLQVxioVUd2Ud2xcpXa/zHAX+6+gT0dVfQV
 qjQWwmAq0PJNrRNWljT6Z9AezCKpDUe2k/MbUt6E5bPzGlYbE0bzFrqGbdT81s9rCRyziyUEu
 7HGVJplqTQDknsCmCsPvroUZ97dUG7j7dfNtpIhvfrnIwFnC9+JowTwK/LtOm3hlXu0QkUQER
 LbPWWgMxdXO6j66SIzxFgMgEGNv43gLVuplmku8jArAje/zZc3tQZ0i0qdGA3n2CDk9VQArQE
 AD2Tn9gJ1p3CXMKUO8pZg0xok6riffIj9kCqTGvhn9HXzxHve/ENIWKBI7a3JamHzI8I23EmD
 LVemdo+HsNnMHOvzKuK36wlSYpq/rx4ki9vqFzM/iZNpgi+pMnQyaqSu6O0/F+KpBf99D7138
 xcvvzHgzWS5ILUr4jXMXqGqx8SKXNELUAGZJ0zPFhgMyMUd0qe536ZlvTNVPhG4e2WKEK1WS2
 6zp5qpAOyN3YX8t0BJQph1NUIS8JDqyeSJBEDCbLKA7Nckr3axvxzVvCnxIy8YuZW0dn79nwq
 FciJYy2ArTQfFdsvr938css8RBzCh2TsoXDuujPr9opnzWA0kwCLDGnqpmdaqdydwuHVShH/I
 igLAHTZu5G0FNkG2y9XjehMw9oodp5mq0tgNBtMChBSAXxZLVXzSm6tXW19ohPK+LnzZRa/0G
 RHMvBvcUC/wMEpGOiBW8QBb9ii1xubjt9G0PfbqTtJygLCMj7a9IrpddILBCOJixxAZ7soGRe
 liJXOU4J7XTWkmtzo0Zm+IeUJBlLV1fe8IDqsV6TliB75zq5dCHynPaxp4aKobZxUQiQnx5lr
 goaJrxGgs5XgAvEbGDa8FRzt+JztnkLG00jpK6jt98GE4+C2W/LxnWA2l0wD9t93msqaVNTIt
 L7X9cU1ctck3xl05fZ7jeQXCZIJ3DWlJIsqpU11te5ahUTn7INMjBxqy9XngE3Ay7uf14mzov
 KNJMgUdCWlO41DQbLRxHED/yKnEwZvkarahU/9wCu3Q28lyA==
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 3 Sep 2019 14:40:18 +0200

The brelse() function tests whether its argument is NULL
and then returns immediately.
Thus the test around the call is not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/ext2/super.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index baa36c6fb71e..30c630d73f0f 100644
=2D-- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -162,8 +162,7 @@ static void ext2_put_super (struct super_block * sb)
 	}
 	db_count =3D sbi->s_gdb_count;
 	for (i =3D 0; i < db_count; i++)
-		if (sbi->s_group_desc[i])
-			brelse (sbi->s_group_desc[i]);
+		brelse(sbi->s_group_desc[i]);
 	kfree(sbi->s_group_desc);
 	kfree(sbi->s_debts);
 	percpu_counter_destroy(&sbi->s_freeblocks_counter);
=2D-
2.23.0

