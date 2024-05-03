Return-Path: <linux-ext4+bounces-2277-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4ED8BA5E3
	for <lists+linux-ext4@lfdr.de>; Fri,  3 May 2024 06:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA9041C21B5F
	for <lists+linux-ext4@lfdr.de>; Fri,  3 May 2024 04:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80508208D4;
	Fri,  3 May 2024 04:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="WofocYPb"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E6614F62
	for <linux-ext4@vger.kernel.org>; Fri,  3 May 2024 04:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714708998; cv=none; b=m7WyU3DDQhbI4pukfpgJQr1uDxZ83qI0nG6ZP4eQDrSZQhG7aK5n9H8KcVLnphW5neddiMtQ3rcy0kXj9JxvJcSGuUBuXAOh0WLVSvCEybtVdvKCuW37ZMqoQAUlUCwysbJwSfqFojHtCoJ02WFVuD/PLwrdK8SAKOrpbyoHhdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714708998; c=relaxed/simple;
	bh=QHI7qxmZ3pVo1EDO9y63ULw/ecTtmkPNG26tMMD8Tp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eBYu+PLWHdX5xehMRlF5u/RMfdCy1N8qAkfiHR2Jui7jp04JbFpsVjc7heFLtjUb26iYfFJz5atqwXmI9Cyp8ZrfeE3tahF6uY5qD2+sv5ob4jjruU7aYHeHd/bIUCbU2HPWLsTUrOTYD/ArPufI7rDu00LPDBr66NpKrk4xDe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=WofocYPb; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-108-26-156-33.bstnma.fios.verizon.net [108.26.156.33])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 443436iZ020721
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 3 May 2024 00:03:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1714708988; bh=PIpM6tSkGUdXZHHO8c6hBO2TK/zSLrjVgDNkWnZ3pT0=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=WofocYPbweNaGNKPlGVmIotOIUU9P1InKGh9ruMsT4SFnc9SI+0akYPGVKq9hHC4n
	 lNGOxzNkl4vD6Kbhrp2gNxU/QsTnLZB+FrSrwXjzbVdH6ZSrnVaqEFTsbLaQ6dAkcW
	 sGzaMXIQGt+8q0h1a7A88zCj63a6Jq2tAolzIrtbKul4HJ216rKjknUG7Q+Z2sKQZy
	 7kCqz8bCnl3oqBP+gI35TKfjyAcfVe44uW/mIC4sAJY9pUsG6VgtdrEZTjsZkRjE6T
	 aepsBzm9Bi6Wr7tTSoDvV64vIxEQ+ncjBs72C+r/5S1kzYaZ8kKl3Gn5vEm2Y8uTd6
	 Vt2iMo/7l4ILQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 2CDBE15C02BB; Fri,  3 May 2024 00:03:06 -0400 (EDT)
Date: Fri, 3 May 2024 00:03:06 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org,
        syzbot+a43d4f48b8397d0e41a9@syzkaller.appspotmail.com
Subject: Re: [PATCH 2/2] ext4: Do not create EA inode under buffer lock
Message-ID: <20240503040306.GH1743554@mit.edu>
References: <20240209111418.22308-1-jack@suse.cz>
 <20240321162657.27420-2-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321162657.27420-2-jack@suse.cz>

On Thu, Mar 21, 2024 at 05:26:50PM +0100, Jan Kara wrote:
> ext4_xattr_set_entry() creates new EA inodes while holding buffer lock
> on the external xattr block. This is problematic as it nests all the
> allocation locking (which acquires locks on other buffers) under the
> buffer lock. This can even deadlock when the filesystem is corrupted and
> e.g. quota file is setup to contain xattr block as data block. Move the
> allocation of EA inode out of ext4_xattr_set_entry() into the callers.
> 
> Reported-by: syzbot+a43d4f48b8397d0e41a9@syzkaller.appspotmail.com
> Signed-off-by: Jan Kara <jack@suse.cz>

Applied, thanks.

					- Ted

