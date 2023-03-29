Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC9F6CEF38
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Mar 2023 18:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjC2QWh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Mar 2023 12:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjC2QWf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 29 Mar 2023 12:22:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DF226A4;
        Wed, 29 Mar 2023 09:22:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2E2671FDFF;
        Wed, 29 Mar 2023 16:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680106949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WvBRl9DMj5JDRWAfdcznsvoZZbR2E7GtfdOus+/MiA4=;
        b=aMLeoHOkQUzONPaUb0GwsAeILWoT8yGYWpi3tfNcSzFIjECGGNmwdNYtXrXVinP9GMmQEi
        cdMD4DQDJezmzqF2ABO/MUtlJkl8XOnY8BoI15ixAd1C0uYLC0M5FEDR1Lyz9GU0UhLmiM
        yB9m0srGm5Pw1mrBYmR14KxSAfx/RrU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680106949;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WvBRl9DMj5JDRWAfdcznsvoZZbR2E7GtfdOus+/MiA4=;
        b=G91k/lwtCjNcTCP2KvO2Poxh3/G7m9TMXUf9XVoUNuywKj8y7UAVbbwUP9IIGnTWJNDATz
        eDd3ukL1qiyTm2Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 19EE0138FF;
        Wed, 29 Mar 2023 16:22:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /S1OBsVlJGQHdAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 29 Mar 2023 16:22:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 37E46A071E; Wed, 29 Mar 2023 18:22:28 +0200 (CEST)
Date:   Wed, 29 Mar 2023 18:22:28 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH] ext4: only update i_reserved_data_blocks on successful
 block allocation
Message-ID: <20230329162228.evbppkkcbbbnaeeo@quack3>
References: <20230325063443.1839558-1-libaokun1@huawei.com>
 <20230327124700.mnldh4sosp3ptbls@quack3>
 <a4ee8f3e-9428-ebb1-c0b4-9348075902b6@huawei.com>
 <20230328100037.vy23wsnl437ujdoh@quack3>
 <7410b9be-da2d-57e0-c4f8-19900df2c440@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7410b9be-da2d-57e0-c4f8-19900df2c440@huawei.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 29-03-23 15:23:19, Baokun Li wrote:
> On 2023/3/28 18:00, Jan Kara wrote:
> > On Mon 27-03-23 21:09:42, Baokun Li wrote:
> > > On 2023/3/27 20:47, Jan Kara wrote:
> > > > On Sat 25-03-23 14:34:43, Baokun Li wrote:
> > > > > In our fault injection test, we create an ext4 file, migrate it to
> > > > > non-extent based file, then punch a hole and finally trigger a WARN_ON
> > > > > in the ext4_da_update_reserve_space():
> > > > > 
> > > > > EXT4-fs warning (device sda): ext4_da_update_reserve_space:369:
> > > > > ino 14, used 11 with only 10 reserved data blocks
> > > > > 
> > > > > When writing back a non-extent based file, if we enable delalloc, the
> > > > > number of reserved blocks will be subtracted from the number of blocks
> > > > > mapped by ext4_ind_map_blocks(), and the extent status tree will be
> > > > > updated. We update the extent status tree by first removing the old
> > > > > extent_status and then inserting the new extent_status. If the block range
> > > > > we remove happens to be in an extent, then we need to allocate another
> > > > > extent_status with ext4_es_alloc_extent().
> > > > > 
> > > > >          use old    to remove   to add new
> > > > >       |----------|------------|------------|
> > > > >                 old extent_status
> > > > > 
> > > > > The problem is that the allocation of a new extent_status failed due to a
> > > > > fault injection, and __es_shrink() did not get free memory, resulting in
> > > > > a return of -ENOMEM. Then do_writepages() retries after receiving -ENOMEM,
> > > > > we map to the same extent again, and the number of reserved blocks is again
> > > > > subtracted from the number of blocks in that extent. Since the blocks in
> > > > > the same extent are subtracted twice, we end up triggering WARN_ON at
> > > > > ext4_da_update_reserve_space() because used > ei->i_reserved_data_blocks.
> > > > Hum, but this second call to ext4_map_blocks() should find already allocated
> > > > blocks in the indirect block and thus should not be subtracting
> > > > ei->i_reserved_data_blocks for the second time. What am I missing?
> > > > 
> > > > 								Honza
> > > > 
> > > ext4_map_blocks
> > >    1. Lookup extent status tree firstly
> > >         goto found;
> > >    2. get the block without requesting a new file system block.
> > > found:
> > >    3. ceate and map the block
> > > 
> > > When we call ext4_map_blocks() for the second time, we directly find the
> > > corresponding blocks in the extent status tree, and then go directly to step
> > > 3,
> > > because our flag is brand new and therefore does not contain EXT4_MAP_MAPPED
> > > but contains EXT4_GET_BLOCKS_CREATE, thus subtracting
> > > ei->i_reserved_data_blocks
> > > for the second time.
> > Ah, I see. Thanks for explanation. But then the problem is deeper than just
> > a mismatch in number of reserved delalloc block. The problem really is that
> > if extent status tree update fails, we have inconsistency between what is
> > stored in the extent status tree and what is stored on disk. And that can
> > cause even data corruption issues in some cases.
> The scenario we encountered was this:
> ```
> write:
>     ext4_es_insert_delayed_block
>     [0/16) 576460752303423487 (U,D)
> writepages:
>     alloc lblk 11 pblk 35328
>     [0/16) 576460752303423487 (U,D)
>     -- remove block 11 from extent
>       [0/11) 576460752303423487 (U,D,R)  +  (Newly allocated)[12/4)
> 549196775151 (U,D,R)
>       --Failure to allocate memory for a new extent will undo as:
>             [0/16) 576460752303423487 (U,D,R)

Yes, this is what I was expecting. So now extent status tree is
inconsistent with the on-disk allocation info because the block 11 is
already allocated on disk but recorded as unallocated in the extent status
tree.

If the similar problem happened say when we punch a hole into a middle of a
written extent and so block on disk got freed but extent status tree would
still record it as allocated, user would be able to access freed block thus
potentially exposing sensitive data.

>     -- if success insert block 11 to extent status tree
>       [0/11) 576460752303423487 (U,D,R) + (Newly allocated)[11/1) 35328 (W)
> + [12/4) 549196775151 (U,D,R)
> 
> U: UNWRITTEN
> D: DELAYED
> W: WRITTEN
> R: REFERENCED
> ```
> 
> When we fail to allocate a new extent, we don't map buffer and we don't do
> io_submit, so why is the extent tree in memory inconsistent with the one
> stored on disk? Am I missing something?
> 
> I would appreciate it if you could explain under what cases and what kind of
> data corruption issues can be caused.

See above.

> > And this should also fix the problem you've hit because in case of
> > allocation failure we may just end up with removed extent from the extent
> > status tree and thus we refetch info from the disk and find out blocks are
> > already allocated.
> 
> Reloading extent tree from disk I don't quite understand here, how do we
> handle reserved blocks? could you explain it in more detail?
> 
> Logically, I think it is still necessary to update i_reserved_data_blocks
> only after a successful allocation. This is also done in
> ext4_ext_map_blocks().

I guess there is some misunderstanding here. Both with
ext4_ext_map_blocks() and ext4_ind_map_blocks() we end up updating
i_reserved_data_blocks only after the blocks are successfully allocated and
inserted in the respective data structure but *before* updating extent
status tree. If extent status tree operation fails, we currently get
inconsistency between extent status tree and on-disk info in both cases
AFAICS. Am I missing something?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
