Return-Path: <linux-ext4+bounces-6654-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D953DA4CB90
	for <lists+linux-ext4@lfdr.de>; Mon,  3 Mar 2025 20:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 378F07A9763
	for <lists+linux-ext4@lfdr.de>; Mon,  3 Mar 2025 19:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB3121B9CF;
	Mon,  3 Mar 2025 19:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SOyKa708"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4081DE2BF
	for <linux-ext4@vger.kernel.org>; Mon,  3 Mar 2025 19:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741028809; cv=none; b=WwXpwNK1uII7Q8CMPVJtKOj61ckusltxKB7fAxUG6l+exp/VubWm1Unwz9OXb4Vy+zMaHHziMmtUZPPK5LEYvbyJkEKFWYe09iBDTHQGxpcMNHGJfdwDuk2U3uadyh/GP/C4UEgzz0GrvyiNwnPN8MuY5tSFo/GNWZyrqu6GUSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741028809; c=relaxed/simple;
	bh=h2VU3ZtHHJqpUGpqUTikqUF9NW67YrDyvPCDXOKvqKw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VpdtzkIf7aKk9HeWQ6fKN9aeqj3BezufxbBucnCLa2DZIhbRpLAkyUE4+8Fenrt/zin72GpUfaBsOcoct1NpEH6Sj7VarAuy+ihcHadqJTKUV1rj2/ZurDQh+Vg7Xd8nbd6p33dDgU2HcTaIK4nWFDS8eM3aDXjq5JSSZ9HV9xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SOyKa708; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741028806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6641qYUdsFYeagTNYOQyVqmEUsSKT6q5NJTRruz5ExA=;
	b=SOyKa708/qXEEHYLaEIPxOMADHR6nIeouDwp8ZMmqCidvB9lNqz0a2esGvfxnYvzcsSUQ4
	6iQRNX5NMK7Igk3aUiXoisvi4wSPY5l04n5zEA7gkZSmo6SUBmX/+/SqjemF1gD2hJJER1
	RM2nKHnp94+86ROc9CHWMTvvKMO99V0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-53-ZfCEW22BNEuTpvhOvvpw8g-1; Mon,
 03 Mar 2025 14:06:28 -0500
X-MC-Unique: ZfCEW22BNEuTpvhOvvpw8g-1
X-Mimecast-MFC-AGG-ID: ZfCEW22BNEuTpvhOvvpw8g_1741028788
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2C8181944D44
	for <linux-ext4@vger.kernel.org>; Mon,  3 Mar 2025 19:06:28 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.22])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ABE6719560AB
	for <linux-ext4@vger.kernel.org>; Mon,  3 Mar 2025 19:06:27 +0000 (UTC)
Date: Mon, 3 Mar 2025 14:09:05 -0500
From: Brian Foster <bfoster@redhat.com>
To: linux-ext4@vger.kernel.org
Subject: Re: [PATCH] debugfs: byteswap dirsearch dirent buf on big endian
 systems
Message-ID: <Z8X-USvFA-ofGrHQ@bfoster>
References: <20250123135211.575895-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123135211.575895-1-bfoster@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Thu, Jan 23, 2025 at 08:52:11AM -0500, Brian Foster wrote:
> fstests test ext4/048 fails on big endian systems due to broken
> debugfs dirsearch functionality. On an s390x system and 4k block
> size, the dirsearch command seems to hang indefinitely. On the same
> system with a 1k block size, the command fails to locate an existing
> entry and causes the test to fail due to unexpected results.
> 
> The cause of the dirsearch failure is lack of byte swapping of the
> on-disk (little endian) dirent buffer before attempting to iterate
> entries in the given block. This leads to garbage record and name
> length values, for example. To resolve this problem, byte swap the
> directory buffer on big endian systems.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> ---
> 
> Hi all,
> 
> I'm not terribly familiar with this code, but this fixes the test and
> doesn't show any regressions from fstests runs on big or little endian
> systems. Thanks.
> 

Ping... curious if anybody has thoughts on this for dirsearch on big
endian? Thanks!

Brian

> Brian
> 
>  debugfs/htree.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/debugfs/htree.c b/debugfs/htree.c
> index a1008150..4ea8f30b 100644
> --- a/debugfs/htree.c
> +++ b/debugfs/htree.c
> @@ -482,6 +482,12 @@ static int search_dir_block(ext2_filsys fs, blk64_t *blocknr,
>  		return BLOCK_ABORT;
>  	}
>  
> +#ifdef WORDS_BIGENDIAN
> +	errcode = ext2fs_dirent_swab_in(fs, p->buf, 0);
> +	if (errcode)
> +		return BLOCK_ABORT;
> +#endif
> +
>  	while (offset < fs->blocksize) {
>  		dirent = (struct ext2_dir_entry *) (p->buf + offset);
>  		errcode = ext2fs_get_rec_len(fs, dirent, &rec_len);
> -- 
> 2.47.1
> 
> 


