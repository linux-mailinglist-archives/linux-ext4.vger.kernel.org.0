Return-Path: <linux-ext4+bounces-6267-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2ABDA2175A
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Jan 2025 06:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 224BA1667A8
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Jan 2025 05:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A392419006F;
	Wed, 29 Jan 2025 05:26:18 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAAF18E75A;
	Wed, 29 Jan 2025 05:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738128378; cv=none; b=Ucwo+64EgYvNWBdzSjtS051Q7g4gYDXs+7ylsO/ZG9R1MRqewfXRJyyNBoxN8b3rLyeOfqTAD+3pxp5WZinPiaFDRx6R+9DUP+acyrYcv65EiJS0T+KWamQztQ4jn6Sh7tKesm7vcjt8uB2MXIfBD32l2op8CpfPSh6yM/iUqnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738128378; c=relaxed/simple;
	bh=A0Oi6U04Nvm7iOLjptkA993U5ehMVsYAR38kzg9jSHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NSgVASKRQGtr8k56jA4TPQO0qsXa6lz4b52u4YGyOYv6ngh0OXD8+Xs/GnI6FKADD7wdGcZRh82SkkCLbQl2d+zURdXZ7jCvshcYpWN3L8K1dxEFP3EreqHYVNADsuHodv9f3dgGYK9AIA149ZW4Pk2Ie2DAcTS1HWRfHrFWJZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D373268D13; Wed, 29 Jan 2025 06:26:10 +0100 (CET)
Date: Wed, 29 Jan 2025 06:26:10 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Zorro Lang <zlang@kernel.org>,
	Brian Foster <bfoster@redhat.com>, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/3] generic/363: remove _supported_fs xfs
Message-ID: <20250129052610.GA28665@lst.de>
References: <20250128071315.676272-1-hch@lst.de> <20250128071315.676272-2-hch@lst.de> <20250128191706.GQ3557695@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128191706.GQ3557695@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jan 28, 2025 at 11:17:06AM -0800, Darrick J. Wong wrote:
> On Tue, Jan 28, 2025 at 08:12:58AM +0100, Christoph Hellwig wrote:
> > Run this test for all file systems.  Just because they are broken doesn't
> > mean that zeroing should not be tested.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Reviewed-by: Brian Foster <bfoster@redhat.com>
> 
> /me notes that this fails on btrfs, though it seems ext4 is ok.....

Well, we should not skip tests because they fail, the point is to show
something is broken..


