Return-Path: <linux-ext4+bounces-3823-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D09CB959C1F
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Aug 2024 14:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9008C280FC5
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Aug 2024 12:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF27A192D66;
	Wed, 21 Aug 2024 12:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UPECP6a7"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8445188CBC
	for <linux-ext4@vger.kernel.org>; Wed, 21 Aug 2024 12:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724244227; cv=none; b=VF1VHKdalcHgyY4K7k6Ina2AmJ/x23GD6syXqcFAFiXGF+PtdR/OJRNMGpSTG3kpvlQrJ3N676KbR2w5PQ1UZvZvLpvGPcyPWMfJv7lQFGPGqvA2HQxysbyvTaRZmLd5CSqV082vTvjV5+hnx1mqcOMOdA2WcwaMKDEUZSiF620=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724244227; c=relaxed/simple;
	bh=V/1oc2fbb0estl1MZgYt8u2OmDkuEWS18pmSpE3Rj3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pp7k+d+bvajU9Zveapo8D30bknxTRMqMTFF82U5XUjmOqVgO2vigukWFpYM+VPUSmPkHE15XKDKyrJDsfTWJi77tzPjmw+cOGtWPUk8s3iHawkZ97uTF5lsPCyFh9E6gYZnTDo/TEgz0JQ+7aED2cDtblFLXjjeyCt9uvS+1Iww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UPECP6a7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724244224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mtlGwLEu5OGOzf4IChunQgRpb70NSVVBOCCeIPeHN3c=;
	b=UPECP6a77FB+xaNIg+wnioraPSpt2FBTAo1IDTwp+8OBiMv7Q6Bj8dJ8UmymJ01QlRLgyW
	Aza9OzsO2IMmdHGjoMtsjnQU/P7cyyQwYbW3X49tdDvN2uozHzvshxUuqUlVAttRcvHceH
	CqXtRP5ONfeh2hL7wtolYDM3x5kYyqI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-106-prwkk3vMMD2VBRICFVTlHQ-1; Wed,
 21 Aug 2024 08:43:40 -0400
X-MC-Unique: prwkk3vMMD2VBRICFVTlHQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BFFB01955BEE;
	Wed, 21 Aug 2024 12:43:37 +0000 (UTC)
Received: from bfoster (unknown [10.22.33.147])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1389E19560AD;
	Wed, 21 Aug 2024 12:43:34 +0000 (UTC)
Date: Wed, 21 Aug 2024 08:44:31 -0400
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH 6/6] xfs: refactor xfs_file_fallocate
Message-ID: <ZsXhL_pJhq2qyy-l@bfoster>
References: <20240821063108.650126-1-hch@lst.de>
 <20240821063108.650126-7-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821063108.650126-7-hch@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Wed, Aug 21, 2024 at 08:30:32AM +0200, Christoph Hellwig wrote:
> Refactor xfs_file_fallocate into separate helpers for each mode,
> two factors for i_size handling and a single switch statement over the
> supported modes.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/xfs/xfs_file.c | 327 +++++++++++++++++++++++++++++-----------------
>  1 file changed, 205 insertions(+), 122 deletions(-)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 489bc1b173c268..9d3bac7731bdcb 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -852,6 +852,189 @@ static inline bool xfs_file_sync_writes(struct file *filp)
>  	return false;
>  }
>  
...
> +
> +static int
> +xfs_falloc_unshare_range(
> +	struct file		*file,
> +	int			mode,
> +	loff_t			offset,
> +	loff_t			len)
> +{
> +	struct inode		*inode = file_inode(file);
> +	loff_t			new_size = 0;
> +	int			error;
> +
> +	error = xfs_falloc_newsize(file, mode, offset, len, &new_size);
> +	if (error)
> +		return error;
> +
> +	error = xfs_reflink_unshare(XFS_I(inode), offset, len);
> +	if (error)
> +		return error;
> +

Doesn't unshare imply alloc?

> +	return xfs_falloc_setsize(file, new_size);
> +}
> +
...
> @@ -894,129 +1075,31 @@ xfs_file_fallocate(
>  	if (error)
>  		goto out_unlock;
>  
> -	if (mode & FALLOC_FL_PUNCH_HOLE) {
> +	switch (mode & FALLOC_FL_MODE_MASK) {
> +	case FALLOC_FL_PUNCH_HOLE:
>  		error = xfs_free_file_space(ip, offset, len);
...
> +		break;
> +	case FALLOC_FL_COLLAPSE_RANGE:
> +		error = xfs_falloc_collapse_range(file, offset, len);
> +		break;
> +	case FALLOC_FL_INSERT_RANGE:
> +		error = xfs_falloc_insert_range(file, offset, len);
> +		break;
> +	case FALLOC_FL_ZERO_RANGE:
> +		error = xfs_falloc_zero_range(file, mode, offset, len);
> +		break;
> +	case FALLOC_FL_UNSHARE_RANGE:
> +		error = xfs_falloc_unshare_range(file, mode, offset, len);
> +		break;
> +	case FALLOC_FL_ALLOCATE_RANGE:
> +		error = xfs_falloc_allocate_range(file, mode, offset, len);
> +		break;
> +	default:
> +		error = -EOPNOTSUPP;
> +		break;
>  	}
>  
> -	if (xfs_file_sync_writes(file))
> +	if (!error && xfs_file_sync_writes(file))
>  		error = xfs_log_force_inode(ip);

I'd think if you hit -ENOSPC or something after doing a partial alloc to
a sync inode, you'd still want to flush the changes that were made..?

Brian

>  
>  out_unlock:
> -- 
> 2.43.0
> 
> 


