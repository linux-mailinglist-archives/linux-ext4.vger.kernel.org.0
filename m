Return-Path: <linux-ext4+bounces-8778-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C108FAF5CB6
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Jul 2025 17:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9419F1C25C7B
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Jul 2025 15:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48CE2D46BE;
	Wed,  2 Jul 2025 15:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMRWqzrR"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BEE2F0E34
	for <linux-ext4@vger.kernel.org>; Wed,  2 Jul 2025 15:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751469584; cv=none; b=sQHUDuxXPjLDggcfbfuSHYT+YrFEtMQNQQYFXJMxIrxOnu8GOI/kXlfZlLUZ8W8cBI1u3QYwWMepbV/3ctUgt05FeP3ktdOROH6+8xLA0z8GpAvtUIwX0sZR3eBo4CdxpbWZzVzHJk7JRBGJoq4DafNjEC0MEO/F/+MRo6eiraE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751469584; c=relaxed/simple;
	bh=6EYuk+3hQ75FYmMtaLJuy7H/MjBmmjE4aIqp3xSk8cM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z8QQcr9s5eg7dPsZB4DidjOXsD1r1h+t+yJjMlYl4iUZmd+i5lrzP4gTe0B61zglPdeFgXwFGZt1wWBHX0Wl7u0Cdm7jpJ7PvVATxxnXmzYofi35x7iBq2rExxEBf9a9nKEmphBJQTg0cBuWJGj5veVkxspca8XqEbPkVtMI/Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMRWqzrR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7671C4CEEF;
	Wed,  2 Jul 2025 15:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751469583;
	bh=6EYuk+3hQ75FYmMtaLJuy7H/MjBmmjE4aIqp3xSk8cM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GMRWqzrR8WZMo8trQIzNuE18AWwl24hBT1kiu67jqa3wzMkbemVbfckbJkuTXVWHy
	 WUckgdp8vEE5FzM6hg0GmXfyYnOHD5lf3tYBE6F4itYCz8a9Rx70KojAWoyaSsg67r
	 RZbYtfqcZfiZPtIT7/l9LrKZZ/u+MffeqVo5X5IlymCw/Y+S9O6nVGI+HG8DvcrOe6
	 OJMSt37t/bPi+D0y8G9P8jv0m7l2Was0wjo/R4TrTO0P067xTgolS6J7k/+rKr0utQ
	 Xewh4Cxs1xI6P/OEBjY6OIoNvnq+zheAsnTFqS8xcSpxR7uXpp9rSCiH+2nbINPWHy
	 o/Bqw6HY1FqTg==
Date: Wed, 2 Jul 2025 08:19:43 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 2/2] fuse2fs.1: fix formatting of newly added options in
 the man page
Message-ID: <20250702151943.GL9987@frogsfrogsfrogs>
References: <20250702035044.47373-1-tytso@mit.edu>
 <20250702035044.47373-2-tytso@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702035044.47373-2-tytso@mit.edu>

On Tue, Jul 01, 2025 at 11:50:44PM -0400, Theodore Ts'o wrote:
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  misc/fuse2fs.1.in | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/misc/fuse2fs.1.in b/misc/fuse2fs.1.in
> index d485ccbdc..21f576074 100644
> --- a/misc/fuse2fs.1.in
> +++ b/misc/fuse2fs.1.in
> @@ -54,7 +54,7 @@ do not replay the journal and mount the file system read-only
>  \fB-o\fR fuse2fs_debug
>  enable fuse2fs debugging
>  .TP
> -.BR -o kernel
> +\fB-o\fR kernel
>  Behave more like the kernel ext4 driver in the following ways:
>  Allows processes owned by other users to access the filesystem.
>  Uses the kernel's permissions checking logic instead of fuse2fs's.
> @@ -63,10 +63,10 @@ Note that these options can still be overridden (e.g.
>  .I nosuid
>  ) later.
>  .TP
> -.BR -o direct
> +\fB-o\fR direct
>  Use O_DIRECT to access the block device.
>  .TP
> -.BR -o cache_size
> +\fB-o\fR cache_size
>  Set the disk cache size to this quantity.
>  The quantity may contain the suffixes k, m, or g.
>  By default, the size is 32MB.
> -- 
> 2.47.2
> 
> 

