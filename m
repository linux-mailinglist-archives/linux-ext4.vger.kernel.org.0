Return-Path: <linux-ext4+bounces-986-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7DA83F058
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Jan 2024 22:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EB551C2192D
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Jan 2024 21:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2688C1B279;
	Sat, 27 Jan 2024 21:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Wt/iIAWY"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9224317BA3
	for <linux-ext4@vger.kernel.org>; Sat, 27 Jan 2024 21:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706392768; cv=none; b=b9B4R0Mtg0sMf4XZvk1ECvQFtbIbuWLh8lXuljbl9wkgEsQFsg1N6kBCJQkK1VpTelSwLQDuH0djs6Uayz2i7KJ6G3KMY5W2+osXwLWo90/x1foYv/sFPNGLjBUQAHWdv2HQQO/IEpw1dTT54S07NxRm+a9LvB6Ol2Hehy6GNvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706392768; c=relaxed/simple;
	bh=G/6KdXu31T1VAui/RJwqf6i/24VbdcZQazuZ9wjU2fQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9ksVsARKq2XzJY5NMgQ308ZfWwcO0+9Z54JSnSUK3Ymgojz3i2kgsFrHlQhoTsdWt30mo0PuiPyaSll+hV6bJ7cdHb4IvuZtj+CLs0ukx3rL6G4ZWTtzzReenq4Fx8FplfNmAEwcIEBcEfFZdEtglf3kV/5WxZ/lIwCFCmkZ8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Wt/iIAWY; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-112-211.bstnma.fios.verizon.net [173.48.112.211])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 40RLwvVr024115
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jan 2024 16:58:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1706392741; bh=G/6KdXu31T1VAui/RJwqf6i/24VbdcZQazuZ9wjU2fQ=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=Wt/iIAWYf1XC1gaI24a7MJaAJTcFxw1KSvcT6YWZ0T7RxjvDxYv4JXWL+ukbYPPDQ
	 lH9WT7iOCqHq90Sh08iByhVGVPc9kUTGjLr3qsQ6//mLLOuMI1J114gHjANv+/ah0/
	 wRBsDOOH05nnWw3HAOx5FvIBGfUt70ID2BVlUkbVljCdEPEwstuAmPz1kx/EFo1/fD
	 ljKJJw69gTjfm/WFXhIZmw2JWq3Yc4xzSI6dt5ftMPsgAn5cFPvE+Cu/9xrqxT3n5/
	 mEl2/Q5u99OKw695+WucacU7KjcejFMhQt4mHEXKAtRj6L5t6CXgjgjt5f/oljmbBa
	 lcZd4i4r98qEw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id B138315C065B; Sat, 27 Jan 2024 16:58:57 -0500 (EST)
Date: Sat, 27 Jan 2024 16:58:57 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: syzbot <syzbot+7ec4ebe875a7076ebb31@syzkaller.appspotmail.com>
Cc: adilger.kernel@dilger.ca, axboe@kernel.dk, brauner@kernel.org,
        jack@suse.cz, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ext4?] KASAN: use-after-free Read in ext4_find_extent
 (3)
Message-ID: <20240127215857.GC2125008@mit.edu>
References: <000000000000c7970f05ff1ecb4d@google.com>
 <00000000000064064a060fe9b55a@google.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000064064a060fe9b55a@google.com>

#syz fix: fs: Block writes to mounted block devices

