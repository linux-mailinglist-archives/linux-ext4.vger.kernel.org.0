Return-Path: <linux-ext4+bounces-4595-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9B89A145D
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Oct 2024 22:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98E9A1C21A73
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Oct 2024 20:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C201C4A28;
	Wed, 16 Oct 2024 20:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="pRGDOSpZ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245544409
	for <linux-ext4@vger.kernel.org>; Wed, 16 Oct 2024 20:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729111693; cv=none; b=Dddme2k3VDkeiAFrCTRn7wI0cfCKf8FhyVZ8GMTze6J85fWYCJQmHqXatSLRn736PnbZQk9AbgNV3o23nerKVILIq3oyjp5f27AeJIV/yTEX99G2W5xBZca+uYA1ZKoT9JoYVkYR0JJTrIw5nmYxifwpgJLSHtOdyJAh+6AFXgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729111693; c=relaxed/simple;
	bh=s5jdB/47iAqJ1SA9t4Fiz1puiR5Vpvt284TpWBzKAwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6DfUm9ksUjMaj4RG/5M1UOpiWxNRxNgX/NR/WBOz+APsxK9VHq++zyk5GR0+ovcC0FhU/OlLrUHP3Ln7klKjQKmgewhNUVRHjBppozV1upyCq+WqrOHCKxSzICSedWt1svwIscWcWJ7a8eaCtZnQM7MY1BUdLzb3SGHM1pL+7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=pRGDOSpZ; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-118-108.bstnma.fios.verizon.net [173.48.118.108])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 49GKlf2x032094
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 16:47:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1729111664; bh=ZQfBRGme9pAxatUx6tTKcx5TVoNCSmdhu0qbM7fqxB4=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=pRGDOSpZupS963yqAF/o7YmgBqT+cbUZFuVNT8g2HOFVddNY2+ujsVZvyww6oBGwi
	 6widAQVX9wLzDlYe22RH4uoaFdUYqSXAAVqX6Aobp8Gcx+3slyefatJ2U4GoZyhjuK
	 hDbk6JXwaona0Il3TPpdi0Fav/S/UCDwdVIQA9a9jUDSEd7yyfoqCrRnsYHFeYCidw
	 Qd1664UP1EunjqFTU2OCjFd2nF+0hxzvFHcbgKfdqt1qVFpmuj9RBK9Vtodxd9pc3L
	 uq29rhpUiVsWRZuYmp1/UNinEywlB5Yr8/d7tQiV3HkTi+ivk9kYeSU9kb0HEF1iQf
	 s/CIwyoyIgdhg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 6566E15C02DB; Wed, 16 Oct 2024 16:47:41 -0400 (EDT)
Date: Wed, 16 Oct 2024 16:47:41 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Baokun Li <libaokun1@huawei.com>
Cc: Jan Kara <jack@suse.cz>, Qianqiang Liu <qianqiang.liu@163.com>,
        adilger.kernel@dilger.ca,
        syzbot <syzbot+f792df426ff0f5ceb8d1@syzkaller.appspotmail.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, Yang Erkun <yangerkun@huawei.com>
Subject: Re: [PATCH] ext4: fix out-of-bounds issue in ext4_xattr_set_entry
Message-ID: <20241016204741.GA3204734@mit.edu>
References: <Zu+vI3EipxSsPOMe@thinkpad.lan>
 <66efba95.050a0220.3195df.008c.GAE@google.com>
 <Zu+8aQBJgMn7xVws@thinkpad.lan>
 <d62a25e9-04de-4309-98d1-22a4f9b5bb49@huawei.com>
 <20241009155028.u7jpzrw6txldt43j@quack3>
 <05f9c7c2-655a-4f5b-be8e-93f511a954bd@huawei.com>
 <20241014163120.hinbd5jc6mp4vev7@quack3>
 <3930aad6-174d-4422-944e-6c90a3ea065a@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3930aad6-174d-4422-944e-6c90a3ea065a@huawei.com>

On Wed, Oct 16, 2024 at 04:02:40PM +0800, Baokun Li wrote:
> As server clusters get larger and larger, server maintenance becomes very
> difficult. Therefore, timely detection of problems (i.e. online scanning,
> similar to e2fsck -fn) and timely and non-stop fixing of problems (i.e.
> online fsck, similar to e2fsck -a) have always been the requirements of
> our customers. Thus online fsck has been on our TODO list, and it's really
> time to start doing it. 😀

As far as online scaning is concerned, if you are using LVM, we can
use a combination of dm-snapshot and e2fsck -fn --- that is what the
e2scrub command automates.

Online fsck is much harder, since it would require back pointers to do
this efficienctly.  To do this, a general way of solving this would
involve a generalized some kind of b-tree or b+tree where changes are
managed via jbd2.  This could be used so that (for example) if we had
a tree which maps block ranges to an inode number, then given a block
number, we can figure out which inode "owns" that block.  The harder
part is those objects that have multiple forward pointers --- for
example an inode might have multiple hard links to multiple
directories, so we need to handle this somehow.

If we had the jbd2-aware b+tree, we could also use this add support
for reflink/clone, which would also be cool.

If this is something that your team really weants to work on, what I'd
suggest is to create a rough design of what the journaled b+tree would
look like, and then implement it first, since this is the prerequisite
for a huge number of advanced file system features.  Implementation
should be done in a way that makes it easy for the code to be usable
both in the kernel and in e2fsprogs, since life will be much easier if
we have e2fsck and debugfs support for the new file system data
structures from the very beginning of the development.

If your company is willing to invest in the engineering effort to do
this, great!  But I have to point out that an alternative approach
that you should consider is whether XFS might be a closer match for
some of your customers' needs.  The advantage of ext4 is that it is
much simpler and easier to understand that XFS.  But as we add these
new features, ext4 will get more complex.  And so one of the design
considerations we should keep in mind is to keep ext4 as simple and
miantainable as possible, even as we add new functionality.

Cheers,

						- Ted

