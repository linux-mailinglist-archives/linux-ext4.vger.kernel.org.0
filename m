Return-Path: <linux-ext4+bounces-833-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7940D82FFD3
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Jan 2024 06:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A79201C23F8C
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Jan 2024 05:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219816AD6;
	Wed, 17 Jan 2024 05:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Y/8u8NK/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48556611A
	for <linux-ext4@vger.kernel.org>; Wed, 17 Jan 2024 05:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705469323; cv=none; b=ucmWt7yKLVS6snkT6Cne5UVxZG3LxwVCkOJde7EpB3pGQ39ot9yb9D96KmehbAusogIah1O+64GExhyjhxGamIs+A9fkPVZ0oNd4F9TvvTc3DxYB1nUfCVnO91hl8/M0TSVbk6ww3L7FsOJbU8ddEsfshlZXrQemux8qSsEoplU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705469323; c=relaxed/simple;
	bh=dJdfnjCYIHQvovHWk7nGZ4qUL1Z6hZWzTRPmsxja+3o=;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=HT6HfT1poULpQuIjsQmRCq23z0z7TGOaOVOPQD1UxOOGhcUE5DBO5kkG49SFYIkQwCRt8C53hJdL8V891MD5ZXtVSqR2JgxCA2jfRde9MCLxtun9lJU9WEeX67lSfDVo16NFRJwVM47MZbihSo4yZ2Oj8TZkOjoaTiFhlkq8w6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Y/8u8NK/; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-112-211.bstnma.fios.verizon.net [173.48.112.211])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 40H5SLlT005871
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 00:28:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1705469304; bh=I0rFGlBN3UecdQ8QGELeVe4qCm5v9+9UkvSYQC4qiJ0=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=Y/8u8NK/+E1GFfr8Vd8YjJdSAbfV7/RHey2EHT0hDdfaQXTLSFVEFRFPkg/kyXAQS
	 Ivx79yKlehsZDhWhdVMxEutKyympswpX4rbqyeC6VnEg+PRtN8fkR0UIXY5apJj1XU
	 +4e28lIFAD7BP4plqtIQ1RLtJz0imVMW0L6SwxK9LETGkrHj5TIbNZnKv2rceSiZfC
	 gG0ePFlHufvYelwcYKQqhQMAHLBpCpSo+YBhTNkOyYai/JOka2Jrg1el9dBn7F3htM
	 btuPyvJKO6AcvZzULq6HmZFgap7UKIaLUJ2N6z30Zj8oE5AkmUZC4y1GN1om+MAupi
	 b+3tAooQJ3SLg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 9002415C0278; Wed, 17 Jan 2024 00:28:21 -0500 (EST)
Date: Wed, 17 Jan 2024 00:28:21 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Brian J. Murrell" <brian@interlinx.bc.ca>
Cc: linux-ext4@vger.kernel.org
Subject: Re: Protecting lost+found from rmdir by directory owner?
Message-ID: <20240117052821.GK911245@mit.edu>
References: <42bc44533e997531baa79c73867a942504122886.camel@interlinx.bc.ca>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42bc44533e997531baa79c73867a942504122886.camel@interlinx.bc.ca>

On Tue, Jan 16, 2024 at 08:26:14AM -0500, Brian J. Murrell wrote:
> Let's say I create a new ext4 filesystem for exclusive use by alice and
> when I mount it, say, on /mnt/alice I set the permissions so that alice
> can work in that directory:
> 
> # mkfs.ext4 /dev/foo
> # mount /dev/foo /mnt/alice
> # chown alice:alice /mnt/alice
> # chmod 775 /mnt/alice
> 
> But now /mnt/alice/lost+found is at the mercy of alice since she has
> write permission for /mnt/alice.
> 
> [How] can I protect /mnt/alice/lost+found from removal by alice?

You can't.  Note that if /lost+found is missing, e2fsck will try to
recreate it if it finds orphaned inodes (e.g., inodes that aren't
connected to the the directory tree).  The reason why mke2fs
pre-creates the lost+found directory is adds a bit more reliability,
in the case where there are no free inodes or free blocks to create
the lost+found directory.  There's also a very tiny risk where if the
file system is horrendously corrupted, asking e2fsck to recreate
lost+found is one more thing that could potentially go wrong.

On the other hand, if the file system is created exclusively for
alice, and she remotes lost+found, in the rare case where something
goes horrendously wrong, she's the only person who would suffer.
Ultimately, just like we can't protect users from yanking out USB
drives before unounting them and waiting for the writes to complete,
sometimes asking users to take personal responsibility is the best
policy.

And for most users, the case that they might accidentally type a
command like "rm * -i" or someone who believes advice from irc that
"rm -rf ~/" is a way to "Read Mail Really Fast", is probably much more
likely than the file system gets so badly corrupted that /lost+found
is going to make that much of a difference.  And that's what backups
are for in any case, right?  :-)

Cheers,

					- Ted

