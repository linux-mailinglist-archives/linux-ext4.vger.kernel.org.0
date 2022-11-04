Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EACFF61905D
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Nov 2022 06:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbiKDFtL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 4 Nov 2022 01:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbiKDFsy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 4 Nov 2022 01:48:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE8B28E1E;
        Thu,  3 Nov 2022 22:48:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F982620B2;
        Fri,  4 Nov 2022 05:48:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D85C4347C;
        Fri,  4 Nov 2022 05:48:50 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oqpZt-0071Ei-1h;
        Fri, 04 Nov 2022 01:49:17 -0400
Message-ID: <20221104054917.365008421@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 04 Nov 2022 01:41:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Tso" <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        linux-ext4@vger.kernel.org
Subject: [RFC][PATCH v3 30/33] timers: jbd2: Use timer_shutdown() before freeing timer
References: <20221104054053.431922658@goodmis.org>
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

Before a timer is freed, timer_shutdown() must be called. Note that it is
assumed that the timer is not running while being freed, so only
timer_shutdown() is used, and not timer_shutdown_sync().

Link: https://lore.kernel.org/all/20220407161745.7d6754b3@gandalf.local.home/

Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Jan Kara <jack@suse.com>
Cc: linux-ext4@vger.kernel.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/jbd2/journal.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 2696f43e7239..57d2445d8c8b 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -2157,6 +2157,8 @@ int jbd2_journal_destroy(journal_t *journal)
 	J_ASSERT(journal->j_checkpoint_transactions == NULL);
 	spin_unlock(&journal->j_list_lock);
 
+	timer_shutdown(&journal->j_commit_timer);
+
 	/*
 	 * OK, all checkpoint transactions have been checked, now check the
 	 * write out io error flag and abort the journal if some buffer failed
-- 
2.35.1
