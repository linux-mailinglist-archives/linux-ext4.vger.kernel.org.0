Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC86E4E2B82
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Mar 2022 16:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243062AbiCUPNK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Mar 2022 11:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243001AbiCUPNK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Mar 2022 11:13:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBFCB822A;
        Mon, 21 Mar 2022 08:11:43 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9CA80210E1;
        Mon, 21 Mar 2022 15:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647875502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LkW4wXj2ty20qEJvZliQRtT+baj4+xrdl7A+ViUcLuY=;
        b=t/u/K+C4pD8fCdpZkbOFGh3vz88F5c01nnykiLuIFxD3IUyi8R2DdRxWJ0B46HzOpC+lSu
        uRhz20argEckFwWSdcQnoW1LYoptclGP47zlfQfOeE3a4lE9qJyyfdAvwVLSUkDYXWfaM+
        T6KCNUlyphWCYaXJkqp0wdj7nbCxNBw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647875502;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LkW4wXj2ty20qEJvZliQRtT+baj4+xrdl7A+ViUcLuY=;
        b=RxXryV3JuGa0xiph/PZD2jB0q3PivW1bBg3ve7qmpJ8wvmJs5sQlsW0PNj3oGITdWgz3H0
        zYHGHeyfHM/2mXCg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 37253A3B83;
        Mon, 21 Mar 2022 15:11:42 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 4684CA0610; Mon, 21 Mar 2022 16:11:41 +0100 (CET)
Date:   Mon, 21 Mar 2022 16:11:41 +0100
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, Ye Bin <yebin10@huawei.com>,
        tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        lczerner@redhat.com
Subject: Re: [PATCH -next] ext4: Fix symlink file size not match to file
 content
Message-ID: <20220321151141.hypnhr6o4vng2sa6@quack3.lan>
References: <20220321113408.4112428-1-yebin10@huawei.com>
 <20220321113703.cibgeac5ipslg3df@quack3.lan>
 <5b3e0bb7-370b-a950-1d2f-b0e31357cc01@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b3e0bb7-370b-a950-1d2f-b0e31357cc01@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Yi!

On Mon 21-03-22 22:38:49, Zhang Yi wrote:
> On 2022/3/21 19:37, Jan Kara wrote:
> > On Mon 21-03-22 19:34:08, Ye Bin wrote:
> >> We got issue as follows:
> >> [home]# fsck.ext4  -fn  ram0yb
> >> e2fsck 1.45.6 (20-Mar-2020)
> >> Pass 1: Checking inodes, blocks, and sizes
> >> Pass 2: Checking directory structure
> >> Symlink /p3/d14/d1a/l3d (inode #3494) is invalid.
> >> Clear? no
> >> Entry 'l3d' in /p3/d14/d1a (3383) has an incorrect filetype (was 7, should be 0).
> >> Fix? no
> >>
> >> As symlink file size not match to file content. If symlink data block
> >> writback failed, will call ext4_finish_bio to end io. In this path don't
> >> mark buffer error. When umount do checkpoint can't detect buffer error,
> >> then will cleanup jounral. Actually, correct data maybe in journal area.
> >> To solve this issue, mark buffer error when detect bio error in
> >> ext4_finish_bio.
> > 
> > Thanks for the patch! Let me rephrase the text a bit:
> > 
> > As the symlink file size does not match the file content. If the writeback
> > of the symlink data block failed, ext4_finish_bio() handles the end of IO.
> > However this function fails to mark the buffer with BH_write_io_error and
> > so when unmount does journal checkpoint it cannot detect the writeback
> > error and will cleanup the journal. Thus we've lost the correct data in the
> > journal area. To solve this issue, mark the buffer as BH_write_io_error in
> > ext4_finish_bio().
> > 
> 
> Thinking about this issue in depth, the symlink data block is one kind of
> metadata, but the page mapping of such block is belongs to the ext4 inode,
> it's not coordinate to other metadata blocks, e.g. directory block and extents
> block. This is why we have already fix the same issue of other metadata blocks
> in commit fcf37549ae19e9 "jbd2: ensure abort the journal if detect IO error
> when writing original buffer back" but missing the case of symlink data block.
> So, after Ye Bin's fix, I think it's worth to unify the symlink data block
> mapping to bdev, any suggestions?

Well, symlink with external block is essentially a case of data=journal
data block. So even if we would handle symlinks, we would still need to
deal with other inodes with journalled data. Also we need to keep the
symlink contents in the page cache to make it simple for generic VFS code
handling symlinks. So I don't see how we could substantially unify
things...

								Honza


-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
