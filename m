Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4BBC542F12
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Jun 2022 13:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237507AbiFHLYC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Jun 2022 07:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238064AbiFHLX6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Jun 2022 07:23:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B3E15EA40
        for <linux-ext4@vger.kernel.org>; Wed,  8 Jun 2022 04:23:56 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 890331F895;
        Wed,  8 Jun 2022 11:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654687435; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/CHGlO1F0bK3L3scggi0g/ZtX/nFc65Dj1mNqwB9Onw=;
        b=Ynly47C5ta7Fj6VrPq+SMFeoMSELCYNjWN+Ab1EWg52iUWzk3vB+0X+cruL0y4lQcQmYqE
        ubJu6Mq69yVb+aCaXgnjqVXy188+Tnv40mCqKOB9gplAASsu8TD/D3yp/XJmOdmP+jYf8q
        gZo9YLpeFpsxrcR5dXxOJ9UPVk5zdRs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654687435;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/CHGlO1F0bK3L3scggi0g/ZtX/nFc65Dj1mNqwB9Onw=;
        b=+YhMZS63OXxAuDvWA+gDmNFJKT3HFpUc93njxd4TRqNW4SqcrHktXsgB2XPmMGd4RrRRUz
        Btr6SdorI+1RchDQ==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 76F8E2C145;
        Wed,  8 Jun 2022 11:23:55 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3781DA06E5; Wed,  8 Jun 2022 13:23:55 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 3/4] jbd2: Remove unused exports for jbd2 debugging
Date:   Wed,  8 Jun 2022 13:23:49 +0200
Message-Id: <20220608112355.4397-3-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220608112041.29097-1-jack@suse.cz>
References: <20220608112041.29097-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1550; h=from:subject; bh=/0i4vFv69IZbrZuzV7RyHDp/5hVJSLvoertXlacY8KA=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBioIbEDhWgX5iXQXLwgFpw4hdg+kdcgg7y4GkDCFtj gEmuiguJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYqCGxAAKCRCcnaoHP2RA2Y/AB/ 9O1MNjDV3RAzWebkkHSFfaHFd6JlvOMtxw33i8pOi0gg3pDAdWy+sSpFD/65VBC3tTen+qXMsvnQPF Yged/Jyb3K1ZsTSTjvwI52p1B1PPXrXxbmVOnUQqNXQPOnskHO6YscQZwj6FNUdcI75c/StVzjk7U1 /xPSoILyUN9OeAZEJ1iXBVIpGfoKx9/ZkMaXoDnceIHZS+9QJ2p9X+HJqp929mN4n6DzlHwKRsflGJ eG7o71Zn9aQMuV0ypyDPFuBmchsE3waU9/xoixNGz6vj4Di47luHbadinwBUQA54TiCc/2oYssfiKL PUiAWATfhZSwq+dEeFHyDSH68zoMf8
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Jbd2 exports jbd2_journal_enable_debug and __jbd2_debug() depite the
first is used only in fs/jbd2/journal.c and the second only within jbd2
code. Remove the pointless exports make jbd2_journal_enable_debug
static.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/journal.c    | 4 +---
 include/linux/jbd2.h | 1 -
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 0a8ff211fac1..f38f57942700 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -49,8 +49,7 @@
 #include <asm/page.h>
 
 #ifdef CONFIG_JBD2_DEBUG
-ushort jbd2_journal_enable_debug __read_mostly;
-EXPORT_SYMBOL(jbd2_journal_enable_debug);
+static ushort jbd2_journal_enable_debug __read_mostly;
 
 module_param_named(jbd2_debug, jbd2_journal_enable_debug, ushort, 0644);
 MODULE_PARM_DESC(jbd2_debug, "Debugging level for jbd2");
@@ -115,7 +114,6 @@ void __jbd2_debug(int level, const char *file, const char *func,
 	printk(KERN_DEBUG "%s: (%s, %u): %pV", file, func, line, &vaf);
 	va_end(args);
 }
-EXPORT_SYMBOL(__jbd2_debug);
 #endif
 
 /* Checksumming functions */
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index d4d59e43769f..6c2aa61e0f73 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -54,7 +54,6 @@
  * CONFIG_JBD2_DEBUG is on.
  */
 #define JBD2_EXPENSIVE_CHECKING
-extern ushort jbd2_journal_enable_debug;
 void __jbd2_debug(int level, const char *file, const char *func,
 		  unsigned int line, const char *fmt, ...);
 
-- 
2.35.3

