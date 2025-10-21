Return-Path: <linux-ext4+bounces-11009-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A63ABF7290
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Oct 2025 16:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A7F94354DC1
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Oct 2025 14:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85A8340289;
	Tue, 21 Oct 2025 14:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pTYEiFrJ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B0F34027C;
	Tue, 21 Oct 2025 14:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761058071; cv=none; b=Gx5gVcH9gkwcySbzk79XDne0VCFb6FZlQoSUp4PQi++uo68XdQt8n3yLOibcCDJAFV+n50skhdEs74RpdSGIWpaaMMgvSoL9l0suV3NLVNUJzWKg8BFw2cDJ7npoGVPQbTS5ScN2eg9nSpEIUVwKjjybUqQ4NYwb5szuMl4HRrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761058071; c=relaxed/simple;
	bh=wc67v7K34+1bSfnbqCK12nzHrWJDtDJXaAVFmovDbEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cz/4Jfar50AjnUYnzbtior7DD22zBwbbJUPmsD/2PDZdmzRZWP9i0hpbJRvp1tdZwmXJzfOmoQ4txF4e2VIv+A4ghK8M6AybkUPvL3t5oo/l2JLmONICjmq5UldPrauTCYpe3uwwVonw6KdoKokgXR/JMJJN85d+YNSv7xHIYDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pTYEiFrJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAAFCC4CEF1;
	Tue, 21 Oct 2025 14:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761058071;
	bh=wc67v7K34+1bSfnbqCK12nzHrWJDtDJXaAVFmovDbEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pTYEiFrJr2Rlh9QBbhwjsA2qwNZMOc5+sP8n0Rc/Nkg2NdZyxb55MziGq+N8OxnYj
	 N1mR6tpAMPMturjfa/uBnjmcIUCHezvD2xXaiAKYjKbPzWWoHqr1h0+gUYdto+rY07
	 kZitVeztJVZUCpon/qlNMki7fgIVohEnM40qg3Xe4AUPuKlThLjR/KUNEwLJ+Sjifs
	 tRRA4lnK0S3VyjsuEdT8uBpcimq5tZuCmcI+BMR2FYhjOg2By1WebwUzOgF4bNFD3X
	 QNP8zu2ZllQZHYd1Ixmv3m0za7nOnJWAunRGBBfWhwm1hZSMJiZoDjr49T1U6u78wx
	 RyEmwMyIICMxA==
Date: Tue, 21 Oct 2025 07:47:50 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Theodore Ts'o <tytso@mit.edu>, zlang@redhat.com,
	fstests@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-ext4 <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 6/8] common/filter: fix _filter_file_attributes to handle
 xfs file flags
Message-ID: <20251021144750.GG3356773@frogsfrogsfrogs>
References: <176054617853.2391029.10911105763476647916.stgit@frogsfrogsfrogs>
 <176054618007.2391029.16547003793604851342.stgit@frogsfrogsfrogs>
 <aPHE0N8JX4H8eEo6@infradead.org>
 <20251017162218.GD6178@frogsfrogsfrogs>
 <aPXeQW0ISn6_aCoP@infradead.org>
 <20251020163713.GM6178@frogsfrogsfrogs>
 <aPcadbSFFBj4Do4c@infradead.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPcadbSFFBj4Do4c@infradead.org>

On Mon, Oct 20, 2025 at 10:30:29PM -0700, Christoph Hellwig wrote:
> On Mon, Oct 20, 2025 at 09:37:13AM -0700, Darrick J. Wong wrote:
> > [add tytso and linux-ext4]
> > 
> > I think we should standardize on the VFS (aka file_getattr) flag values,
> > which means the xfs version more or less wins.
> 
> Ok, I'm more than confused than before.  Shouldn't we simply use
> separate filters for FS_IOC_GETFLAGS vs FS_IOC_FSGETXATTR?

Yeah.  I was going to just provide both versions, but then I went down
the rabbithole of navelgazing about "Is upstream going to accept a
helper for the ext4 lsattr flags even though there are no users?" and
then wandered off to tackle actual useful things like mount/unmount
races in fuse. :P

--D

