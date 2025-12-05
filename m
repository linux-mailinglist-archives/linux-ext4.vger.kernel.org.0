Return-Path: <linux-ext4+bounces-12210-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D34DECA8076
	for <lists+linux-ext4@lfdr.de>; Fri, 05 Dec 2025 15:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE6AB317DE13
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Dec 2025 13:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE1F283C83;
	Fri,  5 Dec 2025 13:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="LxbLOg8t"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0060B32BF52
	for <linux-ext4@vger.kernel.org>; Fri,  5 Dec 2025 13:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764941950; cv=none; b=H9/JvdVc1h6LBXrtZ7X+jSDbr+5LKSV4IZu+UxzKuofhMyZDhNMdjY0PNJ61gUl8cjmsXRBba4kj+j+RNVpnNV6REDOyJjfkERgIop7ZuUscL1j9BWIjRwUs14KNkR94HRn8WUB16iwG6pPsB4D/x7fUhO5RsZXfnWz7CUqTRnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764941950; c=relaxed/simple;
	bh=9ix32H/1guwr5mZjo0o2fAkaY5M7CVC2n11uxnXf7xM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGLG0GzMGpz0tXp+WKjNEGcY61PefTFxkDsr5MvAk0j++Hl78rv/n9UXboMcD6ZA6mkjQ1eDi3r89H3WF+Kh2zGa9g0ppxcbwA6XvNO7H8C/8HS1hc9vZ0gBuslR6zJ8VCRPV8NUaf+iLKtvL1jnLibqaGNboQC576qnlgV/Eeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=LxbLOg8t; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (pool-173-48-102-187.bstnma.fios.verizon.net [173.48.102.187])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5B5DceD2017495
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Dec 2025 08:38:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1764941923; bh=cQMfZBPTko1kW9Nit+VNmKZod5ogRYJ6I5iZamKfSU0=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=LxbLOg8tWqSaY9zjw+y6/Hb81W8VMBmsHUfg6kKhmtFhOEREOcxPwRDfHpU7nxeS9
	 Ajp69wi1QCeZ49tNiABLFPnCrN5Fi79ks0eJeS0gktgUy7cXg08CrJuMIGEN3DzcZ/
	 pOo0ZXSww7qXbJY5R9Tg+GD2ZBJxruyno6wIqAenVV9yC9u543ObCUj5FPViK9b/sT
	 ACfZqpR980LVDbPCo1TRWIgybDNuqLqFHVNBY1Ql0QKGLpAAWiDmQMWbUvRYsN3VOB
	 OtHyTPREK40aafHuN6PvyudXcw8RNdWtfJLEgiKt8yixBaB8HUOu+toLxioWAN1eOC
	 ALFNaUZHMPr8w==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id D90E74E92D04; Fri,  5 Dec 2025 08:37:39 -0500 (EST)
Date: Fri, 5 Dec 2025 08:37:39 -0500
From: "Theodore Tso" <tytso@mit.edu>
To: Matthew Wilcox <willy@infradead.org>
Cc: Deepanshu Kartikey <kartikey406@gmail.com>,
        Zhang Yi <yi.zhang@huaweicloud.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+b0a0670332b6b3230a0a@syzkaller.appspotmail.com,
        adilger.kernel@dilger.ca, djwong@kernel.org
Subject: Re: [PATCH v2] ext4: check folio uptodate state in
 ext4_page_mkwrite()
Message-ID: <20251205133739.GA19558@macsyma.lan>
References: <7b2fafab-a156-47e3-b504-469133b8793d@huaweicloud.com>
 <CADhLXY7AVVfxeTtDfEJXsYvk66CV7vsRMVw4P8PEn3rgOuSOLA@mail.gmail.com>
 <aadd43df-3df4-4dcc-a0b3-e7bfded0dff8@huaweicloud.com>
 <CADhLXY4Pk60+sSLtOOuR2QdTKbYXUAjwhgb7nH8qugf4DROT7w@mail.gmail.com>
 <20251203154657.GC93777@macsyma.lan>
 <aTCtITpW9yLNm2hz@casper.infradead.org>
 <20251203223300.GB71988@macsyma.lan>
 <CADhLXY4_yYdGQCYxq3=gQ6ZTJ7y_=dGsEBqdJ4g7JizX+ocVYA@mail.gmail.com>
 <20251205021818.GF71988@macsyma.lan>
 <aTJSglQznqeph5lM@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTJSglQznqeph5lM@casper.infradead.org>

On Fri, Dec 05, 2025 at 03:33:22AM +0000, Matthew Wilcox wrote:
> It sounds like I was confused -- I thought the folios being
> invalidated in mpage_release_unused_pages() belonged to the block
> device, but from what you're saying, they belong to a user-visible
> file?

Yes, correct.  I'm guessing that we were marking the page !uptodate
back when that was the only way to indicate that there had been any
kind of I/O error (either on the read or write side).  Obviously we
have much better ways of doing it in the 21st century.  :-)

> Now, is the folio necessarily dirty at this point?  I guess so if
> we're in the writeback path.  Darrick got rid of similar code in
> iomap a few years ago; see commit e9c3a8e820ed.  So it'd probably be
> good to have ext4 behave the same way.

Hmm, yes.   Agreed.

    commit e9c3a8e820ed0eeb2be05072f29f80d1b79f053b
    Author: Darrick J. Wong <djwong@kernel.org>
    Date:   Mon May 16 15:27:38 2022 -0700

    iomap: don't invalidate folios after writeback errors
    
    XFS has the unique behavior (as compared to the other Linux
    filesystems) that on writeback errors it will completely
    invalidate the affected folio and force the page cache to reread
    the contents from disk.  All other filesystems leave the page
    mapped and up to date.
    
    This is a rude awakening for user programs, since (in the case
    where write fails but reread doesn't) file contents will appear to
    revert old disk contents with no notification other than an EIO on
    fsync.  This might have been annoying back in the days when iomap
    dealt with one page at a time, but with multipage folios, we can
    now throw away *megabytes* worth of data for a single write error...

As Darrick pointed out we could potentially append a *single* byte to
a file, and if there was some kind of writeback error, we could
potentially throw away *vast* amounts of data for no good reason.

     	  	     	       	     - Ted

