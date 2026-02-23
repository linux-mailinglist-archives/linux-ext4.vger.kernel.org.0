Return-Path: <linux-ext4+bounces-13777-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMSdKHirnGklJwQAu9opvQ
	(envelope-from <linux-ext4+bounces-13777-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Feb 2026 20:33:12 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD84E17C6A6
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Feb 2026 20:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E3F893016169
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Feb 2026 19:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C999B36E47F;
	Mon, 23 Feb 2026 19:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="OKVoAKAR"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFD023EA8B
	for <linux-ext4@vger.kernel.org>; Mon, 23 Feb 2026 19:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771875181; cv=none; b=W/7U7oec5efsNOo9HJFE0LUOoQTjXueAUDQU0daCtlg4yETQZMNeZsuIW2aZbp3Sz/sWmTTX6niE506r+vDBYZ4tvt0k3Ure8RBNqGcHq/Bcoi8pEWDKd8uGNd7EW8tUoYRhuu4nhCntfJrzQDC0UaEHjGzUDhKagEwh8h0ZvQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771875181; c=relaxed/simple;
	bh=usNK/zvyCaerlGBXc9jYU8qDGmXmsiEK6u2ZpiaHrvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJwMTA1IE7AwWULs2Jg/EfFxsOCG5q8CH9LZwHzGPQKezQLSKqi0JmvzSu33i7KaV9idly4C06FqD+NCWVV9KSfb56CXAEpAkTF042fraURwLnMCe8k8NLCvdrz8HbOnOpIUpePL9J3QouSxv/86/+Bntz5eLR/mKr9x7dyqRrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=OKVoAKAR; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (pool-173-48-102-240.bstnma.fios.verizon.net [173.48.102.240])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 61NJWduK027285
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 14:32:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1771875161; bh=BLlZWeQmVc4glY+Q7q8WWVsq7D4lh0/EuVs6l5yEUZU=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=OKVoAKAR554ckn0Zj/PlN8NcunMiawuFfr5wz21LpjowPfIQ3nHHiK8WuLrrkToX7
	 cJIO6OFosfFq0zNfC0/vRK4HgYivd1mh9Y8Ytemu7/YqNSWpY8qfHeXHpPgdJrrB4h
	 4N2s9Beem6+eeJhGKrUj4OvCmCxMrNKWdpjR54QXrEl0LHgG8kJqj/Pw++TSoRujGr
	 ueVL+JQHfbUm8Sh22TfBY5kCnuwltueof7kw1buMN4t4UFqHcOwWp46PYgGbw5xNpX
	 UREskjgnGBHayvJ4xixtWGRs4g9G3XVnNBecWnlDxXd2W/EJ37puVeDMi9RhzX0rdC
	 ILUC4XslTIJ8g==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 1106659912F9; Mon, 23 Feb 2026 14:32:39 -0500 (EST)
Date: Mon, 23 Feb 2026 14:32:38 -0500
From: "Theodore Tso" <tytso@mit.edu>
To: Alejandro Colomar <alx@kernel.org>
Cc: Andreas Dilger <adilger@dilger.ca>,
        Vyacheslav Kovalevsky <slava.kovalevskiy.2014@gmail.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-man@vger.kernel.org
Subject: Re: Writing more than 4096 bytes with O_SYNC flag does not persist
 all previously written data if system crashes
Message-ID: <20260223193238.GA63263@macsyma-wired.lan>
References: <3d8f73f4-3a64-4a86-8fc9-d910d4fa3be1@gmail.com>
 <174A8D06-B9B6-4546-A528-7A814D538208@dilger.ca>
 <20260219133244.GB69183@macsyma-wired.lan>
 <aZxLxum4WFYKbx2O@devuan>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aZxLxum4WFYKbx2O@devuan>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mit.edu,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[mit.edu:s=outgoing];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13777-lists,linux-ext4=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[dilger.ca,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tytso@mit.edu,linux-ext4@vger.kernel.org];
	DKIM_TRACE(0.00)[mit.edu:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AD84E17C6A6
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 01:46:54PM +0100, Alejandro Colomar wrote:
> Hi Ted, Andreas,
> 
> > The parenthetical comment in the second paragraph needs to be removed,
> > since fsync specifices that all dirty information in the page cache
> > will be flushed out.
> 
> Would you mind checking the text in VERSIONS (since there's a reference
> to it right next to the text you're proposing to remove)?  I suspect it
> will also need to be updated accordingly.  I don't feel qualified to
> touch that text by myself.

The text in VERSIONS is not incorrect, in that it is talking about the
distinction of O_SYNC and O_DSYNC in terms of which kinds of metadata
will be persisted.

However, the reason why all of this information regarding Synchronized
I/O is in VERSIONS is describing the historic behaviour of Linux
version 2.6.33 versus more modern versions of Linux.  But 2.6.33 dates
from February 24, 2010 --- 16 years ago.  So it might be simpler if we
simply dropped this kind of historical information.  But if you do
want to keep it, we should move the bulk of that inforamtion into
O_SYNC and O_DSYNC.

So maybe:

       O_DSYNC
              Write  operations  on the file will complete according to the re‐
              quirements of synchronized I/O data integrity completion.

              By the time write(2) (and similar) return, the  output  data  has
              been  transferred to the underlying hardware, along with any file
              metadata that would be required to retrieve that data.

	      See VERSIONS for a description of how historial versions
	      of the Linux kernes from 2010 behaved.

       O_SYNC Write  operations  on the file will complete according to the re‐
              quirements of synchronized I/O file integrity completion (by con‐
              trast with the synchronized I/O data  integrity  completion  pro‐
              vided by O_DSYNC.)

              By the time write(2) (or similar) returns, the output
              data and all file metadata associated inode for the
              opened file have been transferred to the underlying
              hardware.
	      
	      See VERSIONS for a description of how historial versions
	      of the Linux kernes from 2010 behaved.

    VERSIONS
       Before Linux 2.6.33, Linux implemented only the O_SYNC flag for
       open().  However, when that flag was specified, most
       filesystems actually pro‐ vided the equivalent of synchronized
       I/O data integrity completion (i.e., O_SYNC was actually
       implemented as the equivalent of O_DSYNC).

I'd suggest dropping everything else in VERSIONS, including the
discussion of O_RSYNC.  All of that is much more appropriate for a
tutorial.

If you really want to keep all of that text, perhaps it could be moved
into a synchronized-io man page in section 7.  In that we can talk
about the difference of fsync() and fdatasync(), which is interesting
as a conceptual model, and conceptually it is similar to the O_SYNC
and O_DSYNC.  But the difference of what data will be written back
(the data that was written in the file descriptor where the
O_SYNC/O_DSYNC flag was set, eitehr via open or fcntl, versus all
buffered data in the buffer cache).  The synchronized-io man page
could also have more of the information around O_DIRECT in one place.

> If you'd write a patch, I'd appreciate that.

Well, there's a question of what's the minimal change that is needed
to fix out-and-out inaccuracies, and we can just delete some
parenthetical comments.

BTW, if we want to delete inaccurate information, I'd also suggest
deleting the following text in the O_DIRECT section of the man page:

      A semantically similar (but deprecated) interface for block
      devices is described in raw(8).

----

Then there's trying to rearrange the tutorial-style information for
people who want to implement code which needs data persistence
guarantees.  That's quite a lot more work, and while I'm happy to
review or assist someone to write that more expansive tutorial
material, it's not something I'm willing to sign up to do.

----

Finally, there are some philosophical questions about what the goals
of the Linux kernel man pages --- how important is having historical
information (for exmaple O_DIRECT has a "since 2.4.10", which is 25
years ago --- really)? and how important is there to have tutorial
infomation and where should that information should be organized in
the man page.

My personal opinion is that the primary priority of the Linux man page
is to document the specification of the kernel interfaces that we
expose to user space.  Things like tutorial material and a descriptive
of historical versions are of secondary importance.

I'd also advocate dropping historical information for kernel versions
which are older than say, 7 years.  Curretly the oldest LTS kernel
which is supported upstream is 5.10, which was originally released in
2020, and will EOL by end of 2026.  The Linux kernel 5.0 was released
on March 3, 2019, so using a 7 year lookback means that explanation
about how the Linux kernel in 2.4.x, 2.6.y, 3.x, 4.x, etc. can be
dropped from the man pages, since IMHO it will reduces a lot of noise
that will likely confuse readers.

But that's a call for Alex and the man pages project to make.

Cheers,

					- Ted

