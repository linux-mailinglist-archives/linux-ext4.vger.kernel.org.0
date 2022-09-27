Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F83F5ECF5A
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Sep 2022 23:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbiI0ViD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 27 Sep 2022 17:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiI0ViC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 27 Sep 2022 17:38:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0ED107DD6
        for <linux-ext4@vger.kernel.org>; Tue, 27 Sep 2022 14:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664314679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D5ZIksmGurvYC/iOAqtPVWbeUblsOdJ5xwGtu/IzOWI=;
        b=YBIfZafXPewAOPCwMwlF2w2DlDD21qltDYr2cFEMVrVtmC51dGFTeKdAXiJtPaqx9yq9Cp
        1HrshBShVhgvqNhy5iLFSavwN+Xt14nTLUwA6xhnRIjgMImWL1QeLhi/5X4kCLAk1uzMhj
        MZTuB/yV+8ihcPCiACSikzeV3XfNNVk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-55-TK4AGIsOP5W1BDp4xjus1g-1; Tue, 27 Sep 2022 17:37:58 -0400
X-MC-Unique: TK4AGIsOP5W1BDp4xjus1g-1
Received: by mail-wr1-f69.google.com with SMTP id k30-20020adfb35e000000b0022cc5ecd872so207639wrd.8
        for <linux-ext4@vger.kernel.org>; Tue, 27 Sep 2022 14:37:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=D5ZIksmGurvYC/iOAqtPVWbeUblsOdJ5xwGtu/IzOWI=;
        b=vb5a/I6ieLhFRbb6zwQ9ZiD3WA5Nv2psUDwuR218hWDySUYzYJ+4RyyZHtwA67AouR
         7u2bQvxPmpEFo3rItA6pUAz8stM2yayF5o/djdH2FVeUmeYv0FvDtgEjB8f/NOf3aZOL
         9QKP64XaZW7P4XV6jH0qnUr5FdIhNbHYV6bMF2Fa/8HvyEbpT7HNJ9G/HYskviHGjODe
         x0LCDGGbMUDOQXrPHqnikALeXD0UI3JpWUoxAe5vZqDyvMeDkoUjz3QT2pqcRiFy8Tlt
         6T2gjW7QWHAwZ95BJVBZ3N+Dg7X0p2lmvLSPY4J/bRGsJdSQ7QD3DiFCmiDQDTTpHdIe
         1/LA==
X-Gm-Message-State: ACrzQf0K4jhQNC+CJXebolBtkvfyTaq/qoiGzmUPjVaZncRV8O2Qyn8G
        vh3fnNhn6XAaHX9XzRsI0wkTUkiSBdhCTU9cGgc2OVwW7RIZTedFCE9x8a1DuHV6vCuUSo7RwCo
        QGLoqJIweEh8/wnCSmwrh/w==
X-Received: by 2002:a05:6000:2ce:b0:22a:f2dc:1531 with SMTP id o14-20020a05600002ce00b0022af2dc1531mr18615000wry.370.1664314677242;
        Tue, 27 Sep 2022 14:37:57 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM75GZrpOIjx3Y8daQH5gD30RRG235Fd/YqvwBOi/XGXrLC5i+WLs9D44hdtjOnyVVgkm68Sog==
X-Received: by 2002:a05:6000:2ce:b0:22a:f2dc:1531 with SMTP id o14-20020a05600002ce00b0022af2dc1531mr18614976wry.370.1664314677008;
        Tue, 27 Sep 2022 14:37:57 -0700 (PDT)
Received: from redhat.com ([2.55.47.213])
        by smtp.gmail.com with ESMTPSA id n3-20020a5d4203000000b0022acb7195aesm2708029wrq.33.2022.09.27.14.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 14:37:56 -0700 (PDT)
Date:   Tue, 27 Sep 2022 17:37:50 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>, Jason Wang <jasowang@redhat.com>,
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
Subject: Re: [PATCH RFC 3/8] virtio_blk: Add support for provision requests
Message-ID: <20220927173658-mutt-send-email-mst@kernel.org>
References: <20220915164826.1396245-1-sarthakkukreti@google.com>
 <20220915164826.1396245-4-sarthakkukreti@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915164826.1396245-4-sarthakkukreti@google.com>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Sep 15, 2022 at 09:48:21AM -0700, Sarthak Kukreti wrote:
> From: Sarthak Kukreti <sarthakkukreti@chromium.org>
> 
> Adds support for provision requests. Provision requests act like
> the inverse of discards.
> 
> Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> ---
>  drivers/block/virtio_blk.c      | 48 +++++++++++++++++++++++++++++++++
>  include/uapi/linux/virtio_blk.h |  9 +++++++
>  2 files changed, 57 insertions(+)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 30255fcaf181..eacc2bffe1d1 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -178,6 +178,39 @@ static int virtblk_setup_discard_write_zeroes(struct request *req, bool unmap)
>  	return 0;
>  }
>  
> +static int virtblk_setup_provision(struct request *req)
> +{
> +	unsigned short segments = blk_rq_nr_discard_segments(req);
> +	unsigned short n = 0;
> +
> +	struct virtio_blk_discard_write_zeroes *range;
> +	struct bio *bio;
> +	u32 flags = 0;
> +
> +	range = kmalloc_array(segments, sizeof(*range), GFP_ATOMIC);
> +	if (!range)
> +		return -ENOMEM;
> +
> +	__rq_for_each_bio(bio, req) {
> +		u64 sector = bio->bi_iter.bi_sector;
> +		u32 num_sectors = bio->bi_iter.bi_size >> SECTOR_SHIFT;
> +
> +		range[n].flags = cpu_to_le32(flags);
> +		range[n].num_sectors = cpu_to_le32(num_sectors);
> +		range[n].sector = cpu_to_le64(sector);
> +		n++;
> +	}
> +
> +	WARN_ON_ONCE(n != segments);
> +
> +	req->special_vec.bv_page = virt_to_page(range);
> +	req->special_vec.bv_offset = offset_in_page(range);
> +	req->special_vec.bv_len = sizeof(*range) * segments;
> +	req->rq_flags |= RQF_SPECIAL_PAYLOAD;
> +
> +	return 0;
> +}
> +
>  static void virtblk_unmap_data(struct request *req, struct virtblk_req *vbr)
>  {
>  	if (blk_rq_nr_phys_segments(req))
> @@ -243,6 +276,9 @@ static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
>  	case REQ_OP_DRV_IN:
>  		type = VIRTIO_BLK_T_GET_ID;
>  		break;
> +	case REQ_OP_PROVISION:
> +		type = VIRTIO_BLK_T_PROVISION;
> +		break;
>  	default:
>  		WARN_ON_ONCE(1);
>  		return BLK_STS_IOERR;
> @@ -256,6 +292,11 @@ static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
>  			return BLK_STS_RESOURCE;
>  	}
>  
> +	if (type == VIRTIO_BLK_T_PROVISION) {
> +		if (virtblk_setup_provision(req))
> +			return BLK_STS_RESOURCE;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -1075,6 +1116,12 @@ static int virtblk_probe(struct virtio_device *vdev)
>  		blk_queue_max_write_zeroes_sectors(q, v ? v : UINT_MAX);
>  	}
>  
> +	if (virtio_has_feature(vdev, VIRTIO_BLK_F_PROVISION)) {
> +		virtio_cread(vdev, struct virtio_blk_config,
> +			     max_provision_sectors, &v);
> +		q->limits.max_provision_sectors = v ? v : UINT_MAX;
> +	}
> +
>  	virtblk_update_capacity(vblk, false);
>  	virtio_device_ready(vdev);
>  
> @@ -1177,6 +1224,7 @@ static unsigned int features[] = {
>  	VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
>  	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
>  	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD, VIRTIO_BLK_F_WRITE_ZEROES,
> +	VIRTIO_BLK_F_PROVISION,
>  };
>  
>  static struct virtio_driver virtio_blk = {
> diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
> index d888f013d9ff..184f8cf6d185 100644
> --- a/include/uapi/linux/virtio_blk.h
> +++ b/include/uapi/linux/virtio_blk.h
> @@ -40,6 +40,7 @@
>  #define VIRTIO_BLK_F_MQ		12	/* support more than one vq */
>  #define VIRTIO_BLK_F_DISCARD	13	/* DISCARD is supported */
>  #define VIRTIO_BLK_F_WRITE_ZEROES	14	/* WRITE ZEROES is supported */
> +#define VIRTIO_BLK_F_PROVISION	15	/* provision is supported */
>  
>  /* Legacy feature bits */
>  #ifndef VIRTIO_BLK_NO_LEGACY
> @@ -120,6 +121,11 @@ struct virtio_blk_config {
>  	 */
>  	__u8 write_zeroes_may_unmap;
>  
> +	/*
> +	 * The maximum number of sectors in a provision request.
> +	 */
> +	__virtio32 max_provision_sectors;
> +
>  	__u8 unused1[3];
>  } __attribute__((packed));
>  
> @@ -155,6 +161,9 @@ struct virtio_blk_config {
>  /* Write zeroes command */
>  #define VIRTIO_BLK_T_WRITE_ZEROES	13
>  
> +/* Provision command */
> +#define VIRTIO_BLK_T_PROVISION	14
> +
>  #ifndef VIRTIO_BLK_NO_LEGACY
>  /* Barrier before this op. */
>  #define VIRTIO_BLK_T_BARRIER	0x80000000


Feature bit has to be reserved in the virtio spec.
Pls do this through the virtio TC mailing list.

> -- 
> 2.31.0

