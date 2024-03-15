Return-Path: <linux-ext4+bounces-1664-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7EF87D167
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Mar 2024 17:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C29DB23012
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Mar 2024 16:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE66846444;
	Fri, 15 Mar 2024 16:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Y8Wtl+d1"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB7E4CE09
	for <linux-ext4@vger.kernel.org>; Fri, 15 Mar 2024 16:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710521190; cv=none; b=efCF98hjTXZHeLOUgjpSLNSex8K238tE/kTbXUL19QrsNg0jJ1oCE+MlrNd5Nza2kj3WYH8NJgMfrebvWnk5nVmxzJiI/13bbJHBJ8xLNR8xalsshvdHTZ+/u4FmiXh0g2tAGfkrBP9pt/OfK6IuOoG0uf4Qp5hquv2HjoWSw+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710521190; c=relaxed/simple;
	bh=7r/guup6gq63ysvWIpmrTJ2Z/ZX0MkaNzjep6pE6Cv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dTqkyEeelqzkhN2FCc9/IiovuIY4pVUIPTEU9caRPvuZTl2GAhwjX9QJXSYREc6LcoJItBvuyx+PpsKLJbHd7218gcPj6JR235dV/htHI8WMbcf+Two0tZ9+PXLsWjf/UvaZV1LdfObf9NJjyI97ECSikqBufkSyG7XnyMQ3baU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Y8Wtl+d1; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-116-252.bstnma.fios.verizon.net [173.48.116.252])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 42FGjppu026032
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Mar 2024 12:45:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1710521153; bh=PJckWANlFb0272VsNdOUMV4l5mzBM543zgeS+z8pMNY=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=Y8Wtl+d1zafwyh9EK+nl0WIQlt+a5zDPXzWmrGBUgQ/y784PbkKcfhtSqnNIdVAsk
	 qyimJ1lh6zbuIA/GualkF+BLBvnzINI5OWBabz+fL1MidCcscO8Pkw5F3gc1Yx0q/5
	 NhsQZ+k0DcQX/p/IYi6nyyLrgxDSlXDf6Df4Y3GOHiL9bPe2WlvLjQp1aJ1iTSjJd8
	 c4LQNNc6Siw+19fx9/Bde3bhmOdGsYncaB28KvPAUx14RVKXoNmuDRm8iSjtc97c82
	 Pn5wgLmCrTxtNV6g/vqbkrDWDVi80azXTmhT0oylrjl6eSZk5X9QGkSArEiRvdnZzN
	 e9XBY+kvUK1Mw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id D6AA515C0C93; Fri, 15 Mar 2024 12:45:50 -0400 (EDT)
Date: Fri, 15 Mar 2024 12:45:50 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 3/3] ext4: Add support for FS_IOC_GETFSSYSFSPATH
Message-ID: <20240315164550.GD324770@mit.edu>
References: <20240315035308.3563511-1-kent.overstreet@linux.dev>
 <20240315035308.3563511-4-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315035308.3563511-4-kent.overstreet@linux.dev>

On Thu, Mar 14, 2024 at 11:53:02PM -0400, Kent Overstreet wrote:
> the new sysfs path ioctl lets us get the /sys/fs/ path for a given
> filesystem in a fs agnostic way, potentially nudging us towards
> standarizing some of our reporting.
> 
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -5346,6 +5346,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  	sb->s_quota_types = QTYPE_MASK_USR | QTYPE_MASK_GRP | QTYPE_MASK_PRJ;
>  #endif
>  	super_set_uuid(sb, es->s_uuid, sizeof(es->s_uuid));
> +	super_set_sysfs_name_bdev(sb);

Should we perhaps be hoisting this call up to the VFS layer, so that
all file systems would benefit?

					- Ted

