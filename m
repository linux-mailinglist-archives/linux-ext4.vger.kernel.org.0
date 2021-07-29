Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1D53DAA96
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Jul 2021 19:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbhG2R77 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Jul 2021 13:59:59 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:47042 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229485AbhG2R77 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 29 Jul 2021 13:59:59 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 16THxqWp002494
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jul 2021 13:59:52 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 101F515C37C0; Thu, 29 Jul 2021 13:59:52 -0400 (EDT)
Date:   Thu, 29 Jul 2021 13:59:51 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Mikhail Morfikov <mmorfikov@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: Is it safe to use the bigalloc feature in the case of ext4
 filesystem?
Message-ID: <YQLsl7s/GcgMGi47@mit.edu>
References: <0dc45cbd-b3b0-97ab-66a9-f68331cb483e@gmail.com>
 <YQCQODCGtJRTKwS9@mit.edu>
 <ba95a978-18af-794a-4c9d-a8406ade31ae@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba95a978-18af-794a-4c9d-a8406ade31ae@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jul 28, 2021 at 11:36:27AM +0200, Mikhail Morfikov wrote:
> Thanks for the answer.
> 
> I have one question. Basically there's the /etc/mke2fs.conf file and 
> I've created the following stanza in it:
> 
> bigdata = {
>                 errors = remount-ro
>                 features = has_journal,extent,huge_file,flex_bg,metadata_csum,64bit,dir_nlink,extra_isize,bigalloc,^uninit_bg,sparse_super2
>                 inode_size = 256
>                 inode_ratio = 4194304
>                 cluster_size = 4M
>                 reserved_ratio = 0
>                 lazy_itable_init = 0
>                 lazy_journal_init = 0
>         }
> 
> It looks like the cluster_size parameter is ignored in such case (I've 
> tried both 4M and 4194304 values), and the filesystem was created with 
> 64K cluster size (via mkfs -t bigdata -L bigdata /dev/sdb1 ), which is 
> the default when the bigalloc feature is set.

It does work, but you need to use an integer value for cluster_size,
and it needs to be in the [fs_types[ section.  So something like what I
have attached below.

And then try using the command "mke2fs -t ext4 -T bigdata -L bigdata
/dev/sdb1".

If you see the hugefile and hugefiles stanzas below, that's an example
of one way bigalloc has gotten a fair amount of use.  In this use case
mke2fs has pre-allocated the huge data files guaranteeing that they
will be 100% contiguous.  We're using a 32k cluster becuase there are
some metadata files where better allocation efficiencies is desired.

Cheers,

						- Ted

[defaults]
	base_features = sparse_super,large_file,filetype,resize_inode,dir_index,ext_attr
	default_mntopts = acl,user_xattr
	enable_periodic_fsck = 0
	blocksize = 4096
	inode_size = 256
	inode_ratio = 16384
	undo_dir = /var/lib/e2fsprogs/undo

[fs_types]
	ext3 = {
		features = has_journal
	}
	ext4 = {
		features = has_journal,extent,huge_file,flex_bg,metadata_csum,64bit,dir_nlink,extra_isize
		inode_size = 256
	}
	small = {
		blocksize = 1024
		inode_size = 128
		inode_ratio = 4096
	}
	floppy = {
		blocksize = 1024
		inode_size = 128
		inode_ratio = 8192
	}
	big = {
		inode_ratio = 32768
	}
	huge = {
		inode_ratio = 65536
	}
	news = {
		inode_ratio = 4096
	}
	largefile = {
		inode_ratio = 1048576
		blocksize = -1
	}
	largefile4 = {
		inode_ratio = 4194304
		blocksize = -1
	}
	hurd = {
	     blocksize = 4096
	     inode_size = 128
	}
	hugefiles = {
		features = extent,huge_file,flex_bg,uninit_bg,dir_nlink,extra_isize,^resize_inode,sparse_super2
		hash_alg = half_md4
		reserved_ratio = 0.0
		num_backup_sb = 0
		packed_meta_blocks = 1
		make_hugefiles = 1
		inode_ratio = 4194304
		hugefiles_dir = /storage
		hugefiles_name = chunk-
		hugefiles_digits = 5
		hugefiles_size = 4G
		hugefiles_align = 256M
		hugefiles_align_disk = true
		zero_hugefiles = false
		flex_bg_size = 262144
	}

	hugefile = {
		features = extent,huge_file,bigalloc,flex_bg,uninit_bg,dir_nlink,extra_isize,^resize_inode,sparse_super2
		cluster_size = 32768
		hash_alg = half_md4
		reserved_ratio = 0.0
		num_backup_sb = 0
		packed_meta_blocks = 1
		make_hugefiles = 1
		inode_ratio = 4194304
		hugefiles_dir = /storage
		hugefiles_name = huge-file
		hugefiles_digits = 0
		hugefiles_size = 0
		hugefiles_align = 256M
		hugefiles_align_disk = true
		num_hugefiles = 1
		zero_hugefiles = false
	}
	bigdata = {
		errors = remount-ro
		features = has_journal,extent,huge_file,flex_bg,metadata_csum,64bit,dir_nlink,extra_isize,bigalloc,^uninit_bg,sparse_super2
		inode_size = 256
		inode_ratio = 4194304
		cluster_size = 4194304
		reserved_ratio = 0
		lazy_itable_init = 0
		lazy_journal_init = 0
	}
