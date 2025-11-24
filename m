Return-Path: <linux-ext4+bounces-12025-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F2BC824AE
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Nov 2025 20:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 00B124E8CD0
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Nov 2025 19:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8005F2D94AB;
	Mon, 24 Nov 2025 19:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a8a9BFrp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8912D94A1;
	Mon, 24 Nov 2025 19:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764012021; cv=none; b=Iy4rL3AU2KG0OkJhAzjqPfqNqr10kDGrUHQTgv8m5b20zyLh/kW0svwM/tFiMKJQhuQDmKJvD6qFtLWJfz97VC+aJ2e2+9NuzAWfl3zFpSGh6+8T0uyX5vZuuHXz29ev9kpVVtcI6qlo10d8r+v6C6kYWpyz7QTvKow9PH1DFY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764012021; c=relaxed/simple;
	bh=f/4aZMWxPlAyIiHj6MThjV7JghxDz7OC0FQ3b1flVJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dcVesBffiFQlWxsN/uwKo/6JDxsnpLnh9+eRHfa36sg9e7Z68NkodBYRmYX5dy9c0+VoGFLSDUKdQzHaVoiVCYPP66JnM6ZkySjR32hJwXzy42J2Es63+qb6NWeX5Idv70gGRK3GItJyGpasesY++uS7cKHNb45SYFwmkjXDfU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=a8a9BFrp; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fwyBdQ8S3hBpJzyG7dUQUraaJtfMXjgG926lfpSXbdg=; b=a8a9BFrpFPXFUM2WUbySkshtR1
	aecylyHZS2IK1wa9T4dHbVkA8NNbZkwFKYTJCUJO0CIpKECnlzxB/nhFwpp8dSf6Hw/UY7z3CRAtG
	LETfvdIda5jF90hgYRRXWT+6nmJDIarY5NGNt1jJtg+0cQPuPPhaFufgbeIDqQPvTdy6ocdkbwy9y
	RV+bFZNtSwCZ5mXNjAVppf9PPRcAv5+4JKKMkT/avvGRFgj2OnB1yNjw2dxSbzZmtAwwnfKjhdzKi
	1rJoUy/d6lqxiKhEyAZpzeGngd8Mw6bmNFL1QCdjnZXrguevBiW1D19SK0zx/NOmOF5yjtvZCUR6x
	G6Dpar7A==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNc6j-00000007PuN-07JX;
	Mon, 24 Nov 2025 19:20:17 +0000
Date: Mon, 24 Nov 2025 19:20:16 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Theodore Tso <tytso@mit.edu>
Cc: linux-mm@kvack.org, Ext4 Developers List <linux-ext4@vger.kernel.org>,
	linux-xfs@vger.kernel.org
Subject: Re: [REGRESSION] generic/127 failure caused by "mm: Use
 folio_next_pos()"
Message-ID: <aSSv8F_5QYHdqJaT@casper.infradead.org>
References: <20251124191811.GA26781@mac.lan>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124191811.GA26781@mac.lan>

On Mon, Nov 24, 2025 at 01:18:11PM -0600, Theodore Tso wrote:
> And then when I reverted commit 60a70e61430b, the test passed.  I also
> checked and found that this commit was also causing generic/127 to
> fail for xfs:
> 
> kvm-xfstests -c xfs/4k generic/127 --fail-loop-count 0 --kernel-build
> 
> And, with the commit reverted the problem went away.
> 
> The test logs for ext4 and xfs are attached.  Willy, could you take a
> look?  Many thanks!!

https://lore.kernel.org/linux-fsdevel/20251123220518.1447261-1-willy@infradead.org/

