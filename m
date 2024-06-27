Return-Path: <linux-ext4+bounces-2999-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7BB91AA0C
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Jun 2024 16:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A35C81F21B6F
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Jun 2024 14:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F9E19754A;
	Thu, 27 Jun 2024 14:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Go24WEA2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC1013A259
	for <linux-ext4@vger.kernel.org>; Thu, 27 Jun 2024 14:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719500342; cv=none; b=PgKn5nHJEq9HQhK6i0Z48CwNpCeG3sVQpHMyXrw7Ivwoqq24wcSK5iaFbt3iJdj3V8bKXdEhIF7iMyJhiCbo2vVg4i0EE5/T7EueZydKh1dKKaLV3SqhxkC0iKvS6d06FplbMKBhc5Df7jTMtHJKoMHOlAM5P601/PY7tzHC0N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719500342; c=relaxed/simple;
	bh=aAzQsT0oQ9vbbBXrJvB+fEyAFrOdEyRHswJRXal7oKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MH+hb3mG5YscJgYc8QH2YGAk0v+ySP6henYLgYwzY8iz2hemZxuVnb03f4kvqb+GOroks2SagXGv9RqkP0NKOEeSVhVTE/LzI3TaKZRMmTzLbvNlhiIHeV/sT33c8EpTiEabtOosGuXRPfFF8y1rofXhho5t4X6VX3gmc825v4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Go24WEA2; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-120-63.bstnma.fios.verizon.net [173.48.120.63])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 45REwaEl022257
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 10:58:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1719500320; bh=45z46S1vlPy3Zb8mXGWMskv+A9Ox8+WXrBmVToToIEg=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=Go24WEA2gC+HB7aPbZh9n7FoNJq53ESvbUpUE3RzFeSWKsY9YnGD84spwQi1jF32n
	 LhbnhEJkQlbB/OxHFoBg56/qQ9A75TieMsLHh9PiRl65uFltajfa+scLHD8U0sCwjw
	 hzW+uUJ1/ke48VQIFnhutQlV8i1Zv6tsLD5FJ1XedypcxFRNxLRodnK9u6saDNBd6x
	 qFYSnDboi0Eg++QZj3L+QZA3ks4jSzy+LwFB4svr6K4SpLH5F0xVIuDiqri2evF0eJ
	 gpZNdJwqB1dL4CGc/KjVzviWJkywTyP58yYO5sRpe5R662hmw6nlHxME3ivhKPCO39
	 2SNDsGiU35eqA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id A517615C626C; Thu, 27 Jun 2024 10:58:36 -0400 (EDT)
Date: Thu, 27 Jun 2024 10:58:36 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Luis Henriques <luis.henriques@linux.dev>
Cc: Andreas Dilger <adilger@dilger.ca>, Jan Kara <jack@suse.cz>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] ext4: fix fast commit inode enqueueing during a
 full journal commit
Message-ID: <20240627145836.GA439391@mit.edu>
References: <20240529092030.9557-1-luis.henriques@linux.dev>
 <875xtu7aow.fsf@brahms.olymp>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875xtu7aow.fsf@brahms.olymp>

On Thu, Jun 27, 2024 at 02:54:39PM +0100, Luis Henriques wrote:
> On Wed, May 29 2024, Luis Henriques (SUSE) wrote:
> 
> > Hi!
> >
> > Here's v3 of this fix to the fast commit enqueuing bug triggered by fstest
> > generic/047.  This version simplifies the previous patch version by re-using
> > the i_sync_tid field in struct ext4_inode_info instead of adding a new one.
> >
> > The extra patch includes a few extra fixes to the tid_t type handling.  Jan
> > brought to my attention the fact that this sequence number may wrap, and I
> > quickly found a few places in the code where the tid_geq() and tid_gt()
> > helpers had to be used.
> >
> > Again, please note that this fix requires [1] to be applied too.
> >
> > [1] https://lore.kernel.org/all/20240515082857.32730-1-luis.henriques@linux.dev
> >
> > Luis Henriques (SUSE) (2):
> >   ext4: fix fast commit inode enqueueing during a full journal commit
> >   ext4: fix possible tid_t sequence overflows
> 
> Gentle ping...  Has this fell through the cracks?

Sorry, I'm still catching up after being on vacation.  There is a
batch of commits which I've reviewed (up to May 17th) which is
currently undergoing testing.  So that doesn't include this patch yet,
but it's on the list of patches to be reviewed at
patchworks.ozlabs.org/project/linux-ext4 so it won't fall through the
cracks.

					- Ted
					

