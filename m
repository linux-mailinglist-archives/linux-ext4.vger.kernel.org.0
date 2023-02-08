Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E3A68EF91
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Feb 2023 14:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjBHNMv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Feb 2023 08:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjBHNMu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Feb 2023 08:12:50 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7BE460AF
        for <linux-ext4@vger.kernel.org>; Wed,  8 Feb 2023 05:12:48 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1C8101FF2F;
        Wed,  8 Feb 2023 13:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675861967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KL3XpcmjRu8ILZBO+9yt9HOaGAi0L00ZRsXphQUknIg=;
        b=pDZL0xngO0UVX0Rz7sXGp9EzCAiOzTKC2W7mGz+c+Z6lg7GKSYf4Xnfm36Ze/HsbLuPXZB
        rV0sH5lihUTvA6h0zDzpChcL+nR7/aGvDi365AqPxi1Rc6np9dZ9DXnA/UFB4GnS5gAt1B
        Crq3iVMsJM8y+FWgo/GVDiABkTBYxV4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675861967;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KL3XpcmjRu8ILZBO+9yt9HOaGAi0L00ZRsXphQUknIg=;
        b=3JZ55ht/2qcDpo+kHdAcIDi8xcpPzNxBGIWuKTfYa8KlgPqrKl93h3qEJoasBCA+2E9PhU
        WcBWMzDfsGLLJgDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8AEB113425;
        Wed,  8 Feb 2023 13:12:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id m/3YIc6f42NJfwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 08 Feb 2023 13:12:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B4CEAA06D5; Wed,  8 Feb 2023 14:12:40 +0100 (CET)
Date:   Wed, 8 Feb 2023 14:12:40 +0100
From:   Jan Kara <jack@suse.cz>
To:     zhanchengbin <zhanchengbin1@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, tytso@mit.edu, jack@suse.com,
        linux-ext4@vger.kernel.org, yi.zhang@huawei.com,
        linfeilong@huawei.com, liuzhiqiang26@huawei.com
Subject: Re: [PATCH v3 2/2] ext4: restore len when ext4_ext_insert_extent
 failed
Message-ID: <20230208131240.gwfulolnvcz5omdi@quack3>
References: <20230207070931.2189663-1-zhanchengbin1@huawei.com>
 <20230207070931.2189663-3-zhanchengbin1@huawei.com>
 <20230207142356.frf4zzpqlh7mlwft@quack3>
 <c7a79489-c0d7-968b-4fa5-c698ceb63bf9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7a79489-c0d7-968b-4fa5-c698ceb63bf9@huawei.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 08-02-23 15:10:35, zhanchengbin wrote:
> Thanks for your comments.
> I've analyzed this situation, If a failure occurs at a certain layer, the
> start of the upper and lower logical blocks is different, this's same as
> ext4_ext_rm_idx.
> If this happens data is not flushed to disks so data on disks is
> consistent, but data on the memory is inconsistent (have journal). In my
> opinion, we just need to ensure that we don't use the wrong data and flush
> to disk. Look code we can know if ext4_ext_get_access and ext4_ext_dirty
> faild, the verified flag of bh will be cleared, if read this bad inode
> again, read_extent_tree_block will check verified flag and goto
> __ext4_ext_check, finally, return error in the ext4_valid_extent_entries
> function if the logical block start is incorrect, So does not change the
> consistency of data on the disk. (Emmmmmm, I misunderstand the judgment in
> ext4_valid_extent_entries. Later, I will clear the verified flag from the
> modified bh when ext4_valid_extent_entries fails.)
> If no journal, the data on the disk is inconsistent, too. Can use fsck to
> fix it.
> What do you think?

So I agree that as soon as we abort the journal, modified data cannot get
to the disk and so we will not be writing inconsistent extent tree to the
disk. But we could still succeed in submitting requests to zero-out parts
of existing extent and that may corrupt the filesystem if the journal is
already aborted at that moment and gets replayed to some previous, not
quite known state.  So in that case is there any point in trying to fixup
anything?  The only occasions where it makes sense trying to keep extent
tree consistent is during some non-catastrophical errors - currently we
have ENOSPC, EDQUOT, ENOMEM - which make sense because from these we should
better recover without corrupting the filesystem. But I don't really see
any point in trying to fixup the "catastrophical" errors like EIO or
EFSCORRUPTED, it can do only harm.

								Honza
> On 2023/2/7 22:23, Jan Kara wrote:
> > On Tue 07-02-23 15:09:31, zhanchengbin wrote:
> > > Inside the ext4_ext_insert_extent function, every error returned will
> > > not destroy the consistency of the tree. Even if it fails after changing
> > > half of the tree, can also ensure that the tree is self-consistent, like
> > > function ext4_ext_create_new_leaf.
> > 
> > Hum, but e.g. if ext4_ext_correct_indexes() fails, we *will* end up with
> > corrupted extent tree pretty much without a chance for recovery, won't we?
> > 
> > 								Honza
> > 
> > > After ext4_ext_insert_extent fails, update extent status tree depends on
> > > the incoming split_flag. So restore the len of extent to be split when
> > > ext4_ext_insert_extent return failed in ext4_split_extent_at.
> > > 
> > > Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
> > > Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> > > ---
> > >   fs/ext4/extents.c | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> > > index 3559ea6b0781..b926fef73de4 100644
> > > --- a/fs/ext4/extents.c
> > > +++ b/fs/ext4/extents.c
> > > @@ -935,6 +935,7 @@ ext4_find_extent(struct inode *inode, ext4_lblk_t block,
> > >   		bh = read_extent_tree_block(inode, path[ppos].p_idx, --i, flags);
> > >   		if (IS_ERR(bh)) {
> > > +			EXT4_ERROR_INODE(inode, "IO error reading extent block");
> > >   			ret = PTR_ERR(bh);
> > >   			goto err;
> > >   		}
> > > @@ -3251,7 +3252,7 @@ static int ext4_split_extent_at(handle_t *handle,
> > >   		ext4_ext_mark_unwritten(ex2);
> > >   	err = ext4_ext_insert_extent(handle, inode, ppath, &newex, flags);
> > > -	if (err != -ENOSPC && err != -EDQUOT && err != -ENOMEM)
> > > +	if (!err)
> > >   		goto out;
> > >   	if (EXT4_EXT_MAY_ZEROOUT & split_flag) {
> > > -- 
> > > 2.31.1
> > > 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
