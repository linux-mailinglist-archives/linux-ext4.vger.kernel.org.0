Return-Path: <linux-ext4+bounces-2142-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9968A9D39
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Apr 2024 16:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D928C1C212CA
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Apr 2024 14:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408A8168AE1;
	Thu, 18 Apr 2024 14:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="VJTJeU1G"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1C058129
	for <linux-ext4@vger.kernel.org>; Thu, 18 Apr 2024 14:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713450985; cv=none; b=C1jZuxgkdM9995WwGFxJ8srwWdX8q/IpihfKkyeiiBALcJ77AerwldY6uA0Jr0HQx4jNxtSTtXyIblnzqGPqZfEjk8XJRKut428bd+aaucAcZl8n3SM5n8IEjP8ABrAJlYPEQ5R3t+bt9xSioilH/gTxsXbus6JPde+QGS0reEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713450985; c=relaxed/simple;
	bh=CZZ34PA4WEnHfZ9uZWoE5nxNfLXHrAE2rmo0mDIrwBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/RYZkAwDrGigMdXy8/zh3vbZezACWi89f3IIrauHPsQfNSPVqEdhMeLnkB23noO/s5p/vKxyN/FReUkcRKhrjCPbgp0pIueSFKonbW8iVjxhO8UOHx1xqNa0H5kDgLXmCqld9xnXBbcSssFW9KcKwQ2Fj1HNTNszA35Wd5GzLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=VJTJeU1G; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-2.bstnma.fios.verizon.net [173.48.113.2])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 43IEaBYl008799
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 10:36:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1713450973; bh=AjlLNVZP0b+GOkuCzi2ztc2velPCCkSgy+cHakxx5P4=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=VJTJeU1GH8UYLSD93RA90F8X3/eiMIlvFdeJK4qoCzx//i1wozIyJS5p9DQuvvDQ1
	 R9HQHzdo4XE7VVYbpCkR4ftPwpcr6YwZeuBv4P4qU1SNcZ6BxD88kRk+7xB1RXZIHD
	 bnIgghDHzEJtwPYWDGuXgWRQ3qhX4Wv8/Wy12Ck1AggpPD4hAI3dsAbAAn49E4hgK/
	 EeLyX1ywtsDO+lnmaGSjiNHIug/EBF1WkSOB7RzEk5YVpc3KNE9++hTtmxqWD0YR5b
	 gJPXM1chBPZKOoJhb1w0VHr9rpWfl1ghw59DMDf44AxaQZATuU/sBBeEbjzpYzr2VG
	 QsU/U5NYv4sQg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id A87E715C0CBA; Thu, 18 Apr 2024 10:36:11 -0400 (EDT)
Date: Thu, 18 Apr 2024 10:36:11 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andreas Dilger <adilger@dilger.ca>
Cc: Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH] misc: add 2038 timestamp support
Message-ID: <20240418143611.GA3373668@mit.edu>
References: <20230927054016.16645-1-adilger@dilger.ca>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927054016.16645-1-adilger@dilger.ca>

On Tue, Sep 26, 2023 at 11:40:16PM -0600, Andreas Dilger wrote:
> The ext4 kernel code implemented support for s_mtime_hi,
> s_wtime_hi, and related timestamp fields to avoid timestamp
> overflow in 2038, but similar handling is not in e2fsprogs.
> ...

Hey Andreas,

I had recently taken this patch, but I've since found that it was
causing a number of problems.  These have been fixed on the next
branch, but if you have your own build of e2fsprogs, you might want to
make sure you have these two fixups.  The second is especially
important if you plan to use debugfs's set_super_value command on
customer file systems....

In the future, I strongly suggest that large patches to e2fsprogs are
run with make check run with trees built with "configure
--enable-ubsan" and "configure -enable-asan".  If you have a github
account, pushing the changes so that the github actions will do a CI
using github actions to make sure that there aren't build problems on
i386, Windows, MacOS, and Android is also a good thing to do.

Cheers,
						- Ted


commit 5b599a325c1af94111940c14d888ade937f29d19
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Wed Apr 17 23:47:02 2024 -0400

    Fix 32-bit build and test failures
    
    Commit ca8bc9240a00 ("Add post-2038 timestamp support to e2fsprogs")
    was never built or tested on a 32-bit.  It introduced some build
    problems when time_t is a 32-bit integer, and it exposed some test
    bugs.  Fix them.
    
    Fixes: ca8bc9240a00 ("Add post-2038 timestamp support to e2fsprogs")
    Signed-off-by: Theodore Ts'o <tytso@mit.edu>

commit 9103e1e792170a836884db4ee9f2762bf1684f09
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Thu Apr 18 10:04:27 2024 -0400

    debugfs: fix set_field's handling of timestamps
    
    How timestamps are encoded in inodes and superblocks are different.
    Unfortunately, commit ca8bc9240a00 which added post-2038 timestamps
    was (a) overwriting adjacent superblock fields and/or attempting
    unaligned writes to a 8-bit field from a 32-bit pointer, and (b) using
    the incorrect encoding for timestamps stored in inodes.  Fix both of
    these issues, which were found thanks to UBSAN.
    
    Fixes: ca8bc9240a00 ("Add post-2038 timestamp support to e2fsprogs")
    Signed-off-by: Theodore Ts'o <tytso@mit.edu>

