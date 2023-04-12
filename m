Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35346DE974
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Apr 2023 04:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjDLCdY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 11 Apr 2023 22:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDLCdX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 11 Apr 2023 22:33:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C41172B;
        Tue, 11 Apr 2023 19:33:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 257C561C99;
        Wed, 12 Apr 2023 02:33:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F370C433D2;
        Wed, 12 Apr 2023 02:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681266801;
        bh=uWYRkl4H5QxQQyKZRkipfJYb8JT+WBT0+Wf0sQwa8R4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ICEWpWIHfCvZctrTa23zt5ow0V8NDHh2F1i00eVdXSsHwgqMLrkRT/XlEYlKmjHDc
         19nDnI8fLxzFqlz2xC7lWzBe/z+FLZQp9I6XnZMJNnBuVmGr4gIcbNqsErYoKb0m7p
         sxQgr5EWBTLQtP3m6ZbcVg4DVMLneqkbV0LUwwpej+ysbJ8GM6GOmxaIXmht+TVLM5
         8AoJUx4LJxeAkTKLmK+QxNTrCOzWSGGlTQai0S4osbYt1lIObyZ+GefEjAWZe5ts/v
         1DVrYg2TcXMS5rnXRentQX9hoIWFgOeiZNMnlongYGP1HyqIKramwdoHwdF+582obz
         FYYaJGFJaqEvg==
Date:   Tue, 11 Apr 2023 19:33:19 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Andrey Albershteyn <aalbersh@redhat.com>, djwong@kernel.org,
        dchinner@redhat.com, linux-xfs@vger.kernel.org,
        fsverity@lists.linux.dev, rpeterso@redhat.com, agruenba@redhat.com,
        xiang@kernel.org, chao@kernel.org,
        damien.lemoal@opensource.wdc.com, jth@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com
Subject: Re: [PATCH v2 00/23] fs-verity support for XFS
Message-ID: <20230412023319.GA5105@sol.localdomain>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <ZDTt8jSdG72/UnXi@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDTt8jSdG72/UnXi@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Apr 10, 2023 at 10:19:46PM -0700, Christoph Hellwig wrote:
> Dave is going to hate me for this, but..
> 
> I've been looking over some of the interfaces here, and I'm starting
> to very seriously questioning the design decisions of storing the
> fsverity hashes in xattrs.
> 
> Yes, storing them beyond i_size in the file is a bit of a hack, but
> it allows to reuse a lot of the existing infrastructure, and much
> of fsverity is based around it.  So storing them in an xattrs causes
> a lot of churn in the interface.  And the XFS side with special
> casing xattr indices also seems not exactly nice.

It seems it's really just the Merkle tree caching interface that is causing
problems, as it's currently too closely tied to the page cache?  That is just an
implementation detail that could be reworked along the lines of what is being
discussed.

But anyway, it is up to the XFS folks.  Keep in mind there is also the option of
doing what btrfs is doing, where it stores the Merkle tree separately from the
file data stream, but caches it past i_size in the page cache at runtime.

I guess there is also the issue of encryption, which hasn't come up yet since
we're talking about fsverity support only.  The Merkle tree (including the
fsverity_descriptor) is supposed to be encrypted, just like the file contents
are.  Having it be stored after the file contents accomplishes that easily...
Of course, it doesn't have to be that way; a separate key could be derived, or
the Merkle tree blocks could be encrypted with the file contents key using
indices past i_size, without them physically being stored in the data stream.

- Eric
