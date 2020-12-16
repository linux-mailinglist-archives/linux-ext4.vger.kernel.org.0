Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D84F2DBAA1
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Dec 2020 06:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725771AbgLPFcA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Dec 2020 00:32:00 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45577 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725765AbgLPFb7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Dec 2020 00:31:59 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0BG5V9R1013724
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Dec 2020 00:31:10 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 95094420280; Wed, 16 Dec 2020 00:31:09 -0500 (EST)
Date:   Wed, 16 Dec 2020 00:31:09 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 07/12] ext4: Defer saving error info from atomic context
Message-ID: <X9mbnUqNFnJSN1S8@mit.edu>
References: <20201127113405.26867-1-jack@suse.cz>
 <20201127113405.26867-8-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201127113405.26867-8-jack@suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Nov 27, 2020 at 12:34:00PM +0100, Jan Kara wrote:
> When filesystem inconsistency is detected with group locked, we
> currently try to modify superblock to store error there without
> blocking. However this can cause superblock checksum failures (or
> DIF/DIX failure) when the superblock is just being written out.
> 
> Make error handling code just store error information in ext4_sb_info
> structure and copy it to on-disk superblock only in ext4_commit_super().
> In case of error happening with group locked, we just postpone the
> superblock flushing to a workqueue.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

So this patch does make a behavioral change, which is if a file system
contains errors when it is mounted, when the kernel trips over more
file system problems, the first error is overwritten.

Before, s_first_error_* used to mean the first error found since the
file system was checked.  With this patch, s_first_error_* now means
the first error found since the file system was mounted.

This distinction is critical, because there are some buggy distro's
(Ubuntu and Debian) out there where their cloud image does *not* run
fsck on boot.  So if a file system is corrupted, it does not get fixed
up, and file system can get more and more damaged.  In that case, it's
good to know when the file system was first damaged, even if it was
six months earlier and several reboots and remounts later.   :-/

We should be able to fix up this patch by making commit_super only
update the on-disk s_first_error* fields if s_first_error_time on disk
is 0.

					- Ted

P.S.  Bugs have been filed with both distro's.  Ubuntu has accepted it
is a bug, but we're still working on convincing the Debian cloud image
devs....

And it's not just the buggy cloud iamges; it's also happened on
occasion that sloppy embedded Linux developers or sysadmins have
misconfigured their system so that fsck never gets run, and it's nice
to be able to have the forensic data preserved.
