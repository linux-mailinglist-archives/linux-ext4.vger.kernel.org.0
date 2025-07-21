Return-Path: <linux-ext4+bounces-9139-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15502B0C58C
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Jul 2025 15:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26E421AA390F
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Jul 2025 13:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D322D978C;
	Mon, 21 Jul 2025 13:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="HB3uhHUS"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26195339A1
	for <linux-ext4@vger.kernel.org>; Mon, 21 Jul 2025 13:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753105918; cv=none; b=QltQPpYfeP+FM8PNwmZHyQonfKJJlsDj+a7RS8S7wd4hF43WMelugT2S/WOLyWKohC62UPeImAYRFzaH6Dr9ZKzTwUymV5qQLH2TkqnYXInySSyvpdiKWM5or8ncf84Qi/FZja5zZhLx65IZiHYchrfGXaYrTe0xt6YTBNd55C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753105918; c=relaxed/simple;
	bh=/+3b8bgh1vPULVzDfotk0Tuh85QMpR17zv57e9lavHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=onwykZGSyUleh7ee5VgdgWcgLbPELkxjGXrd5JIzrmXN71o7WO6xR5A5YO9Y8MGiuRtYf3IdEdYqCmNXRSFzVRF0yq2JNqQDH7TnUOv60mP3rqfFnRnrwLTcuv8ac6LnsBalQQsLjjW2SVu3VhFQogvoJAynnKF1pD4dzWCwxto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=HB3uhHUS; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-122-135.bstnma.fios.verizon.net [173.48.122.135])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 56LDphi7017498
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 09:51:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1753105905; bh=eS3N/MSmfHPbMFf2Twvw9BHa3nbuJfzcSdiNYA0uTPw=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=HB3uhHUS7cxnPKQYqoi2e1awOK1zpZgNN38eW4gY1WpKdyZJUd0XgZ1cJO2UNt989
	 3FuhywpqwUr/rjL7Dc2zCdm7KDvcat0Nwrji+nEpptMqB9pLOdr+uxa+Z15KgzFCp2
	 q9Cz09RVX3CAPO+EFLwumakT3KJBG3+2P6CLxAa4oFB91BJhn3AxO8zJcxKUW8QqAv
	 sEB89Dm7Luh3Rb487XCTl13FFT5x7h9pYeTvel9y9QiGae0T8MAYcqN+E50yO7BczD
	 RP2XB5jCFqkjmjwnskv2aoeZi14j/1iq8nPg7p9GsPmbvsDuFMVspqvcLuqazEM1zt
	 QYBpgZZ44jWuA==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id DAE332E00D5; Mon, 21 Jul 2025 09:51:42 -0400 (EDT)
Date: Mon, 21 Jul 2025 09:51:42 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jan Kara <jack@suse.cz>
Cc: Moon Hee Lee <moonhee.lee.ca@gmail.com>,
        syzbot+544248a761451c0df72f@syzkaller.appspotmail.com,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] ext4: do not BUG when INLINE_DATA_FL lacks system.data
 xattr
Message-ID: <20250721135142.GA1415603@mit.edu>
References: <CAF3JpA7a0ExYEJ8_c7v7evKsV83s+_p7qUoH9uiYZLPxT_Md6g@mail.gmail.com>
 <20250717145911.GB112967@mit.edu>
 <CAF3JpA6RwyzQMdG4y3P_8jkaS8qUFPerE5MJ8Xecs+VkbPEmpg@mail.gmail.com>
 <20250718010521.GC112967@mit.edu>
 <t6yl3jtspvfby4c6nlqbwjucfkx2evpuebaqvwolgjzcdst3sx@y4yuq7xegul6>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <t6yl3jtspvfby4c6nlqbwjucfkx2evpuebaqvwolgjzcdst3sx@y4yuq7xegul6>

On Mon, Jul 21, 2025 at 02:49:57PM +0200, Jan Kara wrote:
> > We need to do something similar for LOOP_CLR_FD, LOOP_SET_STATUS,
> > LOOP_SET_STATUS64, LOOP_CHANGE_FD, and LOOP_SET_CAPACITY ioctls.
> 
> Well, careful here. Changing loop device underneath mounted filesystem is a
> valid usecase in active use (similarly as changing DM device underneath a
> filesystem). So don't think we can play similar tricks as with
> LOOP_SET_BLOCK_SIZE where changing block device block size just doesn't
> make sense while the device is in use. Similarly LOOP_CLR_FD is an
> equivalent of device going away. LOOP_CHANGE_FD is a legacy of the past but
> it was *designed* to be used to swap backing file under a life filesystem
> (old days of Wild West :)) during boot. We may get away with dropping that
> these days but so far I'm not convinced it's worth the risk. So in this case
> I don't see anything here that couldn't happen with say DM device and thus
> I wouldn't really restrict the loop device functionality...

Sure, and LOOP_SET_CAPACITY might be used to grow a file system image
which the file system could then grow into.  Fair.

This is related to BLK_DEV_WRITE_MOUNTED=n which the syzkaller folks
have agreed to use to prevent noisy syzkaller reports.  We're seeing a
bunch of syzkaller reports now that syzkaller has been taught how to
use these loop ioctls and so we're seeing loop device hijinks.  Which
is fine; I can just start filtering any syzkaller report that uses
loop device ioctls as false positive noise and call it a day.
Unfortunately, that won't help deal with researchers that are taking
the syzkaller code and then sending reports without any dashboards or
reproducers.  :-(

However, I do think that if the file system has advertised that they
don't support random underlying block device hijinks, such as XFS for
example, we should honor this and disallow those "wild west" loop
device operations.  And perhaps we should similarly disallow them if
BLK_DEV_WRITE_MOUNTED=n.

						- Ted


