Return-Path: <linux-ext4+bounces-1432-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5459186CB66
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Feb 2024 15:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BACF1F2515F
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Feb 2024 14:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440F11361D3;
	Thu, 29 Feb 2024 14:23:44 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796DC12F58D
	for <linux-ext4@vger.kernel.org>; Thu, 29 Feb 2024 14:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.238.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709216624; cv=none; b=mdTW2XNEHI1u9G1i8IK/ywF6HXx+9yGHYfSYBlru3HYYHROEvG6gX4+cYC7vfoMmr6E2yP9SBBz0zsxQhFYPslK4RQKfmCFkoTQNdjv84ZTZKUENhQxZvX17/9+C1RVIJO9edxwosFFxVH9MJcCBnPNBVYlxOlBwveuewoxtFqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709216624; c=relaxed/simple;
	bh=Z/Ix3tOT6a0nAt88mwf6cU0mTWv1qJyE2c4TbTKeo8c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AGoaN5t2H85mp5sc+WOG3AiDm55/HAmUIsNYrBz+9VazKlsvO3i2gfIpgIYvO1p6jtFQYri21u8SM35dwKpCjliyW18TB/wa5DXYCavm27uGyE5ZZcOr15qPqwdpTLR25eg+mZcP6uAVifCILm8N/MOsCFcc9cud8Wz4zu0AuDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net; spf=pass smtp.mailfrom=thesusis.net; arc=none smtp.client-ip=34.202.238.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thesusis.net
Received: by vps.thesusis.net (Postfix, from userid 1000)
	id A25DB27856; Thu, 29 Feb 2024 09:23:35 -0500 (EST)
From: Phillip Susi <phill@thesusis.net>
To: Theodore Tso <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org
Subject: Re: [PATCH] [RFC] Fix jbd2 to stop waking up sleeping disks on sync
In-Reply-To: <20240229080759.GB57093@macsyma.local>
References: <20240227212546.110340-1-phill@thesusis.net>
 <20240229080759.GB57093@macsyma.local>
Date: Thu, 29 Feb 2024 09:23:35 -0500
Message-ID: <87edcv1h94.fsf@vps.thesusis.net>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Theodore Tso" <tytso@mit.edu> writes:

> Yeah, this change is going to problems.  The basic idea here is if
> when we request that a transaction to commit, will it issue a a
> commit?  If so, then fsync(2) doesn't need to issue a barrier (i.e., a
> cache flush command).
>
> So for example, if a database does an overwriting write to a file
> block which is already allocated, and then follows it up with a
> fdatasync(2), there won't be any need to make any metadata changes as
> part of writing out the changed block.  Hence, we won't need to start
> a new jbd2 transaction, and in that case, current transaction has
> already commited, so the jbd2 layer won't need to do anything, and so
> it won't have issued a commit.  In that case,
> jbd2_trans_will_send_data_barrier() needs to return false, so that
> fdatasync(2) will actually issue a cache flush command.
>
> The patch you've proposed will cause fdatasync(2) to not issue a
> barrier, which could lead to the write to the database file getting
> lost after a power fail event, which would make the database
> adminisrtator very sad.

So because no metadata changed, jbd2 will not issue a barrier to end the
transaction?  How can we fix this then?  Is there some way that jbd2 can
know whether file data has been written, and thus, issue the barrier to
close the transaction?

