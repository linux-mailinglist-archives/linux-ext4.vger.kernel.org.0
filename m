Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4CE33F65D3
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Aug 2021 19:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240212AbhHXRRA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 Aug 2021 13:17:00 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:42867 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S240343AbhHXRO7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 24 Aug 2021 13:14:59 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 17OHEASY020268
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Aug 2021 13:14:10 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 0763415C3DBB; Tue, 24 Aug 2021 13:14:10 -0400 (EDT)
Date:   Tue, 24 Aug 2021 13:14:09 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 0/5 v7] ext4: Speedup orphan file handling
Message-ID: <YSUo4TBKjcdX7N/q@mit.edu>
References: <20210816093626.18767-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816093626.18767-1-jack@suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

I've been running some tests exercising the orphan_file code, and
there are a number of failures:

ext4/orphan_file: 512 tests, 3 failures, 25 skipped, 7325 seconds
  Failures: ext4/044 generic/475 generic/643
ext4/orphan_file_1k: 524 tests, 6 failures, 37 skipped, 8361 seconds
  Failures: ext4/033 ext4/044 ext4/045 generic/273 generic/476 generic/643

generic/643 is the iomap swap failure, and can be ignored.
generic/475 is a pre-existing test flake that involves simulated disk
failures, which we can also ignore in the context or orphan_file.

However, ext4/044 is one that looks... interesting:

root@kvm-xfstests:~# e2fsck -fn /dev/vdc
e2fsck 1.46.4-orphan-file (22-Aug-2021)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
Orphan file (inode 12) block 0 is not clean.
Clear? no

Failed to initialize orphan file.
Recreate? no

This is highly reproducible, and involves using a file system config
that is probably a little unusual:

Filesystem features:      has_journal ext_attr resize_inode dir_index orphan_file filetype sparse_super large_file

(This was created using "mke2fs -t ext3 -O orphan_file".)

The orphan_file_1k failures seem to involve running out of space in
the orphan_file, and the fallback to using the old fashioned orphan
list seems to return ENOSPC?  For example, from ext4/045:

    +mkdir: No space left on device
    +Failed to create directories - 19679

ext4/045 creates a lot of directories when calls mkdir (ext4/045 tests
creating more than 65000 subdirectories in a directory), and so this
seems to be triggering a failure?

					- Ted
