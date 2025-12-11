Return-Path: <linux-ext4+bounces-12283-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E242ACB4B19
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Dec 2025 05:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B09A530088BA
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Dec 2025 04:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985AE2472BB;
	Thu, 11 Dec 2025 04:52:30 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D2B12DDA1;
	Thu, 11 Dec 2025 04:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765428750; cv=none; b=Pg8RSudYuzVC12aYYbwNqVpi/dJMfqkJwLsIOIAibCBZuOX2vmabZ9T6XZg35q21heQGH3EjYl6HgOWAOVrlJuEcRr2jLGp3l1h40+InkUwR5lMfjHkaQlri5Tpqm9uVTX62YwLoGe/Pnf4a6TCyhpwLU2zlQxWvaRR7eMvQOMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765428750; c=relaxed/simple;
	bh=uO2uelI0XoKDKZJTOl4WxWaNTOhsgykPN2bxICYnNS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dka1tLorA8ERXKGSuIlqrw3VoGY0iRD4UhMhVnr8JWOLdwkUsW+H1SdP+JfBnjILGAncFC8jjDL+CoMH/kR8UqxVfVgEnwG0KuGGTCso4JJtLN8cceuqoP1S2soUrwdRHWt/7GTAalfeXMiOco/B2aL3QltdtiLhfPgdPqa3vmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 32E9F68AA6; Thu, 11 Dec 2025 05:52:24 +0100 (CET)
Date: Thu, 11 Dec 2025 05:52:24 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Zorro Lang <zlang@kernel.org>,
	Anand Jain <anand.jain@oracle.com>,
	Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 02/12] ext4/006: call e2fsck directly
Message-ID: <20251211045223.GA26257@lst.de>
References: <20251210054831.3469261-1-hch@lst.de> <20251210054831.3469261-3-hch@lst.de> <20251210193226.GA94594@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210193226.GA94594@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Dec 10, 2025 at 11:32:26AM -0800, Darrick J. Wong wrote:
> On Wed, Dec 10, 2025 at 06:46:48AM +0100, Christoph Hellwig wrote:
> > _check_scratch_fs takes an optional device name, but no optional
> > arguments.  Call e2fsck directly for this extN-specific test instead.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  tests/ext4/006 | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tests/ext4/006 b/tests/ext4/006
> > index 2ece22a4bd1e..07dcf356b0bc 100755
> > --- a/tests/ext4/006
> > +++ b/tests/ext4/006
> > @@ -44,7 +44,7 @@ repair_scratch() {
> >  	res=$?
> >  	if [ "${res}" -eq 0 ]; then
> >  		echo "++ allegedly fixed, reverify" >> "${FSCK_LOG}"
> > -		_check_scratch_fs -n >> "${FSCK_LOG}" 2>&1
> > +		e2fsck -n >> "${FSCK_LOG}" 2>&1
> 
> Doesn't this need a device name?  e.g. e2fsck -n $SCRATCH_DEV ?

Yes.

