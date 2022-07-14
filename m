Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D78F57512B
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Jul 2022 16:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239565AbiGNOzm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Jul 2022 10:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238284AbiGNOzl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 Jul 2022 10:55:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100BF52464
        for <linux-ext4@vger.kernel.org>; Thu, 14 Jul 2022 07:55:40 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BE61F1FB60;
        Thu, 14 Jul 2022 14:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657810538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TXMkQ3ZAD2ss+HoSNxu5AV+Rmj4hGGMaLuPb+iT6wrk=;
        b=lODR1Jy/tGhmgYFs3mfkaMv+YV9CzwJxjw9qlxg5zcAnEQZOnA/6FHB3UdO+/5FVlEaxtL
        NnjZsC+FGYhpd2aeiJEf3HcHR4ftsE9HH2BmopRon74eSinHEzxl5a5UBlwIsLGZPSwnD6
        UrCtSEUxINQnjeWgp67KWHZ57JT+UZ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657810538;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TXMkQ3ZAD2ss+HoSNxu5AV+Rmj4hGGMaLuPb+iT6wrk=;
        b=hhBmMfybRz3iUDwSmLnByHEBDDEyh4lckGBIdmjjhXelOAgLmFmvyxZZZtxIhiySBOvDsq
        /E4LSMlLZBO+1oAw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id AD83F2C141;
        Thu, 14 Jul 2022 14:55:38 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 300F6A0659; Thu, 14 Jul 2022 16:55:38 +0200 (CEST)
Date:   Thu, 14 Jul 2022 16:55:38 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 06/10] ext2: Factor our freeing of xattr block reference
Message-ID: <20220714145538.jbrbobhi5ppvuxka@quack3>
References: <20220712104519.29887-1-jack@suse.cz>
 <20220712105436.32204-6-jack@suse.cz>
 <20220714123714.xxqo7nnde6xacriu@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714123714.xxqo7nnde6xacriu@riteshh-domain>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 14-07-22 18:07:14, Ritesh Harjani wrote:
> On 22/07/12 12:54PM, Jan Kara wrote:
> > Free of xattr block reference is opencode in two places. Factor it out
> > into a separate function and use it.
> 
> Looked into the refactoring logic. The patch looks good to me.
> Small queries below -
> 
> >
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  fs/ext2/xattr.c | 90 +++++++++++++++++++++----------------------------
> >  1 file changed, 38 insertions(+), 52 deletions(-)
> >
> > diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
> > index 841fa6d9d744..9885294993ef 100644
> > --- a/fs/ext2/xattr.c
> > +++ b/fs/ext2/xattr.c
> > @@ -651,6 +651,42 @@ ext2_xattr_set(struct inode *inode, int name_index, const char *name,
> >  	return error;
> >  }
> >
> > +static void ext2_xattr_release_block(struct inode *inode,
> > +				     struct buffer_head *bh)
> > +{
> > +	struct mb_cache *ea_block_cache = EA_BLOCK_CACHE(inode);
> > +
> > +	lock_buffer(bh);
> > +	if (HDR(bh)->h_refcount == cpu_to_le32(1)) {
> > +		__u32 hash = le32_to_cpu(HDR(bh)->h_hash);
> > +
> > +		/*
> > +		 * This must happen under buffer lock for
> > +		 * ext2_xattr_set2() to reliably detect freed block
> > +		 */
> > +		mb_cache_entry_delete(ea_block_cache, hash,
> > +				      bh->b_blocknr);
> > +		/* Free the old block. */
> > +		ea_bdebug(bh, "freeing");
> > +		ext2_free_blocks(inode, bh->b_blocknr, 1);
> > +		/* We let our caller release bh, so we
> > +		 * need to duplicate the buffer before. */
> > +		get_bh(bh);
> > +		bforget(bh);
> > +		unlock_buffer(bh);
> > +	} else {
> > +		/* Decrement the refcount only. */
> > +		le32_add_cpu(&HDR(bh)->h_refcount, -1);
> > +		dquot_free_block(inode, 1);
> > +		mark_buffer_dirty(bh);
> > +		unlock_buffer(bh);
> > +		ea_bdebug(bh, "refcount now=%d",
> > +			le32_to_cpu(HDR(bh)->h_refcount));
> > +		if (IS_SYNC(inode))
> > +			sync_dirty_buffer(bh);
> > +	}
> > +}
> > +
> >  /*
> >   * Second half of ext2_xattr_set(): Update the file system.
> >   */
> > @@ -747,34 +783,7 @@ ext2_xattr_set2(struct inode *inode, struct buffer_head *old_bh,
> >  		 * If there was an old block and we are no longer using it,
> >  		 * release the old block.
> >  		 */
> > -		lock_buffer(old_bh);
> > -		if (HDR(old_bh)->h_refcount == cpu_to_le32(1)) {
> > -			__u32 hash = le32_to_cpu(HDR(old_bh)->h_hash);
> > -
> > -			/*
> > -			 * This must happen under buffer lock for
> > -			 * ext2_xattr_set2() to reliably detect freed block
> > -			 */
> > -			mb_cache_entry_delete(ea_block_cache, hash,
> > -					      old_bh->b_blocknr);
> > -			/* Free the old block. */
> > -			ea_bdebug(old_bh, "freeing");
> > -			ext2_free_blocks(inode, old_bh->b_blocknr, 1);
> > -			mark_inode_dirty(inode);
> 
> ^^^ this is not needed because ext2_free_blocks() will take care of it.
> Hence you have dropped this in ext2_xattr_release_block()

Correct. ext2_free_blocks() always dirties the inode (unless there is
metadata inconsistency found in which case we don't really care).

> > -			/* We let our caller release old_bh, so we
> > -			 * need to duplicate the buffer before. */
> > -			get_bh(old_bh);
> > -			bforget(old_bh);
> > -		} else {
> > -			/* Decrement the refcount only. */
> > -			le32_add_cpu(&HDR(old_bh)->h_refcount, -1);
> > -			dquot_free_block_nodirty(inode, 1);
> > -			mark_inode_dirty(inode);
> 
> Quick qn -> Don't we need mark_inode_dirty() here?

Notice that I've changed dquot_free_block_nodirty() to dquot_free_block()
because quota info update is the only reason why we need to dirty the inode
so why not let quota code handle it...

> 
> > -			mark_buffer_dirty(old_bh);
> > -			ea_bdebug(old_bh, "refcount now=%d",
> > -				le32_to_cpu(HDR(old_bh)->h_refcount));
> > -		}
> > -		unlock_buffer(old_bh);
> > +		ext2_xattr_release_block(inode, old_bh);
> >  	}

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
