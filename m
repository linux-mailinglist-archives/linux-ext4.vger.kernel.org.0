Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9D1522418
	for <lists+linux-ext4@lfdr.de>; Tue, 10 May 2022 20:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343655AbiEJSdR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 10 May 2022 14:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243656AbiEJSdP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 10 May 2022 14:33:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E120E522F9;
        Tue, 10 May 2022 11:33:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E18760C6B;
        Tue, 10 May 2022 18:33:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8AB9C385A6;
        Tue, 10 May 2022 18:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652207593;
        bh=ccKR1Zfp7al/CzwoPIKOXL0ali/Vti4d4eC/NrVDCts=;
        h=From:To:Cc:Subject:Date:From;
        b=b8kPAjoxv68W5NPtzpDytz7+snjiKpSPEWmYd8sp+lXJmo9zYulVv3ztN0xkdAqnC
         Ro57BIV9kNy0/gI4HGBcjYnoK8Afqn955XEt1fjNNnkcqRUXGqmExd284/KKyrj4kn
         n2vPfMTe+jq4+ZrKXqxqB2mcp5R92bl/ZM/0g4Xn/aLlxwsjG+o0VQUtyBYeY3Pu1U
         wiarJcEZUGYbRbwcKiCgcdRWU7sWYTl6ATQRz/XRiBUYUFdyoj/i6j1x3hfMnQVIG6
         KTvtA93gyOmRL7fUTcB/8/5+z51qisSIWvfkmOodqTc39U6jaG6xuqDfv6mgI9uAoB
         IVaKEkn3DNb2w==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Cc:     fstests@vger.kernel.org, Lukas Czerner <lczerner@redhat.com>
Subject: [PATCH] ext4: reject the 'commit' option on ext2 filesystems
Date:   Tue, 10 May 2022 11:32:32 -0700
Message-Id: <20220510183232.172615-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

The 'commit' option is only applicable for ext3 and ext4 filesystems,
and has never been accepted by the ext2 filesystem driver, so the ext4
driver shouldn't allow it on ext2 filesystems.

This fixes a failure in xfstest ext4/053.

Fixes: 8dc0aa8cf0f7 ("ext4: check incompatible mount options while mounting ext2/3")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/ext4/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 1847b46af8083..69d67724df24f 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1913,6 +1913,7 @@ static const struct mount_opts {
 	 MOPT_EXT4_ONLY | MOPT_CLEAR},
 	{Opt_warn_on_error, EXT4_MOUNT_WARN_ON_ERROR, MOPT_SET},
 	{Opt_nowarn_on_error, EXT4_MOUNT_WARN_ON_ERROR, MOPT_CLEAR},
+	{Opt_commit, 0, MOPT_NO_EXT2},
 	{Opt_nojournal_checksum, EXT4_MOUNT_JOURNAL_CHECKSUM,
 	 MOPT_EXT4_ONLY | MOPT_CLEAR},
 	{Opt_journal_checksum, EXT4_MOUNT_JOURNAL_CHECKSUM,

base-commit: 23e3d7f7061f8682c751c46512718f47580ad8f0
-- 
2.36.1

