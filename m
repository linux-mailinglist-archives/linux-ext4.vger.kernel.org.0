Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5F6C1F5C
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Sep 2019 12:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730767AbfI3KnW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 Sep 2019 06:43:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:57590 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730751AbfI3KnV (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 30 Sep 2019 06:43:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B35F9AE6D;
        Mon, 30 Sep 2019 10:43:20 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id BF0491E3ED9; Mon, 30 Sep 2019 12:43:39 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-ext4@vger.kernel.org>
Cc:     Ted Tso <tytso@mit.edu>, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/19 v2] ext4: Fix transaction overflow due to revoke descriptors
Date:   Mon, 30 Sep 2019 12:43:18 +0200
Message-Id: <20190930103544.11479-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

I'm sending v2 of this series in a quick succession since some more
stress-testing has revealed some bugs and I've also reorganized the series a
bit so I've decided to post new version early not to waste review bandwidth.

Changes since v1:
* Reordered some patches to reduce code churn
* Computation in jbd2_revoke_descriptors_per_block() was too early - moved it
  to later when journal superblock is loaded and so the feature checking
  actually works.
* Made sure nobody outside JBD2 uses handle->h_buffer_credits since now it
  contains also credits for revoke descriptors and it was confusing come users.
* Updated cover letter with more details about reproducer

Original cover letter:

I've recently got a bug report where JBD2 assertion failed due to
transaction commit running out of journal space. After closer inspection of
the crash dump it seems that the problem is that there were too many
journal descriptor blocks (more that max_transaction_size >> 5 + 32 we
estimate in jbd2_log_space_left()) due to descriptor blocks with revoke
records. In fact the estimate on the number of descriptor blocks looks
pretty arbitrary and there can be much more descriptor blocks needed for
revoke records. We need one revoke record for every metadata block freed.
So in the worst case (1k blocksize, 64-bit journal feature enabled,
checksumming enabled) we fit 125 revoke record in one descriptor block.  In
common cases its about 500 revoke records per descriptor block. Now when
we free large directories or large file with data journalling enabled, we can
have *lots* of blocks to revoke - with extent mapped files easily millions
in a single transaction which can mean 10k descriptor blocks - clearly more
than the estimate of 128 descriptor blocks per transaction ;)

This patch series aims at fixing the problem by accounting descriptor blocks
into transaction credits and reserving appropriate amount of credits for revoke
descriptors on transaction handle start. Similar to normal transaction credits,
the filesystem has to provide estimate for the number of blocks it is going
to revoke using the transaction handle so that credits for revoke descriptors
can be reserved.

The series has survived fstests in couple configurations and also the stress
test like:
  Create filesystem with 1KB blocksize and journal size 32MB
  Mount the filesystem with -o nodelalloc
  for (( i = 0; i < 4; i++ )); do
    dd if=/dev/zero of=file$i bs=1M count=2048 conv=fsync
    chattr +j file$i
  done
  for (( i = 0; i < 4; i++ )); do
    rm file$i&
  done

which reliably triggers the assertion failure in JBD2 on unpatched kernel.

Review and comments are welcome :).

								Honza
Previous versions:
Link: http://lore.kernel.org/r/20190927111536.16455-1-jack@suse.cz
