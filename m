Return-Path: <linux-ext4+bounces-7147-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55972A81906
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Apr 2025 00:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14F82189F967
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Apr 2025 22:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C07A2561A9;
	Tue,  8 Apr 2025 22:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="vW5fBzAe"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A56245024
	for <linux-ext4@vger.kernel.org>; Tue,  8 Apr 2025 22:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744152663; cv=none; b=aiaPgB/4QDlzb8Z9tKfZRwfudky+56p3ToqkoTHZXURtxc4r7QQKAbhAqlVtjVxnNZChr2oeffR0zdbdx/C+J4+JWLIHqNVFeWe12CDd8KN/EeFurGdZvpJLp/CwmewWxVpl65EqWUITmnRO8mmhxjmO3qAPu+Ax9F3VOtIDvTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744152663; c=relaxed/simple;
	bh=vMn/pqlIgdXeLiIiX6Qi2jw179hC4RQghNBS8hGqYZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0zLxmX6+C7xEGFwLZmkyPhrx5uysAQd+sb4PSAiNyYFEFEl7O0PmPq9X/GBP1KUkgCM4/sO7ZvAV9Wwk2KbkJswDRSrPVeumxO1gH48ka1S3jP3dUjUVW6mnDa1Md9FYLz9pe2aGGN94LHSQqUmlLi9vTQvijGu5YPbWBRB24M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=vW5fBzAe; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-736c277331eso121290b3a.1
        for <linux-ext4@vger.kernel.org>; Tue, 08 Apr 2025 15:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1744152661; x=1744757461; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t4e6TcScSbS46TYPzeS1oWS93atKNlcHoXycK2oxcMQ=;
        b=vW5fBzAe0imxu4fNHVLF4G0+rBz6dchsprA38wmkFpTUyJDs6MmA0hRVK/3TJEarkR
         wcOFCYgPGCGbQxejqah1vjSnYWaXl0Llt8YGa3+DTV/7ykPq0WdD21xS7uJ0HWEwy1W+
         vduYKCqV9Vb+QmQEkayZNQpKBCaFWcN4XG9PYDTduUz/euckEU4pCV1wLbfeRWF581FW
         23v7nbe75gdUBCvuyyczWq7xsX14MWOIYjs6iktc4bOM0b6I9ByH6sGQEfQ84LGPztfG
         RnI46D+hkTBe7mJ49Iu6Ggr54GFr/RqMqjyuan0gzOJ1Bo0AevAjEMsb7A4H8f53AL/O
         C3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744152661; x=1744757461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4e6TcScSbS46TYPzeS1oWS93atKNlcHoXycK2oxcMQ=;
        b=UUH1qDHpLt+IHfLLbDpvSjUa63d5tdKaFLdTJ81f0ssqaLjqSsduv7p7ogpM/UnM7J
         5gMNZ1M+XmS+NYfxPaVxO1esFzRSwdiVikkSV/MzwpBRnqo5Db3IY1NE1XWBvTc6d/oV
         /RFjPgI1QAcGLFfaQit8+m3Qh5AmMDVVGhQ5/uw+GudRjas9BAYNC0T7oBe6gWr57+qF
         V2tkY2a4kOJ3n6wAI2HfoVeoSxmYJfmziLMkBBwKPXGfNmFWZveXtWIsJaHPCmM74/d/
         eoLlzhpGfJAE1D71ghi6BYcYI3JfW569F6RDsqe4H9jfZlD1jho7P7gYnzQVQGshjisl
         ItXA==
X-Forwarded-Encrypted: i=1; AJvYcCW9vzB4Y9eD5fOT6OPRQ6zeLT3/mIkAy6oJ5eMd7vFWz9oTck2Nh7NotV49FGZ7SKEPjwaVnGwc/+53@vger.kernel.org
X-Gm-Message-State: AOJu0YxVpqoDgDUDa9in6Ivx8zC6Fb3+H7Cr7Gfo6N2Ni5L8do5nQ3Dg
	lvR9Z0cG8MPQpXaIdmM1IinnH0KzozQ9L4zSdpc5xZYTSZMdK/Y9PeOQi9MF+jU=
X-Gm-Gg: ASbGncuCJhsswZI8xxpp6qCst25YcPIMDYxu6GQlLyPEJtQfY1ZsHM5WaZbkKnDudnB
	VLkUBw9h6XxvIldAO0eRRd2SXhghdah8d6Hjz9vhPpn+5yTUnal4kExfMTEUuD2Bw5odPuUHLpO
	KFN3InRN5dt+eRccOtNYRnjtI6MWK8zNoMm76VuM+a6ofBaqWd9JQAsYGm3o4a5dzjpktcvsctk
	uX3aOjMRGtfWKBHrGi/tNTWPxcBEE7Y7cIJN1EGsVq9kXyS8ivF7CZkO6JpOU2JnCC3pe/KP19C
	Is/2XXybXf8+hLMSokRTHyy73M2tA2zOc9grNDJ6OXJdXWwNg9fMnezmsgt3HJ+nRnQvGfsZ1gS
	f0myRjX3ndngLYhaGDet3B/WVw7ym
X-Google-Smtp-Source: AGHT+IH1vqfq5KmC7q977AO5WgEcrZQ60lrohQ1dtQpSWtpSiqHurs35gj5R27z5qJYFLZ4y41PN8w==
X-Received: by 2002:a05:6a00:2411:b0:734:ded8:77aa with SMTP id d2e1a72fcca58-73bae4cc284mr829197b3a.9.1744152661136;
        Tue, 08 Apr 2025 15:51:01 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d9ea0a71sm11117925b3a.113.2025.04.08.15.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 15:51:00 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1u2HmT-00000006F85-0aHp;
	Wed, 09 Apr 2025 08:50:57 +1000
Date: Wed, 9 Apr 2025 08:50:57 +1000
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, djwong@kernel.org, hch@lst.de,
	viro@zeniv.linux.org.uk, jack@suse.cz, cem@kernel.org,
	linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com
Subject: Re: [PATCH v6 02/12] xfs: add helpers to compute log item overhead
Message-ID: <Z_WoUawfJ_QFF5kP@dread.disaster.area>
References: <20250408104209.1852036-1-john.g.garry@oracle.com>
 <20250408104209.1852036-3-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408104209.1852036-3-john.g.garry@oracle.com>

On Tue, Apr 08, 2025 at 10:41:59AM +0000, John Garry wrote:
> From: "Darrick J. Wong" <djwong@kernel.org>
> 
> Add selected helpers to estimate the transaction reservation required to
> write various log intent and buffer items to the log.  These helpers
> will be used by the online repair code for more precise estimations of
> how much work can be done in a single transaction.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/libxfs/xfs_trans_resv.c |  6 +++---
>  fs/xfs/libxfs/xfs_trans_resv.h |  4 ++++
>  fs/xfs/xfs_bmap_item.c         | 10 ++++++++++
>  fs/xfs/xfs_bmap_item.h         |  3 +++
>  fs/xfs/xfs_buf_item.c          | 19 +++++++++++++++++++
>  fs/xfs/xfs_buf_item.h          |  3 +++
>  fs/xfs/xfs_extfree_item.c      | 10 ++++++++++
>  fs/xfs/xfs_extfree_item.h      |  3 +++
>  fs/xfs/xfs_log_cil.c           |  4 +---
>  fs/xfs/xfs_log_priv.h          | 13 +++++++++++++
>  fs/xfs/xfs_refcount_item.c     | 10 ++++++++++
>  fs/xfs/xfs_refcount_item.h     |  3 +++
>  fs/xfs/xfs_rmap_item.c         | 10 ++++++++++
>  fs/xfs/xfs_rmap_item.h         |  3 +++
>  14 files changed, 95 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_trans_resv.c b/fs/xfs/libxfs/xfs_trans_resv.c
> index 13d00c7166e1..ce1393bd3561 100644
> --- a/fs/xfs/libxfs/xfs_trans_resv.c
> +++ b/fs/xfs/libxfs/xfs_trans_resv.c
> @@ -47,7 +47,7 @@ xfs_buf_log_overhead(void)
>   * will be changed in a transaction.  size is used to tell how many
>   * bytes should be reserved per item.
>   */
> -STATIC uint
> +uint
>  xfs_calc_buf_res(
>  	uint		nbufs,
>  	uint		size)
> @@ -84,7 +84,7 @@ xfs_allocfree_block_count(
>   * in the same transaction as an allocation or a free, so we compute them
>   * separately.
>   */
> -static unsigned int
> +unsigned int
>  xfs_refcountbt_block_count(
>  	struct xfs_mount	*mp,
>  	unsigned int		num_ops)
> @@ -129,7 +129,7 @@ xfs_rtrefcountbt_block_count(
>   *	  additional to the records and pointers that fit inside the inode
>   *	  forks.
>   */
> -STATIC uint
> +uint
>  xfs_calc_inode_res(
>  	struct xfs_mount	*mp,
>  	uint			ninodes)
> diff --git a/fs/xfs/libxfs/xfs_trans_resv.h b/fs/xfs/libxfs/xfs_trans_resv.h
> index 0554b9d775d2..e76052028cc9 100644
> --- a/fs/xfs/libxfs/xfs_trans_resv.h
> +++ b/fs/xfs/libxfs/xfs_trans_resv.h
> @@ -97,6 +97,10 @@ struct xfs_trans_resv {
>  
>  void xfs_trans_resv_calc(struct xfs_mount *mp, struct xfs_trans_resv *resp);
>  uint xfs_allocfree_block_count(struct xfs_mount *mp, uint num_ops);
> +unsigned int xfs_refcountbt_block_count(struct xfs_mount *mp,
> +		unsigned int num_ops);
> +uint xfs_calc_buf_res(uint nbufs, uint size);
> +uint xfs_calc_inode_res(struct xfs_mount *mp, uint ninodes);

Why are these exported? They aren't used in this patch, and any code
that doing calculate log reservation calculation should really be
placed in xfs_trans_resv.c along with all the existing log
reservation calculations...

-Dave
-- 
Dave Chinner
david@fromorbit.com

