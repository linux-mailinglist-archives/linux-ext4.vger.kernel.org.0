Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F70B4A786E
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Feb 2022 20:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242882AbiBBTB4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 2 Feb 2022 14:01:56 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:35976 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231486AbiBBTB4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 2 Feb 2022 14:01:56 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 212J1nep027110
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Feb 2022 14:01:50 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 518D315C0040; Wed,  2 Feb 2022 14:01:49 -0500 (EST)
Date:   Wed, 2 Feb 2022 14:01:49 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Beulich <jbeulich@suse.com>
Cc:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: ext4's dependency on crc32c
Message-ID: <YfrVHVn4P3PT9wwY@mit.edu>
References: <73fc221b-400b-a749-4bca-e6854d361a9a@suse.com>
 <YflV+qAsrKCj8h1U@mit.edu>
 <d086e0f2-126f-786a-b4af-d606aa0fa8d8@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d086e0f2-126f-786a-b4af-d606aa0fa8d8@suse.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Feb 02, 2022 at 09:08:03AM +0100, Jan Beulich wrote:
> > Sure, there are some subtleties, though.  For example, we would need
> > to make sure that sbi->s_chksum_driver() is initialized before we
> > attempt to use it.  That's because an malicious attacker (or syzbot
> > fuzzer --- is there a difference? :-) could force the file system
> > feature bits to be set after we decide whether or not to allocate the
> > crypto handle.  This can happen by having a maliciously corrupted file
> > system image which sets the file system feature bits as part of the
> > journal replay, or simply by writing to the superblock after it is
> > mounted.
> 
> Can any of this happen for an ext3 partition (without destroying its
> ext3 nature)? IOW would it be possible to set sbi->s_chksum_driver
> depending on just file system type rather than individual features?

The idea of "an ext3 partition" is not well defined, at least in terms
of the on-disk format.  The ext2/ext3/ext4 superblock has a set of
feature flags, the compat, r/o, and incompat feature flags.  You can
take an "ext3" file system, and enable the "extents" feature, and on
modern kernels (where "mount -t ext3" is handled by the ext4 file
system), new files which are created will be extent-mapped.

You can look at what "mke2fs -t ext3" and "mke2fs -t ext4" will do ---
although that will change over time as you install new versions of
e2fsprogs, but it can also be modified by editing the /etc/mke2fs.conf
file, either becaue a distribution wants to be more aggressive about
enabling a bleeding edge feature (such as fast commits), or because a
particular system adminsitrator or company wants to explicitly enable
or disable some features for their workload:

[defaults]
	base_features = sparse_super,large_file,filetype,resize_inode,dir_index,ext_attr
	default_mntopts = acl,user_xattr
	enable_periodic_fsck = 0
	blocksize = 4096
	inode_size = 256
	...
	
[fs_types]
	ext3 = {
		features = has_journal
	}
	ext4 = {
		features = has_journal,extent,huge_file,flex_bg,metadata_csum,64bit,dir_nlink,extra_isize
	}
	....

Cheers,

					- Ted
