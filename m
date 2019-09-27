Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7CBC03EF
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Sep 2019 13:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfI0LQG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 27 Sep 2019 07:16:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:52386 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727294AbfI0LQF (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 27 Sep 2019 07:16:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A0BF5B130;
        Fri, 27 Sep 2019 11:16:03 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3355E1E3C3C; Fri, 27 Sep 2019 13:16:20 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-ext4@vger.kernel.org>
Cc:     Ted Tso <tytso@mit.edu>, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/15] ext4: Fix transaction overflow due to revoke descriptors
Date:   Fri, 27 Sep 2019 13:15:21 +0200
Message-Id: <20190927111536.16455-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

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
test of deleting large files in -o nodelalloc,data=journal configuration which
reliably triggers the assertion failure in JBD2 on unpatched kernel.

Review and comments are welcome :).

								Honza
