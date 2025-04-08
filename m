Return-Path: <linux-ext4+bounces-7146-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF94A818F8
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Apr 2025 00:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCA041B8207E
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Apr 2025 22:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AEB2561D3;
	Tue,  8 Apr 2025 22:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="1eFAvur0"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4217D255E44
	for <linux-ext4@vger.kernel.org>; Tue,  8 Apr 2025 22:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744152435; cv=none; b=fqFwbvov0jvpgotPE7bVWb/Rla6g8qXooQ7EMK2jZR0N56Jw0WQGBvpric5T3kGPxDsrQ6b/f4m0G2J43/K+2GBBCjcFe2NGq8phz0hYA9FILHSwdrnegb8NG9XBUs9pNQMlHnwh/+tHQakLsDtV/1mjBLm5qu5XX1N0njBUmVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744152435; c=relaxed/simple;
	bh=Uy6csq/iZO0iF/avJnW6XXU0ZKj+Jg8iaWCbQWtkHLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gwi8OSSLFZc+cfocaPOeTg/ZpL4eWWZ+TNH4GltcirSdKte2UrH0HGm5QkKjVy+VeBs0qXl/1A3gBAFqKkhRqpLO/Xjk9QfPawu/xF9CRVOH8YlySV/piV3hH4ucHNYUwF85v+57+x2RqYbIna1XJ/sRTQ94vEC7a0fg1J4O9XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=1eFAvur0; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-227c7e57da2so53095235ad.0
        for <linux-ext4@vger.kernel.org>; Tue, 08 Apr 2025 15:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1744152432; x=1744757232; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o6NRZ+eIBvD2ygB/RFw901KQrONh8kxWwYZ7rUvs968=;
        b=1eFAvur0uvXIdBCtJvaz6H8SigyTFohvXCKvsXpzWYHkGOZ/mnXG65nf+BeRcCFycZ
         G4a9py3Qet1t+lh0XcWRCxwfrGwHMcs3x4Sm4gDmSBlP4SAV0/qtAWhoeH59+BWVpD5J
         QtcSwdOUsByIuOFokVyODL2mqALqPzA6860MQnRmWE9+z29yatYP3uafpO5GFA0Budv6
         bRV+ERyuhK6aYo6Yn0ojWEAEacmB35XWCE5j3JlXudPCsKtOPU4Jef+Fnttg0f7yO43b
         fFvofDDv3vIiGQnDyfKl2YCKUwXxWU6JhFN90I6b+l1Pxb8NDpM24D6PvXuAg3G4Pr+7
         2WeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744152432; x=1744757232;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o6NRZ+eIBvD2ygB/RFw901KQrONh8kxWwYZ7rUvs968=;
        b=V/c4F7AQMcOgp9wrh4ApvxMC8ZQWgtg7BBZNnlDjDgcbgCSGpGBlElUS6h8Rs9elcb
         9jhdfDFVw6u6sJfi3cTQXSXu/ZhNhLNFvM3aAw5KjLRrgddUuN3qaRbHOBKsFD+G9ZfJ
         D8cF+MqqbZx6LUummMnyvpNaSyTWJAstpXq4JLopUp4tp7TPCP8385HFMKqCI2gv1mXF
         CxSTvzwM5Q46Q04iUvWP2dkbs/8XmuDiAEFDnPFVOQISeXe2dDU2lU4v9vcNVA5ozY26
         Iic8/89eP10ItqXgpAxij0HjDr9TEFOCVHTuQO+jpflIAgY0YOpMa4hhi05g8wRi/pOD
         06Wg==
X-Forwarded-Encrypted: i=1; AJvYcCVQulAyg1P9Zdl4Ca5s3A9YgL2XALmTxiJggj0aCc4nDd97yNj2uTMhbhr+Kukbx2Ev9+hj2LV+fg+a@vger.kernel.org
X-Gm-Message-State: AOJu0YxiK3N3cnw9LSHDemcX95uf35mtijxlXdzkk6cFb7W37Cdxd3x6
	ycAuYPXFBow3//o+wLII+B8JFRWw5KFcBqg9PGOIJIVOi6m5Ig1bIVKtFs6kDKk=
X-Gm-Gg: ASbGncuXNfom5YWKibhzkm95Rioigc4oaC7TNbO1D20T1q6EWe9mC44sEAdWY4s4nO/
	TwCAcyeyAW98PnTM1bLBoFxGQPSZzRrxELbNsMyzNDLBqMtRtKV8TuUdA46Uz4mlm4AS+AKcLxE
	6rTuI6E/UMEiwB44GiIkGxLHmTSEd+WVaAQ8QXU9oy1juiwjQYYymVLvKoHF5J12PuWPKjGxXng
	rib3JIbffTzKK25k9JyW95QDWfjD8lJ7h1H6uFAAj8hpyO9f1TGdcPynbRaqWI02JYrLl8yt5nh
	rWimDKzVpYsb55ZgnfYz2R0sCCIMpIlALxLgHoOd27gr7hO3tbrKbFOfCpS2g8Ik7Gs9bvTrHxD
	hqW37+flHxzeXBQh59sABCxsMaztQ
X-Google-Smtp-Source: AGHT+IGurDzqMih/v0exHbuE7Zr5SXTWizgQjwosdkoAtELLC7VfyDCiglM0XFRzA9ZoR+zeRWPrvw==
X-Received: by 2002:a17:902:cecc:b0:223:4341:a994 with SMTP id d9443c01a7336-22ac3f34df7mr4238895ad.9.1744152432520;
        Tue, 08 Apr 2025 15:47:12 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297866e2a0sm106697685ad.180.2025.04.08.15.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 15:47:11 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1u2Hin-00000006F62-0WE5;
	Wed, 09 Apr 2025 08:47:09 +1000
Date: Wed, 9 Apr 2025 08:47:09 +1000
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, djwong@kernel.org, hch@lst.de,
	viro@zeniv.linux.org.uk, jack@suse.cz, cem@kernel.org,
	linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com
Subject: Re: [PATCH v6 11/12] xfs: add xfs_compute_atomic_write_unit_max()
Message-ID: <Z_WnbfRhKR6RQsSA@dread.disaster.area>
References: <20250408104209.1852036-1-john.g.garry@oracle.com>
 <20250408104209.1852036-12-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408104209.1852036-12-john.g.garry@oracle.com>

On Tue, Apr 08, 2025 at 10:42:08AM +0000, John Garry wrote:
> Now that CoW-based atomic writes are supported, update the max size of an
> atomic write for the data device.
> 
> The limit of a CoW-based atomic write will be the limit of the number of
> logitems which can fit into a single transaction.

I still think this is the wrong way to define the maximum
size of a COW-based atomic write because it is going to change from
filesystem to filesystem and that variability in supported maximum
length will be exposed to userspace...

i.e. Maximum supported atomic write size really should be defined as
a well documented fixed size (e.g. 16MB). Then the transaction
reservations sizes needed to perform that conversion can be
calculated directly from that maximum size and optimised directly
for the conversion operation that atomic writes need to perform.

.....

> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index b2dd0c0bf509..42b2b7540507 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -615,6 +615,28 @@ xfs_init_mount_workqueues(
>  	return -ENOMEM;
>  }
>  
> +unsigned int
> +xfs_atomic_write_logitems(
> +	struct xfs_mount	*mp)
> +{
> +	unsigned int		efi = xfs_efi_item_overhead(1);
> +	unsigned int		rui = xfs_rui_item_overhead(1);
> +	unsigned int		cui = xfs_cui_item_overhead(1);
> +	unsigned int		bui = xfs_bui_item_overhead(1);
> +	unsigned int		logres = M_RES(mp)->tr_write.tr_logres;
> +
> +	/*
> +	 * Maximum overhead to complete an atomic write ioend in software:
> +	 * remove data fork extent + remove cow fork extent +
> +	 * map extent into data fork
> +	 */
> +	unsigned int		atomic_logitems =
> +		(bui + cui + rui + efi) + (cui + rui) + (bui + rui);

This seems wrong. Unmap from the data fork only logs a (bui + cui)
pair, we don't log a RUI or an EFI until the transaction that
processes the BUI or CUI actually frees an extent from the the BMBT
or removes a block from the refcount btree.

We also need to be able to relog all the intents and everything that
was modified, so we effectively have at least one
xfs_allocfree_block_count() reservation needed here as well. Even
finishing an invalidation BUI can result in BMBT block allocation
occurring if the operation splits an existing extent record and the
insert of the new record causes a BMBT block split....


> +
> +	/* atomic write limits are always a power-of-2 */
> +	return rounddown_pow_of_two(logres / (2 * atomic_logitems));

What is the magic 2 in that division?

> +}

Also this function does not belong in xfs_super.c - that file is for
interfacing with the VFS layer.  Calculating log reservation
constants at mount time is done in xfs_trans_resv.c - I suspect most
of the code in this patch should probably be moved there and run
from xfs_trans_resv_calc()...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

