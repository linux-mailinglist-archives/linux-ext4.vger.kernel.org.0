Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A46728A3B
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Jun 2023 23:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237040AbjFHVZk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Jun 2023 17:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236177AbjFHVZg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Jun 2023 17:25:36 -0400
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2712D7B
        for <linux-ext4@vger.kernel.org>; Thu,  8 Jun 2023 14:24:50 -0700 (PDT)
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-75d57fdb014so98324685a.0
        for <linux-ext4@vger.kernel.org>; Thu, 08 Jun 2023 14:24:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686259489; x=1688851489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=liAgCM+QUjk8WKzG6uC2H2ST/koBGGcMOvClrIQqatc=;
        b=XmCdSnB/jdcuKE5YX2jDFrwP60k35iUVre49vskJ3o17ELZmbaKxozkIYo5MFv10hB
         XmsrCuLvnIXkJIOJldwjKI10inMb9jycPcO49+ZJ6E7JgA3y+V/qVEpTm9xbXpflddh2
         9cYFaKc/WmIANv3RSSY+HGJxM4iu0sdqWhNayufOGNF4ggBs5uMnMveKaaWtGuC/CEsj
         PPXicrFxiQhWZMb3obLTbhwO+eK6ybnyfcj/1HVmpgwKUjZk7of0+pG29MKZKLU5eDNF
         QR+VKpQ0Nl/Im2AK37Y3Htx2DNygzZ1fg9rth9/cERfNtYzrheC86/zweezkt8nsfS80
         X5Og==
X-Gm-Message-State: AC+VfDz89yBaXsGr6CpkxQlaa7ZQWPNIc94zOkXzrvNtUpVTprvn11x2
        cYO03Zmw2NVO2vLhF+s7zX+M
X-Google-Smtp-Source: ACHHUZ5cTCLmtiiH2aSe8aPBdiBk6FrasapLcCm72SE2cqNOiC9OqxtNKW6L219nYmdc4g2nkFpg4Q==
X-Received: by 2002:a05:6214:c88:b0:628:c4c8:4afb with SMTP id r8-20020a0562140c8800b00628c4c84afbmr3203617qvr.60.1686259489142;
        Thu, 08 Jun 2023 14:24:49 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id g16-20020ac84690000000b003f8e6071e43sm669752qto.3.2023.06.08.14.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 14:24:48 -0700 (PDT)
Date:   Thu, 8 Jun 2023 17:24:47 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>,
        Joe Thornber <ejt@redhat.com>,
        Brian Foster <bfoster@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Theodore Ts'o <tytso@mit.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        Bart Van Assche <bvanassche@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH v7 4/5] dm-thin: Add REQ_OP_PROVISION support
Message-ID: <ZIJHH+ekx59+6Uu0@redhat.com>
References: <20230518223326.18744-1-sarthakkukreti@chromium.org>
 <20230518223326.18744-5-sarthakkukreti@chromium.org>
 <ZGeUYESOQsZkOQ1Q@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGeUYESOQsZkOQ1Q@redhat.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, May 19 2023 at 11:23P -0400,
Mike Snitzer <snitzer@kernel.org> wrote:

> On Thu, May 18 2023 at  6:33P -0400,
> Sarthak Kukreti <sarthakkukreti@chromium.org> wrote:
> 
> > dm-thinpool uses the provision request to provision
> > blocks for a dm-thin device. dm-thinpool currently does not
> > pass through REQ_OP_PROVISION to underlying devices.
> > 
> > For shared blocks, provision requests will break sharing and copy the
> > contents of the entire block. Additionally, if 'skip_block_zeroing'
> > is not set, dm-thin will opt to zero out the entire range as a part
> > of provisioning.
> > 
> > Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> > ---
> >  drivers/md/dm-thin.c | 74 +++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 70 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
> > index 2b13c949bd72..f1b68b558cf0 100644
> > --- a/drivers/md/dm-thin.c
> > +++ b/drivers/md/dm-thin.c
> > @@ -1245,8 +1247,8 @@ static int io_overlaps_block(struct pool *pool, struct bio *bio)
> >  
> >  static int io_overwrites_block(struct pool *pool, struct bio *bio)
> >  {
> > -	return (bio_data_dir(bio) == WRITE) &&
> > -		io_overlaps_block(pool, bio);
> > +	return (bio_data_dir(bio) == WRITE) && io_overlaps_block(pool, bio) &&
> > +	       bio_op(bio) != REQ_OP_PROVISION;
> >  }
> >  
> >  static void save_and_set_endio(struct bio *bio, bio_end_io_t **save,
> > @@ -1394,6 +1396,9 @@ static void schedule_zero(struct thin_c *tc, dm_block_t virt_block,
> >  	m->data_block = data_block;
> >  	m->cell = cell;
> >  
> > +	if (bio && bio_op(bio) == REQ_OP_PROVISION)
> > +		m->bio = bio;
> > +
> >  	/*
> >  	 * If the whole block of data is being overwritten or we are not
> >  	 * zeroing pre-existing data, we can issue the bio immediately.
> 
> This doesn't seem like the best way to address avoiding passdown of
> provision bios (relying on process_prepared_mapping's implementation
> that happens to do the right thing if m->bio set).  Doing so cascades
> into relying on complete_overwrite_bio() happening to _not_ actually
> being specific to "overwrite" bios.
> 
> I don't have a better suggestion yet but will look closer.  Just think
> this needs to be formalized a bit more rather than it happening to
> "just work".
> 
> Cc'ing Joe to see what he thinks too.  This is something we can clean
> up with a follow-on patch though, so not a show-stopper for this
> series.

I haven't circled back to look close enough at this but
REQ_OP_PROVISION bios _are_ being passed down to the thin-pool's
underlying data device.

Brian Foster reported that if he issues a REQ_OP_PROVISION to a thin
device after a snapshot (to break sharing), it'll fail with
-EOPNOTSUPP (response is from bio being passed down to device that
doesn't support it).  I was able to reproduce with:

# fallocate --offset 0 --length 1048576 /dev/test/thin
# lvcreate -n snap --snapshot test/thin

# fallocate --offset 0 --length 1048576 /dev/test/thin
fallocate: fallocate failed: Operation not supported

But reports success when retried:
# fallocate --offset 0 --length 1048576 /dev/test/thin
# echo $?
0

It's somewhat moot in that Joe will be reimplementing handling for
REQ_OP_PROVISION _but_ in the meantime it'd be nice to have a version
of this patch that doesn't error (due to passdown of REQ_OP_PROVISION)
when breaking sharing.  Primarily so the XFS guys (Dave and Brian) can
make progress.

I'll take a closer look tomorrow but figured I'd let you know.

Mike
