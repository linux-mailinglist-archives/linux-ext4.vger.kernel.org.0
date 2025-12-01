Return-Path: <linux-ext4+bounces-12101-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB72C98364
	for <lists+linux-ext4@lfdr.de>; Mon, 01 Dec 2025 17:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 028DF343A61
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Dec 2025 16:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975003346BF;
	Mon,  1 Dec 2025 16:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="IiD3gCmb"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2303321D5
	for <linux-ext4@vger.kernel.org>; Mon,  1 Dec 2025 16:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764606053; cv=none; b=kfjgQdOeV8NJXQUd5u8JF/5Ua2SoeGbjOoldPZG19ECiASYi6Gi7pKb6/7p49QxktQcV5GDVI2O6CAq81FxDWNWiagHsUMupnbpQBzpr9GoLVD1N95QTTfW1ZzwHHOVUtnAFMSgPUxOFMmbURv72PsGuY0IIaaFO91J9wYUzzYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764606053; c=relaxed/simple;
	bh=HE3eTM8DkYirP9jRJ8AUnYsLYDbDAPHy/nkGHspPXX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mz/79EAhAtMnJ4IkeLJqK80vDqFR/nUJA7c/jMdt3MuOgB6Ifbj7gl3+YEhyWehUUYe+MSHSUsDFwQFXngvfIu15EVW3Tv8jaz+g+rjBZlFD1WOkhKaJ1DiJWwhsKYHg4ssO3CkjAZis7keLugcu9MVrwFwuiJJozmCDYiHB5y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=IiD3gCmb; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (pool-173-48-121-67.bstnma.fios.verizon.net [173.48.121.67])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5B1GHngh031640
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 1 Dec 2025 11:17:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1764605871; bh=9+UGEcRr5PXV2wncEXP/f1rUCaM4qAqJF9+IOFq9QdQ=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=IiD3gCmbyBCjWidLqx2u6bCOcHIf73KisYdzj7c8MXixBW0GrtbHWQHgCg2iDc943
	 Dyyszp6/ad9MqYEXXP/66p6hWsOMgU13r0SkvTvA5ocEA7vCcm/FU/XQUM1/5pIsbf
	 LpZYaGw0y5ogUGw2rQkefG8ToST2UN707gbjuFV40cglgg1pTEzDoaSjUiGtJHjLfE
	 x429an9U3iLr5zstFPetBIsq0fVJGMTkr+dFn7enBoNQSOcLAuw7Ob0Dv6SmqU35c0
	 xl4tvM20Jb/WyTeGxtx9jECyL7AE41X5UHLTli0/4+5iIt/vYqJR+dFmsUBzw9OXy5
	 O8wGkacQCHB2Q==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 9F0DA4DB1B85; Mon,  1 Dec 2025 11:16:48 -0500 (EST)
Date: Mon, 1 Dec 2025 11:16:48 -0500
From: "Theodore Tso" <tytso@mit.edu>
To: syzbot <syzbot+bb2455d02bda0b5701e3@syzkaller.appspotmail.com>
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ext4?] possible deadlock in ext4_destroy_inline_data
 (2)
Message-ID: <20251201161648.GA52186@macsyma.lan>
References: <690bcad7.050a0220.baf87.0076.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <690bcad7.050a0220.baf87.0076.GAE@google.com>

This is a flase positive.  The potential deadlock scenarious dentified
by lockdep doesn't happen in real life because one of the locking
dependency chain happens when we are doing orphan file cleanup while
we are also eneding to expand an inode's extra size:

> -> #1 (&sbi->s_writepages_rwsem){++++}-{0:0}:
>        lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
>        percpu_down_read_internal+0x48/0x1c0 include/linux/percpu-rwsem.h:53
>        percpu_down_read include/linux/percpu-rwsem.h:77 [inline]
>        ext4_writepages_down_read fs/ext4/ext4.h:1796 [inline]
>        ext4_writepages+0x1cc/0x350 fs/ext4/inode.c:3024
>        do_writepages+0x32e/0x550 mm/page-writeback.c:2604
>        __writeback_single_inode+0x145/0xff0 fs/fs-writeback.c:1719
>        writeback_single_inode+0x1f9/0x6a0 fs/fs-writeback.c:1840
>        write_inode_now+0x160/0x1d0 fs/fs-writeback.c:2903
>        iput_final fs/inode.c:1901 [inline]
>        iput+0x830/0xc50 fs/inode.c:1966
>        ext4_xattr_block_set+0x1fce/0x2ac0 fs/ext4/xattr.c:2199
>        ext4_xattr_move_to_block fs/ext4/xattr.c:2664 [inline]
>        ext4_xattr_make_inode_space fs/ext4/xattr.c:2739 [inline]
>        ext4_expand_extra_isize_ea+0x12da/0x1ea0 fs/ext4/xattr.c:2827
>        __ext4_expand_extra_isize+0x30d/0x400 fs/ext4/inode.c:6364
>        ext4_try_to_expand_extra_isize fs/ext4/inode.c:6407 [inline]
>        __ext4_mark_inode_dirty+0x46c/0x700 fs/ext4/inode.c:6485
>        ext4_evict_inode+0x80d/0xee0 fs/ext4/inode.c:254
>        evict+0x504/0x9c0 fs/inode.c:810
>        ext4_orphan_cleanup+0xc20/0x1460 fs/ext4/orphan.c:470
>        __ext4_fill_super fs/ext4/super.c:5617 [inline]
>        ext4_fill_super+0x5920/0x61e0 fs/ext4/super.c:5736
    ....

And the other is in the inode writeback path:

> -> #0 (&ei->xattr_sem){++++}-{4:4}:
>        check_prev_add kernel/locking/lockdep.c:3165 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3284 [inline]
>        validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3908
>        __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
>        lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
>        down_write+0x96/0x1f0 kernel/locking/rwsem.c:1590
>        ext4_write_lock_xattr fs/ext4/xattr.h:157 [inline]
>        ext4_destroy_inline_data+0x28/0xe0 fs/ext4/inline.c:1787
>        ext4_do_writepages+0x526/0x4610 fs/ext4/inode.c:2810
>        ext4_writepages+0x205/0x350 fs/ext4/inode.c:3025
>        do_writepages+0x32e/0x550 mm/page-writeback.c:2604
>        __writeback_single_inode+0x145/0xff0 fs/fs-writeback.c:1719
>        writeback_sb_inodes+0x6c7/0x1010 fs/fs-writeback.c:2015
>        wb_writeback+0x43b/0xaf0 fs/fs-writeback.c:2195
    ...

So the first happens while we are mounting the file system, and the
second happens after the file system is mounted and we have written to
a file.

That being said, we probably should just not try to expand the inode's
extra size while evicting the inode.  In practice we don't actually do
this since we haven't expanded the inode's extra size space in over a
decade, and so this only happens in a debugging mount option that
syzbot helpfully uses, and not in real life.

Also, there's no real point in doing this on the evict path,
especially if the inode is about to be released as part of the
eviction.

						- Ted

