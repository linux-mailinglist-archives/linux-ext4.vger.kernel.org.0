Return-Path: <linux-ext4+bounces-4007-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8651D969171
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Sep 2024 04:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8A2D1C228CF
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Sep 2024 02:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D4A1CDA19;
	Tue,  3 Sep 2024 02:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Pq+oxpwE"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1501C43156
	for <linux-ext4@vger.kernel.org>; Tue,  3 Sep 2024 02:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725330580; cv=none; b=fe4+74NQzcEaCT67C185AOVbnGotGpG0HRjhrltch0+ye//6LFnfjTzWzsp5FZT34xcvBCrxPGUgN89fEXSPOUb62CXq2EpJVvmdRwWmMJoWA9Prs3KrQJ0OqQV7FtfjWzvchm5GQ1NhUmOlisExawST1CzvNcVKHNICgBxOLzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725330580; c=relaxed/simple;
	bh=0ApxJd+RU8PA+dLnmn7VPvgJs4YfdR2HY5d6tUj+Se8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a27lYk2Qv6wKCmTVdhMb924QGpcPGMLqjwXsTJjLmqGZIAsnhxWUgwkptQGQQj35hVTVLiId51uhgdom4PHrw/rH93P1ez6i0rNtI4qIeyrc9YwWQNp26K0c56NAR/xEBYHKLeaGeO2gyl/iXH83X70RIKrI9/okM06SzmPRsXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Pq+oxpwE; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-112-93.bstnma.fios.verizon.net [173.48.112.93])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4832T3h7012080
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 2 Sep 2024 22:29:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1725330547; bh=5gGppsPkg9B+A5bJqi2mrS/omhc43hirzEp0aJT7iFM=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=Pq+oxpwEw3KXFUdm/coi7wcIyjfh8fgNzoh6HL2121zcJu26Y05SYlIfqL4lWB+HG
	 yhj2ipCFNYA6WWuDemyefpHVhgbTrfn16TV0IUG/29IFKydtNpeRI7JLMjDcHHIG7b
	 QKA/68VeWvQMluvZhdArlG/ox6Grr5/AxL3ipCxH5al6kVrOt+SkVgMlqYGul5+w3u
	 wKm11GLpq/NCfpvgcEncK5ly3Me87u875dNxDhzU02EystI8SF37IsvzVxlRG5PVQO
	 wIc5E9sDh3tdBgVT6FPXKIsfhKxwIjgnM9fIBmPVdPjWxYdlVaI0eTw0cIFtEG9TJM
	 bA2p/upTKAVyw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 03DBF15C02C4; Mon, 02 Sep 2024 22:29:02 -0400 (EDT)
Date: Mon, 2 Sep 2024 22:29:02 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, steve.kang@unisoc.com
Subject: Re: [RFC PATCHv2 1/1] fs: ext4: Don't use CMA for buffer_head
Message-ID: <20240903022902.GP9627@mit.edu>
References: <20240823082237.713543-1-zhaoyang.huang@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823082237.713543-1-zhaoyang.huang@unisoc.com>

On Fri, Aug 23, 2024 at 04:22:37PM +0800, zhaoyang.huang wrote:
>  
> +#ifndef CONFIG_CMA
>  	bh = sb_getblk(inode->i_sb, map.m_pblk);
> +#else
> +	bh = sb_getblk_gfp(inode->i_sb, map.m_pblk, 0);
> +#endif

So all of these patches to try to work around your issue with CMA are
a bit ugly.  But passing in a GFP mask of zero is definitely not the
right way to go about thing, since there might be certain GFP masks
that are required by a particular block device.  What I think you are
trying to do is to avoid setting the __GFP_MOVEABLE flag.  So in that
case, in the CMA path something like this is what you want:

	bh = getblk_unmoveable(sb->s_bdev, map.m_pblk, sb->s_blocksize);

I'd also sugest only trying to use this is the file system has
journaling enabled.  If the file system is an ext2 file system without
a journal, there's no reason avoid using the CMA region --- and I
assume the reason why the buffer cache is trying to use the moveable
flag is because the amount of non-CMA memory might be a precious
resource in some systems.

				- Ted

