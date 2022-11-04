Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A11F6193F5
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Nov 2022 10:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbiKDJ6o (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 4 Nov 2022 05:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiKDJ6n (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 4 Nov 2022 05:58:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF19C1CB0F
        for <linux-ext4@vger.kernel.org>; Fri,  4 Nov 2022 02:58:41 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <uol@pengutronix.de>)
        id 1oqtTE-0006PP-8J; Fri, 04 Nov 2022 10:58:40 +0100
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <uol@pengutronix.de>)
        id 1oqtTD-002F02-GC; Fri, 04 Nov 2022 10:58:38 +0100
Received: from uol by dude03.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <uol@pengutronix.de>)
        id 1oqtTB-004RAW-7i; Fri, 04 Nov 2022 10:58:37 +0100
From:   =?UTF-8?q?Ulrich=20=C3=96lmann?= <u.oelmann@pengutronix.de>
To:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     =?UTF-8?q?Ulrich=20=C3=96lmann?= <u.oelmann@pengutronix.de>
Subject: [e2fsprogs PATCH] debugfs.8: fix typo
Date:   Fri,  4 Nov 2022 10:58:35 +0100
Message-Id: <20221104095835.1057703-1-u.oelmann@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: uol@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-ext4@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Signed-off-by: Ulrich Ölmann <u.oelmann@pengutronix.de>
---
 debugfs/debugfs.8.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/debugfs/debugfs.8.in b/debugfs/debugfs.8.in
index a3227a80ab24..5b5329c38d6e 100644
--- a/debugfs/debugfs.8.in
+++ b/debugfs/debugfs.8.in
@@ -280,7 +280,7 @@ The hash seed specified with
 must be in UUID format.
 .TP
 .BI dump_extents " [-n] [-l] filespec"
-Dump the the extent tree of the inode
+Dump the extent tree of the inode
 .IR filespec .
 The
 .I -n
-- 
2.30.2

