Return-Path: <linux-ext4+bounces-12341-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CA1CBA0CA
	for <lists+linux-ext4@lfdr.de>; Sat, 13 Dec 2025 00:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6B9F3082351
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Dec 2025 23:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE331E3DED;
	Fri, 12 Dec 2025 23:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="T5L7O2K3"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271BB1E4BE
	for <linux-ext4@vger.kernel.org>; Fri, 12 Dec 2025 23:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765582552; cv=none; b=D8nz7WpYAvWceRxnQ9ZJ3cK9oCiSSvB3llCxSFGwIRowYXlcH6Whu7ZgCeiBiUfOF3XvETAn+Oeu1Gu1IK7lBM806mBMpitxrsLZ9Zp09n2J3kFqNQyqdGQJkOMrRGuXuv8rQVTda8g5rkyRwDgbbbjM+G18M0e5WOUefuEnZb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765582552; c=relaxed/simple;
	bh=D4+sksM0eVo8IGYGQJW41eAr/3L20WCYTlQk+SbgzBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMGseP6wEMBUOpAYeCvhPybY+EUu+/Je/jS7OcgKxUQzGyCQawxaqDAlQS3+VkYUZTfN2GjgYLn27lZmca+ttFp2pOtiD1H4Ff4QW2Sy4CAE8xUHRMNTTKRQFOSC/iXb47SWyhHoDORFD9yYf9BIlf54A0+KacjEERDnMTcIhPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=T5L7O2K3; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (fs96f9c61d.tkyc509.ap.nuro.jp [150.249.198.29])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5BCNZcFt015347
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Dec 2025 18:35:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1765582542; bh=oSdWxFYYDJ7AKF/hNJQwumrsAh3GC+dBMxCmjAE09Ss=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=T5L7O2K3u+ekK7Iw3/uKFaJBuM5xz0FGAXpFILYEYW1KlIf1NX7bC4tr11zK71llP
	 gYXR3NmnlNQlrHsrlITS+dMQdgicn9av1uDHpmd6rPk/Kca18eU4RCK/53udPXdplD
	 EuXTLdQsBgcjfz1fS2Od3NKi4OUJs2Lk3z3WwmVGQ0GQDXuqLlN77QJEC2v1/8z/hA
	 hDhixg6AKhPwyyCPrkH+kKKXlmlGHvE97BSFEdPIJrgavuWWE2kK3f7zT04nOgbtH7
	 7ZVrfniZ4ytyl8O7QkkLwFFsImo2aPpho/hw0Lh3sIi8RVcBbn0XMsutFfYU1edyeW
	 iYCIu40fcR/EQ==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 5BCE54FD2BCF; Sat, 13 Dec 2025 08:35:37 +0900 (JST)
Date: Sat, 13 Dec 2025 08:35:37 +0900
From: "Theodore Tso" <tytso@mit.edu>
To: Andi Kleen <ak@linux.intel.com>
Cc: Winston Wen <wentao@uniontech.com>, linux-ext4@vger.kernel.org
Subject: Re: Inquiry: Possible built-in support for longer filenames in ext4
 (beyond 256 bytes)
Message-ID: <20251212233537.GC88311@macsyma.local>
References: <63C71AFEB9EEBDC8+20251210145935.72a6f028@winn-pc>
 <20251210090536.GB42106@macsyma.local>
 <2EB6F335572BB77B+20251210173202.58c83465@winn-pc>
 <20251210232459.GD42106@macsyma.local>
 <87pl8jzi3n.fsf@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pl8jzi3n.fsf@linux.intel.com>

On Fri, Dec 12, 2025 at 10:10:36AM -0800, Andi Kleen wrote:
> 
> Perhaps you could use xattrs on the directory inode to store the longer
> names, or the overflow.
> 
> One problem is that they may need to be big, exceeding xattr
> limits, but perhaps some total limit on the longer file names
> would be acceptable.

With ext4, there is a limit of a single file system block for all
extended attributes.  You can store the value of extended attribute in
an inode, in which case you only have the four byte inode number in
the xattr block.  But still, if you assume 16 bytes of overhead for
each xattr entry, plus the xattr header, there's only room for 9 400
byte directory entries.

And you wouldn't want to have a lot of directory entries stored in
xattrs anyway, since searching them would have to be a brute force,
O(n) search.  You wouldn't be able to use a hash tree for fast
lookups.

So even if you didn't have the xattr limits, if you had a large number
of very long file names stored in xattrs, it would be a performance
disaster.

Cheers,

						- Ted





