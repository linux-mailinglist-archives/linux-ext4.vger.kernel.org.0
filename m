Return-Path: <linux-ext4+bounces-9230-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 384D6B15919
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Jul 2025 08:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A61B541291
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Jul 2025 06:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C211F4CAA;
	Wed, 30 Jul 2025 06:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="jVqClJgr"
X-Original-To: linux-ext4@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD56D199BC;
	Wed, 30 Jul 2025 06:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753858184; cv=none; b=U09PiLHH/TRIp7qN9z8/HEtjmEytFlNo77EEIU02nxW2k/ov0aOoiaP1gUm47sSa2CreqLWkYp/oseZsh15xrmq+F9zxKZmRFe0cOjUdjw8KF2de7oPluud7PybyFeC4jZBaUhuuGdD27fR6uQviNllLvCtnsr6ofqA979z09aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753858184; c=relaxed/simple;
	bh=1ehwRHB/c8fFjab9F28H5oq/vzrBHPM3+zW4uqq+1+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJkUO3hDPT+G+vc/hCqqFBR3hB5+emC8QJD+Tt7OhRf3YM3WTLg47Je8TV3+EwODv8RCPaXkW68h/vHiZyToObXBxAFqiZXgZlhprVX0880ulV+t1Wo83LE78T2v73nHQyFWCF02zHcNrED04mJRpkv8Iy4sIvrnhX3hNAQSnkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=jVqClJgr; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NmkQwUKQ9zppnOgLD4CWc0W0IQG1SxyEYIDqdfxZLfk=; b=jVqClJgrJirM0nDFfmASsSH7cP
	RiL3ouqzy+jf61YX4AJclE7TYykfdnxHmkwpH/ELPHxS8C7G+HLuouzKTabwyZo7+pzWVyWVHnl56
	QGJ/wT19TDv16naff7QVJ5F9+KIINAIe2t6JfKdlG99febnDYTOiYgBuwiI22M9I230Rv2219CTws
	aOdD0xjx1rAHA+zRQYoxcLBTAucqB5X53ZtgcILS0twHrAcaRy2mu1vW9iSQEidNAvkGwr9AUpF2Z
	aic4fMsRvJwPKj8B/NXPt2p0Glbf/wcoURbsOqCKIaLLuaew/fiRa1H/2v8IzIXXDtykOC/xgwJnP
	eYCsgd8Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uh0d7-0000000AMFB-2YNs;
	Wed, 30 Jul 2025 06:49:37 +0000
Date: Wed, 30 Jul 2025 07:49:37 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: Use IS_ERR_OR_NULL() helper function
Message-ID: <20250730064937.GM222315@ZenIV>
References: <20250730063823.313324-1-zhao.xichao@vivo.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730063823.313324-1-zhao.xichao@vivo.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Jul 30, 2025 at 02:38:23PM +0800, Xichao Zhao wrote:
> Use the IS_ERR_OR_NULL() helper instead of open-coding a NULL and 
> an error pointer checks to simplify the code and improve readability.

IS_ERR_OR_NULL() is almost always a bad idea.  ext4_bread() *is* one
of the cases where NULL is a legitimate return values that is not an
error - it indicates a hole in a sparse file (BTW, not sure if it
can legitimately occur in a directory); the thing is, among the
functions that can return both NULL and ERR_PTR() the meaning assigned
to NULL varies a lot; so much that "ERR_PTR() or NULL" has no good
semantics.

Most of the uses are either sloppy code from somebody who couldn't be
arsed to find out whether it's pointer-or-NULL or pointer-or-ERR_PTR()
or misguided "defensive" crap.  Any caller that is *not* of that sort
is drowning in a pile of garbage.  Let's not breed that...

