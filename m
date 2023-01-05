Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3194665EF03
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Jan 2023 15:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbjAEOnI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Jan 2023 09:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbjAEOnH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Jan 2023 09:43:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F07BF01
        for <linux-ext4@vger.kernel.org>; Thu,  5 Jan 2023 06:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672929743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wjyslnCj3ZEltR7C79+zwgm2T1VJBZSXYdTg0fe8CHE=;
        b=MBxpAt86ENjL9LWeLvCWEiqL7mlE2xwN4vsLxIy7w4cSZ1G6QPwlCoQzMvIFraSJ0I2toi
        GHHGHTzecjUbr+2t7dMoKdlluUpkFXBSlc31IFYiYJgpw61fm3MdP8U01qHTK4ruGV3NL3
        z38jLdmzgseV7JNHd613ZRAlVwq2wh8=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-263-kVRHRkA5Nc-1Zp37YVMu9w-1; Thu, 05 Jan 2023 09:42:16 -0500
X-MC-Unique: kVRHRkA5Nc-1Zp37YVMu9w-1
Received: by mail-yb1-f197.google.com with SMTP id z17-20020a25e311000000b00719e04e59e1so37255837ybd.10
        for <linux-ext4@vger.kernel.org>; Thu, 05 Jan 2023 06:42:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjyslnCj3ZEltR7C79+zwgm2T1VJBZSXYdTg0fe8CHE=;
        b=b+Lc0Qrp93Y7+23Qq5BKkmCGDAM9EPhdzMX0IorpfkepwOZUU2Bz5imIgqWWZnWNtM
         qX0K3qB1iA7QZaEHyEKtJZUl/2rtoPt5vE71MhKTnbxtIif14YEG3rJeDOwDuIvi8Cfq
         oUJY0RRq4DJuYAJ4hcTMF2ksKt4VhJIqfPLbdVqiDG3QsE0/aJH8/RTp8sJvX8V1/Ftg
         jtyl7XRLRxlLhZKFOBmnjtZxEumeLUtm/gGaohojYU6kdHaZmPdUPIExtAEWevbjawuQ
         eJvrgQYGMeGMGiOmkJf0H2MM7oT5uy43RrnRzfXb0mn2q7Ex6maU6Ugry8XJxEYAa2nE
         NzPw==
X-Gm-Message-State: AFqh2kqJFXsGHlqd9AGQ8lzUkvc54HGP7NTP1LNlFtYQoYb+gFB1doCl
        2X5Rk1BL5kh7ggodfct1H1oJMJXzTaRNOROJFSIaF7goM4dVg6sqZV330PQEWkB7vYDmm9aDWEP
        vqxCC3/TFWJV++HsqWEhaAw==
X-Received: by 2002:a05:690c:d84:b0:4b5:c61:1c02 with SMTP id da4-20020a05690c0d8400b004b50c611c02mr9863321ywb.22.1672929736358;
        Thu, 05 Jan 2023 06:42:16 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtgZGayMfn5T2A3YgNPQf9Hcxwo0jOEuaE/UPyg5j2hL0RrzHck6nvnDV5RBSK1tNEA18Dwmw==
X-Received: by 2002:a05:690c:d84:b0:4b5:c61:1c02 with SMTP id da4-20020a05690c0d8400b004b50c611c02mr9863296ywb.22.1672929736089;
        Thu, 05 Jan 2023 06:42:16 -0800 (PST)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id ay34-20020a05620a17a200b006b929a56a2bsm25634809qkb.3.2023.01.05.06.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 06:42:15 -0800 (PST)
Date:   Thu, 5 Jan 2023 09:43:13 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>
Cc:     sarthakkukreti@google.com, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        Daniil Lunev <dlunev@google.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH v2 2/7] dm: Add support for block provisioning
Message-ID: <Y7biAQyLKJDjsAlz@bfoster>
References: <20221229081252.452240-1-sarthakkukreti@chromium.org>
 <20221229081252.452240-3-sarthakkukreti@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221229081252.452240-3-sarthakkukreti@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Dec 29, 2022 at 12:12:47AM -0800, Sarthak Kukreti wrote:
> Add support to dm devices for REQ_OP_PROVISION. The default mode
> is to pass through the request and dm-thin will utilize it to provision
> blocks.
> 
> Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> ---
>  drivers/md/dm-crypt.c         |  4 +-
>  drivers/md/dm-linear.c        |  1 +
>  drivers/md/dm-snap.c          |  7 +++
>  drivers/md/dm-table.c         | 25 ++++++++++
>  drivers/md/dm-thin.c          | 90 ++++++++++++++++++++++++++++++++++-
>  drivers/md/dm.c               |  4 ++
>  include/linux/device-mapper.h | 11 +++++
>  7 files changed, 139 insertions(+), 3 deletions(-)
> 
...
> diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
> index 64cfcf46881d..ab3f1abfabaf 100644
> --- a/drivers/md/dm-thin.c
> +++ b/drivers/md/dm-thin.c
...
> @@ -1980,6 +1992,70 @@ static void process_cell(struct thin_c *tc, struct dm_bio_prison_cell *cell)
>  	}
>  }
>  
> +static void process_provision_cell(struct thin_c *tc, struct dm_bio_prison_cell *cell)
> +{
> +	int r;
> +	struct pool *pool = tc->pool;
> +	struct bio *bio = cell->holder;
> +	dm_block_t begin, end;
> +	struct dm_thin_lookup_result lookup_result;
> +
> +	if (tc->requeue_mode) {
> +		cell_requeue(pool, cell);
> +		return;
> +	}
> +
> +	get_bio_block_range(tc, bio, &begin, &end);
> +
> +	while (begin != end) {
> +		r = ensure_next_mapping(pool);
> +		if (r)
> +			/* we did our best */
> +			return;
> +
> +		r = dm_thin_find_block(tc->td, begin, 1, &lookup_result);

Hi Sarthak,

I think we discussed this before.. but remind me if/how we wanted to
handle the case if the thin blocks are shared..? Would a provision op
carry enough information to distinguish an FALLOC_FL_UNSHARE_RANGE
request from upper layers to conditionally provision in that case?

Brian

> +		switch (r) {
> +		case 0:
> +			begin++;
> +			break;
> +		case -ENODATA:
> +			bio_inc_remaining(bio);
> +			provision_block(tc, bio, begin, cell);
> +			begin++;
> +			break;
> +		default:
> +			DMERR_LIMIT(
> +				"%s: dm_thin_find_block() failed: error = %d",
> +				__func__, r);
> +			cell_defer_no_holder(tc, cell);
> +			bio_io_error(bio);
> +			begin++;
> +			break;
> +		}
> +	}
> +	bio_endio(bio);
> +	cell_defer_no_holder(tc, cell);
> +}
> +
> +static void process_provision_bio(struct thin_c *tc, struct bio *bio)
> +{
> +	dm_block_t begin, end;
> +	struct dm_cell_key virt_key;
> +	struct dm_bio_prison_cell *virt_cell;
> +
> +	get_bio_block_range(tc, bio, &begin, &end);
> +	if (begin == end) {
> +		bio_endio(bio);
> +		return;
> +	}
> +
> +	build_key(tc->td, VIRTUAL, begin, end, &virt_key);
> +	if (bio_detain(tc->pool, &virt_key, bio, &virt_cell))
> +		return;
> +
> +	process_provision_cell(tc, virt_cell);
> +}
> +
>  static void process_bio(struct thin_c *tc, struct bio *bio)
>  {
>  	struct pool *pool = tc->pool;
> @@ -2200,6 +2276,8 @@ static void process_thin_deferred_bios(struct thin_c *tc)
>  
>  		if (bio_op(bio) == REQ_OP_DISCARD)
>  			pool->process_discard(tc, bio);
> +		else if (bio_op(bio) == REQ_OP_PROVISION)
> +			process_provision_bio(tc, bio);
>  		else
>  			pool->process_bio(tc, bio);
>  
> @@ -2716,7 +2794,8 @@ static int thin_bio_map(struct dm_target *ti, struct bio *bio)
>  		return DM_MAPIO_SUBMITTED;
>  	}
>  
> -	if (op_is_flush(bio->bi_opf) || bio_op(bio) == REQ_OP_DISCARD) {
> +	if (op_is_flush(bio->bi_opf) || bio_op(bio) == REQ_OP_DISCARD ||
> +	    bio_op(bio) == REQ_OP_PROVISION) {
>  		thin_defer_bio_with_throttle(tc, bio);
>  		return DM_MAPIO_SUBMITTED;
>  	}
> @@ -3355,6 +3434,8 @@ static int pool_ctr(struct dm_target *ti, unsigned argc, char **argv)
>  	pt->low_water_blocks = low_water_blocks;
>  	pt->adjusted_pf = pt->requested_pf = pf;
>  	ti->num_flush_bios = 1;
> +	ti->num_provision_bios = 1;
> +	ti->provision_supported = true;
>  
>  	/*
>  	 * Only need to enable discards if the pool should pass
> @@ -4053,6 +4134,7 @@ static void pool_io_hints(struct dm_target *ti, struct queue_limits *limits)
>  		blk_limits_io_opt(limits, pool->sectors_per_block << SECTOR_SHIFT);
>  	}
>  
> +
>  	/*
>  	 * pt->adjusted_pf is a staging area for the actual features to use.
>  	 * They get transferred to the live pool in bind_control_target()
> @@ -4243,6 +4325,9 @@ static int thin_ctr(struct dm_target *ti, unsigned argc, char **argv)
>  		ti->num_discard_bios = 1;
>  	}
>  
> +	ti->num_provision_bios = 1;
> +	ti->provision_supported = true;
> +
>  	mutex_unlock(&dm_thin_pool_table.mutex);
>  
>  	spin_lock_irq(&tc->pool->lock);
> @@ -4457,6 +4542,7 @@ static void thin_io_hints(struct dm_target *ti, struct queue_limits *limits)
>  
>  	limits->discard_granularity = pool->sectors_per_block << SECTOR_SHIFT;
>  	limits->max_discard_sectors = 2048 * 1024 * 16; /* 16G */
> +	limits->max_provision_sectors = 2048 * 1024 * 16; /* 16G */
>  }
>  
>  static struct target_type thin_target = {
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index e1ea3a7bd9d9..4d19bae9da4a 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1587,6 +1587,7 @@ static bool is_abnormal_io(struct bio *bio)
>  		case REQ_OP_DISCARD:
>  		case REQ_OP_SECURE_ERASE:
>  		case REQ_OP_WRITE_ZEROES:
> +		case REQ_OP_PROVISION:
>  			return true;
>  		default:
>  			break;
> @@ -1611,6 +1612,9 @@ static blk_status_t __process_abnormal_io(struct clone_info *ci,
>  	case REQ_OP_WRITE_ZEROES:
>  		num_bios = ti->num_write_zeroes_bios;
>  		break;
> +	case REQ_OP_PROVISION:
> +		num_bios = ti->num_provision_bios;
> +		break;
>  	default:
>  		break;
>  	}
> diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
> index 04c6acf7faaa..b4d97d5d75b8 100644
> --- a/include/linux/device-mapper.h
> +++ b/include/linux/device-mapper.h
> @@ -333,6 +333,12 @@ struct dm_target {
>  	 */
>  	unsigned num_write_zeroes_bios;
>  
> +	/*
> +	 * The number of PROVISION bios that will be submitted to the target.
> +	 * The bio number can be accessed with dm_bio_get_target_bio_nr.
> +	 */
> +	unsigned num_provision_bios;
> +
>  	/*
>  	 * The minimum number of extra bytes allocated in each io for the
>  	 * target to use.
> @@ -357,6 +363,11 @@ struct dm_target {
>  	 */
>  	bool discards_supported:1;
>  
> +	/* Set if this target needs to receive provision requests regardless of
> +	 * whether or not its underlying devices have support.
> +	 */
> +	bool provision_supported:1;
> +
>  	/*
>  	 * Set if we need to limit the number of in-flight bios when swapping.
>  	 */
> -- 
> 2.37.3
> 

