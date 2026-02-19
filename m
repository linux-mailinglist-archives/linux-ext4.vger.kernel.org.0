Return-Path: <linux-ext4+bounces-13749-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAOoHCgRl2n7uAIAu9opvQ
	(envelope-from <linux-ext4+bounces-13749-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Feb 2026 14:33:28 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7AC15F1B8
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Feb 2026 14:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C280301AA5D
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Feb 2026 13:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD1331AA91;
	Thu, 19 Feb 2026 13:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="hsXiEdxl"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124BA28DC4
	for <linux-ext4@vger.kernel.org>; Thu, 19 Feb 2026 13:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771507978; cv=none; b=XNyPlvDWw/R0KjgcU1xXa/KGkUNrdY6HXeN0xWObsguKMUCWp78FaM3wUrrognJ1marsda9/2r7grrLzK4TZzFkwh2T3T0iCv+QTDXwJfRZKuk1XbkKtxzRpm3DD80F28QY3Qv/va5G4t93aoV+AVa4K+pJ7/LSdxeIc/U0ixJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771507978; c=relaxed/simple;
	bh=dCck66s0v47ULUUYdlp/cXV9epUOrVjReuinnGfUWx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppv55Oal8lpjzSP5xOkjBvc4EDT+dsrpuljbI+gT6XGTn9A1I4ceMtN0OkwruCY8gs9zji9rnIknvawqm1t1R3lubIegvfkogkO02o5aRnSZDFOHtkYet+GIzsN3yeDbYKvEKslT6RD2Yq/a2EjKV7K41T7MskeIOcTbgoNk9vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=hsXiEdxl; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (pool-173-48-113-47.bstnma.fios.verizon.net [173.48.113.47])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 61JDWjIB023264
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Feb 2026 08:32:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1771507967; bh=VdHBiExKqlXg6NHpKYC77q0+QKRJ4W9ibO9DGh60Ubg=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=hsXiEdxlYaQs13CoTCPwt3iFEy7NpbLKlmR8Sk+gZIVAz2t2DmMyhFfvaIcXphnVd
	 c7wTxGBfiWYx0JCoJexiOb48wwvhDpBcmnwxx/NPs4ly2AD4ilvVk13ino/I0khsv9
	 AqlHGnujhAH1p12zGhWOLRa254Zu/hMjubLZiK349mc+yjRAeI5F+Aqp0eyVhnfmn2
	 d/5RQueX4k1GuU6qJ58t9YV1C2Clg+EpfI2Itt+9atyHEChslNfKGKWYWSz95ncCWU
	 +88OUw9uhHoC65v/JPH3Qs3wdiKkkh+l3ZISdRQ76ueqt1dAjy4Cxtcg0LyFAdsy2W
	 m1Vc3y/LQHnag==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id DFD0F591998E; Thu, 19 Feb 2026 08:32:44 -0500 (EST)
Date: Thu, 19 Feb 2026 08:32:44 -0500
From: "Theodore Tso" <tytso@mit.edu>
To: Andreas Dilger <adilger@dilger.ca>
Cc: Vyacheslav Kovalevsky <slava.kovalevskiy.2014@gmail.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-man@vger.kernel.org
Subject: Re: Writing more than 4096 bytes with O_SYNC flag does not persist
 all previously written data if system crashes
Message-ID: <20260219133244.GB69183@macsyma-wired.lan>
References: <3d8f73f4-3a64-4a86-8fc9-d910d4fa3be1@gmail.com>
 <174A8D06-B9B6-4546-A528-7A814D538208@dilger.ca>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <174A8D06-B9B6-4546-A528-7A814D538208@dilger.ca>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mit.edu,none];
	R_DKIM_ALLOW(-0.20)[mit.edu:s=outgoing];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13749-lists,linux-ext4=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[mit.edu:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tytso@mit.edu,linux-ext4@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-ext4];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,macsyma-wired.lan:mid]
X-Rspamd-Queue-Id: BD7AC15F1B8
X-Rspamd-Action: no action

+linux-man

On Wed, Feb 18, 2026 at 02:55:13PM -0700, Andreas Dilger wrote:
> If anything, the man page should be updated to be more concise, like:
> 
>     "the *just written* output data *on that file descriptor* and associated
>      file metadata have been transferred to the underlying hardware (i.e.
>      as though each write(2) was followed by a call to sync_file_range(2)
>      for the corresponding file offset(s))"

Yeah, this is an inaccuracy in the man page; the definition of O_SYNC
from the Single Unix Specification states:

    O_SYNC    Write I/O operations on the file descriptor shall complete
                                   ^^^^^^^^^^^^^^^^^^^^^^
              as defined by synchronized I/O file integrity completion.

Compare and contrast this to what's in the Linux manpage:

       O_SYNC Write  operations  on the file will complete according to the re‐
              quirements of synchronized I/O file integrity completion (by con‐
              trast with the synchronized I/O data  integrity  completion  pro‐
              vided by O_DSYNC.)

              By  the  time  write(2) (or similar) returns, the output data and
              associated file metadata have been transferred to the  underlying
              hardware (i.e., as though each write(2) was followed by a call to
              fsync(2)).  See VERSIONS.

The parenthetical comment in the second paragraph needs to be removed,
since fsync specifices that all dirty information in the page cache
will be flushed out.  From the fsync man page:

       fsync() transfers ("flushes") all modified in-core data of (i.e.,  modi‐
       fied buffer cache pages for) the file referred to by the file descriptor
       fd  to  the  disk device (or other permanent storage device) so that all
       changed information can be retrieved even if the system  crashes  or  is
       rebooted.   This  includes  writing  through or flushing a disk cache if
       present.  The call blocks until the device reports that the transfer has
       completed.

I'll also mention that the fsync man page doesn't really talk about
its interaction with O_DIRECT writes.  This is mentioned in the
open(2) man page, and in general, people who use O_DIRECT are
generally expected to know what they are doing.  But in the context of
O_DIRECT writes, the fsync(2) call is also used to make sure that a
CACHE FLUSH or equivalent command is sent to the storage device, such
that the O_DIRECT write is guaranteed to persist after a power
failure.

Cheers,

					- Ted

