Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D738676947
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Jan 2023 21:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjAUUgt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 21 Jan 2023 15:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjAUUgn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 21 Jan 2023 15:36:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1369F28D32
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 12:36:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D930E60B6E
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0FEFC4339E
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674333400;
        bh=cetx1mAkAWZjY6IHf+Af5VO4OdrotI1R9aiRjV/sLsM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=merEyI3StstuHSbg9s1J8ptsLAuRAdufsgHoW10gKV+ioKSpGPZrMckBJA+AQG908
         W4WfkYC6Itv3EY3xXoILRllRSce+YhZ2LKl6XsFJeyJCr06XbPlyWW6zzC5YLTWL7W
         uyooZNRLuNTOnUYcERQYGdf/PFEowCuLsAKMpjoOHtOuJbyKAnbI6yXKCagVnH5U5u
         IW7fZA7D/+lBEO+kgF0GuSp/UJGoXwgIq5AeIr2uHrn5fcDKGRvH3Blx+aBn3GQHan
         UI/dTer4lD+Tmx2bDYu9l+uG48Zgl26A7wUYo63rWxsHe0Ht5K5QtLlD4aNniDx+Ho
         QAzs99yNlVKyQ==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 12/38] lib/e2p: fix a -Wunused-variable warning in getflags()
Date:   Sat, 21 Jan 2023 12:32:04 -0800
Message-Id: <20230121203230.27624-13-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230121203230.27624-1-ebiggers@kernel.org>
References: <20230121203230.27624-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

This affected Windows builds.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 lib/e2p/getflags.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/e2p/getflags.c b/lib/e2p/getflags.c
index e4e2ad735..6708cd68b 100644
--- a/lib/e2p/getflags.c
+++ b/lib/e2p/getflags.c
@@ -30,8 +30,8 @@
 
 int getflags (int fd, unsigned long * flags)
 {
-	struct stat buf;
 #if HAVE_STAT_FLAGS
+	struct stat buf;
 
 	if (fstat (fd, &buf) == -1)
 		return -1;
@@ -53,6 +53,7 @@ int getflags (int fd, unsigned long * flags)
 	return 0;
 #else
 #if HAVE_EXT2_IOCTLS
+	struct stat buf;
 	int r, f;
 
 	if (!fstat(fd, &buf) &&
-- 
2.39.0

