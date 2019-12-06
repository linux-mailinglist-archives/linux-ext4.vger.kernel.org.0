Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7EC114B81
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Dec 2019 04:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfLFDvO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Dec 2019 22:51:14 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:42720 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726076AbfLFDvO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Dec 2019 22:51:14 -0500
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xB63p24F023481
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 5 Dec 2019 22:51:02 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id F2187421A48; Thu,  5 Dec 2019 22:51:01 -0500 (EST)
Date:   Thu, 5 Dec 2019 22:51:01 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Viliam Lejcik <Viliam.Lejcik@kistler.com>
Cc:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: e2fsprogs: setting UUID with tune2fs corrupts an ext4 fs image
Message-ID: <20191206035101.GA62394@mit.edu>
References: <5fd4546cdc7f43f282716afb1e1a18cb@kistler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fd4546cdc7f43f282716afb1e1a18cb@kistler.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Dec 05, 2019 at 12:36:35PM +0000, Viliam Lejcik wrote:
> 
> The problem for tune2fs is "Number of entries", when count==limit
> (126). In this case it fails within the following 'if' statement:
> https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git/tree/misc/tune2fs.c#n544
> 
> Then it prints out error, sets 'not clean' fs state in superblock,
> and exits. What fsck does, it recomputes checksums, sets 'clean' fs
> state, and that's all. It doesn't change number of entries,
> count+limit stays the same (126). So that's why rerunning tune2fs
> corrupts the fs again.

So what's going on is that the code in question was originally
designed for file systems with a 4k block size, and when *adding* a
checksum to a directory which didn't already have a checksum "tail"
already reserved.  In that case, you have to recreate the htree index
for that directory.  Since tune2fs didn't want to deal with that
corner case, it would throw up its hands and tell the user to run
e2fsck -fD.  Since the UUID had alrady been changed, and the checksum
seed was based on the checksum seed, e2fsck would report corruptions,
but that was actually what was expected.  Unfortunately the message
printed by tune2fs is super-confusing, and logic for checking for this
case is faulty in that (a) it doesn't take into account the block
size, and (b) it doesn't take into account if there is a checksum
"tail" already present for that particular htree directory.

Most people don't see this because they are using file systems with 4k
block sizes, and it's much less likely they will run into that
situation, since the interior node fanout is significantly larger with
4k blocks.  (Is there a reason you are using a 1k block size?  This
adds quite a bit of inefficiency to the file system, and while it does
reduce internal fragmentation, bytes are quite cheap these days, and
it's probably not worth it if you care about performance at all to use
a 1k block size instead of a 4k block size.)

The workaround I would suggest is assuming you are using a kernel
which is 4.4 or newer (and in 2019, you really should), to turn on the
metadata_csum_seed field, either when the file system is originally
formatted, or using "tune2fs -O ^metadata_csum_seed".  This allows you
to change the UUID without needing to rewrite all of the metadata
blocks, which is faster, works while the file system is mounted, and
avoids the bug in tune2fs.

So using the test file system you sent me, this works just fine:

% tune2fs -O metadata_csum_seed -U random  core-image.ext4
tune2fs 1.45.4 (23-Sep-2019)
% e2fsck -fy !$
e2fsck -fy core-image.ext4
e2fsck 1.45.4 (23-Sep-2019)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
core-image.ext4: 13237/89408 files (0.6% non-contiguous), 249888/357064 blocks

cheers,

					- Ted
