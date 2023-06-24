Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89DC73CBBD
	for <lists+linux-ext4@lfdr.de>; Sat, 24 Jun 2023 17:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjFXPyb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 24 Jun 2023 11:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjFXPya (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 24 Jun 2023 11:54:30 -0400
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A941BCA
        for <linux-ext4@vger.kernel.org>; Sat, 24 Jun 2023 08:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1687622058;
        bh=PppnM6CNiCqibVNJC/KxLiZ/Vbb9z1GbgweMJYp75Mw=;
        h=From:To:Cc:Subject:Date;
        b=y2FWz7xnvziyXrCIBIo3tfg9qz3eabP5epHk3nyqloN6Kz9+ms+Dw4PtYYSeQFFGn
         1O05MD1yiUia8UTeLo31WJvHgYbAxf8NgIVwx4b9zPtZdQvcmwwv0aplPjBt1AvB6k
         2iHdEnuNhUZ5fxZG67JobS6jvLwe8auBxWIVYkGE=
Received: from fedora.. ([2409:8a00:2570:b8a0:da5a:8709:bf59:8c40])
        by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
        id D4E3C8DB; Sat, 24 Jun 2023 23:53:14 +0800
X-QQ-mid: xmsmtpt1687621994t0hh4gafs
Message-ID: <tencent_D6CD42314E6CD7A9ABA771CF10C464390005@qq.com>
X-QQ-XMAILINFO: MjBTD0ccEFNA4LdVE34A9s1fyhJEUTDr7etk7LU4fI3p5o0i+8fsMRjry7QTEc
         r8Md5VW5tz/dEolB/N3xFtU5TKnw6kAAbLRRKZzje86GauHSQeMbnNqrVFmsVRTyJK1+W4BUTZ0n
         6UaQAy6Jh+REr0HNQlHxBbNlVzrqnDf590c6qkuCSswsfufqWcYYyRe4+b1JjXtmkzmNZ2cEUJkI
         /0lFgNQCvqW6d4LnIvpxNe/ZkWphuXi0QCJMrfJIrflD6gVIqnhGm3Ntkbakie1AlCZWb2vySQrH
         29y7nOK2/9/5YYGRtM3dkqgqVwZQX0DhSM6tVo6HhxaUo2UMPCPDLwnC3EOesz3R+FCpENfj0Qdj
         VLoOJdAHDxAzLfqATf4Qh4M+5aZMhMFm2cteIAIZ4eZ7rrLtfkO+TvTLIQNt2q07sX0RTvO9EsBq
         OSAsCc1y3LbLk5jYrd5nsTGJoru3/eDm5zIN5AsLepMNhMW375PJiSwkpXt2bF2nbeKaal6vNLLb
         uxOvS3fnsddJzgBNqrb1wZ1seOHsEn6sDbCBdSWYOacY7EfUbsWYwUJw1mlhMH4i4riQEn4NA4a/
         zxB7PCqRf+vn++mIMT1FN30Y3WoN9+seuSh3LMdWBrlJw5ZRDXi/A4WNp1UKNSD+cQLKdtsvSskB
         19KOmeNnmREkAfuq/n4VwVqNElCakW4mlvUpQKI5gWEv74qPZvUfNaOpTG1GUWfcjcsErojUQHn1
         aTpOe3gTtAqeEswS6l4wkra4vzJwJQMHmzdd+jzyMOlJioKBXurw4v/chNjsrped79s0YcwwiK/H
         NUo7e0dHVwlKPbTHvMlnD0J2DM4Msr6bAdosiDs/MXZq8Tz7Ya3OIyHE3okrTpBj1Zk/Vn1FjUw5
         9fsE8OMvDEzzEzIftlFp0eDax7YIUJlB0HXNENz92GjKZLvFsf6+izFvK/y6/idrIDtQ6FmhGuD2
         1CENWPm3zoNVvOT445T12EcrH49/yHu7kAid98vR6tnBobhvFDFA==
X-QQ-XMRINFO: OaHeJnMbHdYJoNPX7mruotAPXHzc5BrOrw==
From:   Wang Jianjian <wangjianjian0@foxmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     wangjianjian0@foxmail.com
Subject: [PATCH] ext4: Free data blocks directly for ordered journal
Date:   Sat, 24 Jun 2023 23:52:59 +0800
X-OQ-MSGID: <20230624155259.62799-1-wangjianjian0@foxmail.com>
X-Mailer: git-send-email 2.34.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

---
 fs/ext4/mballoc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 7b2e36d103cb..41fdc2f8c061 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -6206,7 +6206,7 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
 	 * consistency guarantees.
 	 */
 	if (ext4_handle_valid(handle) &&
-	    ((flags & EXT4_FREE_BLOCKS_METADATA) ||
+	    ((ext4_should_order_data(inode) && (flags & EXT4_FREE_BLOCKS_METADATA)) ||
 	     !ext4_should_writeback_data(inode))) {
 		struct ext4_free_data *new_entry;
 		/*
-- 
2.34.3

