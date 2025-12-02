Return-Path: <linux-ext4+bounces-12118-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 357F5C99CED
	for <lists+linux-ext4@lfdr.de>; Tue, 02 Dec 2025 02:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 99700345F58
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Dec 2025 01:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CF01F151C;
	Tue,  2 Dec 2025 01:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="G/Lx0Fxp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A6913C3F2
	for <linux-ext4@vger.kernel.org>; Tue,  2 Dec 2025 01:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764640674; cv=none; b=nGouTvfrljm1DGisVhw5mGcb86xa4lBbFPxB2x7dYJci0vqUSUHxEdrzVFCNTCeTMWtdUlswmUQXrvmGMvq0LnCfWmhiJlZV+b0/4JxDnJnpXy9kTLd74bzfDU3SxuxF4kkOdDeFPVO08gEzbANZTO4r9Sf1KDleksk4jJ/e704=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764640674; c=relaxed/simple;
	bh=mqaHqQaiFn1wRlawhn6IUWPYZl1qXq0kGxYLJQ5lcCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hdSVYx3hpH+LjdVPLP+Qw+VmHV/rLMA72hMgUmbL+LBjgxK9zJarhlMCVZbco7hE1k63J50o4P23ewktafy4+I0Klrsr6XMX1kNuvhGZKISOgOr+PKi6bJNb4auN+l94e39vptyjAheKqIjsheNsqShKPDrn5DwEzTqA6BLBCS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=G/Lx0Fxp; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (pool-173-48-121-67.bstnma.fios.verizon.net [173.48.121.67])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5B21vgh6022593
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 1 Dec 2025 20:57:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1764640664; bh=STLtTF+2w5BMvVK/ftSkXYTK9a1ytwNk03bWu7KfjLw=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=G/Lx0FxpxIsiYSf82Do4cMjr28HDOVL8Sw3Z21UWSbPeq2G5j/zTPwz6XO0wPon49
	 8A+DueVHruFTOaR/CfnBuj6GtwJyC/4BRmbWfSE2kD6hzNUCkl0Ah7O8NuO8ooIG9J
	 /VjMlC7r32cgUYXxs8axb9yL5Npp4CYQzCYbD+Lh6QEhswm3qNGxaGk2Z5uTdYQMKc
	 MFyDWok5El2h7oLoeWfaAOdtg8+aK0zrsYTsnzxlnkFJ5crrAVWbah8eFKWSVEu+ZS
	 Zo0EGEAfPGkgu/uh5yl01+EPesuprrXhRfZW6DU5g3e95mn0yEV5Am4MkOZscqCNdP
	 CM/wn/8FFP40A==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 3BD894DBF359; Mon,  1 Dec 2025 20:56:42 -0500 (EST)
Date: Mon, 1 Dec 2025 20:56:42 -0500
From: "Theodore Tso" <tytso@mit.edu>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Andreas Dilger <adilger@dilger.ca>,
        syzbot <syzbot+bb2455d02bda0b5701e3@syzkaller.appspotmail.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ext4?] possible deadlock in ext4_destroy_inline_data
 (2)
Message-ID: <20251202015642.GB29113@macsyma.lan>
References: <690bcad7.050a0220.baf87.0076.GAE@google.com>
 <20251201161648.GA52186@macsyma.lan>
 <2ED9BD8E-9A4D-4800-8633-9FEAD464049D@dilger.ca>
 <20251201232552.GA89435@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201232552.GA89435@frogsfrogsfrogs>

On Mon, Dec 01, 2025 at 03:25:52PM -0800, Darrick J. Wong wrote:
> 
> Or expand extra_isize only when someone tries to set an inode field that
> actually requires it?  e.g. whenever setting the project id?

Or when adding/removing/changing an extended attribute, especially one
stored in the inode table, since that's when we need to make sure
we've left room the expanded inode.

Certainly if all we are doing is, say, updating the atime, trying to
move out an extended attribute to make room for an inode field that
might never get used is kind of a waste.

We just haven't really focused on this much, since we haven't needed
to expand the inode in many years.  But if someone wants to work on
it, that would be great!

					- Ted

