Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2985D4BEC3C
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Feb 2022 22:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbiBUVJp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Feb 2022 16:09:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiBUVJp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Feb 2022 16:09:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9283F23BCE;
        Mon, 21 Feb 2022 13:09:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4CAF7B817A3;
        Mon, 21 Feb 2022 21:09:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BEBDC340E9;
        Mon, 21 Feb 2022 21:09:17 +0000 (UTC)
Date:   Mon, 21 Feb 2022 16:09:16 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [BUG] NEVER dereference pointers from the tracing ring buffer!
Message-ID: <20220221160916.333e6491@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

While working on libtraceevent, it stumbled over a "->" in the print
formats that wasn't parsing properly. Well, the reason it does not
handle this particular case is because it is A MAJOR BUG IN THE KERNEL!

DO NOT DEREFERENCE ANYTHING FROM THE RING BUFFER.

Sorry, for yelling, but I really want to stress this is not something
to do. The ring buffer is referenced seconds, minutes, hours, days,
months after the data has been loaded. This is the same as using
something after it is freed. Just don't do it.

The culprit is:

  ext4_fc_stats

Introduced by: aa75f4d3daaeb ("ext4: main fast-commit commit path")

That has in its print fmt in include/trace/events/ext4.h:


            TP_printk("dev %d:%d fc ineligible reasons:\n"
                      "%s:%d, %s:%d, %s:%d, %s:%d, %s:%d, %s:%d, %s:%d, %s:%d, %s:%d; "
                      "num_commits:%ld, ineligible: %ld, numblks: %ld",
                      MAJOR(__entry->dev), MINOR(__entry->dev),
                      FC_REASON_NAME_STAT(EXT4_FC_REASON_XATTR),
                      FC_REASON_NAME_STAT(EXT4_FC_REASON_CROSS_RENAME),
                      FC_REASON_NAME_STAT(EXT4_FC_REASON_JOURNAL_FLAG_CHANGE),
                      FC_REASON_NAME_STAT(EXT4_FC_REASON_NOMEM),
                      FC_REASON_NAME_STAT(EXT4_FC_REASON_SWAP_BOOT),
                      FC_REASON_NAME_STAT(EXT4_FC_REASON_RESIZE),
                      FC_REASON_NAME_STAT(EXT4_FC_REASON_RENAME_DIR),
                      FC_REASON_NAME_STAT(EXT4_FC_REASON_FALLOC_RANGE),
                      FC_REASON_NAME_STAT(EXT4_FC_REASON_INODE_JOURNAL_DATA),
                      __entry->sbi->s_fc_stats.fc_num_commits,
                      __entry->sbi->s_fc_stats.fc_ineligible_commits,
                      __entry->sbi->s_fc_stats.fc_numblks)

That __entry->sbi can be LONG GONE by the time it is read. You have no
idea what it is pointing to. And even if it is still around, there's no
way that any of those numbers are accurate from the time the event
triggered. Might as well just expose them by some other interface.

This event must be modified or removed from the current release and all
stable kernels that have it.

In the mean time, I need to update my event verifier to detect this and
fail to register the event if it has such cases.

-- Steve
