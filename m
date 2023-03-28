Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7BA6CBBA9
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Mar 2023 12:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbjC1KA4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Mar 2023 06:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232832AbjC1KAv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 28 Mar 2023 06:00:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926136180;
        Tue, 28 Mar 2023 03:00:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4211F1F8BA;
        Tue, 28 Mar 2023 10:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679997638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L3swI2nzmHgC/eyRcwS8QwJ3kMOr2pact6o7Wl+DUFU=;
        b=pAmMUoqFK6W/dtk0yrj0704FOtnNRbilsg+V34xos4fSRAF923B/9lqaXvVa6vi70PYU1/
        7N6BFRYpKkNet/2krMA4c9G3nL3zDGNdyz3G9WQrD9MDRuSwb/owlcsgJrpusDcfJT/Hfg
        kiG8v9x4tIHblCcOVpQ1+JyIvY3aqRs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679997638;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L3swI2nzmHgC/eyRcwS8QwJ3kMOr2pact6o7Wl+DUFU=;
        b=BU5nnRu84251gMYEIyM8zbXt/bYEcwx0MtQfieoUTy2uLITmlTbWYbfCgGJuImIjPwbHRC
        A569vx2qGJyR+xAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 24D421390B;
        Tue, 28 Mar 2023 10:00:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kIz1CMa6ImRnWwAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 28 Mar 2023 10:00:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 69618A071C; Tue, 28 Mar 2023 12:00:37 +0200 (CEST)
Date:   Tue, 28 Mar 2023 12:00:37 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH] ext4: only update i_reserved_data_blocks on successful
 block allocation
Message-ID: <20230328100037.vy23wsnl437ujdoh@quack3>
References: <20230325063443.1839558-1-libaokun1@huawei.com>
 <20230327124700.mnldh4sosp3ptbls@quack3>
 <a4ee8f3e-9428-ebb1-c0b4-9348075902b6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a4ee8f3e-9428-ebb1-c0b4-9348075902b6@huawei.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 27-03-23 21:09:42, Baokun Li wrote:
> On 2023/3/27 20:47, Jan Kara wrote:
> > On Sat 25-03-23 14:34:43, Baokun Li wrote:
> > > In our fault injection test, we create an ext4 file, migrate it to
> > > non-extent based file, then punch a hole and finally trigger a WARN_ON
> > > in the ext4_da_update_reserve_space():
> > > 
> > > EXT4-fs warning (device sda): ext4_da_update_reserve_space:369:
> > > ino 14, used 11 with only 10 reserved data blocks
> > > 
> > > When writing back a non-extent based file, if we enable delalloc, the
> > > number of reserved blocks will be subtracted from the number of blocks
> > > mapped by ext4_ind_map_blocks(), and the extent status tree will be
> > > updated. We update the extent status tree by first removing the old
> > > extent_status and then inserting the new extent_status. If the block range
> > > we remove happens to be in an extent, then we need to allocate another
> > > extent_status with ext4_es_alloc_extent().
> > > 
> > >         use old    to remove   to add new
> > >      |----------|------------|------------|
> > >                old extent_status
> > > 
> > > The problem is that the allocation of a new extent_status failed due to a
> > > fault injection, and __es_shrink() did not get free memory, resulting in
> > > a return of -ENOMEM. Then do_writepages() retries after receiving -ENOMEM,
> > > we map to the same extent again, and the number of reserved blocks is again
> > > subtracted from the number of blocks in that extent. Since the blocks in
> > > the same extent are subtracted twice, we end up triggering WARN_ON at
> > > ext4_da_update_reserve_space() because used > ei->i_reserved_data_blocks.
> > Hum, but this second call to ext4_map_blocks() should find already allocated
> > blocks in the indirect block and thus should not be subtracting
> > ei->i_reserved_data_blocks for the second time. What am I missing?
> > 
> > 								Honza
> > 
> ext4_map_blocks
>   1. Lookup extent status tree firstly
>        goto found;
>   2. get the block without requesting a new file system block.
> found:
>   3. ceate and map the block
> 
> When we call ext4_map_blocks() for the second time, we directly find the
> corresponding blocks in the extent status tree, and then go directly to step
> 3,
> because our flag is brand new and therefore does not contain EXT4_MAP_MAPPED
> but contains EXT4_GET_BLOCKS_CREATE, thus subtracting
> ei->i_reserved_data_blocks
> for the second time.

Ah, I see. Thanks for explanation. But then the problem is deeper than just
a mismatch in number of reserved delalloc block. The problem really is that
if extent status tree update fails, we have inconsistency between what is
stored in the extent status tree and what is stored on disk. And that can
cause even data corruption issues in some cases.

So I think we rather need to work on handling of errors in extent status
tree operations. In the extent status tree, we have extents which we can
just drop without issues and extents we must not drop - this depends on the
extent's status - currently ext4_es_is_delayed() extents must stay, others
may be dropped but I'd wrap the decision in a helper function.

I'm currently inclined towards the following:

1) Removal must never fail. If we need to split extent, we use GFP_NOFAIL
if we cannot just drop the second part of the split extent in case of
allocation failure.

2) Similarly if inserting extent that cannot be dropped, we use GFP_NOFAIL.

3) We do not try to "undo" failed operations like we currently do - with
the above rules we never loose information that cannot be restored.

And this should also fix the problem you've hit because in case of
allocation failure we may just end up with removed extent from the extent
status tree and thus we refetch info from the disk and find out blocks are
already allocated.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
