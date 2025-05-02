Return-Path: <linux-ext4+bounces-7632-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDFFAA7AF7
	for <lists+linux-ext4@lfdr.de>; Fri,  2 May 2025 22:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C85857B2CB9
	for <lists+linux-ext4@lfdr.de>; Fri,  2 May 2025 20:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A191FFC7E;
	Fri,  2 May 2025 20:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WkmRyO9T"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638301F585B
	for <linux-ext4@vger.kernel.org>; Fri,  2 May 2025 20:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746218263; cv=none; b=u2JjPagWY47J5IcwVolK9cUSyNOTji2p1h1HwOWqnTL0mvwzeWIJ08zCiQ6QSKqbupO/w+d+w4xKZV5NfeHTwqfi1kEmUBdh40oy80IxyKRPu1/j0V8/2l8j3fIym5J1eXrbnKuFA9G7PWhfmfX6ue7xmQ2iVMPM8g5FIuJj5n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746218263; c=relaxed/simple;
	bh=ngMOIR/wfNIkvALgdyi3RASMHRKBvpXouxmBnz+Cu5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xn3l9v7D2m/ePgD1IzWR1ohdv8Ut1mBssvLYhtbTJc/zOc7FaHRwldTzzZPhxHRoNWxxbB4BrnyCihOsdkdNcnm8YhbAvsJmePZMPmvtZYv6LNoWuIBSRiK+IB/Rvh10J3xPKSGM8P1MT1KH1fQmpq/jaSHtoZj3gCWhLa7X4Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WkmRyO9T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CB51C4CEE9;
	Fri,  2 May 2025 20:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746218263;
	bh=ngMOIR/wfNIkvALgdyi3RASMHRKBvpXouxmBnz+Cu5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WkmRyO9TU6ZA9Mu4xPzxi+yBlmlIc92gxuOXS7Y7my6tIC+S40f+wK7aiblFfynz2
	 XOd7+QoWYREYnPv0tmQgB9ipTRqVRSOJQaS07NuNKXBHIhvU7uctyFQJKvn0BLK6A6
	 J7rmhgrLazm78BH52i0qvQan7YHMejtVvZQkQ6+TfxR9MdSkeBNuhlS2mYzoUvMfyv
	 Jp7zkQq0+4aIkc+4uL1fiNsA3KGkD39lCdU1TC3RTsd6VjsBhSF6Chom1mfKiOtDUo
	 0QgSBQUymRuTio5V5Pag1R5ExiSMQi6Q4sdG+253bRmJ6mdVU3cHNXfcpNfP2z3YLM
	 njo6Mcws9sWeQ==
Date: Fri, 2 May 2025 13:37:42 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Nicolas Bretz <bretznic@gmail.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz,
	adilger.kernel@dilger.ca
Subject: Re: [PATCH] ext4: added missing kfree
Message-ID: <20250502203742.GF25655@frogsfrogsfrogs>
References: <20250502174012.18597-1-bretznic@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502174012.18597-1-bretznic@gmail.com>

On Fri, May 02, 2025 at 10:40:12AM -0700, Nicolas Bretz wrote:
> Added one missing kfree to fsmap.c
> 
> Signed-off-by: Nicolas Bretz <bretznic@gmail.com>
> ---
>  fs/ext4/fsmap.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/ext4/fsmap.c b/fs/ext4/fsmap.c
> index b232c2767534..d41210abea0c 100644
> --- a/fs/ext4/fsmap.c
> +++ b/fs/ext4/fsmap.c
> @@ -304,6 +304,7 @@ static inline int ext4_getfsmap_fill(struct list_head *meta_list,
>  	fsm->fmr_length = len;
>  	list_add_tail(&fsm->fmr_list, meta_list);
>  
> +	kfree(fsm);

OI: UAF, NAK.

--D

>  	return 0;
>  }
>  
> -- 
> 2.43.0
> 
> 

