Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1DEF32ED25
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Mar 2021 15:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbhCEO34 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 5 Mar 2021 09:29:56 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45714 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229821AbhCEO3l (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 5 Mar 2021 09:29:41 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 125ETZ5d021788
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 5 Mar 2021 09:29:36 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id C4BDB15C3A88; Fri,  5 Mar 2021 09:29:35 -0500 (EST)
Date:   Fri, 5 Mar 2021 09:29:35 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: Add checks to xattr code that we have appropriate
 reclaim context
Message-ID: <YEJAT+4flwcxSrXY@mit.edu>
References: <20210222171626.21884-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210222171626.21884-1-jack@suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Feb 22, 2021 at 06:16:26PM +0100, Jan Kara wrote:
> Syzbot is reporting that ext4 can enter fs reclaim from kvmalloc() while
> the transaction is started like:
> 
>   fs_reclaim_acquire+0x117/0x150 mm/page_alloc.c:4340
>   might_alloc include/linux/sched/mm.h:193 [inline]
>   slab_pre_alloc_hook mm/slab.h:493 [inline]
>   slab_alloc_node mm/slub.c:2817 [inline]
>   __kmalloc_node+0x5f/0x430 mm/slub.c:4015
>   kmalloc_node include/linux/slab.h:575 [inline]
>   kvmalloc_node+0x61/0xf0 mm/util.c:587
>   kvmalloc include/linux/mm.h:781 [inline]
>   ext4_xattr_inode_cache_find fs/ext4/xattr.c:1465 [inline]
>   ext4_xattr_inode_lookup_create fs/ext4/xattr.c:1508 [inline]
>   ext4_xattr_set_entry+0x1ce6/0x3780 fs/ext4/xattr.c:1649
>   ext4_xattr_ibody_set+0x78/0x2b0 fs/ext4/xattr.c:2224
>   ext4_xattr_set_handle+0x8f4/0x13e0 fs/ext4/xattr.c:2380
>   ext4_xattr_set+0x13a/0x340 fs/ext4/xattr.c:2493
> 
> This should be impossible since transaction start sets PF_MEMALLOC_NOFS.
> Add some assertions to the code to catch if something isn't working as
> expected early.
> 
> Link: https://lore.kernel.org/linux-ext4/000000000000563a0205bafb7970@google.com/
> Signed-off-by: Jan Kara <jack@suse.cz>

Thanks, applied.

					- Ted
