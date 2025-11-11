Return-Path: <linux-ext4+bounces-11758-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB92C4CB2C
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Nov 2025 10:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B6113B3151
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Nov 2025 09:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0EF2F2618;
	Tue, 11 Nov 2025 09:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0uoosa4p"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385462F12D9;
	Tue, 11 Nov 2025 09:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762853468; cv=none; b=ku1GYL3uepYG/bmLVU56N5vA/rYC5ElWatAVmHAcXRLwXAK/KhvMZ7m7My8JkMXjlTgbF04D2UrHZlK8p5dp+KEWlYvJOYRyd2kQ6LJ8zIfzKK+NIEEi5B+PVr0NF82WAaVHhBZ68dicMu/ZhUSaLM0h7Yc/vrn7+maRpKQRKzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762853468; c=relaxed/simple;
	bh=z8TX5Xe+eJCIcMaotStXwwsEAEmt0MhULkk7hKf3FEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGI6v6jgNfFo7UhfD7dcvTGQkA2tUSXtOWHaIZBqbxE42JaR4BNBYkQzK4OKpWzOJBfaneC6KzabtF70ZzfeahXOSQhJv9ohhOZCeICek9DMLc6/V1b535cT8jZNGepRcbh+vBhKcBrpLkeIeXVF272/XQR7qiuRjohvgeC7kzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0uoosa4p; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0JcAVWIQ1/FQB9GWlWkASRhBLDmO04aYfyJ4ItSBp7E=; b=0uoosa4pgwKcChNw6rzwzIdxvk
	lhXJt1L4w+u6GHg8OYYAkYcKNL05ku6KRC0LYkQQYWvIhtekOwgbQJN1QTNTkAuzT9+hlfG8RRLpl
	xY/X9C2jtWCIALLQKMBTzDjyAmGIvhe5+E10EIBvBKRo8MJaUD2973EO75Gp81Aq88UsLl1xE/cCG
	nhpRIctA5iO/UW9C/ISRjVoMTNCB4rC9v90I2DwxJQNvdiV2UCAOiYzo5XHEuhB+qO45EfHQz0Dpq
	dC52Dq58BkAHxVPWa8FYizKEcJ/l/1UwhMsdC6Er8meX/hhYxCeA3XOsSSRKpjd30Kv+7yRwpYm5C
	jdHrDcSw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIkiQ-00000006qmu-3y1I;
	Tue, 11 Nov 2025 09:31:06 +0000
Date: Tue, 11 Nov 2025 01:31:06 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 6/7] generic/774: reduce file size
Message-ID: <aRMCWr2UHlc2FawQ@infradead.org>
References: <176279908967.605950.2192923313361120314.stgit@frogsfrogsfrogs>
 <176279909116.605950.12144124358096086284.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176279909116.605950.12144124358096086284.stgit@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Nov 10, 2025 at 10:27:35AM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> We've gotten complaints about this test taking hours to run and
> producing stall warning on test VMs with a large number of cpu cores.  I

Btw, we should still find a way to avoid stalls for anything a user
can easily trigger, independent of fixing the test case.  What were
these stall warnings?

The patch looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

