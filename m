Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28E06D991F
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Oct 2019 20:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390931AbfJPS0Z (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Oct 2019 14:26:25 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:54323 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727374AbfJPS0Z (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Oct 2019 14:26:25 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9GIQILo029702
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Oct 2019 14:26:19 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id AA04C420458; Wed, 16 Oct 2019 14:26:18 -0400 (EDT)
Date:   Wed, 16 Oct 2019 14:26:18 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 06/13] ext4: add fields that are needed to track
 changed files
Message-ID: <20191016182618.GF11103@mit.edu>
References: <20191001074101.256523-1-harshadshirwadkar@gmail.com>
 <20191001074101.256523-7-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001074101.256523-7-harshadshirwadkar@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Oct 01, 2019 at 12:40:55AM -0700, Harshad Shirwadkar wrote:
> +/*
> + * Ext4 fast commit inode specific information
> + */
> +struct ext4_fast_commit_inode_info {

I think it would be better to move the contents of this structure
directly into ext4_inode_info, instead of adding this structure to
ext4_inode_info; the structure is never used in a free-standing
context.

> +	/*
> +	 * Flag indicating whether this inode is eligible for fast commits or
> +	 * not.
> +	 */
> +	bool fc_eligible;
> +
> +	/*
> +	 * Flag indicating whether this inode is newly created during this
> +	 * tid:subtid.
> +	 */
> +	bool fc_new;

These two bools could be replaced using EXT4_STATE_* flags.  Grep for
EXT4_STATE_NEWENTRY to see an example of how an EXT4_STATE_ flag is
defined and used.


> +	rwlock_t fc_lock;

What is this used for?  If it's only just to protect the i_fc_list
list_head, maybe name it i_fc_list_lock?

> diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
> index 764ff4c56233..ff30f3015551 100644
> --- a/fs/ext4/ialloc.c
> +++ b/fs/ext4/ialloc.c
> @@ -1131,6 +1131,7 @@ struct inode *__ext4_new_inode(handle_t *handle, struct inode *dir,
>  
>  	ext4_clear_state_flags(ei); /* Only relevant on 32-bit archs */
>  	ext4_set_inode_state(inode, EXT4_STATE_NEW);
> +	ext4_init_inode_fc_info(inode);
>  
>  	ei->i_extra_isize = sbi->s_want_extra_isize;
>  	ei->i_inline_off = 0;

I don't think this is necessary; the inode was returned by ext4_iget,
so the ext4_alloc_inode() will have already called that function.


> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 420fe3deed39..f230a888eddd 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4996,6 +4996,7 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
>  	for (block = 0; block < EXT4_N_BLOCKS; block++)
>  		ei->i_data[block] = raw_inode->i_block[block];
>  	INIT_LIST_HEAD(&ei->i_orphan);
> +	ext4_init_inode_fc_info(&ei->vfs_inode);
>  

The inode here was returned by iget_locked(), which means
ext4_alloc_inode() will have been called.

> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 7725eb2105f4..c90337fc98c1 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1139,6 +1140,7 @@ static void init_once(void *foo)
>  	init_rwsem(&ei->i_data_sem);
>  	init_rwsem(&ei->i_mmap_sem);
>  	inode_init_once(&ei->vfs_inode);
> +	ext4_init_inode_fc_info(&ei->vfs_inode);
>  }

Maybe pull the rwlock_init() out of ext4_init_inode_fc_info() and
stuff it here?

Basically, it looks like certain fields are getting redundantly
initalized a lot.  The init_once function will initialize those fields
that will be reset when the structure is released.  If we are sure
that it will be reset (e.g., the spinlock will be reset), then we can
initialize it once in init_once() and then not re-initializing in
other places, such as ext4_alloc_inode().

There are some people who think it's not worth it to avoid using
init_once, since this can cause bugs if it turns out it wasn't
properly reset at the time when the object is released.  So the other
approach is to drop the ext4_init_inode_fc_info() and then just
reinitialize the spinlock every time.  (OTOH, if someone else is still
holding on the spinlock when you release it, then reinitialize the
spinlock can *also* lead to a very hard-to-debug crash.)

	     	    	      	   		 - Ted
