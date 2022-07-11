Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0BAF57085A
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Jul 2022 18:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiGKQaG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 11 Jul 2022 12:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiGKQaC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 11 Jul 2022 12:30:02 -0400
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3170211C09
        for <linux-ext4@vger.kernel.org>; Mon, 11 Jul 2022 09:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1657556990;
        bh=DxmupAZsBDKPp6Sdn5io+7Bjin7OjUvkJl+T8Rym94Q=;
        h=From:To:Cc:Subject:Date;
        b=tc+xFG0CHs9gfLMPndK26+t5R/HgfLWV9itcZI530JWSVMFvZU9bSYkDRndU+76Xd
         ocbtc1NcNsDOeTR84El7hN4TEfg+5RD7IdTt9xvfJ3jwiTxshSQH1yL7mL9KDJMma2
         k7kk2F3JTHUr+PxrL19LgpgIO8LSEE3rA9kgx038=
Received: from fedora.. ([123.112.70.63])
        by newxmesmtplogicsvrszc10.qq.com (NewEsmtp) with SMTP
        id 6A99663F; Tue, 12 Jul 2022 00:26:41 +0800
X-QQ-mid: xmsmtpt1657556801tbm5y9wql
Message-ID: <tencent_D668868A37626B4E053D6D7B5320DBCB1C08@qq.com>
X-QQ-XMAILINFO: MllZffuBkEb5BdH8XmAYbKAMpfIKwvJzGdVcdQRrZDVP98iN16GOze2aiggvcT
         pOjGTiUjnCY9+0T5Fm02Iwi6bZba3mZ9Ik4biX2PxL7U861kFWYGkleH3xZ+So5RYyGLHEiUlviT
         8Sr5CuCKCHqv7BC17dmlmcQLs6eitpSf6/h3EWCuvQfCCkXFPpB0tio2VVbZk8xK0MddtARW8AtG
         +NMGQuXzspvZ6H+Zze7JA5LK7x4EelaDPOyZT8XYdh37B/C/Q1FDkQBRY/hU0IqG2IN+2R0nbW9P
         PwmLX0Q8ymcjI6Dq+wvPzd4YEEfmXr7N2TCQQY/+LOnrSQhkn7q9+iiiXbFUXzkxWxz4RKJgmM7J
         jdyLrlEb4xmmt5YbF7Qr50CvzP6qLim335zjKENb+2GeFlNyHD94newipPMneKSFLorG3xxN4EEz
         XulDf2w5TndEKBqniAp/V7DGqYgpQrbEpWj3JfzT47zq78hxWtShn8JyX1Y3fEf64QczrL3VOTAu
         wgWMrxU8csbrC+COb/CxaQtwpiT9Zbg0mVWPxwiI+47xSpWakcoYXK6bOdmFG4Kaxc1N9ohQsOlT
         R9le681KQBPQr4x25QjgUo7U0+TtXTEgYTneo3+TSVzXQgcUaSiFMlM6IFsswqrof/7Rma/6HFAe
         sD6eMm0KB9bgYowMYUdJ+wnLbV4W0lz2NIM/kETH3+YWsaEU0ul2o2imvyb0pnWxib9bGojRCsxN
         K+PpiJj+eTAsD9y4EfsgzEmwHxj53fSv4jQ9PNV+KN1IplB3t7qqC3A/FQtMJs0wjqMduyVjy6xT
         4RrybTMBeInFAUXib5/Mn1b1UuJ3kWQZDkEiH2vOnEMxq39rLBqMDOW9aBErOA3n2ZwoUjGJ07s8
         5xf7sDroIt+wGi5T9yyfGotI+bCw1wZOocKuVoDhhGx2tCYoIM3/w4x3oG9MF2FU7gRJl4v9Mznu
         2d7V2CraqESQuGB5v1TMz9+rlQcyE/HpOiBwn5F3XgLbTYrzphUmV5XJmwvZ4T2T7UtnBDgkDUxP
         61L+HqqYFjfrfrw9OW
From:   Wang Jianjian <wangjianjian0@foxmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Wang Jianjian <wangjianjian0@foxmail.com>
Subject: [PATCH] jbd2: Set the right uuid for block tag
Date:   Tue, 12 Jul 2022 00:26:37 +0800
X-OQ-MSGID: <20220711162637.1656784-1-wangjianjian0@foxmail.com>
X-Mailer: git-send-email 2.34.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

journal->j_uuid is not initialized and let us use the uuid from
j_superblock. And since this is the only place where j_uuid is used
so that we can remove it.

Signed-off-by: Wang Jianjian <wangjianjian0@foxmail.com>
---
 fs/jbd2/commit.c     |  2 +-
 include/linux/jbd2.h | 10 ----------
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 5b9408e3b370..efde9c494e7a 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -720,7 +720,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 		bufs++;
 
 		if (first_tag) {
-			memcpy (tagp, journal->j_uuid, 16);
+			memcpy (tagp, journal->j_superblock->s_uuid, 16);
 			tagp += 16;
 			space_left -= 16;
 			first_tag = 0;
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index de9536680b2b..9d51f4b55cb5 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1079,16 +1079,6 @@ struct journal_s
 	 */
 	tid_t			j_commit_request;
 
-	/**
-	 * @j_uuid:
-	 *
-	 * Journal uuid: identifies the object (filesystem, LVM volume etc)
-	 * backed by this journal.  This will eventually be replaced by an array
-	 * of uuids, allowing us to index multiple devices within a single
-	 * journal and to perform atomic updates across them.
-	 */
-	__u8			j_uuid[16];
-
 	/**
 	 * @j_task: Pointer to the current commit thread for this journal.
 	 */
-- 
2.34.3

