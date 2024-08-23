Return-Path: <linux-ext4+bounces-3882-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3405095D265
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Aug 2024 18:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3349285068
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Aug 2024 16:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21591898F4;
	Fri, 23 Aug 2024 16:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="V4MIS8yS"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2BE1898E6
	for <linux-ext4@vger.kernel.org>; Fri, 23 Aug 2024 16:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724429152; cv=none; b=bXQs4ZYfpebNBoJqChIwBxO0aFj94JnzTBr33X3Zb5xY9MKRNBhpiG1p1QRy2HvIoDQB6j1GmxwIJ4KEmqVkn5Lheb6oaN0kOdwL7DSeQH2cv/op+MqYp69UtWDH98UGO+Y8GrtHyitxaWoIPJhXVuU4CBi08xlDqBW2ymrLMNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724429152; c=relaxed/simple;
	bh=FstkNDRNbaK14vWvEY1SladmWDSjQ+KqFzh47ygUass=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FkxdOa2JOxcUnvz18kycCzMSy1FamwS5nlk5U/90d5C2IiLrx929Q2a13/Yk3lCs34Th1Tj5PXG9oRbiE1f9zAHH2lmfzWpb29+f3d/H9nox/4NFnLisLZB1OX+f3hhPfBHMf7dwvaZ1IyqEhWBD+ZotG8c0Wg7LE2wQeq7G4lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=V4MIS8yS; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-112-67.bstnma.fios.verizon.net [173.48.112.67])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 47NG5J1Z018050
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Aug 2024 12:05:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1724429122; bh=AMQjT8wPGTwlJZgBL47TXzuwBFUu6cj117cSla0JD24=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=V4MIS8yS7VBx21EO1dW6OBzSh/Gk5WJ6nGL6NKYpXDo/2DmorgnScyrMNpmHepeSs
	 vBjJpDddWIZ4/lgPgzwn6bnoXE/6Uk14KeZWTPHYSZyeVe4XEIK154nuijWDLNasyV
	 Zkq7beWCqA5Lj5s6ebiyNth4U9E3/ulYGRGPa5wRfrdkaarDbpKmx1m+Wol7IlPM/B
	 b49lSIUT9rgfhc/NfRA3RRWWpJbINwkYdmflJSX5Mjzlzv7dUS2hPZYS2EL28e7Oko
	 tlcbaAdLz8E4cafZVYpaJvHECc4zvFxOZVN4ksuaOgNjuavFwGBSn/V21VamqjuqPF
	 WYc3bA64cdjuQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id DCD6B15C02C0; Fri, 23 Aug 2024 12:05:18 -0400 (EDT)
Date: Fri, 23 Aug 2024 12:05:18 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Baokun Li <libaokun1@huawei.com>
Cc: Edward Adam Davis <eadavis@qq.com>,
        syzbot+ae688d469e36fb5138d0@syzkaller.appspotmail.com,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] ext4: No need to continue when the number of entries is 1
Message-ID: <20240823160518.GA424729@mit.edu>
References: <00000000000075a135061c0480d0@google.com>
 <tencent_BE7AEE6C7C2D216CB8949CE8E6EE7ECC2C0A@qq.com>
 <172433877725.370733.2330809797744892142.b4-ty@mit.edu>
 <6ba9afc8-fa95-478c-8ed2-a4ad10b3c520@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ba9afc8-fa95-478c-8ed2-a4ad10b3c520@huawei.com>

On Fri, Aug 23, 2024 at 10:22:19AM +0800, Baokun Li wrote:
> 
> I think this patch is wrong and it will hide the real problem.
> 
> The maximum length of a filename is 255 and the minimum block size is 1024,
> so it is always guaranteed that the number of entries is greater than or
> equal to 2 when do_split() is called.
> 
> The problem reported by syzbot was actually caused by a missing check in
> make_indexed_dir(). The issue has been fixed:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=50ea741def58
> 
> So unless ext4_dx_add_entry() and make_indexed_dir(), or some other function
> has a bug, 'split == 0' will not occur.
> 
> If we want to defend against future changes that introduce bugs, I think
> it's better to add a WARN_ON_ONCE to make sure that the problem isn't hidden
> and that it doesn't trigger serious bugs like out-of-bounds access.

I agree that given your patch (50ea741def58: "ext4: check dot and
dotdot of dx_root before making dir indexed") split should never be
zero.  (Although there are two ways this could happen --- either count
could be 0, or count == max).  But this patch isn't wrong per se
because in the case where split == 0, we do want to prevent the
out-of-bounds memory access bug.

That being said; adding a WARN_ON_ONCE(split == 0) might be a good
idea, although I'd probably also print more debugging information so
we can take a look at the file system and understand what might have
happened.  Maybe something like this?

	if (WARN_ON_ONCE(split == 0)) {
	   	/* should never happen, but... */
		ext4_error_inode_block(dir, (*bh)->b_blocknr, 0,
				"bad indexed directory? hash=%08x:%08x "
				"count=%d move=%u", hinfo->hash, hinfo->minor_hash,
				count, move);
		brelse(*bh);
		brelse(bh2);
		*bh = 0;
		return ERR_PTR(-EFSCORRUPTED);
	}

I haven't checked to make sure all of the error code paths / error
handling right, but something like this might be useful for debugging
purposes --- if the file system developer could get access to the file
system moment the error is logged.  If the data center automation
causes the file system to get fsck'ed or reformatted right away (which
is the only scalable thing to do if there are millions of file systems
in production :-), something like this is probably not going to help
all that much.  Still, it certainly wouldn't hurt.

If someone does think this would be helpful for them, I wouldn't
object to adding a patch something like this.

Cheers,

						- Ted

