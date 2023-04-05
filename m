Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF1F6D85C6
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Apr 2023 20:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjDESQE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Apr 2023 14:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDESQD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Apr 2023 14:16:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0432F659B;
        Wed,  5 Apr 2023 11:16:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52AA963D92;
        Wed,  5 Apr 2023 18:16:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 710CAC433EF;
        Wed,  5 Apr 2023 18:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680718561;
        bh=wiJeaBlTTUnHN5dRjU986tMd+hpSmAJjFn5myvsg4zA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=REOOWtLgQ9JDh9SSF6xoyg94oSouuHFnpL2v3YnQ3T2oBYSI6IMS8Hy8imtRKtDy1
         cU3K/Iy3e/I3Q2+TSdKRafqsRNXapecZukPc1WANLn9sTP01Li50nyZ7qlCS5TCVJ+
         3cW7AZM1K/82Q6rN89XufLRWJRxkvNpgVxn/rDB2tRQwEAn32VY0qtyYqIT5Mhljtf
         O5whuuDDjSKbQwdJKsF8Nl8Wr8dqY9vgtd1lUYNpjci7tFUD9wHH4/61yvdWJlTH+K
         DtIew2Dd7HkelryBLbZ5MioiFh7yAV2qMaWKrH/687VXslb1Q2GI4zSjEhOMaWMwe0
         NDlFE8RqYVveQ==
Date:   Wed, 5 Apr 2023 18:16:00 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Andrey Albershteyn <aalbersh@redhat.com>, dchinner@redhat.com,
        hch@infradead.org, linux-xfs@vger.kernel.org,
        fsverity@lists.linux.dev, rpeterso@redhat.com, agruenba@redhat.com,
        xiang@kernel.org, chao@kernel.org,
        damien.lemoal@opensource.wdc.com, jth@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com
Subject: Re: [PATCH v2 21/23] xfs: handle merkle tree block size != fs
 blocksize != PAGE_SIZE
Message-ID: <ZC264FSkDQidOQ4N@gmail.com>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <20230404145319.2057051-22-aalbersh@redhat.com>
 <20230404163602.GC109974@frogsfrogsfrogs>
 <20230405160221.he76fb5b45dud6du@aalbersh.remote.csb>
 <20230405163847.GG303486@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405163847.GG303486@frogsfrogsfrogs>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Apr 05, 2023 at 09:38:47AM -0700, Darrick J. Wong wrote:
> > The merkle tree pages are dropped after verification. When page is
> > dropped xfs_buf is marked as verified. If fs-verity wants to
> > verify again it will get the same verified buffer. If buffer is
> > evicted it won't have verified state.
> > 
> > So, with enough memory pressure buffers will be dropped and need to
> > be reverified.
> 
> Please excuse me if this was discussed and rejected long ago, but
> perhaps fsverity should try to hang on to the merkle tree pages that
> this function returns for as long as possible until reclaim comes for
> them?
> 
> With the merkle tree page lifetimes extended, you then don't need to
> attach the xfs_buf to page->private, nor does xfs have to extend the
> buffer cache to stash XBF_VERITY_CHECKED.

Well, all the other filesystems that support fsverity (ext4, f2fs, and btrfs)
just cache the Merkle tree pages in the inode's page cache.  It's an approach
that I know some people aren't a fan of, but it's efficient and it works.

We could certainly think about moving to a design where fs/verity/ asks the
filesystem to just *read* a Merkle tree block, without adding it to a cache, and
then fs/verity/ implements the caching itself.  That would require some large
changes to each filesystem, though, unless we were to double-cache the Merkle
tree blocks which would be inefficient.

So it feels like continuing to have the filesystem (not fs/verity/) be
responsible for the cache is the best way to allow XFS to do things a bit
differently, without regressing the other filesystems.

I'm interested in hearing any other proposals, though.

- Eric
