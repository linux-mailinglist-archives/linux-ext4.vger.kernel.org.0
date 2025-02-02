Return-Path: <linux-ext4+bounces-6294-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 715E7A24FEA
	for <lists+linux-ext4@lfdr.de>; Sun,  2 Feb 2025 21:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E6273A4DCD
	for <lists+linux-ext4@lfdr.de>; Sun,  2 Feb 2025 20:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8371D5CC7;
	Sun,  2 Feb 2025 20:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="KN2cdxv+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A982AE93
	for <linux-ext4@vger.kernel.org>; Sun,  2 Feb 2025 20:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738527493; cv=none; b=jUtbP2Ck7TbAOuf05w7cA4/xGmTGFGgIJVurMOSnIaQfIihTJb3jjWOOP8Obtm3dQhSEeDizA9Nb4kKx84YbpC6mzZNF9jm0oHLnCm8hPXmBZ6wjTATRig/zPa2GDQqHRut3R5Ue8tjErHLIWwo2UO73MXukd9HtLjts23+m5IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738527493; c=relaxed/simple;
	bh=lC5qWUAc8OmB5ODHVRPoh3celqz/zJN+gT4ZcedqdQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=py4SHrYoz1RsG+sDL0TOfp69yhZrI+xuIOLcdWcIIMYnIeHVMsRNF9+nVXwkTVvoCBugwxHrmG4S9IEKQ6CXoIy62TBEHRw8lZrsd0rQkVZ3/CjQdO4vtU6/ur2f98OEehZ3Gya8FgdLxG0cN68e9pvLb2V6FsEYPMgjEAsuQfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=KN2cdxv+; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-91.bstnma.fios.verizon.net [173.48.82.91])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 512KFvuY006901
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 2 Feb 2025 15:15:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1738527359; bh=V4h/knnBI7UbczlATnC7XEngtfHTj0SNqe4fJiG/GBQ=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=KN2cdxv+CEZ6mJEeJXFhMt+MJXdMf8jYh/HX1+smsiG35phhVqeKeZurURPwtsuEj
	 oISpk7KV0uppW2FZYCno6lZQhgDPQM8Ec9ZrbYfEpRp28TOfe5MIoY8GQ6fjc1EUtS
	 NL2OpiFbwsMkeNURbXGWBDFBr75vrScroeD1gknd7VWIhnW79Xn0MTrnHF4XR0NXEV
	 C9R7hPk41UsADVMwoHgPYQuSarDcBFXe5jzkpwFyaoEdhHDhkY0xFqx+HafRldrY1x
	 Yywb7gSZWbBRecEMRjI/F7OV4JirNTF03EocjNlwV3f+XgU3uXYgGJNmvxrfPL4lbj
	 PEjDvVNwSW5+g==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 52FAE15C013F; Sun, 02 Feb 2025 15:15:57 -0500 (EST)
Date: Sun, 2 Feb 2025 15:15:57 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Artem S. Tashkinov" <aros@gmx.com>
Cc: Andreas Dilger <adilger@dilger.ca>, linux-ext4@vger.kernel.org
Subject: Re: A possible way to reduce free space fragmentation?
Message-ID: <20250202154319.GB12129@macsyma-2.local>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba25991f-43ff-4412-8978-27ad8198e347@gmx.com>

On Sat, Feb 01, 2025 at 03:48:16PM +0000, Artem S. Tashkinov wrote:
> 
> 
> On 2/1/25 3:38 PM, Andreas Dilger wrote:
> > It should be possible to run "find $DIR -type f -size -1M | xargs e4defrag" to only defragment files below 1MB (or whatever you consider "small").
> 
> I have smaller files completely defragmented already.
> 
> The issue is a dozen of 50-250MB files that span multiple extents (up to
> 30).

How big are the extents?  If you are performing large sequential
reads, a few seeks every few megabytes is really not a big deal from a
performance perspective, and it's certainly not worth the huge amount
of time that a perfect defragmentation would take (since that would
require moving smaller files out of the way to free up enough
contiguous space for a big file).

This is why Windows defraggers have mostly fallen out of faver, and
why no one has really found it worthwhile to invest more effort in
improving e4defrag (either the userspace program or the underlying
kernel infrastructure).

> > > ext4 has no free space defragmentation and at most you can use e4defrag
> > > to defragment individual files. I now have a 24GB ext4 filesystem that
> > > has only 7GB of space occupied however it has small files scattered all
> > > over it and now bigger files occupy more than one extent and I cannot
> > > reduce fragmentation to zero. One way to approach that would be to
> > > shrink the volume and then defragment it but that will involve a ton of
> > > disk writes and unnecessary tear and wear. Is it possible to modify the
> > > e4degrag utility to move small defragmented files, so that they were
> > > placed consecutively instead of being randomly spread all over the disk?

Anything is *possible*.  Whether anyone thinks its worth their
development time is a different question.  Many years ago, at a
face-to-face ext4 developer's get together, we had sketched out some
ideas for how we might do this.  It included ways to block certain
areas of the disk from being used for normal block allocation, and an
extended ext4-specific fallocate-like ioctl which e4defrag could use
to allocate blocks in a specific portion of the file system.

But no company has a business case where implementing this feature
would have a positive return on investment; no hobbyist has been
interested in doing in their free time; and unfortunately, this is too
complicated of a project for a Google Summer of Code, Outreachy, or
other Intern project.

If you're interested, I'm happy to chat.  But basically, this is a
"patches are welcome; send us code and we'll be happy to review them"
sort of situation.

Cheers,

						- Ted
						


