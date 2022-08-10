Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7AD958F37A
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Aug 2022 22:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbiHJUXE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 10 Aug 2022 16:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbiHJUXE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 10 Aug 2022 16:23:04 -0400
X-Greylist: delayed 91 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 10 Aug 2022 13:23:02 PDT
Received: from omta001.cacentral1.a.cloudfilter.net (omta001.cacentral1.a.cloudfilter.net [3.97.99.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D1712AD9;
        Wed, 10 Aug 2022 13:23:02 -0700 (PDT)
Received: from shw-obgw-4002a.ext.cloudfilter.net ([10.228.9.250])
        by cmsmtp with ESMTP
        id LnhQoBo01S8WrLsCooYX6K; Wed, 10 Aug 2022 20:21:30 +0000
Received: from fanir.tuyoix.net ([68.150.218.192])
        by cmsmtp with ESMTP
        id LsCnoCRzPC3uhLsCooPkZO; Wed, 10 Aug 2022 20:21:30 +0000
X-Authority-Analysis: v=2.4 cv=a6MjSGeF c=1 sm=1 tr=0 ts=62f4134a
 a=LfNn7serMq+1bQZBlMsSfQ==:117 a=LfNn7serMq+1bQZBlMsSfQ==:17
 a=biHskzXt2R4A:10 a=M51BFTxLslgA:10 a=nlC_4_pT8q9DhB4Ho9EA:9 a=3I1X_3ewAAAA:8
 a=WYyIRKPEA7E15j6liCQA:9 a=QEXdDO2ut3YA:10 a=VG9N9RgkD3hcbI6YpJ1l:22
Received: from tuyoix.net (fanir.tuyoix.net [192.168.144.16])
        (authenticated bits=0)
        by fanir.tuyoix.net (8.17.1/8.17.1) with ESMTPSA id 27AKKjSx021807
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 10 Aug 2022 14:21:28 -0600
Date:   Wed, 10 Aug 2022 14:20:45 -0600 (MDT)
From:   =?UTF-8?Q?Marc_Aur=C3=A8le_La_France?= <tsi@tuyoix.net>
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ext4: Register ext[23] support only after successful ext4
 registration
Message-ID: <7ef87cdb-0d0b-2488-6f42-a670a6454630@tuyoix.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463807856-1187121505-1660162889=:21798"
X-CMAE-Envelope: MS4xfETwVeud0/q+9aKL615T+Eu82O7Wd/7qdumgmXBWXiAAby6jOSwoi9TJWyNmF1KhqfpLViFWdIeGYOJGOWz1VVbipVhDRUHw2Jgd1kVNrdOrXStkqm97
 Ss6Of6ztF8DfJ5h4WqrF8QBuu1rRDK1fq3MeVjAwey00nJ9GOC8NBrhDDmMN5hmllhuWBlPm/mj0HfjkQop+Cj/hUeP7bAYNOzxf3zaSigDEibWN/T8p0LeD
 oQO1zZtDzSwkeWDLevPD9Ugoc+WIDoH621flDzCxeN7WXRHp/4h2I6dmJkVQroOM
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463807856-1187121505-1660162889=:21798
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Register ext4 as a "replacement" for ext2 and ext3 only after ext4 itself has
been successfully registered.  As a side effect, this allows
unregister_as_ext[23]() to be inlined.

This change is not eligible for stable@.

Please Reply-To-All.

Thanks and have a great day.

Marc.

Signed-off-by: Marc Aurèle La France <tsi@tuyoix.net>

diff -aNpRruz -X /etc/diff.excludes linux-5.17.1/fs/ext4/super.c devel-5.17.1/fs/ext4/super.c
--- linux-5.17.1/fs/ext4/super.c	2022-03-28 02:03:22.000000000 -0600
+++ devel-5.17.1/fs/ext4/super.c	2022-03-28 07:14:10.799008309 -0600
@@ -7123,16 +7123,14 @@ static int __init ext4_init_fs(void)
 	if (err)
 		goto out05;

-	register_as_ext3();
-	register_as_ext2();
 	err = register_filesystem(&ext4_fs_type);
 	if (err)
 		goto out;

+	register_as_ext3();
+	register_as_ext2();
 	return 0;
 out:
-	unregister_as_ext2();
-	unregister_as_ext3();
 	ext4_fc_destroy_dentry_cache();
 out05:
 	destroy_inodecache();
---1463807856-1187121505-1660162889=:21798--
