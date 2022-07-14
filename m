Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D99E57529A
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Jul 2022 18:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234681AbiGNQRO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Jul 2022 12:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiGNQRN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 Jul 2022 12:17:13 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688D261D5B
        for <linux-ext4@vger.kernel.org>; Thu, 14 Jul 2022 09:17:12 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id c6so837721pla.6
        for <linux-ext4@vger.kernel.org>; Thu, 14 Jul 2022 09:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LpP+5F2CiErgCX4jg/dDEbcd9sY5qbBV3D47hgTaYWc=;
        b=oG+JOno4R2qaCShKnZODb0q2W9ZslW06s+7LDGTbiIme9mMAucV2P1mB4d0m6SwC8Z
         KxjHEjAJqdTtus0lzFmkS6mNYXNCLPnAiQBCbbuC9lisWx19lyh7Wo0GA+HgNrqnoLsS
         mbOy65+FeAHBfUmPskUvnFQCkU9sO7LQJdiLjIdh+N2KpS9uYwpQFn5KA8eH2jM7Xama
         iMPKqjcj0Y+7wuX3fNigb9ivAZt3xxZStOb/MuKADMI7JLzUeCgLenbzwTVaY0yoJUjg
         4Cw0upaLpDNbS7K6S6iiLbfVs5TZIg90Ju7xRNPhclsY+6H/tyBOcSS20YbDJO4skXjN
         zCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LpP+5F2CiErgCX4jg/dDEbcd9sY5qbBV3D47hgTaYWc=;
        b=6QT6IwAtFG1ePQyTl3dGWQwpVFwdet874upTvEkut6/5UzPxvrmlD/EmoOI8+5tGXR
         ZSh21M1swAKFhmf7FAtWjnE3M1vCZK4EhxgAA5pd1W71apcgKZ2pcHC4lNjmbtVXINKl
         mIsF1xqJp1mkpX6X8BEoyQoiozgi8Ehoy/vIfVIfT86r3LO/dKgeGHpE8Anza3NggF8G
         RVw6CPhGlABNiLGTY3qRk8e6AlubvnUqprQA4bWzm1nYNhoQKbOJ9KeqKhfFbTLd7J80
         sF4lhtMfpL8sk639qsPChnJg6XgcTGidVPsVvVAcPN983EDPxsPzuN6pbkoGNHEj9n/V
         s9dQ==
X-Gm-Message-State: AJIora9gkZEcvvD6u78Bu1r+k/X2q3l14n3CUy4jY249LNdb/0wxEVVb
        PGlA42eBJTVlbd33SWSNPiA=
X-Google-Smtp-Source: AGRyM1uEzhTpRK0cTLcN4Lc21Hr2g4OSD5DMsqA68VCfSarB/4mY+8qODGHzEAW/kuXq4dOL4mFb+g==
X-Received: by 2002:a17:903:120c:b0:167:8847:21f2 with SMTP id l12-20020a170903120c00b00167884721f2mr8920755plh.11.1657815431806;
        Thu, 14 Jul 2022 09:17:11 -0700 (PDT)
Received: from localhost ([2406:7400:63:cb1d:811:33e9:9bc2:d40])
        by smtp.gmail.com with ESMTPSA id z1-20020aa79581000000b0052895642037sm1885410pfj.139.2022.07.14.09.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 09:17:11 -0700 (PDT)
Date:   Thu, 14 Jul 2022 21:47:06 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 06/10] ext2: Factor our freeing of xattr block reference
Message-ID: <20220714161706.7itdgwl5cjbgdwzs@riteshh-domain>
References: <20220712104519.29887-1-jack@suse.cz>
 <20220712105436.32204-6-jack@suse.cz>
 <20220714123714.xxqo7nnde6xacriu@riteshh-domain>
 <20220714145538.jbrbobhi5ppvuxka@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714145538.jbrbobhi5ppvuxka@quack3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/07/14 04:55PM, Jan Kara wrote:
> On Thu 14-07-22 18:07:14, Ritesh Harjani wrote:
> > On 22/07/12 12:54PM, Jan Kara wrote:
> > > Free of xattr block reference is opencode in two places. Factor it out
> > > into a separate function and use it.
> >
> > Looked into the refactoring logic. The patch looks good to me.
> > Small queries below -
> >
> > >
> > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > ---
> > >  fs/ext2/xattr.c | 90 +++++++++++++++++++++----------------------------
> > >  1 file changed, 38 insertions(+), 52 deletions(-)
> > >
> > > diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
> > > index 841fa6d9d744..9885294993ef 100644
> > > --- a/fs/ext2/xattr.c
> > > +++ b/fs/ext2/xattr.c
> > > @@ -651,6 +651,42 @@ ext2_xattr_set(struct inode *inode, int name_index, const char *name,
> > >  	return error;
> > >  }
> > >
> > > +static void ext2_xattr_release_block(struct inode *inode,
> > > +				     struct buffer_head *bh)
> > > +{
> > > +	struct mb_cache *ea_block_cache = EA_BLOCK_CACHE(inode);
> > > +
> > > +	lock_buffer(bh);
> > > +	if (HDR(bh)->h_refcount == cpu_to_le32(1)) {
> > > +		__u32 hash = le32_to_cpu(HDR(bh)->h_hash);
> > > +
> > > +		/*
> > > +		 * This must happen under buffer lock for
> > > +		 * ext2_xattr_set2() to reliably detect freed block
> > > +		 */
> > > +		mb_cache_entry_delete(ea_block_cache, hash,
> > > +				      bh->b_blocknr);
> > > +		/* Free the old block. */
> > > +		ea_bdebug(bh, "freeing");
> > > +		ext2_free_blocks(inode, bh->b_blocknr, 1);
> > > +		/* We let our caller release bh, so we
> > > +		 * need to duplicate the buffer before. */
> > > +		get_bh(bh);
> > > +		bforget(bh);
> > > +		unlock_buffer(bh);
> > > +	} else {
> > > +		/* Decrement the refcount only. */
> > > +		le32_add_cpu(&HDR(bh)->h_refcount, -1);
> > > +		dquot_free_block(inode, 1);
> > > +		mark_buffer_dirty(bh);
> > > +		unlock_buffer(bh);
> > > +		ea_bdebug(bh, "refcount now=%d",
> > > +			le32_to_cpu(HDR(bh)->h_refcount));
> > > +		if (IS_SYNC(inode))
> > > +			sync_dirty_buffer(bh);
> > > +	}
> > > +}
> > > +
> > >  /*
> > >   * Second half of ext2_xattr_set(): Update the file system.
> > >   */
> > > @@ -747,34 +783,7 @@ ext2_xattr_set2(struct inode *inode, struct buffer_head *old_bh,
> > >  		 * If there was an old block and we are no longer using it,
> > >  		 * release the old block.
> > >  		 */
> > > -		lock_buffer(old_bh);
> > > -		if (HDR(old_bh)->h_refcount == cpu_to_le32(1)) {
> > > -			__u32 hash = le32_to_cpu(HDR(old_bh)->h_hash);
> > > -
> > > -			/*
> > > -			 * This must happen under buffer lock for
> > > -			 * ext2_xattr_set2() to reliably detect freed block
> > > -			 */
> > > -			mb_cache_entry_delete(ea_block_cache, hash,
> > > -					      old_bh->b_blocknr);
> > > -			/* Free the old block. */
> > > -			ea_bdebug(old_bh, "freeing");
> > > -			ext2_free_blocks(inode, old_bh->b_blocknr, 1);
> > > -			mark_inode_dirty(inode);
> >
> > ^^^ this is not needed because ext2_free_blocks() will take care of it.
> > Hence you have dropped this in ext2_xattr_release_block()
>
> Correct. ext2_free_blocks() always dirties the inode (unless there is
> metadata inconsistency found in which case we don't really care).
>
> > > -			/* We let our caller release old_bh, so we
> > > -			 * need to duplicate the buffer before. */
> > > -			get_bh(old_bh);
> > > -			bforget(old_bh);
> > > -		} else {
> > > -			/* Decrement the refcount only. */
> > > -			le32_add_cpu(&HDR(old_bh)->h_refcount, -1);
> > > -			dquot_free_block_nodirty(inode, 1);
> > > -			mark_inode_dirty(inode);
> >
> > Quick qn -> Don't we need mark_inode_dirty() here?
>
> Notice that I've changed dquot_free_block_nodirty() to dquot_free_block()
> because quota info update is the only reason why we need to dirty the inode
> so why not let quota code handle it...
>

Ok, yes. Missed it. Thanks for pointing it out.

-ritesh
