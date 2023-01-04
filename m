Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0769365CF03
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Jan 2023 10:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbjADJEN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Jan 2023 04:04:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234066AbjADJDv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 Jan 2023 04:03:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F7CB1B
        for <linux-ext4@vger.kernel.org>; Wed,  4 Jan 2023 01:03:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CFC24B81366
        for <linux-ext4@vger.kernel.org>; Wed,  4 Jan 2023 09:03:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76461C433D2;
        Wed,  4 Jan 2023 09:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672823028;
        bh=n+8e/fJ/L1a0Revfdd/SwZ8NDjuLIr+Yj1JiI1MHyyA=;
        h=From:To:Cc:Subject:Date:From;
        b=nP+7ma6K4CnUxvrvKwqzRnzIcreBT4rtxXB8nv/5WgJYVrpvs1C2rYgXov4EdXEVA
         ii2V5gu5TX/LzWhB8BJ2i0nGNpwNz58y2UYOzYXVQbXdQU0GHKSJuOo+29J3DX0l58
         OtVP7ZGLPzEmOJecRLhElvP5UL+I+PXDx5reOLy7noHllRSfl3Zwcd/2ZX03BXESqQ
         rzJGLeC5uel/e7pvRnryn2yoY3GqtFvSuhoWTztfJkhlpg5NCq4YucGlDqfEKMB8dL
         /bM3ynv9lnkHmhb0bklSZK0xtJMvdajW/pHWZ4lj7iboGdtNi7doSYdIxxkV8iwcgH
         6Kv3/r3Cj3nKA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Cc:     Lukas Czerner <lczerner@redhat.com>
Subject: [e2fsprogs PATCH] libsupport: remove unused label in get_devname()
Date:   Wed,  4 Jan 2023 01:03:41 -0800
Message-Id: <20230104090341.276131-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Address the following compiler warning with gcc -Wall:

devname.c: In function ‘get_devname’:
devname.c:61:1: warning: label ‘out_strdup’ defined but not used [-Wunused-label]
   61 | out_strdup:
      | ^~~~~~~~~~

Cc: Lukas Czerner <lczerner@redhat.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 lib/support/devname.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/support/devname.c b/lib/support/devname.c
index 8c2349a3..e0306ddf 100644
--- a/lib/support/devname.c
+++ b/lib/support/devname.c
@@ -58,7 +58,6 @@ char *get_devname(blkid_cache cache, const char *token, const char *value)
 		goto out;
 	}
 
-out_strdup:
 	if (is_file)
 		ret = strdup(token);
 out:
-- 
2.39.0

