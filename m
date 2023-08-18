Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78ED8780544
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Aug 2023 07:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357916AbjHRFAy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Aug 2023 01:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357947AbjHRFAv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 18 Aug 2023 01:00:51 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593FF358E
        for <linux-ext4@vger.kernel.org>; Thu, 17 Aug 2023 22:00:49 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-102-95.bstnma.fios.verizon.net [173.48.102.95])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 37I50aRl024848
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 01:00:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1692334839; bh=NFb54xf9TxvRO+bnuqhnmC+n+2wEnPT9Qu5u0CCl7tM=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=iT045XV95NTikCFKtn/+MEPtFLISe4haKF0GGMTXTCfmExvwehh8K9rdTWJ+BUXFw
         2QnNy07ipHxgxiVIWDhooGGnyHSGeQ+tyHeCJNOV5OCekgdztT1wIlMv1sIeP7l/d+
         HcFgaafi+69+pXJjG9LV4NWpxbzhmgoOLf/D9TP6aYwZqibe8J9Cvo+d4Pg5jqvRBE
         9AZaScJGUZssYa5cuDgQhNSMYOOVuNuP3RP5hYQb+wiytg70111Tvap8IHkMfj0Yt+
         W/MTqOyAQKIB6oH7GylNIlurmwq8ebh9zIHiRfDb1CVqk26hMByjifQ+yh0OQCvTST
         YvA6SyprgsH6Q==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id C423E15C0501; Fri, 18 Aug 2023 01:00:36 -0400 (EDT)
Date:   Fri, 18 Aug 2023 01:00:36 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/13] ext4: remove unnecessary check for avoiding
 multiple update_backups in ext4_flex_group_add
Message-ID: <20230818050036.GG3464136@mit.edu>
References: <20230629120044.1261968-1-shikemeng@huaweicloud.com>
 <20230629120044.1261968-13-shikemeng@huaweicloud.com>
 <20230816034730.GT2247938@mit.edu>
 <2a0c45d9-29f0-10a3-fc40-d48e101c8d91@huaweicloud.com>
 <20230817141112.GZ2247938@mit.edu>
 <cfad4b27-3174-1124-1516-a2ddb3843639@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfad4b27-3174-1124-1516-a2ddb3843639@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Aug 18, 2023 at 11:16:35AM +0800, Kemeng Shi wrote:
> Ah, I guess here is the thing I missed that make this confusing:
> sbi->s_group_desc contains only primary block of each group. i.e.
> sbi->s_group_desc['i'] is the primary gdb block of group 'i'.

Correct.  In fact, when we need to modify a block group descriptor for
a group, we call ext4_get_group_desc(), and it references
sbi->s_group_desc to find the appropriate buffer_head for the bg
descriptor that we want to modify.

I'm not sure "only" is the right adjective to use here, since the
whole *point* of s_group_desc[] is to keep the buffer_heads for the
block group descriptor blocks in memory, so we can modify them when we
allocate or free blocks, inodes, etc.  And we only modify the primary
block group descriptors.

The secondary, or backup block group descriptors are only by used
e2fsck when the primary block group descriptor has been overwritten,
so we can find the inode table, allocation bitmaps, and so on.  So we
do *not* modify them in the course of normal operations, and that's by
design.  The only time the kernel will update those block group
descriptors is when we are doing an online resize, and we need make
sure the backup descriptors are updated, so that if the primary
descriptors get completely smashed, we can still get critical
information such as the location of that block group's inode table.

> From add_new_gdb and add_new_gdb_meta_bg, we can find that we always
> add primary gdb block of new group to s_group_desc. To be more specific:
> add_new_gdb
> 	gdblock = EXT4_SB(sb)->s_sbh->b_blocknr + 1 + gdb_num;
> 	gdb_bh = ext4_sb_bread(sb, gdblock, 0);
> 	n_group_desc[gdb_num] = gdb_bh;
> 
> add_new_gdb_meta_bg
> 	gdblock = ext4_meta_bg_first_block_no(sb, group) +
> 		  ext4_bg_has_super(sb, group);
> 	gdb_bh = ext4_sb_bread(sb, gdblock, 0);
> 	n_group_desc[gdb_num] = gdb_bh;

Put another way, there are EXT4_DESC_PER_BLOCK(sb) bg descriptors in a
block.  For a file system with the 64-bit feature enabled, the size of
the block group descriptor is 128.  If the block size is 4096, then we
can fit 32 block group descriptors in a block.

When we add a new block group such that its block group descriptor
will spill into a new block, then we need to expand s_group_desc[]
array, and initialize the new block group descriptor block.  And
that's the job of add_new_gdb() and add_new_gdb_meta_bg().

> > More generally, this whole patch series is making it clear that the
> > online resize code is hard to understand, because it's super
> > complicated, leading to potential bugs, and very clearly code which is
> > very hard to maintain.  So this may mean we need better comments to
> > make it clear *when* the backup block groups are going to be
> > accomplished, given the various different cases (e.g., no flex_bg or
> > meta_bg, with flex_bg, or with meat_bg).
> > 
> Yes, I agree with this. I wonder if a series to add comments of some
> common rules is good to you. Like the information mentioned above
> that s_group_desc contains primary gdb block of each group.

Well, the meaning of s_group_desc[] was obvious to me, but that's why
it's useful to have somone with "new eyes" take a look at code, since
what may be obvious to old hands might not be obvious to someone
looking at the code for the first time --- and so yes, it's probably
worth documenting.  The question is where is the best place to put it,
since the primary place where s_group_desc[] is *not* online resize.

s_group_desc[] is initialized in ext4_group_desc_init() in
fs/ext4/super.c, and it is used in fs/ext4/balloc.c, and of course, it
is defined in fs/ext4.h.  

						- Ted
