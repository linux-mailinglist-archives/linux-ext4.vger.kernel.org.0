Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABF253EA5F
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Jun 2022 19:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239835AbiFFOky (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 6 Jun 2022 10:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239834AbiFFOkx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 6 Jun 2022 10:40:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796B8CA3FD
        for <linux-ext4@vger.kernel.org>; Mon,  6 Jun 2022 07:40:52 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 341FD1F919;
        Mon,  6 Jun 2022 14:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654526451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Tx1kcbmTDD5GCRgvrHb2o1kOsNktY0BYQ41JVGc/GkE=;
        b=aCGj9a77+jvoXzz1qFOLd6CL5F7kr37EIsyvRGSxSaEJVvb/OJZxCrr1sVcwlWB9XOWJmu
        QvqwHqvzzX7UW2EoPw2763LPaI32WfI95kf2Ap4xejRs1bqGEzIB/nnf5C0pUTV2KIdQjk
        3LhYNJV3loxMQuoRUpq0eKBnwHfq2Qo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654526451;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Tx1kcbmTDD5GCRgvrHb2o1kOsNktY0BYQ41JVGc/GkE=;
        b=59FipQI6wViVQWnSZYOFW9/1O2ekIUl2qFukTr0xObdEWpoLh1bD9Dhh6U7GOHyR5IqDLX
        6lgi12nFqGAPdEDg==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2A6F42C141;
        Mon,  6 Jun 2022 14:40:51 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id DAE9BA0633; Mon,  6 Jun 2022 16:40:50 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH] jbd2: Remove unused exports for jbd2 debugging
Date:   Mon,  6 Jun 2022 16:40:47 +0200
Message-Id: <20220606144047.16780-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1550; h=from:subject; bh=SP4aXUs1HV33DUjFab1bBWr0guyqh1jwWz6lTN5iBEE=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBinhHpiB13qNTcUHd5tIJcQHtwyqFPt1zlwhR6MjuK fs2KrAGJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYp4R6QAKCRCcnaoHP2RA2QAvCA DYA7r2H+ACpFca55hjF3pI3A5hUd0v4eO8c0Js2NH59IoRG704JLpjCRUAvghiphdCV18Uhg1gkJbd /JFtrS/lwqjxyBKb4WfXLjim8IkGcooRWc1g+LRxJXtuSfEBj9ptNk6+cuv6bC9VTzM9oIba9GT6qo JSCvHW05RnYcAJLFfjFrQSqxNhOpc2rvHmzWe0s/MVHDEmjHITeVGJTTxYpCVoRKtRJuvB/gPbNMoA GJXl4cX+uZmuBl/KBeXJ8rH+1WztIw2gZfX7p+jUS4kBJAtxvaRgBMvEvkGwaSuek4puDb7vOKBeZS YDeye9F80qGsqoaK1KMcSTYE2HTULg
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
index c0cbeeaec2d1..164bd0eff3cf 100644
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
index e79d6e0b14e8..6d3c23fecbc2 100644
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

