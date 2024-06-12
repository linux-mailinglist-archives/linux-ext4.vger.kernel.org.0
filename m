Return-Path: <linux-ext4+bounces-2865-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E4B90567C
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Jun 2024 17:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2529283466
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Jun 2024 15:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20D6181BB1;
	Wed, 12 Jun 2024 15:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pX1H+S7C"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6688E181BA9;
	Wed, 12 Jun 2024 15:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718204862; cv=none; b=bbohWMmF2kDUsemPkKR9nWS4lK7wVFIhh1ouXc13gem5KNKFW29fFdVucMMEJyN/nqx6yD2mJ+q8AfVzP107iEJaZdfkcPQZ6La9gw8dhs+6V06aXmlNRmsvMZQNeN8vtA5YYKE0pD5Vxn3VS7DHSRNduitHbZx+RnGTgWlVO1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718204862; c=relaxed/simple;
	bh=9NekqWvmrjHgLmsxHX2G+/ZncWBRGFcroyyNaWCh+FI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQnaTc+dSfnvqrybmSj9XOuriEp1HE2kf8uvwrwat/nu18FQ7uWkQn2O+skyf/jFXewLw7xsHdg+q8UEvW5mkJcSkUaiYi/aebafucLoy66oILy5cyww1xdwTLgyZEenxYlc6Wdm0TcTgdcYRMw/aaBdngUqy9CQFCaf3vPBtMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pX1H+S7C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DDB1C116B1;
	Wed, 12 Jun 2024 15:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718204861;
	bh=9NekqWvmrjHgLmsxHX2G+/ZncWBRGFcroyyNaWCh+FI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pX1H+S7CCZQQw1Pv2pz13ykdn5K7Ia4/WPa2o37e8o3GeMV2QQ5j2OFpUdVKHFiKX
	 dYRUpxEqa0H4lEfSqHaPVdCFmb1sGamWDDTGeRG3eBNmBpaKDq+1g2TsoN8FwcttTZ
	 WsPbFJRkcAp96zQbd2OqAS8UufRdoiaYiqQwXLTZBpYa44/HWiis+yFUmfgDbuhz+q
	 DjnxaLZ5qdBVh+2lbLwxBqNh+/lZ/tC6q6SfezgmlJMl1TJ5hk+PVjF/7UZwuBNMIe
	 b7NzBDEM/WUwjuWhEQe3A90bPyoonyTsyvsOtPQToO4rM9pJckInFEu650czyhEEye
	 gIgR8diubxYZA==
Date: Wed, 12 Jun 2024 08:07:39 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Hugh Dickins <hughd@google.com>, Yosry Ahmed <yosryahmed@google.com>,
	syzbot <syzbot+9c1fe13fcb51574b249b@syzkaller.appspotmail.com>,
	akpm@linux-foundation.org, chengming.zhou@linux.dev,
	hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, nphamcs@gmail.com,
	syzkaller-bugs@googlegroups.com, linux-ext4@vger.kernel.org
Subject: Re: [syzbot] [mm?] KMSAN: uninit-value in zswap_store
Message-ID: <20240612150739.GA1170@sol.localdomain>
References: <000000000000d0f165061a6754c3@google.com>
 <CAJD7tkaTQU1Kxt935fmq+_BJd-VT6vKFj58o7Aq+QhoyrOtCmw@mail.gmail.com>
 <02a21a55-8fe3-a9eb-f54b-051d75ae8335@google.com>
 <20240612075027.5pzkkovaewtx63n5@quack3>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612075027.5pzkkovaewtx63n5@quack3>

On Wed, Jun 12, 2024 at 09:50:27AM +0200, Jan Kara wrote:
> On Tue 11-06-24 02:13:59, Hugh Dickins wrote:
> > On Mon, 10 Jun 2024, Yosry Ahmed wrote:
> > > Hugh, do you mind taking a quick look at whether this is a real bug?
> > > 
> > > If this is expected behavior, perhaps there is some annotation we can
> > > use in zswap that it is fine to encounter uninitialized data when
> > > reading the folio.
> > 
> > I've not been faced with a KMSAN report before, so I might well be
> > misunderstanding its language: but this looks like an ext4 "bug" to me.
> > 
> > I think the story that the three KMSAN stacks are telling is this:
> > syzbot has an ext4 filesystem on a loop device on a tmpfs file (I do
> > exactly that too); ext4 is doing some ext4_xattr_inode_write() business,
> > in the course of which it writes back a not-fully-initialized block to
> > the loop device; shmem faithfully copies that data into its pagecache,
> > then later when under memory pressure that page gets "written" out to
> > zswap: where zswap_is_page_same_filled() takes an interest in the data,
> > and KMSAN objects because some of it was not originally initialized.
> > 
> > If that's a correct interpretation, then it's probably not a big deal:
> > it's probably the uninitialized end of a buffer that's written out,
> > not any part of the "disk" which ext4 would ever show to a user; but
> > I do agree with KMSAN that ext4 would do better to clear that area,
> > rather than accidentally storing someone else's super-secret info.
> 
> Yes, that seems to be accurate.  ext4_xattr_inode_write() stores large
> extended attribute in the inode and we don't bother to zero out the tail of
> the block we use since we never access bytes beyond xattr size. Frankly I
> don't consider this a bug since the uninitialized bytes are never exposed
> to (unpriviledged) userspace. But I agree that out of pure precaution and
> because it doesn't cost much in terms of performance we could zero out the
> block tail.

Writing uninitialized memory to disk is definitely a bug.

- Eric

