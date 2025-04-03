Return-Path: <linux-ext4+bounces-7052-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84317A7A7A6
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Apr 2025 18:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 862A73A818F
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Apr 2025 16:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535E8250C18;
	Thu,  3 Apr 2025 16:13:20 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CAB250C15
	for <linux-ext4@vger.kernel.org>; Thu,  3 Apr 2025 16:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743696800; cv=none; b=qjO4siRXWTqtao4rqOC3z0jN5GXkaJkAX1jVDTESN/okXC63MWMSH3x/OiwkYip5vV1tV/HW7p9FGBoK06Y5tJLVWnE1FiKONIKaJ/kXgiQ9ywS9KtQDTQ10HR74wfoBQ78kQCqYsn5TDCkYrB1Ipgm1k3k3wZPrCDMOkJZfww8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743696800; c=relaxed/simple;
	bh=ZxlrAciEoWVbQD1CtbCSoNvl5hTx6xGK12SlTdXCDIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xs7I8ER/xLxM3ziwN6Vq6bCw67dBG0gjLOYqjkqSQKKHXHoXe9HgqYBPB3trvHrW0bUijcrnjY81LWVkHtgKv18KjY4ZSvpmMxUPhHUqBrJduTlSCi9R1Yt6EM+U5/hyuWwyrzbrH+qhVvsOjccyJ/JMfqakzLIeutdaHaILhgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-119-246.bstnma.fios.verizon.net [173.48.119.246])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 533GBsv8001822
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 3 Apr 2025 12:11:54 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id B7F192E0019; Thu, 03 Apr 2025 12:11:53 -0400 (EDT)
Date: Thu, 3 Apr 2025 12:11:53 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jan Kara <jack@suse.cz>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        brauner@kernel.org, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, riel@surriel.com, hannes@cmpxchg.org,
        oliver.sang@intel.com, david@redhat.com, axboe@kernel.dk, hare@suse.de,
        david@fromorbit.com, djwong@kernel.org, ritesh.list@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, gost.dev@samsung.com, p.raghav@samsung.com,
        da.gomez@samsung.com
Subject: Re: [PATCH 2/3] fs/buffer: avoid races with folio migrations on
 __find_get_block_slow()
Message-ID: <20250403161153.GA3051250@mit.edu>
References: <20250330064732.3781046-1-mcgrof@kernel.org>
 <20250330064732.3781046-3-mcgrof@kernel.org>
 <lj6o73q6nev776uvy7potqrn5gmgtm4o2cev7dloedwasxcsmn@uanvqp3sm35p>
 <20250401214951.kikcrmu5k3q6qmcr@offworld>
 <Z-yZxMVJgqOOpjHn@casper.infradead.org>
 <Z-3spxNHYe_CbLgP@bombadil.infradead.org>
 <2jrcw4mtwcophanqmi2y74ffgf247m6ap44u3gedpylsjl3bz6@yueuwkmcwm66>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2jrcw4mtwcophanqmi2y74ffgf247m6ap44u3gedpylsjl3bz6@yueuwkmcwm66>

On Thu, Apr 03, 2025 at 03:43:12PM +0200, Jan Kara wrote:
>   fs/ext4/ialloc.c:recently_deleted() - this one is the most problematic
>     place. It must bail rather than sleeping (called under a spinlock) but
>     it depends on the fact that if bh is not returned, then the data has been
>     written out and evicted from memory. Luckily, the usage of
>     recently_deleted() is mostly an optimization to reduce damage in case
>     of crash so rare false failure should be OK. Ted, what is your opinion?

Yes, if we can just assume that inode has not been recently deleted in
the rare case where a miogration is taking place, that should be fine.
So in practice, recently_deleted() could just call some variant of
find_get_block() (with some flag ) which returns NULL if we need to
sleep (e.g., if it is not in the buffer cache so a read would need to
take place, or we need to wait for the page migration to complete),
that should work fine.

Thanks,

					- Ted

