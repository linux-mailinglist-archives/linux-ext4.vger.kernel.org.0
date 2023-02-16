Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D0669952C
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Feb 2023 14:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjBPNHU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Feb 2023 08:07:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjBPNHT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Feb 2023 08:07:19 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5A0BDCD
        for <linux-ext4@vger.kernel.org>; Thu, 16 Feb 2023 05:07:17 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7FA111FD6D;
        Thu, 16 Feb 2023 13:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676552836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9QDWkEuyLJfRgBiv/rbzBtJqZeM7uS6Wr2iZ6tOz/gA=;
        b=y5NV/iMBw2EKhXyLxnHpjnEd89S65Fp890h5NrvLIayIXhGO9KsXdNAfTGA6Bb1E2mAuQc
        87xJ26BkruAaUxhUivTx9sKb/SU1uGsjyo7BqM4rov4hxS3PhtqBvDmhqHwmDmE2swK3di
        Z6dELJ+Ys7to3RVKj2NyWIxfqKt8+A8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676552836;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9QDWkEuyLJfRgBiv/rbzBtJqZeM7uS6Wr2iZ6tOz/gA=;
        b=ji2RAVPjz1kR8F/qHAQ8HWFqPcMyvVSZohsdoRTxYYpQ2eg3FBU6qruuseQ+mUVaHFza8n
        mH3x+XZajvFVHfAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 68DC113438;
        Thu, 16 Feb 2023 13:07:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rAmYGYQq7mNpUwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 16 Feb 2023 13:07:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 7971FA06E1; Thu, 16 Feb 2023 14:07:15 +0100 (CET)
Date:   Thu, 16 Feb 2023 14:07:15 +0100
From:   Jan Kara <jack@suse.cz>
To:     zhanchengbin <zhanchengbin1@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, tytso@mit.edu, jack@suse.com,
        linux-ext4@vger.kernel.org, yi.zhang@huawei.com,
        linfeilong@huawei.com, liuzhiqiang26@huawei.com
Subject: Re: [PATCH v4 1/2] ext4: fix inode tree inconsistency caused by
 ENOMEM in ext4_split_extent_at
Message-ID: <20230216130715.kcvcvitdinpv7wwt@quack3>
References: <20230213040522.3339406-1-zhanchengbin1@huawei.com>
 <20230213040522.3339406-2-zhanchengbin1@huawei.com>
 <20230214114835.hpjr4zgofrcp7hyy@quack3>
 <a666524b-e811-c35e-3f2b-f2d63622f674@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a666524b-e811-c35e-3f2b-f2d63622f674@huawei.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 15-02-23 16:51:23, zhanchengbin wrote:
> 
> On 2023/2/14 19:48, Jan Kara wrote:
> > On Mon 13-02-23 12:05:21, zhanchengbin wrote:
> > > If ENOMEM fails when the extent is splitting, we need to restore the length
> > > of the split extent.
> > > In the call stack of the ext4_split_extent_at function, only in
> > > ext4_ext_create_new_leaf will it alloc memory and change the shape of the
> > > extent tree,even if an ENOMEM is returned at this time, the extent tree is
> > > still self-consistent, Just restore the split extent lens in the function
> > > ext4_split_extent_at.
> > > 
> > > ext4_split_extent_at
> > >   ext4_ext_insert_extent
> > >    ext4_ext_create_new_leaf
> > >     1)ext4_ext_split
> > >       ext4_find_extent
> > >     2)ext4_ext_grow_indepth
> > >       ext4_find_extent
> > > 
> > > Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
> > > ---
> > >   fs/ext4/extents.c | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> > > index 9de1c9d1a13d..0f95e857089e 100644
> > > --- a/fs/ext4/extents.c
> > > +++ b/fs/ext4/extents.c
> > > @@ -935,6 +935,7 @@ ext4_find_extent(struct inode *inode, ext4_lblk_t block,
> > >   		bh = read_extent_tree_block(inode, path[ppos].p_idx, --i, flags);
> > >   		if (IS_ERR(bh)) {
> > > +			EXT4_ERROR_INODE(inode, "IO error reading extent block");
> > 
> > Why have you added this? Usually we don't log any additional errors for IO
> > errors because the storage layer already reports it... Furthermore this
> > would potentialy panic the system / remount the fs RO which we also usually
> > don't do in case of IO errors, only in case of FS corruption.
> > 
> > 								Honza
> 
> Because failure of read_extent_tree_block indirectly leads to filesystem
> inconsistency in ext4_split_extent_at, I want the filesystem to become
> read-only after failure.

Can you please describe how exactly? Because I'd rather declare the error
directly in ext4_split_extent_at() than in ext4_find_extent() unless it
gets too complicated...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
