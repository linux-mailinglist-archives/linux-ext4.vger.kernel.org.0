Return-Path: <linux-ext4+bounces-12288-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9BDCB4B50
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Dec 2025 06:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A380E3009ABC
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Dec 2025 05:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CAD28312D;
	Thu, 11 Dec 2025 05:00:14 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA423277013;
	Thu, 11 Dec 2025 05:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765429214; cv=none; b=LTG2Oc0DszjYiroMmaNWi7kw6kgsLa5fwqnLm8i5eWkO3yO4ZUIauyqJaNYBg9UeR89s9dfAI8yVCTksj2dhRjPGPjCGjssfCRDelaVk3xTqq3sFSAuCUALFbfjW03r/od5qsnN8obPg9KlozCRAouwepL+L3dE8NLM7C6PFRbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765429214; c=relaxed/simple;
	bh=Df52MrnJ5ShXHc8s3+kKaf8lAobhtiiDjznj55lw3ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uxl7DxWbwAtdS4OMSPS8UHcf3JgsX8sF+N5nruHYvdUXR499UNFlHuk929H6SOL8mRH9TvudUpS2801MR4W0ZpBa0Kk5rxt1f2mlnNlDOzbcsBpTarlbFahCT4Tt9zC4pkAjvo5t14Afv1LxHcuPZ58Yx8PM3cdxmsPc96d1j1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id F0A62227A87; Thu, 11 Dec 2025 06:00:09 +0100 (CET)
Date: Thu, 11 Dec 2025 06:00:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Zorro Lang <zlang@kernel.org>,
	Anand Jain <anand.jain@oracle.com>,
	Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 07/12] xfs/185: don't use SCRATCH_{,RT}DEV helpers
Message-ID: <20251211050008.GF26257@lst.de>
References: <20251210054831.3469261-1-hch@lst.de> <20251210054831.3469261-8-hch@lst.de> <20251210200248.GG94594@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210200248.GG94594@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Dec 10, 2025 at 12:02:48PM -0800, Darrick J. Wong wrote:
> > -_scratch_mkfs >> $seqres.full
> > -_try_scratch_mount >> $seqres.full || \
> > +$MKFS_XFS_PROG -r rtdev=$rtloop $ddloop  >> $seqres.full
> > +mount -o rtdev=$rtloop $ddloop $SCRATCH_MNT >> $seqres.full || \
> >  	_notrun "mount with injected rt device failed"
> 
> What happens if SCRATCH_LOGDEV is set?  I guess we ignore it, and
> everything is good?  I suppose the logdev configuration isn't really
> relevant here anyway.
> 
> If the answers are 'nothing' and 'yes' then

Yes, this now ignores the SCRATCH_* config entirely.


