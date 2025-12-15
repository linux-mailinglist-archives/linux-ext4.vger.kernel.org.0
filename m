Return-Path: <linux-ext4+bounces-12360-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 751C3CBC8FB
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Dec 2025 06:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4B6BD300855F
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Dec 2025 05:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCDD324B33;
	Mon, 15 Dec 2025 05:28:12 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C31287505;
	Mon, 15 Dec 2025 05:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765776492; cv=none; b=hXjAbXWtG9AxqHUtPGS/Kn0wpapahD07WYZnsHhkAvvlaM2JdRwWTWCTX4qGPt7n4IEklbR6TBGRT8jMn28HdLqlqlW5RpJ2VgnIv3JFmUQkSZS8pM0gzHhzQQ4BXRZ7hMNIJh4otWrxKIjuffC+bTcovxjR+kWdekyuymP8jDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765776492; c=relaxed/simple;
	bh=cd2xy6i7N2ep2Pl7hOXtMiBKq5+3hzOoTcqACoNTwN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XvRN0d80ihlOLGnzWZNFqt5StN7rNMgtGiJkKBVLpQdaYpq9PIjUimfAr5PMKbug/1l5AmekE0jtvdF25dDg7ZCAB9r0RyuoTj9o0Lu4gufYaoYMWCu9rOdhAMVCP+jfmf6oKnkPzkHKjlDkeEVBcZZ5BVPY/VsbZleob/p3oa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 76A84227A87; Mon, 15 Dec 2025 06:27:56 +0100 (CET)
Date: Mon, 15 Dec 2025 06:27:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Zorro Lang <zlang@kernel.org>,
	Anand Jain <asj@kernel.org>, Filipe Manana <fdmanana@suse.com>,
	fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 02/13] ext4/006: call e2fsck directly
Message-ID: <20251215052756.GA30524@lst.de>
References: <20251212082210.23401-1-hch@lst.de> <20251212082210.23401-3-hch@lst.de> <20251212200246.GE7716@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212200246.GE7716@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Dec 12, 2025 at 12:02:46PM -0800, Darrick J. Wong wrote:
> > diff --git a/tests/ext4/006 b/tests/ext4/006
> > index 2ece22a4bd1e..ab78e79d272d 100755
> > --- a/tests/ext4/006
> > +++ b/tests/ext4/006
> > @@ -44,7 +44,7 @@ repair_scratch() {
> >  	res=$?
> >  	if [ "${res}" -eq 0 ]; then
> >  		echo "++ allegedly fixed, reverify" >> "${FSCK_LOG}"
> > -		_check_scratch_fs -n >> "${FSCK_LOG}" 2>&1
> > +		e2fsck -n "${SCRATCH_DEV}" >> "${FSCK_LOG}" 2>&1
> 
> Minor nit: $E2FSCK_PROG, not e2fsck.

This test harcoded "e2fsck" right above the diff context, so this is just
trying to be consistent.

