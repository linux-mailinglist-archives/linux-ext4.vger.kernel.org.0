Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A63532A1E
	for <lists+linux-ext4@lfdr.de>; Tue, 24 May 2022 14:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237196AbiEXMLs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 May 2022 08:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233396AbiEXMLs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 24 May 2022 08:11:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A1A139805
        for <linux-ext4@vger.kernel.org>; Tue, 24 May 2022 05:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653394305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sEI/Dcu3+QzIxfHlZeMPW7wnTyUUPuRL46h4raxehBI=;
        b=Lur8BeIuI4XLG83JSBiLTSvTrLQEZEiVCCw/+CM/sEolcty7U0+3e8yBs+WkAU37X+27Oe
        9njnxqWKsSAaNl3z3fQ4spoKvER9+f8HM6VO9Q93+cHgdR95mNIyGIUvmYZcvmPao0mtPD
        qeG3Wwqq6hPnqrt2r5Sj9r8DG4agMjo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-646-Zy6FR-paNJqN21ixPH2u8g-1; Tue, 24 May 2022 08:11:44 -0400
X-MC-Unique: Zy6FR-paNJqN21ixPH2u8g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DB9501C3E985;
        Tue, 24 May 2022 12:11:43 +0000 (UTC)
Received: from fedora (unknown [10.40.194.98])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E84401121315;
        Tue, 24 May 2022 12:11:41 +0000 (UTC)
Date:   Tue, 24 May 2022 14:11:39 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     "libaokun (A)" <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yebin10@huawei.com, yukuai3@huawei.com,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH 1/2] ext4: fix bug_on ext4_mb_use_inode_pa
Message-ID: <20220524121139.cm6475vnmkupsp5q@fedora>
References: <20220521134217.312071-1-libaokun1@huawei.com>
 <20220521134217.312071-2-libaokun1@huawei.com>
 <20220523095803.gomx2q62ymocrkrz@fedora>
 <2525e39a-5be9-bae1-b77d-60f583892868@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2525e39a-5be9-bae1-b77d-60f583892868@huawei.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, May 23, 2022 at 08:19:03PM +0800, libaokun (A) wrote:
> 在 2022/5/23 17:58, Lukas Czerner 写道:
> > On Sat, May 21, 2022 at 09:42:16PM +0800, Baokun Li wrote:
> > > Hulk Robot reported a BUG_ON:
> > > ==================================================================
> > > kernel BUG at fs/ext4/mballoc.c:3211!
> > > [...]
> > > RIP: 0010:ext4_mb_mark_diskspace_used.cold+0x85/0x136f
> > > [...]
> > > Call Trace:
> > >   ext4_mb_new_blocks+0x9df/0x5d30
> > >   ext4_ext_map_blocks+0x1803/0x4d80
> > >   ext4_map_blocks+0x3a4/0x1a10
> > >   ext4_writepages+0x126d/0x2c30
> > >   do_writepages+0x7f/0x1b0
> > >   __filemap_fdatawrite_range+0x285/0x3b0
> > >   file_write_and_wait_range+0xb1/0x140
> > >   ext4_sync_file+0x1aa/0xca0
> > >   vfs_fsync_range+0xfb/0x260
> > >   do_fsync+0x48/0xa0
> > > [...]
> > > ==================================================================
> > > 
> > > Above issue may happen as follows:
> > > -------------------------------------
> > > do_fsync
> > >   vfs_fsync_range
> > >    ext4_sync_file
> > >     file_write_and_wait_range
> > >      __filemap_fdatawrite_range
> > >       do_writepages
> > >        ext4_writepages
> > >         mpage_map_and_submit_extent
> > >          mpage_map_one_extent
> > >           ext4_map_blocks
> > >            ext4_mb_new_blocks
> > >             ext4_mb_normalize_request
> > >              >>> start + size <= ac->ac_o_ex.fe_logical
> > >             ext4_mb_regular_allocator
> > >              ext4_mb_simple_scan_group
> > >               ext4_mb_use_best_found
> > >                ext4_mb_new_preallocation
> > >                 ext4_mb_new_inode_pa
> > >                  ext4_mb_use_inode_pa
> > >                   >>> set ac->ac_b_ex.fe_len <= 0
> > >             ext4_mb_mark_diskspace_used
> > >              >>> BUG_ON(ac->ac_b_ex.fe_len <= 0);
> > > 
> > > we can easily reproduce this problem with the following commands:
> > > 	`fallocate -l100M disk`
> > > 	`mkfs.ext4 -b 1024 -g 256 disk`
> > > 	`mount disk /mnt`
> > > 	`fsstress -d /mnt -l 0 -n 1000 -p 1`
> > > 
> > > The size must be smaller than or equal to EXT4_BLOCKS_PER_GROUP.
> > > Therefore, "start + size <= ac->ac_o_ex.fe_logical" may occur
> > > when the size is truncated. So start should be the start position of
> > > the group where ac_o_ex.fe_logical is located after alignment.
> > > In addition, when the value of fe_logical or EXT4_BLOCKS_PER_GROUP
> > > is very large, the value calculated by start_off is more accurate.
> > > 
> > > Fixes: cd648b8a8fd5 ("ext4: trim allocation requests to group size")
> > > Reported-by: Hulk Robot<hulkci@huawei.com>
> > > Signed-off-by: Baokun Li<libaokun1@huawei.com>
> > > ---
> > >   fs/ext4/mballoc.c | 11 +++++++++++
> > >   1 file changed, 11 insertions(+)
> > > 
> > > diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> > > index ea653d19f9ec..32410b79b664 100644
> > > --- a/fs/ext4/mballoc.c
> > > +++ b/fs/ext4/mballoc.c
> > > @@ -4107,6 +4107,17 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
> > >   	size = size >> bsbits;
> > >   	start = start_off >> bsbits;
> > > +	/*
> > > +	 * Because size must be less than or equal to
> > > +	 * EXT4_BLOCKS_PER_GROUP, start should be the start position of
> > > +	 * the group where ac_o_ex.fe_logical is located after alignment.
> > > +	 * In addition, when the value of fe_logical or
> > > +	 * EXT4_BLOCKS_PER_GROUP is very large, the value calculated
> > > +	 * by start_off is more accurate.
> > > +	 */
> > > +	start = max(start, round_down(ac->ac_o_ex.fe_logical,
> > > +			EXT4_BLOCKS_PER_GROUP(ac->ac_sb)));
> > This does not look right. The second argument in round_down() must be a
> > power of two, but there is no such restriction on blocks per group.
> 
> Indeed, block peer group size should be a multiple of 8. I forgot.
> 
> Thank you very much for your correction.
> 
> > Also I am not quite sure why do we adjust the start in this way at all?
> > If we found what seems to be a preallocated extent which we can use and
> > we're actually going to use 0 lenght extent it seems like the problem is
> > somewhere else? Can you desribe the problem a bit more in detail?
> > 
> > Maybe I need to look at the ext4_mb_normalize_request() some more.
> > 
> > -Lukas
> The logical block map reached before the problem stack was 1011.
> 
> The estimated location of the size logical block of the inde plus the
> required allocation length 7, the size is 1018.
> 
> But the i_size of inode is 1299, so the size is 1299, the aligned size is
> 2048, and the end is 2048.
> 
> Because of the restriction of ar -> pleft, start==648.
> 
> EXT4_BLOCKS_PER_GROUP (ac- > ac_sb) is 256, so the size is 256 and the end
> is 904.
> 
> It is not normal to truncate here, the end is less than 1299 of the target
> logical block,
> that is, the allocated range does not contain the target logical block.
> 
> Then this new scope conflicts with the previous PA, as follows:
> 
>           pa_start-506           pa_end-759
>  |____________P________V_________P__________V_____________l________|
>  0                       start-648                   end-904 logical-1299 
> 2048
> 
> In this case, start is changed to pa_end, that is, 759.
> In this case, a bug_ON is reported in ext4_mb_mark_diskspace_used.
> 
> The problem is caused by the truncation introduced in the
> cd648b8a8fd5 ("ext4: trim allocation requests to group size").
> The size must be smaller than or equal to EXT4_BLOCKS_PER_GROUP.
> However, the truncation method is incorrect. The group where the logical is
> located should be used for allocation. If the value of EXT4_BLOCKS_PER_GROUP
> is 256, size 2048 can be divided into eight groups. If the value of logical
> is 1299,
> the value of logical must be in the sixth group, that is,
> start=1299/256*256=5*256=1280, end=size+1280=1536.
> Then, the value range can be further narrowed down based on other
> restrictions.
> 
>                                    1024     1280     1536
> |________|________|________|________|________|__l______|________|________|
> 0 group1 group2 group3 group4 group5 group6 group7 group8 2048

Ok, thanks for the explanation it makes sense now, although should not
we just adjust the start only when the size is being truncated to the
EXT4_BLOCKS_PER_GROUP?

-Lukas

> 
> > > +
> > >   	/* don't cover already allocated blocks in selected range */
> > >   	if (ar->pleft && start <= ar->lleft) {
> > >   		size -= ar->lleft + 1 - start;
> > > -- 
> > > 2.31.1
> > > 
> > .
> 
> -- 
> With Best Regards,
> Baokun Li

