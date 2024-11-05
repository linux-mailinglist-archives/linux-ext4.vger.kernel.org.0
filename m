Return-Path: <linux-ext4+bounces-4967-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2D59BD013
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Nov 2024 16:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EF352819CD
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Nov 2024 15:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1871D9A61;
	Tue,  5 Nov 2024 15:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="JZE8QhsZ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20641D9697
	for <linux-ext4@vger.kernel.org>; Tue,  5 Nov 2024 15:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730819324; cv=none; b=sQuoxow8G+nu9C83w7jtCeyt8JOQvFc3aQmAkzZzkrwtfBrZ1Rtd3zG50yCfRHEP0eIP/o6xDW1wXOTGA0su8Cgj/k0/6dXuv8n9pk/wR0cz8ODej7ikF3MKCqpg912gcxcVJShtqRSVBzhs/QTJ106dqd9afnWBm6kAcn3Hl7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730819324; c=relaxed/simple;
	bh=xs9hwGdl0KBmPRd6aGG8qgRe52Vr2R71AnAvQ0KFysY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UMWFrIdZRLYhouoEKEZyw8d/nF9d0ueMFf1qmfbV3pEj1c5J+04R39eKgun+mMj56rt0NlsPnbUxYR15lr4pjTWyEBf2FdGVueZZOd2C97c/xu49f9MATsjgUbrtQMhT3fisJbe5FBQRTneC3I4UqGvO6MoI8YyAifb3vqgFnvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=JZE8QhsZ; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-224.bstnma.fios.verizon.net [173.48.82.224])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4A5F8CEH025771
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 5 Nov 2024 10:08:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1730819296; bh=c4qZqGbYjgITD2eX2Niv+Ly/kY9oNfRv2yhBiMtubRQ=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=JZE8QhsZfybhq2dnfDuVJVFL0mWTPjPBDPltJjwsUlN4TStK3LcJDp1/pJFrzptEV
	 LyrpK/AzY1BpppzQEn76KqtCdGDpQ/LJo4OpEcwP8xb+MQrCVO36BSoxH8HYfv7rWr
	 sF+T3Rbzz11ipOBdjStai3KAb4867oOcad9btYKwHo6HWn7WcaHW/WtaL+ws7rFKZi
	 Rf/YYh6McxVJZGCshUw5v7BJRAWoeHBp65RcgEyKE3sIkEQ4XbDdGFSEH9GzHCWt4S
	 0c+7sigqQyij1xpTJMOaIC7Wkw5+pBcc3gOjIetzJiIaYUPbiUyIwLZfVRBVQKyZEJ
	 21z/5D2dTZl9Q==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 4AC2215C02FA; Tue, 05 Nov 2024 10:08:12 -0500 (EST)
Date: Tue, 5 Nov 2024 10:08:12 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jens Axboe <axboe@kernel.dk>
Cc: Carlos Maiolino <cem@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        John Garry <john.g.garry@oracle.com>, brauner@kernel.org,
        Catherine Hoang <catherine.hoang@oracle.com>,
        linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-block@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [ANNOUNCE] work tree for untorn filesystem writes
Message-ID: <20241105150812.GA227621@mit.edu>
References: <20241105004341.GO21836@frogsfrogsfrogs>
 <fegazz7mxxhrpn456xek54vtpc7p4eec3pv37f2qznpeexyrvn@iubpqvjzl36k>
 <72515c41-4313-4287-97cc-040ec143b3c5@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72515c41-4313-4287-97cc-040ec143b3c5@kernel.dk>

On Tue, Nov 05, 2024 at 05:52:05AM -0700, Jens Axboe wrote:
> 
> Why is this so difficult to grasp? It's a pretty common method for
> cross subsystem work - it avoids introducing conflicts when later
> work goes into each subsystem, and freedom of either side to send a
> PR before the other.
> 
> So please don't start committing the patches again, it'll just cause
> duplicate (and empty) commits in Linus's tree.

Jens, what's going on is that in order to test untorn (aka "atomic"
although that's a bit of a misnomer) writes, changes are needed in the
block, vfs, and ext4 or xfs git trees.  So we are aware that you had
taken the block-related patches into the block tree.  What Darrick has
done is to apply the the vfs patches on top of the block commits, and
then applied the ext4 and xfs patches on top of that.

I'm willing to allow the ext4 patches to flow to Linus's tree without
it personally going through the ext4 tree.  If all Maintainers
required that patches which touched their trees had to go through
their respective trees, it would require multiple (strictly ordered)
pull requests during the merge window, or multiple merge windows, to
land these series.  Since you insisted on the block changes had to go
through the block tree, we're trying to accomodate you; and also (a)
we don't want to have duplicate commits in Linus's tree; and at the
same time, (b) but these patches have been waiting to land for almost
two years, and we're also trying to make things land a bit more
expeditiously.

Cheers,

					- Ted

