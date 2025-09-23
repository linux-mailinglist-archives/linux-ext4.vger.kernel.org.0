Return-Path: <linux-ext4+bounces-10372-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 352ECB95C88
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Sep 2025 14:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A10813A77D8
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Sep 2025 12:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A36322DC9;
	Tue, 23 Sep 2025 12:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="TBTj2fHD"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB6F322DA7
	for <linux-ext4@vger.kernel.org>; Tue, 23 Sep 2025 12:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758629411; cv=none; b=ZnWtfh7goxPlG1B8ZMHEEWg7Ciu7x9ZosItZdbrBFl+3tR/G+nY8KXH3d4/nZsqedDR+ew8Fh+JH4gayzzlipvYE1JlQ4xq+brF2z1rUrP96sCvWyQ1zmh2I3qWB1IX/BdPW7th06XYVa/2jYYIO5lywlXrRg1+Qxx7uf5CnFSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758629411; c=relaxed/simple;
	bh=86ujaIA25Y7ndJzivkOtthSsdvh4Gt2SZ0tHSdykE3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lkoW1yHgyxUhYAIr3B1nacEHYMCs1bfHS79kodc3nAI7575t5IOHl4ESZElJnfXJB/9FBZs1DwVDdPNV7ujbku+HHX2VK6eIvEgC6oNfw7BVkJF0DZFXS/DRcIkEz3oAZX2WWNbX/4qlV9wXs/L0+AmPXNiWPgHYwuh56u6JwQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=TBTj2fHD; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-223.bstnma.fios.verizon.net [173.48.111.223])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 58NC9sO7032033
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Sep 2025 08:09:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1758629396; bh=49iSOLLb1QbNUwpl4qSuS6TXaZr85TUR3lyHl4NFknM=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=TBTj2fHDDkjX5dnKLKb7ihDbF/qWAya+ZHrGysVeEzWuGWTfVXxWpDvJlTVUdeKTt
	 Deytw8r5LEXUbKI7t4bpOfHH6IeawWmTwwBpAACeSrvbLauOn4D1sLUPsqNVOTRnLp
	 mqeWRUVjmeWSGLs7juijAauFLQpo4W9rcw0V85tIThdYOVYsbnW1n/usYOLezkQMnz
	 XoHO6wnsMH0KrTej51GodS3qAUfV5YcsklVJHjTgMkXRsOBEaQgrUnNMuXshyxbMJR
	 HgAkqJf9lvESjV1l+zWQdhYVI05kYO4Lt2BT5+h4bR4y5+DRiaNb/7WSnN4BNBr+E6
	 q3vcbWIzo1Ghg==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 2B5832E00D9; Tue, 23 Sep 2025 08:09:54 -0400 (EDT)
Date: Tue, 23 Sep 2025 08:09:54 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+4c9d23743a2409b80293@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: validate xattr entries in ext4_xattr_move_to_block
Message-ID: <20250923120954.GA531144@mit.edu>
References: <20250923092512.1088241-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923092512.1088241-1-kartikey406@gmail.com>

On Tue, Sep 23, 2025 at 02:55:12PM +0530, Deepanshu Kartikey wrote:
> During inode expansion, ext4_xattr_move_to_block() processes xattr entries
> from on-disk structures without validating their integrity. Corrupted
> filesystems may contain xattr entries where e_value_size is zero but
> e_value_inum is non-zero, indicating the entry claims to store its value
> in a separate inode but has no actual value.
> 
> This corruption pattern leads to a WARNING in ext4_xattr_block_set() when
> it encounters i->value_len of zero while i->in_inode is set, violating
> the function's invariant that in-inode xattrs must have non-zero length.
> 
> Add validation in ext4_xattr_move_to_block() to detect this specific
> corruption pattern and return -EFSCORRUPTED, preventing the invalid
> data from propagating to downstream functions and causing warnings.
> 
> Reported-by: syzbot+4c9d23743a2409b80293@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?extid=4c9d23743a2409b80293
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>

Thanks for the patch!  Could you try moving the validation test to the
check_xattrs() function?  This should hopefully catch other
maliciously fuzzed file systems so it might address other syzbot
complaints.

Something like:

		if (ea_ino && !size) {
			err_str = "invalid size in ea xattr";
			goto errout;
		}

In retrospect, we probably should have had the code interpret
e_value_size==0 as meaning that the xattr entry is always unused, so
that tests such as:

		if (!last->e_value_inum && last->e_value_size) {

could become

		if (last->e_value_size) {

But there are also places where the code assumes that if e_value_inum
is non-zero, it doesn't need to test e_value_size.

It should be the case where whenever we clear e_value_inum, we also
set i_value_size to zero.  So having e_value_num!=0 && e_value_size==0
should only be the case when someone is trying to maliciously play
games with us.

Cheers,

						- Ted

