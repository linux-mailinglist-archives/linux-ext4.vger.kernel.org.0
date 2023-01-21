Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70E6676960
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Jan 2023 21:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjAUUhO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 21 Jan 2023 15:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjAUUgt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 21 Jan 2023 15:36:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAF629404
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 12:36:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBF0960B7A
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 820D4C433A0
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674333405;
        bh=oQmgzUdIgg73PPkYMSSJW+stji+THJwg5Hc1tvFGtRQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=KYR8tvYEsRdC/Z+h3m5wsozooMCuJ+GmPQbOoSO1xR3OmvI9qEheLI7iq+EmoAQyH
         8zPTR0E8RZ+eOGG7HsjxkOtYIYg1jVaTmKBNraOezWXmfN+jqwt1To8yZa46evlviq
         Vr+7jQWLy3vzNy6w7wyTiirp49DNYEgQBQdO63B2dHOr5UFnbrbPiRwIoGSjqubpEN
         dvyZtpHbQaIBIBx8y//TeogBIG05/vSqFQhP1DFgUYCJp8QdloacBopjhNAC/9TNRG
         tWFKAP2m7gfRIFrxGERTZcetSfHV1Dfm8kB+QKfDf5XxsLPhknhoi21WPjGa+qF7h6
         ND3PbYIyugBzw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 35/38] misc/tune2fs: fix -Wunused-variable warnings in handle_fslabel()
Date:   Sat, 21 Jan 2023 12:32:27 -0800
Message-Id: <20230121203230.27624-36-ebiggers@kernel.org>
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

These warnings show up in non-Linux builds.  To fix them, only declare
local variables when they are needed.

While we're here, also make handle_fslabel() static.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 misc/tune2fs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/misc/tune2fs.c b/misc/tune2fs.c
index 7937b8b56..d3258149e 100644
--- a/misc/tune2fs.c
+++ b/misc/tune2fs.c
@@ -3082,14 +3082,15 @@ fs_update_journal_user(struct ext2_super_block *sb, __u8 old_uuid[UUID_SIZE])
  *		1 on error
  *		-1 when the old method should be used
  */
-int handle_fslabel(int setlabel) {
+static int handle_fslabel(int setlabel)
+{
+#ifdef __linux__
 	errcode_t ret;
 	int mnt_flags, fd;
 	char label[FSLABEL_MAX];
 	int maxlen = FSLABEL_MAX - 1;
 	char mntpt[PATH_MAX + 1];
 
-#ifdef __linux__
 	ret = ext2fs_check_mount_point(device_name, &mnt_flags,
 					  mntpt, sizeof(mntpt));
 	if (ret) {
-- 
2.39.0

