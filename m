Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B96E64D823
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Dec 2022 10:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiLOJAd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Dec 2022 04:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLOJAb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Dec 2022 04:00:31 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484722DAA7
        for <linux-ext4@vger.kernel.org>; Thu, 15 Dec 2022 01:00:30 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EB2E120E89;
        Thu, 15 Dec 2022 09:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671094828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+t2v6USOzKg1UzS2CKL5vREEZklFSfnzqGQwj2bc4X0=;
        b=xs/KIIvfC4yNr8jmlNnXoaSXxpm2Z5svxLEV4BFTid9y98zafESPMG+QMCITow4xpQEa5a
        X6usMZ58iRPRP+VHT4MGqlE55h2tvq57fo/BmFxBefeQooOI7Z+kkcuzpa9yVKmMXtdxBR
        QwdAFm6JE/D2V5Pjikkyikznx4e8+aY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671094828;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+t2v6USOzKg1UzS2CKL5vREEZklFSfnzqGQwj2bc4X0=;
        b=1k7gSHfdxNYziOcJ1+Yq8nVvQvyicxAE17W8REghPdbU+2b0X+RFCagujnfnUJsdpzB3pt
        45pS5RNrqHDjfkCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A68BF13434;
        Thu, 15 Dec 2022 09:00:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id StucKCzimmOXIAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 15 Dec 2022 09:00:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 65B4EA0727; Thu, 15 Dec 2022 10:00:26 +0100 (CET)
Date:   Thu, 15 Dec 2022 10:00:26 +0100
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huaweicloud.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, yukuai3@huawei.com
Subject: Re: [RFC PATCH] ext4: dio take shared inode lock when overwriting
 preallocated blocks
Message-ID: <20221215090026.scnl7nx5klkjgsld@quack3>
References: <20221203103956.3691847-1-yi.zhang@huawei.com>
 <20221214170125.bixz46ybm76rtbzf@quack3>
 <1df360ba-35f4-18e1-5544-acb18a680a90@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1df360ba-35f4-18e1-5544-acb18a680a90@huaweicloud.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 15-12-22 16:24:49, Zhang Yi wrote:
> On 2022/12/15 1:01, Jan Kara wrote:
> > On Sat 03-12-22 18:39:56, Zhang Yi wrote:
> >> In the dio write path, we only take shared inode lock for the case of
> >> aligned overwriting initialized blocks inside EOF. But for overwriting
> >> preallocated blocks, it may only need to split unwritten extents, this
> >> procedure has been protected under i_data_sem lock, it's safe to
> >> release the exclusive inode lock and take shared inode lock.
> >>
> >> This could give a significant speed up for multi-threaded writes. Test
> >> on Intel Xeon Gold 6140 and nvme SSD with below fio parameters.
> >>
> >>  direct=1
> >>  ioengine=libaio
> >>  iodepth=10
> >>  numjobs=10
> >>  runtime=60
> >>  rw=randwrite
> >>  size=100G
> >>
> >> And the test result are:
> >> Before:
> >>  bs=4k       IOPS=11.1k, BW=43.2MiB/s
> >>  bs=16k      IOPS=11.1k, BW=173MiB/s
> >>  bs=64k      IOPS=11.2k, BW=697MiB/s
> >>
> >> After:
> >>  bs=4k       IOPS=41.4k, BW=162MiB/s
> >>  bs=16k      IOPS=41.3k, BW=646MiB/s
> >>  bs=64k      IOPS=13.5k, BW=843MiB/s
> >>
> >> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> >> ---
> >>  It passed xfstests auto mode with 1k and 4k blocksize.
> > 
> > Besides some naming nits (see below) I think this should work. But I have
> > to say I'm a bit uneasy about this because we will now be changing block
> > mapping from unwritten to written only with shared i_rwsem. OTOH that
> > happens during writeback as well so we should be fine and the gain is very
> > nice.
> > 
> Thanks for advice, I will change the argument name to make it more reasonable.
> 
> > Out of curiosity do you have a real usecase for this?
> 
> No, I was just analyse the performance gap in our benchmark tests, and have
> some question and idea while reading the code. Maybe it could speed up the
> first time write in some database. :)
> 
> Besides, I want to discuss it a bit more. I originally changed this code to
> switch to take the shared inode and also use ext4_iomap_overwrite_ops for
> the overwriting preallocated blocks case. It will postpone the splitting extent
> procedure to endio and could give a much more gain than this patch (+~27%).
> 
> This patch:
>   bs=4k       IOPS=41.4k, BW=162MiB/s
> Postpone split:
>   bs=4k       IOPS=52.9k, BW=207MiB/s
> 
> But I think it's maybe too radical. I looked at the history and notice in
> commit 0031462b5b39 ("ext4: Split uninitialized extents for direct I/O"),
> it introduce the flag EXT4_GET_BLOCKS_DIO(now it had been renamed to
> EXT4_GET_BLOCKS_PRE_IO) to make sure that the preallocated unwritten
> extent have been splitted before submitting the I/O, which is used to
> prevent the ENOSPC problem if the filesystem run out-of-space in the
> endio procedure. And 4 years later, commit 27dd43854227 ("ext4: introduce
> reserved space") reserve some blocks for metedata allocation.  It looks
> like this commit could also slove the ENOSPC problem for most cases if we
> postpone extent splitting into the endio procedure. I don't find other
> side effect, so I think it may also fine if we do that. Do you have some
> advice or am I missing something?

So you are right these days splitting of extents could be done only on IO
completion because we have a pool of blocks reserved for these cases. OTOH
this will make the pressure on the reserved pool higher and if we are
running out of space and there are enough operations running in parallel we
*could* run out of reserved blocks. So I wouldn't always defer extent
splitting to IO completion unless we have a practical and sufficiently
widespread usecase that would benefit from this optimization.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
