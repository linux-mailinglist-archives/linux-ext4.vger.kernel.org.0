Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA4B2028A
	for <lists+linux-ext4@lfdr.de>; Thu, 16 May 2019 11:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfEPJaY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 May 2019 05:30:24 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:51817 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726374AbfEPJaY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 May 2019 05:30:24 -0400
Received: from callcc.thunk.org (168-215-239-3.static.ctl.one [168.215.239.3] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x4G9U8Rv029692
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 May 2019 05:30:12 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 3F4BD420024; Thu, 16 May 2019 05:28:48 -0400 (EDT)
Date:   Thu, 16 May 2019 05:28:48 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, jack@suse.cz,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] fstests: generic, fsync fuzz tester with fsstress
Message-ID: <20190516092848.GA6975@mit.edu>
References: <20190515150221.16647-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515150221.16647-1-fdmanana@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, May 15, 2019 at 04:02:21PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Run fsstress, fsync every file and directory, simulate a power failure and
> then verify the all files and directories exist, with the same data and
> metadata they had before the power failure.
> 
> This tes has found already 2 bugs in btrfs, that caused mtime and ctime of
> directories not being preserved after replaying the log/journal and loss
> of a directory's attributes (such a UID and GID) after replaying the log.
> The patches that fix the btrfs issues are titled:
> 
>   "Btrfs: fix wrong ctime and mtime of a directory after log replay"
>   "Btrfs: fix fsync not persisting changed attributes of a directory"
> 
> Running this test 1000 times:
> 
> - on ext4 it has resulted in about a dozen journal checksum errors (on a
>   5.0 kernel) that resulted in failure to mount the filesystem after the
>   simulated power failure with dmflakey, which produces the following
>   error in dmesg/syslog:
> 
>     [Mon May 13 12:51:37 2019] JBD2: journal checksum error
>     [Mon May 13 12:51:37 2019] EXT4-fs (dm-0): error loading journal

I'm curious what configuration you used when you ran the test.  I
tried to reproduce it, and had no luck:

TESTRUNID: tytso-20190516042341
KERNEL:    kernel 5.1.0-rc3-xfstests-00034-g0c72924ef346 #999 SMP Wed May 15 00:56:08 EDT 2019 x86_64
CMDLINE:   -c 4k -C 1000 generic/547
CPUS:      2
MEM:       7680

ext4/4k: 1000 tests, 1855 seconds
Totals: 1000 tests, 0 skipped, 0 failures, 0 errors, 1855s

FSTESTPRJ: gce-xfstests
FSTESTVER: blktests baccddc (Wed, 13 Mar 2019 00:06:50 -0700)
FSTESTVER: fio  fio-3.2 (Fri, 3 Nov 2017 15:23:49 -0600)
FSTESTVER: fsverity bdebc45 (Wed, 5 Sep 2018 21:32:22 -0700)
FSTESTVER: ima-evm-utils 0267fa1 (Mon, 3 Dec 2018 06:11:35 -0500)
FSTESTVER: nvme-cli v1.7-35-g669d759 (Tue, 12 Mar 2019 11:22:16 -0600)
FSTESTVER: quota  62661bd (Tue, 2 Apr 2019 17:04:37 +0200)
FSTESTVER: stress-ng 7d0353cf (Sun, 20 Jan 2019 03:30:03 +0000)
FSTESTVER: syzkaller bab43553 (Fri, 15 Mar 2019 09:08:49 +0100)
FSTESTVER: xfsprogs v5.0.0 (Fri, 3 May 2019 12:14:36 -0500)
FSTESTVER: xfstests-bld 9582562 (Sun, 12 May 2019 00:38:51 -0400)
FSTESTVER: xfstests linux-v3.8-2390-g64233614 (Thu, 16 May 2019 00:12:52 -0400)
FSTESTCFG: 4k
FSTESTSET: generic/547
FSTESTOPT: count 1000 aex
GCE ID:    8592267165157073108
