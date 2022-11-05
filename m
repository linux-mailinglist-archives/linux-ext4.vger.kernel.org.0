Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A968A61D7BC
	for <lists+linux-ext4@lfdr.de>; Sat,  5 Nov 2022 07:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiKEGBn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 5 Nov 2022 02:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiKEGBe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 5 Nov 2022 02:01:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125E73121D;
        Fri,  4 Nov 2022 23:01:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D40F609EB;
        Sat,  5 Nov 2022 06:01:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08763C433D7;
        Sat,  5 Nov 2022 06:01:31 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1orCFj-007Orn-0j;
        Sat, 05 Nov 2022 02:01:59 -0400
Message-ID: <20221105060159.054190416@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 05 Nov 2022 02:00:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-ext4@vger.kernel.org
Subject: [PATCH v4a 23/38] timers: ext4: Use timer_shutdown_sync() before freeing timer
References: <20221105060024.598488967@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Before a timer is freed, timer_shutdown_sync() must be called.

Link: https://lore.kernel.org/all/20221104054053.431922658@goodmis.org/

Cc :"Theodore Ts'o" <tytso@mit.edu>
Cc :Andreas Dilger <adilger.kernel@dilger.ca>
Cc: linux-ext4@vger.kernel.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/ext4/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 7950904fbf04..f54ed936d800 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1225,7 +1225,7 @@ static void ext4_put_super(struct super_block *sb)
 	}
 
 	ext4_es_unregister_shrinker(sbi);
-	del_timer_sync(&sbi->s_err_report);
+	timer_shutdown_sync(&sbi->s_err_report);
 	ext4_release_system_zone(sb);
 	ext4_mb_release(sb);
 	ext4_ext_release(sb);
-- 
2.35.1
