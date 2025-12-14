Return-Path: <linux-ext4+bounces-12354-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBF6CBB655
	for <lists+linux-ext4@lfdr.de>; Sun, 14 Dec 2025 04:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36176300B2B1
	for <lists+linux-ext4@lfdr.de>; Sun, 14 Dec 2025 03:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040B81C3F0C;
	Sun, 14 Dec 2025 03:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="V+XbLfnm"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB65E15E97
	for <linux-ext4@vger.kernel.org>; Sun, 14 Dec 2025 03:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765682271; cv=none; b=T2HuH6PzjFzD7CkWIM5bKp3YNwvNMe5wfGJl+N5TCjQvri22ZGep84xgy3/vRX3Rz+FREz65O4CCbxnAXHF4BFGJwa6hPARZFRHwuKtMeHkOcBfeyYv3sLvgcZ5vddlR50IkN4FbXHOnfPBdDnkBmkg1f8Pg9em8oa+ig9ugLKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765682271; c=relaxed/simple;
	bh=2TZHxjByFKqZclGOmzTvh9sNLIJRwicf76xglXULxLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GhYHxBDskzYpDft9YJ6XniON5NdMqVPKnewEcd1Z6LNAo+x5WQDDdfV/HiOmzdiBBtWNIQwzTP6wP/8TucaqsF7D1LOTDpbTikKPZ3MzqdXO9+ijRxg5Mfkix7oNiYIhJms4N9a8HNR6gzXyd2NooV3TxyYC6TUxHt/vv6TMvvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=V+XbLfnm; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org ([151.240.205.109])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5BE3HWiV001670
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Dec 2025 22:17:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1765682258; bh=aKKqIAKMF158ToIe4p5lyJbMeEsI16gyrpbd2aWnevQ=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=V+XbLfnmUwh1Dxcuh2ouCSTdeVAevLHohgPG06yRhwRv3zV4aTPRKHCMkNaImHrzG
	 Yb1fFVQPgDa+fGb4SnxKVxQv3fNYBZtXaBWu47LPs+PLDRyegOCijlApWom1+5D7Af
	 jJtYI3O8vxRgH05ATwc252T17+uuvowxtrvchXFwvGabEfQYzV+CPb6D0+EtFT6tqM
	 npXXIUBtZIHHRDvVq9FGL7SADud4N/ekhmKw/ZFV9lp3PgsJKqbOBpAdf+t+YpN5Y1
	 ytEcrIkgkkFIkvkzT9lUB3mnaYwJAgg6mfC3sOUKorynTR/ni/HlxDiWY8MrmCJHjv
	 G4adPL0z3EKxg==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id EE18C5008BB3; Sun, 14 Dec 2025 12:17:30 +0900 (JST)
Date: Sun, 14 Dec 2025 12:17:30 +0900
From: "Theodore Tso" <tytso@mit.edu>
To: =?utf-8?B?5L2Z5piK6ZOW?= <3230100410@zju.edu.cn>
Cc: security@kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: Fix KASAN use-after-free in ext4_find_extent
Message-ID: <20251214031730.GA50322@macsyma.local>
References: <2edd9a0c.3e90f.19b0314cfc8.Coremail.3230100410@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2edd9a0c.3e90f.19b0314cfc8.Coremail.3230100410@zju.edu.cn>

Thank you for your report.

However, I am not sure we fully understand the true root cause of the
problem.  The inode's root extent tree header is checked when the
inode is first read from disk, in __ext4_iget():

			if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
				ret = ext4_ext_check_inode(inode);
			else
				ret = ext4_ind_check_inode(inode);

And ext4_ext_check_inode() does basically what your patch adds:

int ext4_ext_check_inode(struct inode *inode)
{
	return ext4_ext_check(inode, ext_inode_hdr(inode), ext_depth(inode), 0);
}

So it looks like when the inode is originally read from the file
system, it is not corruptd.  This is consistent with your finding that
the crafted file system had no corruptions reported by fsck.

What this implies is that somehow the root node of the extent tree is
getting corrupted by the kernel code --- and that's very concerning,
and we should fix _that_, since (a) constantly checking the root
extent tree node every single time we do an extent tree lookup is
extra overhead, and (b) if something is corrupting the extent tree,
_not_ corrupting the file system as opposed to noticing that the file
system has gotten corrupted and then declaring the file system is
corrupted requiring that the file system needs to be fixed by fsck.ext4.

If you have time to do that further investigation, I would really
appreiciate it.  Otherwise, I'll schedule time to do that deeper
investigation in the next few weeks.

By the way, the patch that you included was white-space corrupted,
probably by your mail client (presumably, gmail?).  One way to avoid
this is to attach the patch as a file, or send it separately using git
send-email.  See the [1] for more details.

[1] https://www.kernel.org/doc/html/latest/process/submitting-patches.html

Thanks,

						- Ted

