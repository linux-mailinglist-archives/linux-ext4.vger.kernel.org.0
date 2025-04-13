Return-Path: <linux-ext4+bounces-7224-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C046BA871FA
	for <lists+linux-ext4@lfdr.de>; Sun, 13 Apr 2025 14:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0ACE3B585D
	for <lists+linux-ext4@lfdr.de>; Sun, 13 Apr 2025 12:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA92D1A8403;
	Sun, 13 Apr 2025 12:50:50 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A8BE57D
	for <linux-ext4@vger.kernel.org>; Sun, 13 Apr 2025 12:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744548650; cv=none; b=LhzblJMTMf8Q+7xCG+fpGAnsu1t9Ij5IckYBqygEvj65tR1ku4pNaXLkPUWU6SZlXxmJW+9nThn/AKxzKlHbWIc7YXemXvhW421FISjCoeGbh2VSUOBW4mrNaouMX+hX+iC6mqYeVMB5NlWG3/qjLKmcuF/laIEi4NTEKCpjRwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744548650; c=relaxed/simple;
	bh=f6hWhAVNRCt1ZlU8kRO/QK8Bf80ASNvP+5hVXVlXR6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OcWMRd6GTHIOCxR6Bu2pJs1KnuFvMOg62+YU+MbNbMXFlFpq6JjV4TsrQjy0loQ2zxs95ZKdscueqINKksgksjZHmZnRQPAxT/xshn+aUCAnzeO27DDG3R3ERD4Wm46iZfkfK8E0zVkxDwkxJj5DA6WsbHCj0iCBQDJvmovz0/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-137.bstnma.fios.verizon.net [173.48.82.137])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 53DCoe9B010927
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 13 Apr 2025 08:50:41 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 5A0F12E00E9; Sun, 13 Apr 2025 08:50:40 -0400 (EDT)
Date: Sun, 13 Apr 2025 08:50:40 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Kevin Paul Reddy Janagari <kevinpaul468@gmail.com>
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH] ext4: filesystems without casefold feature cannot be
 mounted
Message-ID: <20250413125040.GB1116327@mit.edu>
References: <20250413045718.150126-1-kevinpaul468@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250413045718.150126-1-kevinpaul468@gmail.com>

On Sun, Apr 13, 2025 at 10:27:18AM +0530, Kevin Paul Reddy Janagari wrote:
> commit 985b67cd8639 ("ext4: filesystems without casefold feature cannot be
> mounted with siphash") upstream
> 
> CONFLICT: A condition above this was wrapped in #ifdef making git not
> able to merge them: Merge conflict
> 
> When mounting the ext4 filesystem, if the default hash version is set to
> DX_HASH_SIPHASH but the casefold feature is not set, exit the mounting.
> 
> compile tested
> Signed-off-by: Kevin Paul Reddy Janagari <kevinpaul468@gmail.com>

I believe the problem you are concerned with was fixed by commit
a2187431c395 ("ext4: fix error message when rejecting the default
hash")

And I'm not sure what you meant by your reference to the merge
conflict?  Were you trying to cherry-pick 985b67cd8639 into some other
tree or branch, and that was where you saw the merge conflict?

     		    	     	       - Ted

