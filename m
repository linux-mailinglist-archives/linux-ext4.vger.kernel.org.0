Return-Path: <linux-ext4+bounces-8971-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E6BB03506
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Jul 2025 05:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88E411899663
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Jul 2025 03:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE17C14D29B;
	Mon, 14 Jul 2025 03:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="IS3t9pjl"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08A32E36F0
	for <linux-ext4@vger.kernel.org>; Mon, 14 Jul 2025 03:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752464339; cv=none; b=afqereS1KZSVWhS/lVYUo0Iq/fMVXqgcG643AEd+aESPYFPb+Zoa75WjNBKVAM90gJKIJ7xo3UcqsSF+1mhsmNwapV5Sz1wfXDVHxECQEUJdwrBBOMs2k7x6tkgX+KQbUBlz6EHs1w+AgDYZ/Qz1zQt6SBcTfhylC3ZqGAfQleI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752464339; c=relaxed/simple;
	bh=/caf2hAz3y8riFds0Ho/OCuVBR0TqaCXOSDTn9lU95o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5w25J0XfHYn79I54Fng+2APCrWqTj1nOV4s+1ZvMe417O5CXW6qGu00DgdIUEir9TN1caENtpsgTfQzFLnOu5yx7pOMHngpF7WGicg5frTpYHKm4WLkmussql/3+P3udn08VEIOiuXtakBPH2xLISu9LpOAqHJpSawq39yVHag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=IS3t9pjl; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-102-187.bstnma.fios.verizon.net [173.48.102.187])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 56E3cmvW026726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 13 Jul 2025 23:38:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1752464330; bh=GsbV3b/2Jza6RTGEIq7Fo2HxJ4hUNj3V7CfLEyFwAf0=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=IS3t9pjlltXkLVM4jK5sJ7XgkvPgwlCQbOCiQp9j3K/oeLxOFwLk1/cX9lU3Ckl+L
	 xFDNbFnjyxZK6YrYed4cevwlGizyh7w4tqFj0OXAx0iStjDnljuI0e/iQaM92UIxjb
	 rvZaW6+5R2cHX6fzEchl7UqynBAyrV0J4ve09mYCJvCV0AWvqiG7qUILaBTrhj3nRJ
	 /Uv1UlbBNPBgtI8wlRttiz9YgP60EAZ4PxzJ9vFedYC26PPcbvgvLdAM7K/Xta/zJO
	 zq/qCcwgwLRCttuLykoBD/S22mUh4yEbbBZLsPDLUs2l192cveeoKRVswv/5Cw+a6W
	 +vL4c9Y4dcVsw==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 1DD272E00D5; Sun, 13 Jul 2025 23:38:48 -0400 (EDT)
Date: Sun, 13 Jul 2025 23:38:48 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org,
        syzbot+5322c5c260eb44d209ed@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: verify dirent offset in ext4_readdir()
Message-ID: <20250714033848.GC23343@mit.edu>
References: <20250701141141.55938-1-dmantipov@yandex.ru>
 <20250702152304.GM9987@frogsfrogsfrogs>
 <7debf2e6-0d2d-46bf-b3f8-f24c8e5f41b5@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7debf2e6-0d2d-46bf-b3f8-f24c8e5f41b5@yandex.ru>

On Thu, Jul 03, 2025 at 12:54:06PM +0300, Dmitry Antipov wrote:
> On 7/2/25 6:23 PM, Darrick J. Wong wrote:
> 
> > Why wouldn't you encode this check in __ext4_check_dir_entry and solve
> > this problem for all the callsites?
> 
> Next thing to try indeed.
> 
> BTW, looking through ext4_search_dir(), why the search doesn't
> actually start from the specified offset? I.e. shouldn't it be:

ext4_search_dir() always searches the entire directory block.  The
offset is relative to the beginning of the directory, and it's used
only printing error messages so someone who is debugging a file system
failure knows where in the directory the corruption was found:

		ext4_error_file(filp, function, line, bh->b_blocknr,
				"bad entry in directory: %s - offset=%u, "
				"inode=%u, rec_len=%d, size=%d fake=%d",
				error_msg, offset, le32_to_cpu(de->inode),
				rlen, size, fake);

Offset can (and very often will be) significanty larger tan the size
of search_buf, so 

> +       de = (struct ext4_dir_entry_2 *)search_buf + offset;

would be practcally guaranteed to induce an out-of-bounds read.

      	 	    	       	  	    		  - Ted

