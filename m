Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C0D6FCC40
	for <lists+linux-ext4@lfdr.de>; Tue,  9 May 2023 19:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbjEIRDf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 9 May 2023 13:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235322AbjEIRDR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 9 May 2023 13:03:17 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04487A5FC
        for <linux-ext4@vger.kernel.org>; Tue,  9 May 2023 09:59:43 -0700 (PDT)
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7575ff76964so180379285a.2
        for <linux-ext4@vger.kernel.org>; Tue, 09 May 2023 09:59:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683651532; x=1686243532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNfiDYylpHckBsTJBtckQjf+FcPfo0wjhkF9b1/i4T8=;
        b=cKjEWuV32pKPWMoACpuG7vV+RZ6Vh6PnyioilsntH0HvuCxRHoeWZb5JbkZ9m71hpa
         YgBGV3NUJxU1IoDmM14VekpIjZWpdppvE8N7OPeaULPsyk5Y8fG4fLlt7W7A8v+s4Y/0
         Y+B5V6+MB91QTSrNHM2BnU6pBomFjgXsIqP/vnx+6T9N+VlZ+c7amH9UcWDa3vDDj+AH
         jHVBOYMiwGF+RBbZILp+su49mxsConQfxwCcrH6TZfhQhvOveYNZbN+uvuM2r8MFd9qW
         rnNnYfcmH/z0zDEBmbJWIJA5GqaQaIy+zTpEZX4fSOiFTrYYDutKcJ46E6qad+nC3Mii
         NM9Q==
X-Gm-Message-State: AC+VfDyAcaPsYvQMx2fM8HUNnpF5vA6xW3XpAjFh47O9sVLnP+C+Zrs8
        KVZzyFnQ5Iprgp7eQ50aPXEz
X-Google-Smtp-Source: ACHHUZ6uxzUunep6oGxrhGEI8fJWpdH9biEaIAPK8tnW9no4oBDOuhDxrDrorqXw1bgEv5VB07afuQ==
X-Received: by 2002:a05:6214:528b:b0:621:44ee:7065 with SMTP id kj11-20020a056214528b00b0062144ee7065mr1016696qvb.9.1683651532284;
        Tue, 09 May 2023 09:58:52 -0700 (PDT)
Received: from localhost ([217.138.208.150])
        by smtp.gmail.com with ESMTPSA id pp16-20020a056214139000b006168277998csm896786qvb.58.2023.05.09.09.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 09:58:51 -0700 (PDT)
Date:   Tue, 9 May 2023 12:58:50 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>
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
        Brian Foster <bfoster@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH v6 4/5] dm-thin: Add REQ_OP_PROVISION support
Message-ID: <ZFp7ykxGFUbPG1ON@redhat.com>
References: <20230420004850.297045-1-sarthakkukreti@chromium.org>
 <20230506062909.74601-1-sarthakkukreti@chromium.org>
 <20230506062909.74601-5-sarthakkukreti@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230506062909.74601-5-sarthakkukreti@chromium.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, May 06 2023 at  2:29P -0400,
Sarthak Kukreti <sarthakkukreti@chromium.org> wrote:

> dm-thinpool uses the provision request to provision
> blocks for a dm-thin device. dm-thinpool currently does not
> pass through REQ_OP_PROVISION to underlying devices.
> 
> For shared blocks, provision requests will break sharing and copy the
> contents of the entire block. Additionally, if 'skip_block_zeroing'
> is not set, dm-thin will opt to zero out the entire range as a part
> of provisioning.
> 
> Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> ---
>  drivers/md/dm-thin.c | 70 +++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 66 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
> index 2b13c949bd72..3f94f53ac956 100644
> --- a/drivers/md/dm-thin.c
> +++ b/drivers/md/dm-thin.c
> @@ -274,6 +274,7 @@ struct pool {
>  
>  	process_bio_fn process_bio;
>  	process_bio_fn process_discard;
> +	process_bio_fn process_provision;
>  
>  	process_cell_fn process_cell;
>  	process_cell_fn process_discard_cell;
> @@ -913,7 +914,8 @@ static void __inc_remap_and_issue_cell(void *context,
>  	struct bio *bio;
>  
>  	while ((bio = bio_list_pop(&cell->bios))) {
> -		if (op_is_flush(bio->bi_opf) || bio_op(bio) == REQ_OP_DISCARD)
> +		if (op_is_flush(bio->bi_opf) || bio_op(bio) == REQ_OP_DISCARD ||
> +		    bio_op(bio) == REQ_OP_PROVISION)
>  			bio_list_add(&info->defer_bios, bio);
>  		else {
>  			inc_all_io_entry(info->tc->pool, bio);
> @@ -1245,8 +1247,8 @@ static int io_overlaps_block(struct pool *pool, struct bio *bio)
>  
>  static int io_overwrites_block(struct pool *pool, struct bio *bio)
>  {
> -	return (bio_data_dir(bio) == WRITE) &&
> -		io_overlaps_block(pool, bio);
> +	return (bio_data_dir(bio) == WRITE) && io_overlaps_block(pool, bio) &&
> +	       bio_op(bio) != REQ_OP_PROVISION;
>  }
>  
>  static void save_and_set_endio(struct bio *bio, bio_end_io_t **save,
> @@ -1953,6 +1955,51 @@ static void provision_block(struct thin_c *tc, struct bio *bio, dm_block_t block
>  	}
>  }
>  
> +static void process_provision_bio(struct thin_c *tc, struct bio *bio)
> +{
> +	int r;
> +	struct pool *pool = tc->pool;
> +	dm_block_t block = get_bio_block(tc, bio);
> +	struct dm_bio_prison_cell *cell;
> +	struct dm_cell_key key;
> +	struct dm_thin_lookup_result lookup_result;
> +
> +	/*
> +	 * If cell is already occupied, then the block is already
> +	 * being provisioned so we have nothing further to do here.
> +	 */
> +	build_virtual_key(tc->td, block, &key);
> +	if (bio_detain(pool, &key, bio, &cell))
> +		return;
> +
> +	if (tc->requeue_mode) {
> +		cell_requeue(pool, cell);
> +		return;
> +	}
> +
> +	r = dm_thin_find_block(tc->td, block, 1, &lookup_result);
> +	switch (r) {
> +	case 0:
> +		if (lookup_result.shared) {
> +			process_shared_bio(tc, bio, block, &lookup_result, cell);
> +		} else {
> +			bio_endio(bio);
> +			cell_defer_no_holder(tc, cell);
> +		}
> +		break;
> +	case -ENODATA:
> +		provision_block(tc, bio, block, cell);
> +		break;
> +
> +	default:
> +		DMERR_LIMIT("%s: dm_thin_find_block() failed: error = %d",
> +			    __func__, r);
> +		cell_defer_no_holder(tc, cell);
> +		bio_io_error(bio);
> +		break;
> +	}
> +}
> +
>  static void process_cell(struct thin_c *tc, struct dm_bio_prison_cell *cell)
>  {
>  	int r;
> @@ -2228,6 +2275,8 @@ static void process_thin_deferred_bios(struct thin_c *tc)
>  
>  		if (bio_op(bio) == REQ_OP_DISCARD)
>  			pool->process_discard(tc, bio);
> +		else if (bio_op(bio) == REQ_OP_PROVISION)
> +			pool->process_provision(tc, bio);
>  		else
>  			pool->process_bio(tc, bio);
>  
> @@ -2579,6 +2628,7 @@ static void set_pool_mode(struct pool *pool, enum pool_mode new_mode)
>  		dm_pool_metadata_read_only(pool->pmd);
>  		pool->process_bio = process_bio_fail;
>  		pool->process_discard = process_bio_fail;
> +		pool->process_provision = process_bio_fail;
>  		pool->process_cell = process_cell_fail;
>  		pool->process_discard_cell = process_cell_fail;
>  		pool->process_prepared_mapping = process_prepared_mapping_fail;
> @@ -2592,6 +2642,7 @@ static void set_pool_mode(struct pool *pool, enum pool_mode new_mode)
>  		dm_pool_metadata_read_only(pool->pmd);
>  		pool->process_bio = process_bio_read_only;
>  		pool->process_discard = process_bio_success;
> +		pool->process_provision = process_bio_fail;
>  		pool->process_cell = process_cell_read_only;
>  		pool->process_discard_cell = process_cell_success;
>  		pool->process_prepared_mapping = process_prepared_mapping_fail;
> @@ -2612,6 +2663,7 @@ static void set_pool_mode(struct pool *pool, enum pool_mode new_mode)
>  		pool->out_of_data_space = true;
>  		pool->process_bio = process_bio_read_only;
>  		pool->process_discard = process_discard_bio;
> +		pool->process_provision = process_bio_fail;
>  		pool->process_cell = process_cell_read_only;
>  		pool->process_prepared_mapping = process_prepared_mapping;
>  		set_discard_callbacks(pool);
> @@ -2628,6 +2680,7 @@ static void set_pool_mode(struct pool *pool, enum pool_mode new_mode)
>  		dm_pool_metadata_read_write(pool->pmd);
>  		pool->process_bio = process_bio;
>  		pool->process_discard = process_discard_bio;
> +		pool->process_provision = process_provision_bio;
>  		pool->process_cell = process_cell;
>  		pool->process_prepared_mapping = process_prepared_mapping;
>  		set_discard_callbacks(pool);
> @@ -2749,7 +2802,8 @@ static int thin_bio_map(struct dm_target *ti, struct bio *bio)
>  		return DM_MAPIO_SUBMITTED;
>  	}
>  
> -	if (op_is_flush(bio->bi_opf) || bio_op(bio) == REQ_OP_DISCARD) {
> +	if (op_is_flush(bio->bi_opf) || bio_op(bio) == REQ_OP_DISCARD ||
> +	    bio_op(bio) == REQ_OP_PROVISION) {
>  		thin_defer_bio_with_throttle(tc, bio);
>  		return DM_MAPIO_SUBMITTED;
>  	}
> @@ -3396,6 +3450,9 @@ static int pool_ctr(struct dm_target *ti, unsigned int argc, char **argv)
>  	pt->adjusted_pf = pt->requested_pf = pf;
>  	ti->num_flush_bios = 1;
>  	ti->limit_swap_bios = true;
> +	ti->num_provision_bios = 1;
> +	ti->provision_supported = true;
> +	ti->max_provision_granularity = true;
>  
>  	/*
>  	 * Only need to enable discards if the pool should pass
> @@ -4114,6 +4171,8 @@ static void pool_io_hints(struct dm_target *ti, struct queue_limits *limits)
>  	 * The pool uses the same discard limits as the underlying data
>  	 * device.  DM core has already set this up.
>  	 */
> +
> +	limits->max_provision_sectors = pool->sectors_per_block;
>  }
>  
>  static struct target_type pool_target = {
> @@ -4288,6 +4347,9 @@ static int thin_ctr(struct dm_target *ti, unsigned int argc, char **argv)
>  		ti->max_discard_granularity = true;
>  	}
>  
> +	ti->num_provision_bios = 1;
> +	ti->provision_supported = true;
> +

We need this in thin_ctr: ti->max_provision_granularity = true;

More needed in the thin target than thin-pool; otherwise provision bio
issued to thin devices won't be split appropriately.  But I do think
its fine to set in both thin_ctr and pool_ctr.

Otherwise, looks good.

Thanks,
Mike
