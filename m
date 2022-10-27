Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B8C60FB72
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Oct 2022 17:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236418AbiJ0PKh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 27 Oct 2022 11:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236125AbiJ0PJS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 27 Oct 2022 11:09:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE29618F26D;
        Thu, 27 Oct 2022 08:09:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A8B8623BB;
        Thu, 27 Oct 2022 15:09:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D42C433B5;
        Thu, 27 Oct 2022 15:09:15 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oo4Ve-00Bvgj-1a;
        Thu, 27 Oct 2022 11:09:30 -0400
Message-ID: <20221027150930.322796357@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 27 Oct 2022 11:05:52 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-ext4@vger.kernel.org
Subject: [RFC][PATCH v2 27/31] timers: ext4: Use del_timer_shutdown() before freeing timer
References: <20221027150525.753064657@goodmis.org>
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

Before a timer is freed, del_timer_shutdown() must be called.

Link: https://lore.kernel.org/all/20220407161745.7d6754b3@gandalf.local.home/

Cc :"Theodore Ts'o" <tytso@mit.edu>
Cc :Andreas Dilger <adilger.kernel@dilger.ca>
Cc: linux-ext4@vger.kernel.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/ext4/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 989365b878a6..c8a59e3148e2 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1225,7 +1225,7 @@ static void ext4_put_super(struct super_block *sb)
 	}
 
 	ext4_es_unregister_shrinker(sbi);
-	del_timer_sync(&sbi->s_err_report);
+	del_timer_shutdown(&sbi->s_err_report);
 	ext4_release_system_zone(sb);
 	ext4_mb_release(sb);
 	ext4_ext_release(sb);
-- 
2.35.1
