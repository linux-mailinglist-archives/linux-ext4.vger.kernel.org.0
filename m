Return-Path: <linux-ext4+bounces-10570-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3904BB50F4
	for <lists+linux-ext4@lfdr.de>; Thu, 02 Oct 2025 21:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2198E426B82
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Oct 2025 19:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7902877ED;
	Thu,  2 Oct 2025 19:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="aJ0fSIfd"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6939328726B
	for <linux-ext4@vger.kernel.org>; Thu,  2 Oct 2025 19:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759435085; cv=none; b=RJhOkk8g2/Nyv3gGSYBv60LVVjr0nllNyb0bJuauJmot/h1liZwzoeVbYEV2V1pVZpmZsb4/gr76/il3dVserryvn8Q2qp5TzDQKW5AjcGofzkiuuvh/Rli/1vNRqtaB+BlfoLBdU3IhKgpbIG3ApinUefKs6LS/B++Lp1R4GNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759435085; c=relaxed/simple;
	bh=NJm0G2kFfmlKHx6vBWy3hvw7rHzNNsFK83w6VBDtdQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmzGzAHc7Maiuk8pkmxF1+K9mF2rPA7s2toNDQKODAHuKNgyIYqqS9R5Vqqk71jo7ooBwr9DdegPamofcQfoAu/26Cmu0i3+76c9DAAhhCKMqDa4e6L8NzyUPFFYbVxvtw2P4DJvlO5GGYUOBADm7X/hP4AhMnMJNvrwnq/eR/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=aJ0fSIfd; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-113-189.bstnma.fios.verizon.net [173.48.113.189])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 592JvtLg023503
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 2 Oct 2025 15:57:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1759435077; bh=VVzNSFKczNxnMv4g8WM938qHmXQSnCYoNr4MqOMTSn8=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=aJ0fSIfds44gTq9cdlppx7NhNof1+CWAw6JqngC50s8i/ErqQtxcXYHdC/62VefNy
	 3eGFrH1WJHJhvpijozzImsBa2I+TQADPzIKKc26Je8o46m08adUK7aXpVMXhtptHWX
	 8zfq0+xMa9P/MWGx2GHbdxuRJ1XBRhQI0rnOr4Y57pJ5x1e/JTZZkCb8DFWyEWYwsL
	 A3iQnOOWz/nVY2t6IC9mEKWwW1cRb5LPTPfALKfzEcu1S48PVTQPR2QfL+GUweJmkw
	 3xtbavTH0fR1c6Z+FjADNmQ1uY0U2qcxDhpP/us0McIPA5eQWhGwpRzhAjwwKklvp0
	 qtBrOOliK2EBQ==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id A0EC72E00D9; Thu, 02 Oct 2025 15:57:55 -0400 (EDT)
Date: Thu, 2 Oct 2025 15:57:55 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: reject inline data flag when i_extra_isize is zero
Message-ID: <20251002195755.GB354523@mit.edu>
References: <20251002104151.2392385-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002104151.2392385-1-kartikey406@gmail.com>

On Thu, Oct 02, 2025 at 04:11:51PM +0530, Deepanshu Kartikey wrote:
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 5b7a15db4953..d082fff675ac 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5417,6 +5417,12 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
>  
>  	if (EXT4_INODE_SIZE(inode->i_sb) > EXT4_GOOD_OLD_INODE_SIZE) {
>  		if (ei->i_extra_isize == 0) {
> +			if (ext4_has_inline_data(inode)) {

I'm not sure how we would ever enter this code code branch?
ext4_has_inline_data() is defind as follows:

	return ext4_test_inode_flag(inode, EXT4_INODE_INLINE_DATA) &&
	       EXT4_I(inode)->i_inline_off;

Sure, the inode can have the INLINE_DATA flag set, and if i_extra_size
is zero, that's an impossible situation modulo a deliberately,
maliciously corrupted file system.

But there's also the requiremnt that i_inline_off is non-zero, and at
this point in ext4_iget(), i_inline_off should still be 0.  So how
does this work?

If the instead of ext4_has_inline_data(inode), this were changed to
ext4_test_inode_flag(inode, EXT4_INODE_INLINE_ATA), this would make
sense to me.  But given that you tested this with sybot and aparently
it prevented the reprducer from triggering the issue --- this worries
me, and makes me wonder what we're missing?

We should also make sure that a test file system with this corruption
is also repaired by e2fsck.

					- Ted


> +				ext4_error_inode(inode, function, line, 0,
> +						 "inline data flag set but i_extra_isize is zero");
> +				ret = -EFSCORRUPTED;
> +				goto bad_inode;
> +			}
>  			/* The extra space is currently unused. Use it. */
>  			BUILD_BUG_ON(sizeof(struct ext4_inode) & 3);
>  			ei->i_extra_isize = sizeof(struct ext4_inode) -
> -- 
> 2.43.0
> 

