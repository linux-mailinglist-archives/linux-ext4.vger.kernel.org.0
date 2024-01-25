Return-Path: <linux-ext4+bounces-912-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C1683B7A8
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jan 2024 04:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E83171C24613
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jan 2024 03:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8892D6FBE;
	Thu, 25 Jan 2024 03:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jqJ93DjM"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE6763B1;
	Thu, 25 Jan 2024 03:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706152431; cv=none; b=BqCfo+5lOoQd5klTVcqspUD6Ff63DDPphH42Z0pxsQDaWvbB7oZhOU/5kdfxS+ldGEAqKpisTQErpb1uIH+fvVZMRe14TGbmA6A3FbzvE6W2TH2IZb6IlIxpXDjr5dTTFDT9uXn99gmdQQFfll24mmz7jtBAB8P3DNUurAvwn+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706152431; c=relaxed/simple;
	bh=paUTc/9FphzBCnZcrDM9ZvQCJpksDKQ6ilRoRSSSBGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UY/98bFYZBVNtGUb45Z3WwNb1q3XMRWF5+1R/91InkdW28P2PfuvwkX2rfdc7zfUmvuj+oQNIqabFbe/OWq//ebpb4L0SCxvTMX92fZj8uzrSrkoj+lrqCSCw2wqkynxbe5LWXrpsGXGvOfM1bKFICjifVK38C8K8dc6kQYyOl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jqJ93DjM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF53C433F1;
	Thu, 25 Jan 2024 03:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706152430;
	bh=paUTc/9FphzBCnZcrDM9ZvQCJpksDKQ6ilRoRSSSBGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jqJ93DjMTJySl66BliexsxEn/cZmYh2Sq/3oICmTkLpcuXAwNpUL8rx47nSZpqWZz
	 nMH32OKwLGL9JMNLOIbefpSxDitfEGGAGEP5KiiYGSXkoKJiqv1uubsLTXSdclSXVk
	 08PswQwrmp+VCmafQ4uqKd0t/9un/Zc/8unK1G5vsmqAV8UoVfNJc87KbXgOer/Vun
	 tiHLE4BMUn87epXKgtFO0UczuOWSku2paqYn2nYfhkF5wfNyawWbaxRxrTBOx6gSE2
	 UR2llNSua5G19KaITc4yNZxQh02F99Ny1flJtjf4fxqMgDPiSRphNziHQ073LX4WTj
	 /pIBoxyct6MtQ==
Date: Wed, 24 Jan 2024 19:13:48 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: viro@zeniv.linux.org.uk, jaegeuk@kernel.org, tytso@mit.edu,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, amir73il@gmail.com
Subject: Re: [PATCH v3 06/10] libfs: Add helper to choose dentry operations
 at mount
Message-ID: <20240125031348.GD52073@sol.localdomain>
References: <20240119184742.31088-1-krisman@suse.de>
 <20240119184742.31088-7-krisman@suse.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119184742.31088-7-krisman@suse.de>

On Fri, Jan 19, 2024 at 03:47:38PM -0300, Gabriel Krisman Bertazi wrote:
> +/**
> + * generic_set_sb_d_ops - helper for choosing the set of
> + * filesystem-wide dentry operations for the enabled features
> + * @sb: superblock to be configured
> + *
> + * Filesystems supporting casefolding and/or fscrypt can call this
> + * helper at mount-time to configure sb->s_d_root to best set of dentry

s_d_op, not s_d_root.

- Eric

