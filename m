Return-Path: <linux-ext4+bounces-7175-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E74DEA82A35
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Apr 2025 17:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DD10170CD3
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Apr 2025 15:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C1B266F1A;
	Wed,  9 Apr 2025 15:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jgor3xc9"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1DF266B5B;
	Wed,  9 Apr 2025 15:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744212066; cv=none; b=TGQM7YIMVKpzSMRLFhWUTAUo4bocRe9qRj5pqumhSrvm0lcbb6KA9m3/jKtB24GUYLizqvQI6eau2Aejiqc2FwFCo3PlHM9XF8B+w6Pm6JboqEzPOxhqGIXzndwFdcurUSaSp7cMpc7Kin4//djflHXs+qQD05b8VNUW2/LDaSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744212066; c=relaxed/simple;
	bh=jNROT0ywWLtuqbrPSS5F1bmkNkKl+7e0QLNWYOD/fC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DMZOzS/vKPM9MRzIy3KlQ/ED5/VQME2a/Q/B8xAXaTuJ2GM+ZRGRaB3pdy9Cl1irHfllSe8lebBmISq8Zn1bL+cnWQdBlL8/Cyrj+3pMIFgL7HH3P310yNL5zraPgi9J796hjykscNu2JkNF0Y2F43mNanVhBON79zqZNqjNkys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jgor3xc9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D28C1C4CEE2;
	Wed,  9 Apr 2025 15:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744212064;
	bh=jNROT0ywWLtuqbrPSS5F1bmkNkKl+7e0QLNWYOD/fC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jgor3xc9xwqlATQl6PP4ywBUS3hMjpuAq3e2wiCYRGY1o8t58umCNyvj18D5buwuD
	 0q45Pc1Y/EfKnI++rOg4y9HMebQMKERhqE0KtF9eeuicUW1ADKqzX4vpYHBAAW8Jc/
	 I27YYOLcNTzr5R7DrK+wyYMDElgLU8VHOWfqnozGVCLay37y6/0+WYsDWwDyUrSwrE
	 xYuCpopRiQF4UG80rVLltDTxcfju1W3h5CIRsgl2U5hnll1ZRdreo41nuiytuvOvbA
	 VaAjq2qiZu5woqYZ0b568R0waLDmP/gP0NZDaElwxt1EPsZVe0rlyLDumIeoJPkev9
	 NMJm/NQ6LFlgw==
Date: Wed, 9 Apr 2025 08:21:03 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
	ojaswin@linux.ibm.com, zlang@kernel.org, david@fromorbit.com
Subject: Re: [PATCH v4 2/6] generic/367: Remove redundant sourcing of
 common/config
Message-ID: <20250409152103.GM6283@frogsfrogsfrogs>
References: <cover.1744181682.git.nirjhar.roy.lists@gmail.com>
 <022be73df43379408c355cc18e1a3243f2ee7faf.1744181682.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <022be73df43379408c355cc18e1a3243f2ee7faf.1744181682.git.nirjhar.roy.lists@gmail.com>

On Wed, Apr 09, 2025 at 07:00:48AM +0000, Nirjhar Roy (IBM) wrote:
> common/config will be source by _begin_fstest
> 
> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Reviewed-by: Zorro Lang <zlang@redhat.com>

Yep, confirmed.
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  tests/generic/367 | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tests/generic/367 b/tests/generic/367
> index ed371a02..567db557 100755
> --- a/tests/generic/367
> +++ b/tests/generic/367
> @@ -11,7 +11,6 @@
>  # check if the extsize value and the xflag bit actually got reflected after
>  # setting/re-setting the extsize value.
>  
> -. ./common/config
>  . ./common/filter
>  . ./common/preamble
>  
> -- 
> 2.34.1
> 
> 

