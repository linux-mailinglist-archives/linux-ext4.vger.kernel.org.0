Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4EE6D8591
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Apr 2023 20:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbjDESDt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Apr 2023 14:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjDESDr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Apr 2023 14:03:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773E96584;
        Wed,  5 Apr 2023 11:03:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74A8D62A89;
        Wed,  5 Apr 2023 18:02:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96EE1C433D2;
        Wed,  5 Apr 2023 18:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680717768;
        bh=3aMW3YLQCtQtlrkIbSPGZmnQ0yHQUxiJ9ttklW4hHxM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bDpmWKsJVZ3ckZA2xplbSRbcINv1TpMxisrITW5MrlmHOMQ3fien87NPN4a9AJA/B
         x/QThFLx1SwGIWFo7Yx4Ag15CHnoj5bQhPU74Lr9NnQzQAppm4KDtyjgnjuKzJLhfa
         7HyOovstmSkofw3kQLFfw9x5/h+8yFRSKEbXd3TFBt1w7lWOvtRr56+nYgTgBGNR50
         Ljh42NAKmGC04mDXzBLfWEnfodDd6BPXzXQouL4wP0Gh16p95effEXjNlRYp8rj8tc
         QM6XfbnPOu9Rc95DaJV9yZ5Z6e/fRetGpCm+o4wsNTx7fpv6ZZEpQM7h1h3nHBzDie
         nZaAvfwaMjd3A==
Date:   Wed, 5 Apr 2023 18:02:47 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Andrey Albershteyn <aalbersh@redhat.com>, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
        rpeterso@redhat.com, agruenba@redhat.com, xiang@kernel.org,
        chao@kernel.org, damien.lemoal@opensource.wdc.com, jth@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com
Subject: Re: [PATCH v2 19/23] xfs: disable direct read path for fs-verity
 sealed files
Message-ID: <ZC23x22bxItnsANI@gmail.com>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <20230404145319.2057051-20-aalbersh@redhat.com>
 <20230404161047.GA109974@frogsfrogsfrogs>
 <20230405150142.3jmxzo5i27bbc4c4@aalbersh.remote.csb>
 <20230405150927.GD303486@frogsfrogsfrogs>
 <ZC2YsgYRsvBejGYY@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZC2YsgYRsvBejGYY@infradead.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Apr 05, 2023 at 08:50:10AM -0700, Christoph Hellwig wrote:
> On Wed, Apr 05, 2023 at 08:09:27AM -0700, Darrick J. Wong wrote:
> > Thinking about this a little more -- I suppose we shouldn't just go
> > breaking directio reads from a verity file if we can help it.  Is there
> > a way to ask fsverity to perform its validation against some arbitrary
> > memory buffer that happens to be fs-block aligned?

You could certainly add such a function that wraps around verify_data_block().
The minimal function prototype needed (without supporting readahead or reusing
the ahash_request) would be something like the following, I think:

    bool fsverity_verify_blocks_dio(struct inode *inode, u64 pos,
                                    struct folio *folio,
                                    size_t len, size_t offset);

And I really hope that you don't want to do DIO to the *Merkle tree*, as that
would make the problem significantly harder.  I think DIO for the data, but
handling the Merkle tree in the usual way, would be okay?

> 
> That would be my preference as well.  But maybe Eric know a good reason
> why this hasn't been done yet.
> 

I believe it would be possible, especially if DIO to the Merkle tree is not in
scope.  There just hasn't been a reason to the work yet.  And ext4 and f2fs
already fall back to buffer I/O for other filesystem features, so there was
precedent for not bothering with DIO, at least in the initial version.

- Eric
