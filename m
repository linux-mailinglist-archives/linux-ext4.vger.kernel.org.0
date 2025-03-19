Return-Path: <linux-ext4+bounces-6925-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BD8A699CB
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Mar 2025 20:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 203EB19C1720
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Mar 2025 19:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C539214A9E;
	Wed, 19 Mar 2025 19:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fo7qbJp6"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0567421480E
	for <linux-ext4@vger.kernel.org>; Wed, 19 Mar 2025 19:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742413847; cv=none; b=Wxp+TTlrONKCm5j/aOjiBCZ30C4TE8qpObbcWZvjbJYirhPpuFXh+YqsDboqKqeSikGPl65wJ8ViUWakkMNJMxXSeYGQohJTJYzuSKDMhFl6DGjIlnxK6pcgdL57RoaBudTViIm7cTm53BknGWHYLiiphFhb1h17K9XSNPgimu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742413847; c=relaxed/simple;
	bh=sExoy8pqp0ariENfKfzxL5q5xGicuuhF34RlyGSM2pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sf42aMMkDHRLATE5fdRE3ebMuKFR7WF80Lx8yMHK8lOz6Vdwr5tc+p3x+9bBBh8/adZ2EirbFT2Rfctk22UucE5BbawDgXZiGvDnOKXHfP0xb/PhWnyTMZcT2jG3m1PW1J1GIbsQNn4nQeXAYSfpvHnW3yIouYLEBgapNDajuQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fo7qbJp6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742413844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UoMsJz6uQ9Xsq6hoAcbPVlQz7ODTaS5nZ9IsZpDthKQ=;
	b=fo7qbJp6mTZXrn7vlLUeRjNkyjaV39JGnfrWavRiTYeDsBi7CyEF57Tg1ERZi3OVcyL90h
	Z3u0B1dk8BgsXlhdusxFYYFrkunEpE/u+p9CtJZqFnYip9cY3Zx7iAZIK9eFXsgLnhMjQ9
	VG7CwCW1X2RyWpNyMXFNBujswymo3O0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-550-pc5hPzSgOM-Mh3OFUt2lmQ-1; Wed,
 19 Mar 2025 15:50:38 -0400
X-MC-Unique: pc5hPzSgOM-Mh3OFUt2lmQ-1
X-Mimecast-MFC-AGG-ID: pc5hPzSgOM-Mh3OFUt2lmQ_1742413836
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7B028180AB19;
	Wed, 19 Mar 2025 19:50:33 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (unknown [10.6.23.247])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4E6C11956095;
	Wed, 19 Mar 2025 19:50:31 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 52JJoUdr2309780
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 15:50:30 -0400
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 52JJoRRp2309779;
	Wed, 19 Mar 2025 15:50:27 -0400
Date: Wed, 19 Mar 2025 15:50:27 -0400
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de,
        tytso@mit.edu, djwong@kernel.org, john.g.garry@oracle.com,
        chaitanyak@nvidia.com, shinichiro.kawasaki@wdc.com,
        yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com,
        yangerkun@huawei.com
Subject: Re: [RFC PATCH -next v3 06/10] dm: add BLK_FEAT_WRITE_ZEROES_UNMAP
 support
Message-ID: <Z9sgAxM-hZZJtZu9@redhat.com>
References: <20250318073545.3518707-1-yi.zhang@huaweicloud.com>
 <20250318073545.3518707-7-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318073545.3518707-7-yi.zhang@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Tue, Mar 18, 2025 at 03:35:41PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Set the BLK_FEAT_WRITE_ZEROES_UNMAP feature on stacking queue limits by
> default. This feature shall be disabled if any underlying device does
> not support it.
> 
Reviewed-by: Benjamin Marzinski <bmarzins@redhat.com>

> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  drivers/md/dm-table.c | 7 +++++--
>  drivers/md/dm.c       | 1 +
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index 453803f1edf5..d4a483287e26 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -598,7 +598,8 @@ int dm_split_args(int *argc, char ***argvp, char *input)
>  static void dm_set_stacking_limits(struct queue_limits *limits)
>  {
>  	blk_set_stacking_limits(limits);
> -	limits->features |= BLK_FEAT_IO_STAT | BLK_FEAT_NOWAIT | BLK_FEAT_POLL;
> +	limits->features |= BLK_FEAT_IO_STAT | BLK_FEAT_NOWAIT | BLK_FEAT_POLL |
> +			    BLK_FEAT_WRITE_ZEROES_UNMAP;
>  }
>  
>  /*
> @@ -1848,8 +1849,10 @@ int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
>  		limits->discard_alignment = 0;
>  	}
>  
> -	if (!dm_table_supports_write_zeroes(t))
> +	if (!dm_table_supports_write_zeroes(t)) {
>  		limits->max_write_zeroes_sectors = 0;
> +		limits->features &= ~BLK_FEAT_WRITE_ZEROES_UNMAP;
> +	}
>  
>  	if (!dm_table_supports_secure_erase(t))
>  		limits->max_secure_erase_sectors = 0;
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 5ab7574c0c76..b59c3dbeaaf1 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1096,6 +1096,7 @@ void disable_write_zeroes(struct mapped_device *md)
>  
>  	/* device doesn't really support WRITE ZEROES, disable it */
>  	limits->max_write_zeroes_sectors = 0;
> +	limits->features &= ~BLK_FEAT_WRITE_ZEROES_UNMAP;
>  }
>  
>  static bool swap_bios_limit(struct dm_target *ti, struct bio *bio)
> -- 
> 2.46.1


