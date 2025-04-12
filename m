Return-Path: <linux-ext4+bounces-7216-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7948FA86FD0
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Apr 2025 23:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A2BF171583
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Apr 2025 21:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446951A0739;
	Sat, 12 Apr 2025 21:53:23 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366F8F4ED
	for <linux-ext4@vger.kernel.org>; Sat, 12 Apr 2025 21:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744494803; cv=none; b=Xg8kyuND75noXRYxhashh9UgRqpwLStNwNH9MWzFcUGIniRKFM3PFwSd1OwgZOXzhBDeDw7y6gQ9kzpNK/jBKH6jo3qYO2DaJbjeCkHaU9kL9ehXEGMaKiDMykZpVWINB07iETx8kcUJ7w0KJKJySlYW7M5OWqBW+nyO7GyKcas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744494803; c=relaxed/simple;
	bh=Zbs/TcJE/Yr0ARJquYUmR8vlylohAXTmvMb/IC0mplU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sZCYJ73p6BmYMIZLH+eNkEDT4y3ly6F+BrOSx5z9uL2jY1JIjLjqfAPoQ5ttHxqiV84qeRdNRl77wjLX5OLy7GkQeYvI0OzyMNcA2vQWjEXVHXKdORRtPnhm8CGsT32P5sJSc5lBgHc3bbWmZot7JRzi49dydfiyYwPOKwtTH0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-137.bstnma.fios.verizon.net [173.48.82.137])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 53CLqwkd017084
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Apr 2025 17:52:58 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id C3C412E00E9; Sat, 12 Apr 2025 17:52:57 -0400 (EDT)
Date: Sat, 12 Apr 2025 17:52:57 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: generic_permission() optimization
Message-ID: <20250412215257.GF13132@mit.edu>
References: <CAHk-=whJgRDtxTudTQ9HV8BFw5-bBsu+c8Ouwd_PrPqPB6_KEQ@mail.gmail.com>
 <20241031-klaglos-geldmangel-c0e7775d42a7@brauner>
 <CAHk-=wjwNkQXLvAM_CKn2YwrCk8m4ScuuhDv2Jzr7YPmB8BOEA@mail.gmail.com>
 <CAHk-=wiKyMzE26G7KMa_D1KXa6hCPu5+3ZEPUN0zB613kc5g4Q@mail.gmail.com>
 <CAHk-=wiB6vJNexDzBhc3xEwPTJ8oYURvcRLsRKDNNDeFTSTORg@mail.gmail.com>
 <CAHk-=whSzc75TLLPWskV0xuaHR4tpWBr=LduqhcCFr4kCmme_w@mail.gmail.com>
 <a7gys7zvegqwj2box4cs56bvvgb5ft3o3kn4e7iz43hojd4c6g@d3hihtreqdoy>
 <CAHk-=wgEvF3_+sa5BOuYG2J_hXv72iOiQ8kpmSzCpegUhqg4Zg@mail.gmail.com>
 <CAGudoHGxr5gYb0JqPqF_J0MoSAb_qqoF4gaJMEdOhp51yobbLw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHGxr5gYb0JqPqF_J0MoSAb_qqoF4gaJMEdOhp51yobbLw@mail.gmail.com>

On Sat, Apr 12, 2025 at 06:26:09PM +0200, Mateusz Guzik wrote:
> > I tried to do the same thing for ext4, and failed miserably, but
> > that's probably because my logic for "maybe_acls" was broken since I'm
> > not familiar enough with ext4 at that level, and I made it do just

Linus, what problems did you run into?

> >         /* Initialize the "no ACL's" state for the simple cases */
> >         if (!ext4_test_inode_state(inode, EXT4_STATE_XATTR) && !ei->i_file_acl)
> >                 cache_no_acl(inode);
> >
> > which doesn't seem to be a strong enough text.

Linus, were you running into false positives or false negatives?  You
said "failed miserably", which seems to imply that you ran into cases
where cache_no_acl() got called when the inode actually had an ACL ---
e.g., a false positive.

That's different from what Mateuz is reporting which is that most
inodes w/o ACL were getting cache_no_acl(), but some cases
cache_no_acl() was't getting called when it should.  That is, a flase
negative:

> bpftrace over a kernel build shows almost everything is sorted out:
>  bpftrace -e 'kprobe:security_inode_permission { @[((struct inode
> *)arg0)->i_acl] = count(); }'
> 
> @[0xffffffffffffffff]: 23810
> @[0x0]: 65984202
> 
> That's just shy of 66 mln calls where the acls were explicitly set to
> empty, compared to less than 24k where it was the default "uncached"
> state.
> 
> So indeed *something* is missed, but the patch does cover almost everything.

So the test which we're talking about:

> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 4008551bbb2d..34189d85e363 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5071,7 +5071,12 @@ struct inode *__ext4_iget(struct super_block
> *sb, unsigned long ino,
>                 goto bad_inode;
>         }
> 
> +       /* Initialize the "no ACL's" state for the simple cases */
> +       if (!ext4_test_inode_state(inode, EXT4_STATE_XATTR) && !ei->i_file_acl)
> +               cache_no_acl(inode);
> +
>         brelse(iloc.bh);
> 

tests if the inode does not have an extended attribute.  Posix ACL's
are stored as xattr's --- but if there are any extended attributes (or
in some cases, inline data), in order to authoratatively determine
whether there is an ACL or not will require iterating over all of the
extended attributes.  This can be rather heavyweight, so doing it
unconditionally any time we do an iget() is probably not warranted.

Still, if this works 99.99% of the time, given that most peple don't
enable inline_data, and most folks aren't setting extended attributes,
it should be fine.  Of course, given that SELinux's security ID's are
stored as extended attriutes, at that point this optimization won't
work.  But if you are using SELinux, you probably don't care about
performance anyway.  :-)

					- Ted

