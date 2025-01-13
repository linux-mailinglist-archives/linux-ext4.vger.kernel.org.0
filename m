Return-Path: <linux-ext4+bounces-6067-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4868EA0C15C
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Jan 2025 20:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E172165A89
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Jan 2025 19:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724D91C5D7E;
	Mon, 13 Jan 2025 19:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="H9ol8YiP"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A47F1B21BC
	for <linux-ext4@vger.kernel.org>; Mon, 13 Jan 2025 19:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736796378; cv=none; b=gDJsY3BLVqfTPJlSAkxqcIgQndpJf82SLMPtCQ3Am38KSZAjfCkG4QWSH+Oi86BFgNs6ujDMaipBu2ryp2XD+emUrX7zrL5cFYjArY1JU+mHHHqhOWfSapYsAn1hSapi/4ss9i9JXujkNja6/q4SfpaheRCVA1AulLwvizjsnjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736796378; c=relaxed/simple;
	bh=gjtCWMVAcVEY3Ig8XqpeaoQtCHDhgj+pHuAUZvZEoGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1AI0IKvryxshSXa63HW0+/6NYe4W3B+HSjSj7/psmyoRpNmpe1wN6QXgnSloLpTZbZirHlcfxpY0M7Orel56GM7oZiUCiR1eKC4PAOvr2KmgtY0DD+f42+Kb45dtEiM93KW0k0isqJDITo8ehKh+/1o8RHs/Iyh1cSYxcaNiJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=H9ol8YiP; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-229.bstnma.fios.verizon.net [173.48.82.229])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 50DJQ332031488
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 14:26:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1736796365; bh=eAwchZwZGUQHq6Kb1GScy92lPymhMMz6ghymT3RjY94=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=H9ol8YiPU0ZzEDMKWDxtq4RsduJqGDBW1+2yZXIgbkOAZ/xnoDt1cMvkSxhW8qVAi
	 zDp5SAk144dYkAo1PKGNoYizW4opsUbt0LsPscXGEYgw6GSYerHjqeaoRhsAd0jbpO
	 JIeRD7yVujcb20iBLUlylVMkjbc6byU3SIy0riLBAi5A+q1qwZc8Yop6MTcZGkfIKS
	 Pgf0CS/RhCQFDmL8NPyOiBOmgJE+YO/NdKdSyYyxTK55vVd/HMn0g3kSFu0ro9YVky
	 j69r2llG54SGCMUxcrYui73Y6HIA8Snqjz9rBHubYVS1Q60WNMpYcfts0GRj/60LAF
	 5DV9VwS6qfzvw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 4593615C0135; Mon, 13 Jan 2025 14:26:03 -0500 (EST)
Date: Mon, 13 Jan 2025 14:26:03 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Catalin Patulea <cronos586@gmail.com>, linux-ext4@vger.kernel.org,
        Kazuya Mio <k-mio@sx.jp.nec.com>
Subject: Re: e2fsck max blocks for huge non-extent file
Message-ID: <20250113192603.GA1950906@mit.edu>
References: <CAE2LqHL6uY=Sq2+aVtW-Lkbu9mvjFkaNqLaDA8Bkpmvx9AjHBg@mail.gmail.com>
 <20250113163345.GO1284777@mit.edu>
 <20250113183517.GC6152@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113183517.GC6152@frogsfrogsfrogs>

On Mon, Jan 13, 2025 at 10:35:17AM -0800, Darrick J. Wong wrote:
> 
> Hmm -- num_blocks is ... the number of "extent records", right?  And on
> a !extents file, each block mapped by an {in,}direct block counts as a
> separate "extent record", right?
> 
> In that case, I think (1U<<31) isn't quite right, because the very large
> file could have an ACL block, or (shudder) a "hurd translator block".
> So that's (1U<<31) + 2 for !extents files.
> 
> For extents files, shouldn't this be (1U<<48) + 2?  Since you /could/
> create a horrifingly large extent tree with a hojillion little
> fragments, right?  Even if it took a million years to create such a
> monster? :)

The code paths in question are only used for indirect mapped files.
The logic for handling extent-mapped files is check_blocks_extents()
in modern versions of e2fsprogs, which is why Catalin was only seeing
this for an ext3 file systems that had huge_file enabled.

You're right though that we shouldn't be using num_blocks at all for
testing for regular files or directory files that are too big, since
num_blocks include blocks for extended attribute blocks, the
ind/dind/tind blocks, etc.  We do care about num_blocks being too big
for the !huge_file case since for !huge_file file systems i_blocks is
denominated in 512 byte units, and is only 32-bits wide.  So in that
case, we *do* care about the size of the file including metadata
blocks being no more than 2TiB.

						- Ted


