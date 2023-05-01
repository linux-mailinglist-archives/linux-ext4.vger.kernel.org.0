Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222596F368D
	for <lists+linux-ext4@lfdr.de>; Mon,  1 May 2023 21:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbjEATQo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 1 May 2023 15:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbjEATQn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 1 May 2023 15:16:43 -0400
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E681708
        for <linux-ext4@vger.kernel.org>; Mon,  1 May 2023 12:15:53 -0700 (PDT)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-619ca08c166so9676766d6.1
        for <linux-ext4@vger.kernel.org>; Mon, 01 May 2023 12:15:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682968553; x=1685560553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xta1ORIjLKUC6sudz2oVdR8ZSjIECo/NNbn+t5B7/30=;
        b=SHV/TT1opTmCtKL/ay/K84ko+Epd/CL5Bv7tPfZRW/Y9RFGPIJsy3MCCYZcTsDIHb6
         aWIVQjMrpgwMdMUeEmU2w8AbIvivDjG9DsFV1L+uFqOt4fRD/hhUulvnt15m6ShR2LFv
         7dOunf898c4RsvLcq4qrx7J7JoJEScym2RU/fAfxW0J3EHCZM6L3TX7Y6bjHx1X7GNJi
         weZNscyfMf60+16xGlA52AtYu1v4mv/w8w3zEluBetc1FZ2ZjlBusEMSONkbZQ8syy/b
         3sCnvee4B7KHEgwxSjgFcbTVYbNKQtbkEX0bI1izSqCfLEwDmY4k86tfy4E2FoV4KhEd
         bStw==
X-Gm-Message-State: AC+VfDxVNbwfG0DUGWuLehtMYPvDXRprCsJGJCjRz86rtD4GKLhaIOU1
        QIkagY1iDSitrm4HFQxd5az+
X-Google-Smtp-Source: ACHHUZ4jmmEuczYIXEM5IlwBG9kl9JWTkff4UV1CX3KDAprVLLnMz+RC3V5MfXehBawcFMx/T2jIDA==
X-Received: by 2002:a05:6214:27e1:b0:5e3:d150:3168 with SMTP id jt1-20020a05621427e100b005e3d1503168mr1170309qvb.18.1682968553151;
        Mon, 01 May 2023 12:15:53 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id o14-20020a0ccb0e000000b0061b62c1534fsm69023qvk.23.2023.05.01.12.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:15:52 -0700 (PDT)
Date:   Mon, 1 May 2023 15:15:51 -0400
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
        Daniil Lunev <dlunev@google.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Brian Foster <bfoster@redhat.com>,
        Alasdair Kergon <agk@redhat.com>, ejt@redhat.com
Subject: Re: [PATCH v5 4/5] dm-thin: Add REQ_OP_PROVISION support
Message-ID: <ZFAP5yQ0mwE4F6Vg@redhat.com>
References: <20230414000219.92640-1-sarthakkukreti@chromium.org>
 <20230420004850.297045-1-sarthakkukreti@chromium.org>
 <20230420004850.297045-5-sarthakkukreti@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420004850.297045-5-sarthakkukreti@chromium.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Apr 19 2023 at  8:48P -0400,
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
>  drivers/md/dm-thin.c | 73 +++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 68 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
> index 2b13c949bd72..58d633f5c928 100644
> --- a/drivers/md/dm-thin.c
> +++ b/drivers/md/dm-thin.c
> @@ -1891,7 +1893,8 @@ static void process_shared_bio(struct thin_c *tc, struct bio *bio,
>  
>  	if (bio_data_dir(bio) == WRITE && bio->bi_iter.bi_size) {
>  		break_sharing(tc, bio, block, &key, lookup_result, data_cell);
> -		cell_defer_no_holder(tc, virt_cell);
> +		if (bio_op(bio) != REQ_OP_PROVISION)
> +			cell_defer_no_holder(tc, virt_cell);

Can you please explain why cell_defer_no_holder() is skipped for REQ_OP_PROVISION here?

Thanks,
Mike
