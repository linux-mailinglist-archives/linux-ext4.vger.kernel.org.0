Return-Path: <linux-ext4+bounces-6765-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1EBA5CBBC
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Mar 2025 18:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 823E81718CA
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Mar 2025 17:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2641E262D05;
	Tue, 11 Mar 2025 17:07:43 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DE41D5ADC
	for <linux-ext4@vger.kernel.org>; Tue, 11 Mar 2025 17:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741712862; cv=none; b=Y+xPQc/MZil/ddfGxWn7UvtvuHQvGO0FEv+xpIoFHoQinE049DIVgMt+HX13HRvXfwv9eQ/YJCUqFCAWdqBd14nx88tgXNhcyWkyCL2xlfSfm8hFZPfoJGtaMNiRyoMrRJbcMYqS+plZL8zm8wFTqIdDxXxphZe2jf5uoabQz/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741712862; c=relaxed/simple;
	bh=sbvcIkCTUWV1RX0zPre1zQWKFthhA+09Rj/3chBDGok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AyguekKS1PpdPoiBxx08cDHTh8ttloQGWIzAVwxKKxEmA+k2u9+T6ns72LxJDMSD8SvTEhLKlePtnOd+fHDsaQs6y5IBg4m7U5y9DxLzVJwNqiQe6Otl84n74P5owOgFyazBvNfMpiTht3WUVoXU8YgCeWmm6Q1eHc13imOxNjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-112-29.bstnma.fios.verizon.net [173.48.112.29])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52BH7PIP028198
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 13:07:25 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 1DE302E010B; Tue, 11 Mar 2025 13:07:25 -0400 (EDT)
Date: Tue, 11 Mar 2025 13:07:25 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: David Laight <david.laight.linux@gmail.com>,
        "Artem S. Tashkinov" <aros@gmx.com>, linux-ext4@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: A syscall for changing birth time
Message-ID: <20250311170725.GE8837@mit.edu>
References: <bda3fa3f-dd12-40de-841a-e4c216ab533f@gmx.com>
 <20250310135828.GB8837@mit.edu>
 <20250310221243.0d5db7b3@pumpkin>
 <20250311044935.GD69932@mit.edu>
 <20250311045635.GP2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311045635.GP2023217@ZenIV>

On Tue, Mar 11, 2025 at 04:56:35AM +0000, Al Viro wrote:
> On Tue, Mar 11, 2025 at 12:49:35AM -0400, Theodore Ts'o wrote:
> 
> > This really goes to my question of exactly how useful the file
> > creation time concept really is.  Perhaps that's why the developers at
> > the UC Berkley made ctime be "inode change time", I suspect when they
> > authored the BSD Fast File System 42 years ago.  Personally, while I
> > don't find "change time" to be all that useful --- I find "creation
> > time" an order of magnitude *more* useless.  :-)
> 
> The third timestamp had been introduced in v7 and it had been "change
> time" from the very beginning, with incremental backups as stated
> rationale in filesys(5).  "I'm sure that" from David means "I couldn't
> be arsed to check my WAG"...


I actually pulled down the V7 sources and there was a comment in
/usr/sys/h/ino.h which has a comment around the on-disk inode stating
"creation time" (see below).  These comments are also there up to
3BSD, and changed to "inode change time" in the BSD 4.2 sources,
probably coincident with the BSD Fast File System implementation.

So to be fair to David, I'm guessing this is what he saw.

I still maintain that "creation time" as a concept isn't terribly
useful, and that's probably *why* historical Unix systems have used
ctime as "change time" for decades.  Whether it's 42 years or 45 years
doesn't really change my point.

  		      		      	 - Ted

struct dinode
{
	unsigned short	di_mode;     	/* mode and type of file */
	short	di_nlink;    	/* number of links to file */
	short	di_uid;      	/* owner's user id */
	short	di_gid;      	/* owner's group id */
	off_t	di_size;     	/* number of bytes in file */
	char  	di_addr[40];	/* disk block addresses */
	time_t	di_atime;   	/* time last accessed */
	time_t	di_mtime;   	/* time last modified */
	time_t	di_ctime;   	/* time created */
};


