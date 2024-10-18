Return-Path: <linux-ext4+bounces-4614-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C469A31A5
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Oct 2024 02:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 420B71F23DC1
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Oct 2024 00:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0702288BD;
	Fri, 18 Oct 2024 00:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="XLNb7Mbw"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF0A3987D
	for <linux-ext4@vger.kernel.org>; Fri, 18 Oct 2024 00:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729210806; cv=none; b=uUOAMDn7002wQuFNY98c3FPGbcwduTuoqNT1y8uXSDmwpCGem1J1E1DHYMCepZXNvhT7MA+Aux9fmwuy1vbWDYBoOb5IpwlU4RdT9556PhPp1lIFNjujn2nxeKEoLIRBPs6xp0Ha789HhQjt/hw7WDYar9rz1Wr9Iiw9NrnFPOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729210806; c=relaxed/simple;
	bh=srO20DVZTlhdLAo8ayyJZbk3waLfGsBwWrolo3XVCb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3rj4Zlyckvf1twh0XFZgizYEHiVeDavCtfovSjXIsbScMU4lhOsJdj8+OHSSmVpNw2ttO+bokTX+oKzny+FCiNNoruJxLyq5DIz+rqOuyp+UnRXYaSpzT4k1aFT9TjvBoD8vMYxhNDOfrMM7LhTfkcsJlrQk8Sl0Tp0SOXiTGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=XLNb7Mbw; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-118-108.bstnma.fios.verizon.net [173.48.118.108])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 49I0JsQu015080
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 20:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1729210795; bh=MCN4YJlDFktZnLKEJIj7Gwg14SEKLln26TgEwXs/0qo=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=XLNb7MbwFWFRgaO6fGAfEL/o5kmluqrtzHXyIfEa4yqhhWt40nbaPN52N3mqRGxF4
	 ffhW9PE1T+Alg7Ff2Cyns+43pPULPFnUfZItd56M41DtR5dUHymmyzVR0ubmWPcZEP
	 CaQlbGxAjHToCr/xFDzrg4Slv5l7byI7360yV8cOYrcMFUeZeMzOCp1idCxy+B4ekt
	 IkpVwUfd2tq9Yy9kXgnR86h2gWN3ntQNOMaK7uwZduAM/pzPgmQ6H38RtJKYz1VFVI
	 CENGc1H9BenaT8mM077VWobimcpl7aafvwIyGGJMdbVdZACReSkAEZhA6KinnNkV5L
	 zSDHROa9q5zjQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id CEBE915C02DB; Thu, 17 Oct 2024 20:19:53 -0400 (EDT)
Date: Thu, 17 Oct 2024 20:19:53 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Nicolas Bretz <bretznic@gmail.com>
Cc: linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2] ext4: inode: Delete braces for single statements
Message-ID: <20241018001953.GB3204734@mit.edu>
References: <20241014140654.69613-1-bretznic@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014140654.69613-1-bretznic@gmail.com>

On Mon, Oct 14, 2024 at 07:06:54AM -0700, Nicolas Bretz wrote:
> checkpatch.pl warnings - braces are not necessary
> 
> Signed-off-by: Nicolas Bretz <bretznic@gmail.com>

The checkpatch.pl script is meant to check *patches*, and in general,
in the ext4 subsystem (as with many other subststems) patches which
only fix checkpatch.pl file are discouraged, since it can introduce
potential patch conflicts when cherrypicking fixes, or in the course
of other people doing other development.

Granted, dealing with the patch conflicts aren't that hard, but the
cost/benefit ratio isn't worth it.  For kernel newbies who are looking
for practice submitting patches, cleaning up checkpatch warnings in
the staging subsystem are fine, but in general, it's best to not send
cleanup-only patches to other parts of the system.

Of course, if you're modifying that part of the code in question,
that's a perfect time to clean it up while you're at it.

> Removed trailing whitespaces introduced in v1

In the future, please put changes between the v1 and v2 patches after
the three hyphens (by where the summary of how many lines were added
or removed in each file).  That way the description of changes between
earlier versions aren't preserved forever in the git commit
description, since they aren't really useful once they've landed in
the git.

Thanks,

					- Ted

