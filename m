Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C321D563F9B
	for <lists+linux-ext4@lfdr.de>; Sat,  2 Jul 2022 13:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbiGBLHx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 2 Jul 2022 07:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbiGBLHw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 2 Jul 2022 07:07:52 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C8415A24;
        Sat,  2 Jul 2022 04:07:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D86A9CE0121;
        Sat,  2 Jul 2022 11:07:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A511C341CA;
        Sat,  2 Jul 2022 11:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656760068;
        bh=tBv95/of+78CCOl13jgM+LOJKweUAuGjF5j/ye3oFZ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LT9KrD+rWg9IuzsItd1P7y/5em1aDpXbR2u7NogYL19x5A15sKXxbN9mMtJUFCgLl
         5XyBnScayiFL4ktv3zhjlS+G3gwfrEZs8QDi9FXEKAXErB9Jh1cd8t2iR2MeITFtWy
         VnK+KOALajxQ0ja4fLnSfeJ6JoEQMYueFxkzY/cbtZE3lN4HoeL7EW5DGAd3PwlZAz
         9KEgumA/MhWFI3U7OY9/6xIANGO/L6XW+jSyZphg0cmR7Zzt5XqlpWcbgbOkxgZ9b3
         8ZV4pDpcO5clpXmhU4eJQUsBOy/z/KX34LjEKAWoiTbGhzAhj8pq6odxWAybv1xMqu
         fjGVZZkn4ysaQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1o7ayX-007grr-Jm;
        Sat, 02 Jul 2022 12:07:45 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/12] docs: ext4: blockmap.rst: fix a broken table
Date:   Sat,  2 Jul 2022 12:07:33 +0100
Message-Id: <002632a675934d5e7e0899559eb9da4e53639137.1656759989.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656759988.git.mchehab@kernel.org>
References: <cover.1656759988.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

There's one missing space, causing a long error message when
building the docs.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/12] at: https://lore.kernel.org/all/cover.1656759988.git.mchehab@kernel.org/

 Documentation/filesystems/ext4/blockmap.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/filesystems/ext4/blockmap.rst b/Documentation/filesystems/ext4/blockmap.rst
index 2bd990402a5c..cc596541ce79 100644
--- a/Documentation/filesystems/ext4/blockmap.rst
+++ b/Documentation/filesystems/ext4/blockmap.rst
@@ -1,7 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0
 
 +---------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
-| i.i_block Offset   | Where It Points                                                                                                                                                                                                              |
+| i.i_block Offset    | Where It Points                                                                                                                                                                                                              |
 +=====================+==============================================================================================================================================================================================================================+
 | 0 to 11             | Direct map to file blocks 0 to 11.                                                                                                                                                                                           |
 +---------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
-- 
2.36.1

