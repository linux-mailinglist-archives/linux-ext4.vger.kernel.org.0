Return-Path: <linux-ext4+bounces-10433-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2025BBA3A48
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Sep 2025 14:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7DA0627F5C
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Sep 2025 12:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AB123E347;
	Fri, 26 Sep 2025 12:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="YfmUOBTz"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6E918C02E
	for <linux-ext4@vger.kernel.org>; Fri, 26 Sep 2025 12:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758890286; cv=none; b=AnvcR+kCcWTIbaLBtZOQyRP2NKTI0kNnhFQVsfxiTM0ZihRRbSOBZbbpQjxQJsbv2WN+ekE/SEQ/VI32VTTgcKK4odJGV2YC6RAtGWbQNICXFf+A9ev5CAYOTMwqemFwzQ1JI895rQmPDUjXxokwtAMENKc2E6ifIuA5m3wXr34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758890286; c=relaxed/simple;
	bh=AAnczlQ3gVQd6lE65U4G+hnj0JnTGdQsfanTqPzSfB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rA0hhFh+AqvF1jBolvKYQFMpQorMNmurhIYo7NFiOijRBFm8y2PvrwL4oU8HolJXGweDfJnO4/YtQCUpIZv8KfF0vmblFtAhd8FU/0SFA2UdAqnTf+/Af1F38x4frESf6os65STkZcdSKYdJVF1jPcylHR/DmTGzcREAWH0Zv20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=YfmUOBTz; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-115-162.bstnma.fios.verizon.net [173.48.115.162])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 58QCZaeS016272
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 08:35:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1758890138; bh=/3LBz4Tk1XyfFxRazsBT96DMKukaqcHxsrVMPrUyl4Q=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=YfmUOBTzLtwlSd6a07krllAKEyDNtRKXO+eYBjRh1F+VcGe4epIhB5xjfU4PAgDMt
	 xWqgX2KAGvvxlBTvcsVEk8efsiKSGkdqqX6L0eO1f8lXbcbmg/ZfRduJ07WYgB3DV9
	 BlvjscjHjboL3DPjl+3YYaVsG2pXzQzM8eOrXsNBLfuMZ+cdceyjbBLiXiL7nv5SsU
	 6uGzd3AfZ9YkaPrqwwpxKT69ppqKreyBKhpWpORZ4GBjpf74QYWriZEA+APrT+eEJX
	 +sTh3kFAHtKM0hSJdB9WXhCcDQSDgsI4STpQ7XjjofCwaNiG0hyLyRvoU6aGjkSqu5
	 gUxScHjzgN0ww==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 676762E00D9; Fri, 26 Sep 2025 08:35:36 -0400 (EDT)
Date: Fri, 26 Sep 2025 08:35:36 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        Zhang Yi <yi.zhang@huawei.com>, linux-kernel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH 2/2] fsmap: use blocksize units instead of cluster units
Message-ID: <20250926123536.GA12175@mit.edu>
References: <cover.1757058211.git.ojaswin@linux.ibm.com>
 <d332ed2f90a0c8533139741d25e7fc1935773e14.1757058211.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d332ed2f90a0c8533139741d25e7fc1935773e14.1757058211.git.ojaswin@linux.ibm.com>

On Fri, Sep 05, 2025 at 01:44:47PM +0530, Ojaswin Mujoo wrote:
> Currently, ext4's implementation of fsmap converts the ranges to cluster
> units if bigalloc is enabled and then converts to block units whenever
> needed. However, this back and forth conversion has known to cause
> several edge case issues since even with bigalloc the metadata is still
> in block size unit....

This commit causes ext4/028 to fail with a 1k blocksize.  The failure
happens after just under 45 minutes; before this commit, ext4/028
would complete after a second.

Do you have a preference regarding whether I just drop this commit, or
drop the whole series?  The previous patch looks fine to me and fixes
a real problem, so my plan is to keep the 1/2 commit and drop this
one.

Cheers,

						- Ted

