Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44BC5E7BE8
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Sep 2022 15:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiIWNeN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 23 Sep 2022 09:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiIWNeM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 23 Sep 2022 09:34:12 -0400
Received: from shell.v3.sk (mail.v3.sk [167.172.186.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC3B131F54
        for <linux-ext4@vger.kernel.org>; Fri, 23 Sep 2022 06:34:11 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id CE8A7E3887;
        Fri, 23 Sep 2022 13:12:37 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id UpgK_Xk-K7Ha; Fri, 23 Sep 2022 13:12:36 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 0160FE3889;
        Fri, 23 Sep 2022 13:12:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id QnzHD766Kf45; Fri, 23 Sep 2022 13:12:35 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 56887E3887;
        Fri, 23 Sep 2022 13:12:35 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] tune2fs: fix an error message
Date:   Fri, 23 Sep 2022 15:25:48 +0200
Message-Id: <20220923132548.1701519-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

  $ tune2fs -O ^has_journal -ff /dev/sdh2
  Recovering journal. tune2fs: Unknown code ____ 251 while recovering jou=
rnal.

  Before: Please run e2fsck -fy -O.
  After: Please run e2fsck -fy /dev/sdh2.

Note this doesn't fix the "Unknown code" message, just the "Please run
e2fsck" one.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 misc/tune2fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc/tune2fs.c b/misc/tune2fs.c
index 088f87e5..c85737ad 100644
--- a/misc/tune2fs.c
+++ b/misc/tune2fs.c
@@ -3343,7 +3343,7 @@ _("Warning: The journal is dirty. You may wish to r=
eplay the journal like:\n\n"
 		if (retval) {
 			com_err("tune2fs", retval,
 				"while recovering journal.\n");
-			printf(_("Please run e2fsck -fy %s.\n"), argv[1]);
+			printf(_("Please run e2fsck -fy %s.\n"), device_name);
 			rc =3D 1;
 			goto closefs;
 		}
--=20
2.37.3

