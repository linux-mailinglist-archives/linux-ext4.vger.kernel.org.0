Return-Path: <linux-ext4+bounces-1746-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2E688AB24
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Mar 2024 18:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 881B236941E
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Mar 2024 17:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC16A1272A3;
	Mon, 25 Mar 2024 15:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKJvkNes"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58217126F25
	for <linux-ext4@vger.kernel.org>; Mon, 25 Mar 2024 15:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711382151; cv=none; b=P0hHKviC/7tY6AN6KSN0vt8wIkO5VeVDiKdIwgqJYrDo3pxMUWvL//eR8kip14UfNDWduqjL1nDC+1mtruaL5IvF0bJvPRAqttULK4pi5UBhV03weUQoqgjYqvptPSzHqJnb/YEGGjnvcjMrLOzqUtjvpe7bykRMTxQIzqsgocY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711382151; c=relaxed/simple;
	bh=Di3Pdf74VoDBEyDw3dlc4sEprYzM7gWQMvKE3j/9kg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KtJ4oo+hsucctBdbJHQPX7HyIrgqF4Dqs3n9ktB9Az+04zPHwfSEhLoa1LcTz6tVH2q9f66g3N1oVPTtzKwe2cXzrWYn8TPPyDNP6+q3Dck+UK/Z6Qk+wD0GhgeqKTa2hIdIFaEmEQAip03SPw3o3uVta/y/Girjril6XWCAj5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKJvkNes; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E41A0C433F1;
	Mon, 25 Mar 2024 15:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711382151;
	bh=Di3Pdf74VoDBEyDw3dlc4sEprYzM7gWQMvKE3j/9kg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DKJvkNesCELxY16jhSca10Rcuzzf5NXiELY3af/RylbdZ7GZgiwvJsRtcWRxKPFDw
	 3Sa3HgZsysJ0Qgj2hQ7aOHva5hef3V0lAKMf3wXumnvmqyX97SNgwGU742KoQKkcQs
	 dV9KywlStznVVyWb/rhIYLMG1f/O0bmaTLegmSw+sC8Jkh016A6bpHECn8nZr/ERDc
	 BN9OYJUmB9jz8wcY6AxfSMz1i1WdaSrz7+PlwgyIffnvxWA2lEXirZnd6blfntXHNA
	 UOGRWzpZfDV3VXQaFFJ/Dwd7kq3TDFtCulUF3BVYXvwEav+NTVD4Fq1zBAOmzZduY6
	 I+hkJ6EXR2eEw==
Date: Mon, 25 Mar 2024 08:55:50 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Srivathsa Dara <srivathsa.d.dara@oracle.com>
Cc: linux-ext4@vger.kernel.org, adilger@dilger.ca,
	rajesh.sivaramasubramaniom@oracle.com, junxiao.bi@oracle.com
Subject: Re: [PATCH v2] e2fsprogs: misc/mke2fs.8.in: Correct valid
 cluster-size values
Message-ID: <20240325155550.GA6371@frogsfrogsfrogs>
References: <20240325103621.1266289-1-srivathsa.d.dara@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325103621.1266289-1-srivathsa.d.dara@oracle.com>

On Mon, Mar 25, 2024 at 10:36:21AM +0000, Srivathsa Dara wrote:
> According to the mke2fs man page, the supported cluster-size values
> for an ext4 filesystem are 2048 to 256M bytes. However, this is not
> the case.
> 
> When mkfs is run to create a filesystem with following specifications:
> * 1k blocksize and cluster-size greater than 32M
> * 2k blocksize and cluster-size greater than 64M
> * 4k blocksize and cluster-size greater than 128M
> mkfs fails with "Invalid argument passed to ext2 library while trying
> to create journal" error. In general, when the cluster-size to blocksize
> ratio is greater than 32k, mkfs fails with this error.
> 
> Went through the code and found out that the function
> `ext2fs_new_range()` is the source of this error. This is because when
> the cluster-size to blocksize ratio exceeds 32k, the length argument
> to the function `ext2fs_new_range()` results in 0. Hence, the error.
> 
> This patch corrects the valid cluster-size values.
> ---
>  misc/mke2fs.8.in | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/misc/mke2fs.8.in b/misc/mke2fs.8.in
> index 30f97bb5..8194cc41 100644
> --- a/misc/mke2fs.8.in
> +++ b/misc/mke2fs.8.in
> @@ -232,9 +232,9 @@ test is used instead of a fast read-only test.
>  .TP
>  .B \-C " cluster-size"
>  Specify the size of cluster in bytes for file systems using the bigalloc
> -feature.  Valid cluster-size values are from 2048 to 256M bytes per
> -cluster.  This can only be specified if the bigalloc feature is
> -enabled.  (See the
> +feature.  Valid cluster-size values range from 2 to 32768 times the
> +filesystem blocksize per cluster.  This can only be specified if the

I think it's redundant to say cluster twice in this sentence:

"The cluster size must be a power of two between 2 and 32768 times the
filesystem block size."

It's also worth mentioning that mkfs rounds the parameter down to the
nearest power of two, e.g. "-C 20k" gets you a 16k cluster size.

--D

> +bigalloc feature is enabled.  (See the
>  .B ext4 (5)
>  man page for more details about bigalloc.)   The default cluster size if
>  bigalloc is enabled is 16 times the block size.
> -- 
> 2.39.3
> 
> 

