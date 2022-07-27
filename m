Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC695824D3
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Jul 2022 12:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbiG0Kvd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Jul 2022 06:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbiG0Kvc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Jul 2022 06:51:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF473ED63
        for <linux-ext4@vger.kernel.org>; Wed, 27 Jul 2022 03:51:30 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9340137B6E;
        Wed, 27 Jul 2022 10:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658919089; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=U38jMaYDdCGtXdlR1DQyXPyrKNr7T0sQtjjGTV3x7Jg=;
        b=xkbEtTD1JxejeUg6giZa3hMK6bJRrvR7zrqLDjQNPZHL3f0osc09Jznsm4UksiRj7/NwGg
        oX5tMiXbDj/ZYX15k5mHRv0LneaMW2LtuOvB+WFdE/U7vDoiZnk8+04KvyOfj359TqvN4I
        o3FWZLtFQj/4I9DtGMwFJINA5NPm96I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658919089;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=U38jMaYDdCGtXdlR1DQyXPyrKNr7T0sQtjjGTV3x7Jg=;
        b=tf+WuiKIL/3BXMoFW/BOKaYAJ+PW6s+e7tJh9KvawdaVqcr67FO3D4mDUkHEtWmIFHTwNB
        3+KR4qcRWPH6aKCw==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 81F272C141;
        Wed, 27 Jul 2022 10:51:29 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A77E3A0661; Wed, 27 Jul 2022 12:51:23 +0200 (CEST)
Date:   Wed, 27 Jul 2022 12:51:23 +0200
From:   Jan Kara <jack@suse.cz>
To:     linux-ext4@vger.kernel.org
Cc:     Ted Tso <tytso@mit.edu>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: Ext4 mballoc behavior with mb_optimize_scan=1
Message-ID: <20220727105123.ckwrhbilzrxqpt24@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

before going on vacation I was tracking down why reaim benchmark regresses
(10-20%) with larger number of processes with the new mb_optimize_scan
strategy of mballoc. After a while I have reproduced the regression with a
simple benchmark that just creates, fsyncs, and deletes lots of small files
(22k) from 16 processes, each process has its own directory. The immediate
reason for the slow down is that with mb_optimize_scan=1 the file blocks
are spread among more block groups and thus we have more bitmaps to update
in each transaction. 

So the question is why mballoc with mb_optimize_scan=1 spreads allocations
more among block groups. The situation is somewhat obscured by group
preallocation feature of mballoc where each *CPU* holds a preallocation and
small (below 64k) allocations on that CPU are allocated from this
preallocation. If I trace creating of these group preallocations I can see
that the block groups they are taken from look like:

mb_optimize_scan=0:
49 81 113 97 17 33 113 49 81 33 97 113 81 1 17 33 33 81 1 113 97 17 113 113
33 33 97 81 49 81 17 49

mb_optimize_scan=1:
127 126 126 125 126 127 125 126 127 124 123 124 122 122 121 120 119 118 117
116 115 116 114 113 111 110 109 108 107 106 105 104 104

So we can see that while with mb_optimize_scan=0 the preallocation is
always take from one of a few groups (among which we jump mostly randomly)
which mb_optimize_scan=1 we consistently drift from higher block groups to
lower block groups.

The mb_optimize_scan=0 behavior is given by the fact that search for free
space always starts in the same block group where the inode is allocated
and the inode is always allocated in the same block group as its parent
directory. So the create-delete benchmark generally keeps all inodes for
one process in the same block group and thus allocations are always
starting in that block group. Because files are small, we always succeed in
finding free space in the starting block group and thus allocations are
generally restricted to the several block groups where parent directories
were originally allocated.

With mb_optimize_scan=1 the block group to allocate from is selected by
ext4_mb_choose_next_group_cr0() so in this mode we completely ignore the
"pack inode with data in the same group" rule. The reason why we keep
drifting among block groups is that whenever free space in a block group is
updated (blocks allocated / freed) we recalculate largest free order (see
mb_mark_used() and mb_free_blocks()) and as a side effect that removes
group from the bb_largest_free_order_node list and reinserts the group at
the tail.

I have two questions about the mb_optimize_scan=1 strategy:

1) Shouldn't we respect the initial goal group and try to allocate from it
in ext4_mb_regular_allocator() before calling ext4_mb_choose_next_group()?

2) The rotation of groups in mb_set_largest_free_order() seems a bit
undesirable to me. In particular it seems pointless if the largest free
order does not change. Was there some rationale behind it?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
