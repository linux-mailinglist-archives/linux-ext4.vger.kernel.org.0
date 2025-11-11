Return-Path: <linux-ext4+bounces-11757-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F0FC4CADB
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Nov 2025 10:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4146D4F3B83
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Nov 2025 09:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25C22EDD69;
	Tue, 11 Nov 2025 09:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NAyRmNsj"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9ED1E7C23;
	Tue, 11 Nov 2025 09:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762853399; cv=none; b=U1sSg5kotPQk6KeSVdW/ZkLraGFJIHDoccgl2mooKQVeAJwmEppvuXt6vQ/tm3sz/+11PAFbIYW+mnrHYlJHki5xjMMVZ4KDvt5QBVwVUOm1BtPNlf6i0AThouXXChInNblZSO8VzC5GjrfVu5uc4ZXZu3K/TOlW8NLutix+jQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762853399; c=relaxed/simple;
	bh=kaLucZEJ4YS1HPett39SZpYnsQ4TXu9CRYgVRxQfXSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+eadCTOWHJK7YyHcbpcxxR1knUWHmWBS8Wj919kELJjqAqE/Tv9TajsFBbfQtguRv7iS1GcUOB04/NeYjOCJwKHmX8cALOX1An1twS6Sj305mKObethEuD/jlgs9zX3jDHGaaANds2EJ0RZWDKOg3+VqgJMdkIr0xgIEKqc1Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NAyRmNsj; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KOGX5U0hIAV8DLXo2ghwwdTEcIHxrAEQiaVG4VywUq0=; b=NAyRmNsjZkRkIWiWoC71wwR339
	8aZgDfavsFm/PpXTrxT4xxEaZvErUrMZZkXuAjFOjJ3FPrZvf337Q5d5Cavz2QmzslqrqcpnMBqY6
	crOhAwCRpVV/Vc1L9hCyRPzzzlBFhrMdd/AfwI7seYEBKToO7Iud6FxUfe6pmiogHRvWDYEaZXntB
	sfzMoPfDa1JHxg7dB0PEVD0wKcMdfBtI0PlLjwmNyZPPJ4lz7DXEzt/dO7ParMSKFVNhfT3CmlEsE
	I70ztMaBa35J/uA/7MHEiOB2CUlzpdyxY/oYujvwXS/DR7dTGOTySHwdLWfsd8dLjbnr0rOVYBUmD
	g5eSkn6Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIkhJ-00000006qU3-2XKW;
	Tue, 11 Nov 2025 09:29:57 +0000
Date: Tue, 11 Nov 2025 01:29:57 -0800
From: Christoph Hellwig <hch@infradead.org>
To: John Garry <john.g.garry@oracle.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, zlang@redhat.com,
	fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 6/7] generic/774: reduce file size
Message-ID: <aRMCFb73LbsCagid@infradead.org>
References: <176279908967.605950.2192923313361120314.stgit@frogsfrogsfrogs>
 <176279909116.605950.12144124358096086284.stgit@frogsfrogsfrogs>
 <fce01b4e-928a-48c8-afe2-265e5893c6cf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fce01b4e-928a-48c8-afe2-265e5893c6cf@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Nov 11, 2025 at 09:13:27AM +0000, John Garry wrote:
> On 10/11/2025 18:27, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > We've gotten complaints about this test taking hours to run and
> > producing stall warning on test VMs with a large number of cpu cores.  I
> > think this is due to the maximum atomic write unit being very large on
> > XFS where we can fall back to a software-based out of place write
> > implementation.
> > 
> > On the victim machine, the atomic write max is 4MB and there are 24
> > CPUs.  As a result, aw_bsize to be 1MB, so the file size is
> > 1MB * 24 * 2 * 100 == 4.8GB.  I set up a test machine with fast storage
> > and 24 CPUs, and the atomic writes poked along at 25MB/s and the total
> > runtime was 300s.  On spinning rust those stats will be much worse.
> > 
> > Let's try backing the file size off by 10x and see if that eases the
> > complaints.
> > 
> 
> The awu max for xfs is still unbounded (so the file size could still be
> huge). For ext4, it is limited by HW constraints - the largest HW awu max I
> heard about is 256KB. How about also limiting awu max to something sane,
> like 1MB?

Sounds fine to ne, as long as we document it as an arbitrary limit.


