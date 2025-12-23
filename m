Return-Path: <linux-ext4+bounces-12494-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B56CD8129
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Dec 2025 05:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 123DE3018961
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Dec 2025 04:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188E82ED873;
	Tue, 23 Dec 2025 04:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="WUTJRRtO"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B2A1A275
	for <linux-ext4@vger.kernel.org>; Tue, 23 Dec 2025 04:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766465142; cv=none; b=N1zTItHT64GAaDMSppQLiFQ4NDuIWI4UBsm7rwRAnFLxdAbbM8n0MiCfebhR3Xhu4DfgU08CO4s2tLt9Mhh/gXOeFsz9fyp/LQR1XaE9W6++BMS4fBi9FH47XyVBZfn7wRiiMrIlvBvA+/k7icoy7jjEH8Kf9fJZCa8c64FoYms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766465142; c=relaxed/simple;
	bh=xU1flpG+bFTgFXQZ1ttZ3k5xtB0GqyRLYnpQsjqTbVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sTvdBc9NT3bhFR3TbCy9d9lJxoizjXqy7CN5MzIKo+akPvV5KHQIocAo6FKTvVa0L7MxkQSkGN5RrRrbF3TkUNyzp4ZTSZESHzWB7is0wT/OKEtyWa1hoBbFjlpYGoOKIUk3w4SRwYd5FLPZW4wmQ5hol+Oz6lxOsag2BJj+o88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=WUTJRRtO; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (pool-173-48-82-200.bstnma.fios.verizon.net [173.48.82.200])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5BN4jK2g011882
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Dec 2025 23:45:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1766465122; bh=bwLHe0FQH9x5sI/BxWhVk/lR7mQaV+Gll5qBxP49uO0=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=WUTJRRtOamG3CoNPpIkVQPQLQxz/wbR92AklL+O3nyT5G53ATpPWlVNf6xQxjmUfo
	 kPC7Z6gGI/kadWyOSSgxyK2iPZATK9N8WnD7EQbYVgd9oxYMnWgYUQgPtq+ogg17VG
	 q5xC5u26myH6saXT9psEKWveP7jQYgUx28lUPkMVHV+DxYXiH+GMAPRyj0CAhzKbyl
	 akiy4eUzDJmU7wXd/PNJFMaKVED0pslwZ1k7nOU+Wzvo//l5luk3zH92tZH0MHCH9i
	 dMw8aPxUS9+2AoQtL6d2fNRUmy7tRPBG/f4XfeyZj2NywaUqAc8+ojhfvlPJ+3fflW
	 8UPuHYpByWysw==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id E2496515E930; Mon, 22 Dec 2025 23:45:19 -0500 (EST)
Date: Mon, 22 Dec 2025 23:45:19 -0500
From: "Theodore Tso" <tytso@mit.edu>
To: Daniel Mazon <daniel.mazon@proton.me>
Cc: Andreas Dilger <adilger@dilger.ca>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: ext4: a tool to modify the inode count
Message-ID: <20251223044519.GF42033@macsyma.lan>
References: <PAsXqba23hYRwwgFsaneY7Hmxe8-AmdAhSAUH2CW_vtTAi0Y8wVch4QrmW-gU2KahqhsxpxHesEDBZSXlM70jazF0yC-DaPfWgFckG6uzXo=@proton.me>
 <EB431D42-1CDA-4522-B365-8411801B684E@dilger.ca>
 <woSqjqMgjW_pNb2fMhKZ20_RP4BrbYKrX6NHMhGu-n3Mt0VVdP0UiEEopdqeo63OehhHmTs2zJoF8UVU96_IaPiQRvrNyyo-FMCuoPAtKXQ=@proton.me>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <woSqjqMgjW_pNb2fMhKZ20_RP4BrbYKrX6NHMhGu-n3Mt0VVdP0UiEEopdqeo63OehhHmTs2zJoF8UVU96_IaPiQRvrNyyo-FMCuoPAtKXQ=@proton.me>

On Mon, Dec 22, 2025 at 11:15:20PM +0000, Daniel Mazon wrote:
> IMHO, maybe the best approach would be to keep it in its own binary,
> and compile with the object files containing the functions from resize2fs
> which are used to also modify the inode count. This shall benefit from
> reusing code, and not overload resize2fs with functionality (which
> already does resizing and switching between 32/64 bits). But I will let
> the experts decide on what is the best course of action.

The reason why it's better to add that functionality to resize2fs is
that it's clear that you were doing a lot of code reuse by cut and
paste.  This is an anti-pattern, because when a bug is fixed in one
variant of the copied code, it sticks around in the other variant.
It's even worse when this copy-pasta is in security critical code,
because then when you fix the security bug in one copy of the code,
then the attacker might immediately check to see if you forgot it in
the other copy or worse, the several dozen other copies.  Hence the
meme[1], which warns against the spaghetti code that can result from
the really nasty practice of copy-pasta.     :-)

[1] https://tenor.com/view/copy-pasta-copy-fake-plagiarism-nft-gif-5062305734325825604

Yes, it might mean that we might need to refactor some of the
functions that you copied --- and then made changes --- but the
resulting functions will hopefully be more useful in other contexts or
for other use cases.  So it might be more work, yes.  But hopefully
the code will be higher quality.  (And part of the code review process
will be us trying to help you make the code be high quality before we
accept the patch, because what's critically important is the future
code maintainability of the code base.)

As a suggestion, perhaps "resize -i NNN" would resize the inode table
to have NNN inodes.  And perhaps "resize2fs -i +NNN" or "resize2fs -i
-NNN" would increase or decrease the inode table by NNN inodes.  (And
obviously we might need to round the number of inodes since the number
of inodes must be a multiple of 8, and should be a multiple of the
inodes per block.)

Cheers,

						- Ted

