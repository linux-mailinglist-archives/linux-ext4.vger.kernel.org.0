Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D32C677151
	for <lists+linux-ext4@lfdr.de>; Sun, 22 Jan 2023 19:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjAVSG1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 22 Jan 2023 13:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjAVSG0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 22 Jan 2023 13:06:26 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B1B18B00;
        Sun, 22 Jan 2023 10:06:22 -0800 (PST)
Received: (Authenticated sender: didi.debian@cknow.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 9B478100007;
        Sun, 22 Jan 2023 18:06:18 +0000 (UTC)
From:   Diederik de Haas <didi.debian@cknow.org>
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-ext4@vger.kernel.org (open list:EXT4 FILE SYSTEM),
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list)
Cc:     Diederik de Haas <didi.debian@cknow.org>
Subject: [PATCH] docs: ext4: Fix full name of the GPL
Date:   Sun, 22 Jan 2023 19:05:51 +0100
Message-Id: <20230122180552.53445-1-didi.debian@cknow.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
---
 Documentation/filesystems/ext4/about.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/ext4/about.rst b/Documentation/filesystems/ext4/about.rst
index cc76b577d2f4..c150519bbf3f 100644
--- a/Documentation/filesystems/ext4/about.rst
+++ b/Documentation/filesystems/ext4/about.rst
@@ -17,7 +17,8 @@ created demonstration filesystems.
 
 License
 -------
-This book is licensed under the terms of the GNU Public License, v2.
+This book is licensed under the terms of the GNU General Public License,
+v2.
 
 Terminology
 -----------
-- 
2.39.0

