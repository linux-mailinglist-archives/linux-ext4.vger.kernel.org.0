Return-Path: <linux-ext4+bounces-2900-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA8F90FB67
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Jun 2024 04:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E62F41F22836
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Jun 2024 02:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C1B18EB1;
	Thu, 20 Jun 2024 02:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="GDZH68xF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D28171A1
	for <linux-ext4@vger.kernel.org>; Thu, 20 Jun 2024 02:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718851869; cv=none; b=oIeh/ECScxglmLZPw8um6zTOwRLiyqMvNBasX3FBEGjS6I6ZBxrd1iaAnNCvhve2K87pMaY8nrZ82fM8p7e0W23LfazUjpiejBZy69OBBk6iOVIKGO27ckNMCuidlYi4pFBUS/h3ehuE7BIGMD3hNAE3Ttz37fQkahUwkuyQxjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718851869; c=relaxed/simple;
	bh=lWd4tRBjtAirRVUKqQsiipjNU8yXMYGT/mCcres80c0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pKJ52Q2WSQUb4n6lT2Qiz14d8NRdRC2sFGtkIy6HiUNe4pLkOWYelvKLTAZVCI6cxNphZqFmv5pHFiRF/ew4KZrZiTz9tGjUNDIipgn8yUZ4SzHZ2XEckX6fc0TJLz+VFY0ixzLUerddq7B3ffaBIRTw7KK53rbnM+8g5Bgd/RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=GDZH68xF; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-120-239.bstnma.fios.verizon.net [173.48.120.239])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 45K2oVUY011125
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 22:50:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1718851835; bh=W+nBGbxqJxXVGLbHacUyEagB34USQ/ZRkZnamwwdgeo=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=GDZH68xFtlb7Cj1+VQHcLiYuprELsM75KYvdx9ANH09TYJutfxFfTbbuzPVRhHfvU
	 kzP7jQAEJ4cQQxa8xDjjOPtKdAehy0gBnNdux3ctkgCxpf99KA4/CVtuCg63AI3WNg
	 0snRyLHQ0cAGdcTFpdoDbikSJDVX7WBcUrOVHwaRrzj4ga/eDPb3ry92BZiyZa0LnV
	 x8MRPXylgBDyO9wUN/Z7Wb9fB+Nn9+VzLiX4xtBzOAcGDZ8WgkWP5NOw4AFDzEkG7I
	 NVx/Us07EJUgmB0yPMRI9ztgMDVeOgmkN9y5EcjGNdolQXuhK0Dzz+8lPlpe3xcvbE
	 1Yd9bkxnB1OjQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 54F3215C0579; Wed, 19 Jun 2024 22:50:31 -0400 (EDT)
Date: Wed, 19 Jun 2024 22:50:31 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ye Bin <yebin@huaweicloud.com>
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, jack@suse.cz,
        Ye Bin <yebin10@huawei.com>
Subject: Re: [PATCH v3] jbd2: avoid mount failed when commit block is partial
 submitted
Message-ID: <20240620025031.GA1553731@mit.edu>
References: <20240425064515.836633-1-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425064515.836633-1-yebin@huaweicloud.com>

Apologies for not getting back to this until now; I was focused on
finalizing changes for the merge window, and then I was on vacation
for the 3 or 4 weeks.

On Thu, Apr 25, 2024 at 02:45:15PM +0800, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> We encountered a problem that the file system could not be mounted in
> the power-off scenario. The analysis of the file system mirror shows that
> only part of the data is written to the last commit block.
> The valid data of the commit block is concentrated in the first sector.
> However, the data of the entire block is involved in the checksum calculation.
> For different hardware, the minimum atomic unit may be different.
> If the checksum of a committed block is incorrect, clear the data except the
> 'commit_header' and then calculate the checksum. If the checkusm is correct,
> it is considered that the block is partially committed.

This makes a lot of sense; thanks for changing the patch to do this.

> However, if there are valid description/revoke blocks, it is
> considered that the data is abnormal and the log replay is stopped.

I'm not sure I understand your thinking behind this part of the patch,
though.  The description/revoke blocks will have their own checksum,
and while I grant that it would be... highly unusual for the commit
block to be partially written as the result of a torn write, and then
for there to be subsequent valid descriptor or revoke blocks (which
would presumably be part of the next transaction), I wonder if the
extra complexity is worth it.

I can't think of a situation where this might happen other than say, a
bit flip in the portion of commit block where we don't care about its
contents; but in that case, after zeroing out parts of the commit
block that we don't care about, if the checksum is valid, presumably
we would have managed to luckily recover from the bit flip.  So
continuing shouldn't be risky.

What am I missing?

						- Ted

