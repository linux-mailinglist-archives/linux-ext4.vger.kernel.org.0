Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259985E7CCD
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Sep 2022 16:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbiIWOXe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 23 Sep 2022 10:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbiIWOXa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 23 Sep 2022 10:23:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1BF131F45
        for <linux-ext4@vger.kernel.org>; Fri, 23 Sep 2022 07:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663943008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MtMta5sZ7F8zj2gNZ2FUjMLqWdc2TCa8gGZwFvL5igI=;
        b=N2eQy8M9WK0KndyPz7YJIe9AhbZ/9B0/GpeRNPAOzOxMnt1IjGo9vnui+5SSwRrJ+j8BHr
        A88SwCWyibMLYuAcY+GTh0iKSkdlG0zACcUeQHZVmmSo8xQOfFgnO724AcCR92ZhrKpDKp
        prnGSPEx/6D2XS8/fwvndYbR7Xw+3qk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-212-ESHQbun_MoS0eVnPsXzHiQ-1; Fri, 23 Sep 2022 10:23:27 -0400
X-MC-Unique: ESHQbun_MoS0eVnPsXzHiQ-1
Received: by mail-qv1-f71.google.com with SMTP id nm17-20020a0562143b1100b004a5a3002d87so8575133qvb.8
        for <linux-ext4@vger.kernel.org>; Fri, 23 Sep 2022 07:23:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=MtMta5sZ7F8zj2gNZ2FUjMLqWdc2TCa8gGZwFvL5igI=;
        b=TFrrD90yqOIRAf2RV3Lt8dgdjbk7hzYWLf5uUc959kSAuRFOUuaoQTI4EhQ+yncWpG
         WKW1W0CtARLAwbnGR8lb7cQXkx929fK7BxqCR5qSygzsajq9G5XMk2lrKLfe+z4R6256
         QmWBSXrpi8N01gLxYJNyHhrVHbLat/WhnBTQA6dR6a+8cUSDPFVmJHEbraGKCYEo/Xgn
         +XXLbWMkyA6Pn+hPFTN8Rp9JNANuEW03kxtlmZahZ47cz/9x63w/s0qc4LgNkU9sXcES
         UZE1iSILHpbBOi0uvrcusipsQJq5Npxtj16hSJp0GKPXqxDhSAkmbt4v6URw+fK8JWcn
         aAZQ==
X-Gm-Message-State: ACrzQf1UkUjX/H79h4d6XuwIGh5fSnCLtZIpDN1iWqOcBAitw7TpG1M6
        uhgF5hjaYZtn9shHedvZTGjlD7/zL/CkAIvw91xSVfT5/l/Ox0/e34EEymIqzjv8ztBTRBsk7ho
        VHIVsAk0uxiLHhitsPpKH
X-Received: by 2002:a37:ef18:0:b0:6ce:175f:409a with SMTP id j24-20020a37ef18000000b006ce175f409amr5781673qkk.572.1663943006692;
        Fri, 23 Sep 2022 07:23:26 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7XaeBSmIgCS5xVoX7O37KV2Q4BatIbL+4W7934TQWhD9AMaj+EBoxQ49sZN/jgeEabR6YtNA==
X-Received: by 2002:a37:ef18:0:b0:6ce:175f:409a with SMTP id j24-20020a37ef18000000b006ce175f409amr5781650qkk.572.1663943006470;
        Fri, 23 Sep 2022 07:23:26 -0700 (PDT)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id y26-20020a37f61a000000b006ceb933a9fesm5847674qkj.81.2022.09.23.07.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 07:23:26 -0700 (PDT)
Date:   Fri, 23 Sep 2022 10:23:25 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        Daniil Lunev <dlunev@google.com>,
        Evan Green <evgreen@google.com>,
        Gwendal Grignou <gwendal@google.com>
Subject: Re: [PATCH RFC 2/8] dm: Add support for block provisioning
Message-ID: <Yy3BXc9wf4PH6Rby@redhat.com>
References: <20220915164826.1396245-1-sarthakkukreti@google.com>
 <20220915164826.1396245-3-sarthakkukreti@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915164826.1396245-3-sarthakkukreti@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Sep 15 2022 at 12:48P -0400,
Sarthak Kukreti <sarthakkukreti@chromium.org> wrote:

> From: Sarthak Kukreti <sarthakkukreti@chromium.org>
> 
> Add support to dm devices for REQ_OP_PROVISION. The default mode
> is to pass through the request and dm-thin will utilize it to provision
> blocks.
> 
> Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> ---
>  drivers/md/dm-crypt.c         |  4 +-
>  drivers/md/dm-linear.c        |  1 +
>  drivers/md/dm-table.c         | 17 +++++++
>  drivers/md/dm-thin.c          | 86 +++++++++++++++++++++++++++++++++--
>  drivers/md/dm.c               |  4 ++
>  include/linux/device-mapper.h |  6 +++
>  6 files changed, 113 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
> index 159c6806c19b..357f0899cfb6 100644
> --- a/drivers/md/dm-crypt.c
> +++ b/drivers/md/dm-crypt.c
> @@ -3081,6 +3081,8 @@ static int crypt_ctr_optional(struct dm_target *ti, unsigned int argc, char **ar
>  	if (ret)
>  		return ret;
>  
> +	ti->num_provision_bios = 1;
> +
>  	while (opt_params--) {
>  		opt_string = dm_shift_arg(&as);
>  		if (!opt_string) {
> @@ -3384,7 +3386,7 @@ static int crypt_map(struct dm_target *ti, struct bio *bio)
>  	 * - for REQ_OP_DISCARD caller must use flush if IO ordering matters
>  	 */
>  	if (unlikely(bio->bi_opf & REQ_PREFLUSH ||
> -	    bio_op(bio) == REQ_OP_DISCARD)) {
> +	    bio_op(bio) == REQ_OP_DISCARD || bio_op(bio) == REQ_OP_PROVISION)) {
>  		bio_set_dev(bio, cc->dev->bdev);
>  		if (bio_sectors(bio))
>  			bio->bi_iter.bi_sector = cc->start +
> diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
> index 3212ef6aa81b..1aa782149428 100644
> --- a/drivers/md/dm-linear.c
> +++ b/drivers/md/dm-linear.c
> @@ -61,6 +61,7 @@ static int linear_ctr(struct dm_target *ti, unsigned int argc, char **argv)
>  	ti->num_discard_bios = 1;
>  	ti->num_secure_erase_bios = 1;
>  	ti->num_write_zeroes_bios = 1;
> +	ti->num_provision_bios = 1;
>  	ti->private = lc;
>  	return 0;
>  
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index 332f96b58252..b7f9cb66b7ba 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -1853,6 +1853,18 @@ static bool dm_table_supports_write_zeroes(struct dm_table *t)
>  	return true;
>  }
>  
> +static bool dm_table_supports_provision(struct dm_table *t)
> +{
> +	for (unsigned int i = 0; i < t->num_targets; i++) {
> +		struct dm_target *ti = dm_table_get_target(t, i);
> +
> +		if (ti->num_provision_bios)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +

This needs to go a step further and verify a device in the stack
actually services REQ_OP_PROVISION.

Please see dm_table_supports_discards(): it iterates all devices in
the table and checks that support is advertised.

For discard, DM requires that _all_ devices in a table advertise
support (that is pretty strict and likely could be relaxed to _any_).

You'll need ti->provision_supported (like ->discards_supported) to
advertise actual support is provided by dm-thinp (even if underlying
devices don't support it).

And yeah, dm-thinp passdown support for REQ_OP_PROVISION can follow
later as needed (if there actual HW that would benefit from
REQ_OP_PROVISION).

Mike

