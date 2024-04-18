Return-Path: <linux-ext4+bounces-2146-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B128AA214
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Apr 2024 20:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A49EA1F21A64
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Apr 2024 18:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E2D15DBA2;
	Thu, 18 Apr 2024 18:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="MEkVfCrn"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DF042AAC
	for <linux-ext4@vger.kernel.org>; Thu, 18 Apr 2024 18:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713465165; cv=none; b=koGpYEN2GZV9u9U0vW3k25o3gKDxBrebOdPRDDGF29g3+9ScAMAZXz/Vbk3W3x6F3x0D4W/Nb8hr8mgrNHChP0fC5hTisHLZonCsQzEQnXNXL4xw7ylcGikTzdcoSNfGgv20y4ACHF4+Y9H53iCusT5fo7ALMcfAGOEk1CwTKmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713465165; c=relaxed/simple;
	bh=z9wiDxymeoFfWC/hUGIvbxEadiwLjGB8R04sCmBuKco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YjFqzqDkzoAcF7m1N/HMNYwvvNxL5PvmTrenR7ksRqcx0UPrKzeqSWwL2+jZbsiws9aYme2lc0faRFjdAEjRF4rmWYgnwV1Ks3bcQYfUXdJvKMh9iz3tgMHLhLUGvQN37YFranJQBkdURZOFzwHQJtUMUvyl9VsWFrGTnnX9quE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=MEkVfCrn; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-2.bstnma.fios.verizon.net [173.48.113.2])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 43IIWYeM022323
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 14:32:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1713465157; bh=hM8hcZ+5hAQArvKaF1WusmNhXKAVuYRnsnV79mcxO2U=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=MEkVfCrnoxUu/XQK2Ad9uul9iHpCRX1cqNEmgWuqKcXzsGkbUiaCVKVO/qXFZL6g9
	 qENer7A7xPn+k93hgsaiuJSLz+Cz5DwsgM81ebEiD6fLwn80hz0hx0w0Ik3oOFKtdQ
	 1wB9i3NR8lcMP3uXjKwkj9383yoz5V1/ExTsie/iite7hPvf2c4AXktT2craM4xzo5
	 lQIdYr6vQ1jbOEUU2+OLc3AJtcdM4Pd3IlrzxdvU4ktxYFGO0qNouxt27463OterU0
	 c7uoEKH3oz2OEI95LcFaMI1I03E1Zum5RGskhelHR5QOpRvGpc4B2gZT8WN4AjhJxu
	 X5Ek5Gwi1HUiw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id BADE515C0CBA; Thu, 18 Apr 2024 14:32:34 -0400 (EDT)
Date: Thu, 18 Apr 2024 14:32:34 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andreas Dilger <adilger@dilger.ca>
Cc: Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH] misc: add 2038 timestamp support
Message-ID: <20240418183234.GA3374174@mit.edu>
References: <20230927054016.16645-1-adilger@dilger.ca>
 <20240418143611.GA3373668@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418143611.GA3373668@mit.edu>

On Thu, Apr 18, 2024 at 10:36:11AM -0400, Theodore Ts'o wrote:
> 
> I had recently taken this patch, but I've since found that it was
> causing a number of problems.  These have been fixed on the next
> branch, but if you have your own build of e2fsprogs, you might want to
> make sure you have these two fixups.  The second is especially
> important if you plan to use debugfs's set_super_value command on
> customer file systems....

One more commit that's needed to fix post-2038 timestamps:

commit 8b37e89f850610d51b7550ac34b8912b3000ced5
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Thu Apr 18 14:16:55 2024 -0400

    debugfs: fix printing post-2038 inode timestamps
    
    Debugfs's stat command called ext2fs_inode_xtime_get() with a struct
    inode * instead of a struct large_inode *.  As a result, printing
    inode timestamps will be incorrect if the time value is larger than
    2**32.
    
    Fixes: ca8bc9240a00 ("Add post-2038 timestamp support to e2fsprogs")
    Signed-off-by: Theodore Ts'o <tytso@mit.edu>

						- Ted

