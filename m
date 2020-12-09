Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88D522D4AA0
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Dec 2020 20:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730933AbgLITke (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Dec 2020 14:40:34 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56754 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731932AbgLITkZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Dec 2020 14:40:25 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0B9JdZgH015362
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 9 Dec 2020 14:39:36 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 4A472420136; Wed,  9 Dec 2020 14:39:35 -0500 (EST)
Date:   Wed, 9 Dec 2020 14:39:35 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     brookxu <brookxu.cn@gmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Subject: Re: [PATCH RESEND 4/8] ext4: add the gdt block of meta_bg to
 system_zone
Message-ID: <20201209193935.GO52960@mit.edu>
References: <1604764698-4269-1-git-send-email-brookxu@tencent.com>
 <1604764698-4269-4-git-send-email-brookxu@tencent.com>
 <20201203150841.GM441757@mit.edu>
 <4770d6b2-bb9f-7bc5-4fbd-2104bfeba7c2@gmail.com>
 <20201209043415.GG52960@mit.edu>
 <dd6c2921-1397-4b1a-5a20-23956f9cf956@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd6c2921-1397-4b1a-5a20-23956f9cf956@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Dec 09, 2020 at 07:48:09PM +0800, brookxu wrote:
> 
> Maybe I missed something. If i% meta_bg_size is used instead, if
> flex_size <64, then we will miss some flex_bg. There seems to be
> a contradiction here. In the scenario where only flex_bg is
> enabled, it may not be appropriate to use meta_bg_size. In the
> scenario where only meta_bg is enabled, it may not be appropriate
> to use flex_size.
> 
> As you said before, it maybe better to remove
> 
> 	if ((i <5) || ((i% flex_size) == 0))
> 
> and do it for all groups.

I don't think the original (i % flex_size) made any sense in the first
place.

What flex_bg does is that it collects the allocation bitmaps and inode
tables for each block group and locates them within the first block
group in a flex_bg.  It doesn't have anything to do with whether or
not a particular block group has a backup copy of the superblock and
block group descriptor table --- in non-meta_bg file systems and the
meta_bg file systems where the block group is less than
s_first_meta_bg * EXT4_DESC_PER_BLOCK(sb).  And the condition in
question is only about whether or not to add the backup superblock and
backup block group descriptors.  So checking for i % flex_size made no
sense, and I'm not sure that check was there in the first place.

> In this way weh won't miss some flex_bg, meta_bg, and sparse_bg.
> I tested it on an 80T disk and found that the performance loss
> was small:
> 
>  unpatched kernel:
>  ext4_setup_system_zone() takes 524ms, 
> 
>  patched kernel:
>  ext4_setup_system_zone() takes 552ms, 

I don't really care that much about the time it takes to execute
ext4_setup_system_zone().

The really interesting question is how large is the rb_tree
constructed by that function, and what is the percentage increase of
time that the ext4_inode_block_valid() function takes.  (e.g., how
much additional memory is the system_blks tree taking, and how deep is
that tree, since ext4_inode_block_valid() gets called every time we
allocate or free a block, and every time we need to validate an extent
tree node.

Cheers,

						- Ted
