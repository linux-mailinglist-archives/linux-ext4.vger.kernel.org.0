Return-Path: <linux-ext4+bounces-12280-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E3519CB43ED
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Dec 2025 00:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51ECC3014623
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Dec 2025 23:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8AF2E7BDD;
	Wed, 10 Dec 2025 23:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="A+Ad08NS"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396C125D53B
	for <linux-ext4@vger.kernel.org>; Wed, 10 Dec 2025 23:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765409119; cv=none; b=PxvCKlu7CPDG28kfPTxGyH1navEge4uoN+3ZO5W/dSIwTi8tjDzbxTWWdPweU+6nI8+X0W4mEifl3GCuP1wBr0asTVxLYB6wLNHVe27fuQDQWNS//NO9r8FD8Rgut3uiUnE8WdPyqUT+gY2ENPvJ4J34BGwJvoHxxk0Uxjid9OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765409119; c=relaxed/simple;
	bh=bhrlLuMeo0oU7OF90TT3IcZanUEIY1nDJkAQRv3Z39U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBfg4XthBpKVxQdpex23aB92JGC8z5+22uGmNy3YGHM3xjsXpon+yu+y9wd7JQtqqKxJ9ybVOuFLuzlabzlPvapjqt/BQrcCXNH0Vhb8aOM7TA6w+Oigsqb5QShPUDrmcAo9BkwrinADi4Kh6tKAeaHrjj4oYIIFWvbUZfqXoQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=A+Ad08NS; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (fs96f9c61d.tkyc509.ap.nuro.jp [150.249.198.29])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5BANP10C028930
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Dec 2025 18:25:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1765409104; bh=ywlwlW8qmfavg7/ahTDuIeVOSnaTXK8uBENtwL59MLQ=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=A+Ad08NS9TAJYtU5U1LpUdxnfGVs+XrxIco3DOLU+DeeACO0A38q5auwY+CBf7/XI
	 Wv2T8FQSpKDHURNTtwI+4f9uoabZ6YW/7qvVXQWRY8ju3qp2odxpPwmj5vn9fIBQ78
	 j3H7glI3xBO3jknVW2YTtXg5Y6VIwNgCB40YDBRafn0uN+uIwji1uw1Mkt3vlE9E1L
	 xou+iRTTp1C5QCGsjbb22iGiGkb0u9Q/S6oMZK/mM1sXZ1/7foQ03Wm38OJ+Qg1mk5
	 hGLIUSogslCoOS6yZKyFXOVfwQNBfOo/1RJ9CJ/O8NqvvEluREDtZtuMIo3jC3/Rr9
	 LynvSChQ50AUg==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id BF8D64F8CE94; Thu, 11 Dec 2025 08:24:59 +0900 (JST)
Date: Thu, 11 Dec 2025 08:24:59 +0900
From: "Theodore Tso" <tytso@mit.edu>
To: Winston Wen <wentao@uniontech.com>
Cc: linux-ext4@vger.kernel.org
Subject: Re: Inquiry: Possible built-in support for longer filenames in ext4
 (beyond 256 bytes)
Message-ID: <20251210232459.GD42106@macsyma.local>
References: <63C71AFEB9EEBDC8+20251210145935.72a6f028@winn-pc>
 <20251210090536.GB42106@macsyma.local>
 <2EB6F335572BB77B+20251210173202.58c83465@winn-pc>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2EB6F335572BB77B+20251210173202.58c83465@winn-pc>

On Wed, Dec 10, 2025 at 05:32:02PM +0800, Winston Wen wrote:
> To better understand, I’ve reviewed the readdir/getdents man pages and
> the glibc struct dirent definition. It appears that d_name is
> implemented as a flexible array member rather than a fixed-size array
> of 256 bytes.

Intresting; the struture definition I quoted was from the readdir man
page.

I suspect there may be some number of random failures that might occur
because of hidden dependencies on the historical / traditional value
of NAME_MAX.  For example, it might be OK for glibc; but what about
other C libraries that ship on Linux, such as musl, dietlibc, bionic,
etc.?

> Going back to our original question: we were curious whether it might
> be possible to support longer filenames natively within ext4 itself
> (rather than through FUSE), perhaps via on-disk format extension or
> auxiliary storage like xattrs. If this is architecturally feasible, we
> would be very interested in exploring it further.

Well, extended attributes won't work, because xattrs are associated
with the inode, not the directory entry.  So you need to handle cases
where the file has multiple hard links.  And if you are doing a lookup
by long file name, there's a chicken and egg problem; you can't match
against the full filename until you read the xattr, and you can't do
that until you've lookup.

The only way to do this would be to make an incompatible change to the
directory layout.  And doing this would require either refactoring and
doing extensive rework of the code in fs/ext4/namei.c and
fs/ext4/dir.c, to support both the the original v1 version of the
directory layout, and the v2 version of the directory layout, as well
as handling the v2 verison of the directory when it is encrypted.
It's _doable_, but it's a huge amount of work.  So the question is
whether it's worth it.  If this is some random class project where you
don't care about bugs or reliability, that's one thing.  If this is
something that need to be hardened for production usage, it's quite a
lot more work.

Why are you interested in doing this?  Is there business justification
such that your company would be willing invest a significant amount of
effort?

Cheers,

						- Ted

