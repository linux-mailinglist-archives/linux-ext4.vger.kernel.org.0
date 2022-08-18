Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9FE0598904
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Aug 2022 18:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343847AbiHRQhg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Aug 2022 12:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244557AbiHRQhf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Aug 2022 12:37:35 -0400
X-Greylist: delayed 338 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 18 Aug 2022 09:37:26 PDT
Received: from nov-007-i646.relay.mailchannels.net (nov-007-i646.relay.mailchannels.net [46.232.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975DBBD1FE
        for <linux-ext4@vger.kernel.org>; Thu, 18 Aug 2022 09:37:25 -0700 (PDT)
X-Sender-Id: novatrend|x-authuser|juerg@bitron.ch
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 2C3E82EC0125;
        Thu, 18 Aug 2022 16:31:45 +0000 (UTC)
X-Sender-Id: novatrend|x-authuser|juerg@bitron.ch
X-MC-Relay: Neutral
X-MailChannels-SenderId: novatrend|x-authuser|juerg@bitron.ch
X-MailChannels-Auth-Id: novatrend
X-Rock-Battle: 4a49c51500084122_1660840304749_2583936967
X-MC-Loop-Signature: 1660840304749:1531491570
X-MC-Ingress-Time: 1660840304749
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bitron.ch;
        s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=lJ6oeWv+txluGOADm8nXm+vjTNfSnFT+DYkWL9esStM=; b=gc65RNBKFhIKDb2gRFG95Uc8rq
        r3Q4e85VmhxZ1STSlw+SXLmQKzAhXDKI5Lmma3/yy4Soe+Q1aILNgdr4NQG4fCmaPPkMvHY7brHlJ
        526lsZmz7PV0q+RipKa2DWFG5;
From:   =?UTF-8?q?J=C3=BCrg=20Billeter?= <j@bitron.ch>
To:     linux-ext4@vger.kernel.org
Cc:     Theodore Ts'o <tytso@mit.edu>,
        =?UTF-8?q?J=C3=BCrg=20Billeter?= <j@bitron.ch>
Subject: [PATCH] create_inode: do not fail if filesystem doesn't support xattr
Date:   Thu, 18 Aug 2022 18:31:32 +0200
Message-Id: <20220818163132.1618794-1-j@bitron.ch>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AuthUser: juerg@bitron.ch
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

As `set_inode_xattr()` doesn't fail if the `llistxattr()` function is
not available, it seems inconsistent to let `set_inode_xattr()` fail if
`llistxattr()` fails with `ENOTSUP`, indicating that the filesystem
doesn't support extended attributes.

Signed-off-by: Jürg Billeter <j@bitron.ch>
---
 misc/create_inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/misc/create_inode.c b/misc/create_inode.c
index c00d5458..d7ab1c20 100644
--- a/misc/create_inode.c
+++ b/misc/create_inode.c
@@ -150,6 +150,8 @@ static errcode_t set_inode_xattr(ext2_filsys fs, ext2_ino_t ino,
 
 	size = llistxattr(filename, NULL, 0);
 	if (size == -1) {
+		if (errno == ENOTSUP)
+			return 0;
 		retval = errno;
 		com_err(__func__, retval, _("while listing attributes of \"%s\""),
 			filename);
-- 
2.35.3

