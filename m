Return-Path: <linux-ext4+bounces-10963-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EED2BEBFEE
	for <lists+linux-ext4@lfdr.de>; Sat, 18 Oct 2025 01:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3140919C715A
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Oct 2025 23:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C1627510E;
	Fri, 17 Oct 2025 23:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6uIEvzv"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F6D2494F0
	for <linux-ext4@vger.kernel.org>; Fri, 17 Oct 2025 23:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760743731; cv=none; b=Q62nYxJI72J8quS4Kb9Po26rJZPEO28g3c70iFttsRgcTNlQKxxSfVBBJgAPWPSDtMzlJoDzUAOS/znwdi9D3/EEkpOU6JNJH77BM3YHXkM6BcqN/p/QtSfskAuOy1dpKOKNqfFhGWfh3YKYoeLIwf+9HpxpWaORvRvAsXgdvBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760743731; c=relaxed/simple;
	bh=p8+FQTe/o47LLiv3XKi3UAEg9kuHIjMIG1rOq4ezNF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jj1cLO3GwyOxOQ/3GHMUfoJydLkr78wBrWh6YuNezrx6Wo9yu/SICOO+ubgJNy8ZMHH71Amtry76Q8irEE9D+8fXA/gc4ofeMx+CkeH3y9ioDS60qmjsEoxsDSXzquBliHf6EhLSwFQgBRwHgugPzZ/h/P/apjZ0oy0VSuXX53Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6uIEvzv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0605C4CEE7;
	Fri, 17 Oct 2025 23:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760743730;
	bh=p8+FQTe/o47LLiv3XKi3UAEg9kuHIjMIG1rOq4ezNF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P6uIEvzvjqXQ4NC6nheWCOqIuGmTqqktxA3dHc+Gj92t8Os6bsjXblGk6m5NbR//D
	 DW1zQ8FB4kOIytbbyVkDfmIu9FGdRodkujkR9CeHXM61ErwoT62Q2I3Fk2pOVlqkEc
	 06TXaGQJc2z/Nvjrz4ZZdMWnva9C+BhSJVFe2h9I0Q4N07lli0GIE0YtWDk6tGBWrG
	 uJcDosecgbbQD01aa9CWDxNYujkPAa+njI6gCAgVMTMb8xY+84G9MBrQKVBi4k+qKs
	 aFnS+vBO+qUeLnK8+vY4iiCcIqVxD9eqq9RIvC8I4Urey58NUG8vLdkLlfsEQH76tc
	 +MGkv8l9FXlJw==
Date: Fri, 17 Oct 2025 16:28:50 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dave Dykstra <dwd@cern.ch>
Cc: linux-ext4@vger.kernel.org,
	Dave Dykstra <2129743+DrDaveD@users.noreply.github.com>
Subject: Re: [PATCH] fuse2fs: open read-only when ro option and image
 non-writable
Message-ID: <20251017232850.GJ6170@frogsfrogsfrogs>
References: <20251016200206.3035-1-dave.dykstra@cern.ch>
 <20251017192456.GG6170@frogsfrogsfrogs>
 <aPKjtQz5lmUcWf5O@cern.ch>
 <aPKroGbrXvuoBZUl@cern.ch>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPKroGbrXvuoBZUl@cern.ch>

On Fri, Oct 17, 2025 at 03:48:32PM -0500, Dave Dykstra wrote:
> On Fri, Oct 17, 2025 at 03:14:50PM -0500, Dave Dykstra wrote:
> > On Fri, Oct 17, 2025 at 12:24:56PM -0700, Darrick J. Wong wrote:
> ...
> > > > +	ret = 4;
> > > 
> > > Why 4?  Is this an internal mount bug?
> > 
> > I was just guessing; I didn't know what the bits meant.  Where are they
> > documented?  All I knew was that it needed to not include the "& 1" bit
> > which was included with "ret = 3" because that printed an erroneous
> > error just after the "out" label.
> 
> Oh, it's supposed to follow the return codes from mount(8).  I think
> ret = 2 is most appropriate then.

Could you please spend more time understanding the context in which fuse
servers operate, particularly when they're called as mount(8) helpers?

--D

> Dave
> 
> 

