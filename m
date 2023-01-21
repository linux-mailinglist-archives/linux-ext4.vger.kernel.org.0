Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46AA9676965
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Jan 2023 21:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjAUUh3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 21 Jan 2023 15:37:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjAUUgt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 21 Jan 2023 15:36:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD88E29401
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 12:36:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F799B80880
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEFC1C433A4;
        Sat, 21 Jan 2023 20:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674333403;
        bh=nZolUev9y8vGyoa8mztER7yXUdthugp/QkTK4SWdr5o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oXP2lFEmSIJuACU2+meYlEBLshtyUJNYwdLygZPo1oRSCh+zZc3XNl/LH1REwKzLr
         wThPOFIJGwr2I6aDkIHDy34M2EITXXCoCsZkG7MYYMMNyPAr5uts4+ZrfVXBLWjdFu
         8NLbAlOe3U5zN9qFzDxG8FoadGzp9rX/DGT7jcpn5rew5UXSCVvjb0lfhoAbCMCOoZ
         7HaQ4SSWlhTQzyX741wHhSBUlO36Tz9l5NxWz4NzilGuvHrnbxOG7q8V5gp60DC7u0
         K5D+feHCeuhVyxhzPsRCVwdmTPrEVLddlPyQrYAI5kZgVhhsTCQgsf56ke+SzpWPEu
         lGOgIPdmBX1Ow==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Cc:     Lukas Czerner <lczerner@redhat.com>
Subject: [PATCH 23/38] lib/support: remove unused label in get_devname()
Date:   Sat, 21 Jan 2023 12:32:15 -0800
Message-Id: <20230121203230.27624-24-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230121203230.27624-1-ebiggers@kernel.org>
References: <20230121203230.27624-1-ebiggers@kernel.org>
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

Reviewed-by: Lukas Czerner <lczerner@redhat.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 lib/support/devname.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/support/devname.c b/lib/support/devname.c
index 8c2349a32..e0306ddfb 100644
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

