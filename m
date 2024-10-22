Return-Path: <linux-ext4+bounces-4718-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 371FD9AA0BC
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Oct 2024 13:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDAC72847F7
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Oct 2024 11:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4034E19ADA3;
	Tue, 22 Oct 2024 11:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="tNh0SD57"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7614419538D
	for <linux-ext4@vger.kernel.org>; Tue, 22 Oct 2024 11:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729594812; cv=none; b=D8mKA2rTBQnKpcW8Vc5YcUZ99tHBi7TQDfmbdgKH8piciX8Xr9o8iknidur3v/3E0MSBDFPj4VAqmiBc2kvXHdaTRTKMi82B+Ay5LzGk+MO1I0xb2fHL5J1ouA9UbN5aMjdU5f7RX/XIaS83NaLHNAfc0ziKVCMwIEu6+PxF+o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729594812; c=relaxed/simple;
	bh=KdF3QOAhlOp9YeqxF52QtNhKIFKPYRdOdKsTCBx2ARI=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RBFWP/h8+WurKErmCwXTeIYXaQRy1MyOep8MJW+Hk5QZdOe/6k/zvEH+8F9U8/J5rz6qixewhLrZTbFDbla8VNTTcIR5b4Ip+OXvix2Y30yeKMKp9ANZSv47DdkkVbS5GqqBj4y5ElIwGjl9Cv6BWqAsFbQh7P9YdlJNwAurKR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=tNh0SD57; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729594812; x=1761130812;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=gCz2WOAC0TtMxRpla9tG4gw5erEv5fdp4bqGetpKGek=;
  b=tNh0SD572Jsr072Lz9SFD+bjeu5Mk94getzYGfM6lgsHwxPc32/YOQIo
   cwskHWDh9qko6X5SgrC4FY05C5jW40YuAh1cmyFTJtktYJdYugszHwwmn
   FXttwnW8SrZMB+Az8gnYyLrUfS4AH3HVdLjyG+jVwmy3R9dyX06TNVi+Z
   s=;
X-IronPort-AV: E=Sophos;i="6.11,223,1725321600"; 
   d="scan'208";a="769230069"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 11:00:02 +0000
Received: from EX19MTAUEA002.ant.amazon.com [10.0.44.209:31827]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.95.25:2525] with esmtp (Farcaster)
 id d90f7e57-24b6-4e19-a859-6dd59d65c91f; Tue, 22 Oct 2024 11:00:01 +0000 (UTC)
X-Farcaster-Flow-ID: d90f7e57-24b6-4e19-a859-6dd59d65c91f
Received: from EX19EXOUEA001.ant.amazon.com (10.252.134.47) by
 EX19MTAUEA002.ant.amazon.com (10.252.134.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 22 Oct 2024 11:00:00 +0000
Received: from EX19MTAUEB001.ant.amazon.com (10.252.135.35) by
 EX19EXOUEA001.ant.amazon.com (10.252.134.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 22 Oct 2024 11:00:00 +0000
Received: from email-imr-corp-prod-pdx-all-2c-619df93b.us-west-2.amazon.com
 (10.43.8.2) by mail-relay.amazon.com (10.252.135.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Tue, 22 Oct 2024 11:00:00 +0000
Received: from dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com (dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com [10.15.1.225])
	by email-imr-corp-prod-pdx-all-2c-619df93b.us-west-2.amazon.com (Postfix) with ESMTP id B0D5E44EA6;
	Tue, 22 Oct 2024 10:59:59 +0000 (UTC)
Received: by dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com (Postfix, from userid 23907357)
	id 44FCA9C23; Tue, 22 Oct 2024 12:59:59 +0200 (CEST)
From: Mahmoud Adam <mngyadam@amazon.com>
To: Jan Kara <jack@suse.cz>
CC: Greg KH <gregkh@linuxfoundation.org>, <hch@lst.de>, <sashal@kernel.org>,
	<tytso@mit.edu>, <linux-ext4@vger.kernel.org>, <regressions@lists.linux.dev>
Subject: Re: [5.10.y] Regression in EXT3/4 with v5.10.227, LTP preadv03 is
 failing
In-Reply-To: <20241022094032.h5fnoqcudkxjp3vu@quack3> (Jan Kara's message of
	"Tue, 22 Oct 2024 11:40:32 +0200")
References: <lrkyqy12hpikl.fsf@dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com>
	<2024102130-thieving-parchment-7885@gregkh>
	<lrkyqldyhpeb5.fsf@dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com>
	<20241022094032.h5fnoqcudkxjp3vu@quack3>
Date: Tue, 22 Oct 2024 12:59:59 +0200
Message-ID: <lrkyqfroopfm8.fsf@dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jan Kara <jack@suse.cz> writes:

> On Mon 21-10-24 19:15:58, Mahmoud Adam wrote:
>> Greg KH <gregkh@linuxfoundation.org> writes:
>> 
>> > On Mon, Oct 21, 2024 at 05:43:54PM +0200, Mahmoud Adam wrote:
>> >> 
>> >> Hello,
>> >> 
>> >>   In the latest 5.10.227 we see LTP preadv03 failing on EXT3/4, when
>> >> bisected it was found that the commit dde4c1e1663b6 ("ext4: properly
>> >> sync file size update after O_SYNC direct IO") is causing it
>> >> 
>> >> This seems similar to what occurred before[1] and if I understand
>> >> correctly it was because of missing dependency backport 936e114a245b6
>> >> ("iomap: update ki_pos a little later in iomap_dio_complete") which was
>> >> then backported to 5.15 & 6.1 but not to 5.10.
>> >> 
>> >> *This is not failing on 5.15 nor 6.1, and it does fail consistently in x86-64 & ARM
>> >> 
>> >> [1]: https://lore.kernel.org/all/20231205122122.dfhhoaswsfscuhc3@quack3/
>> >> 
>> >
>> >
>> > What do you suggest be done?
>> >
>> 
>> I think as an urgent fix I would suggest reverting the mentioned commit
>> and commits that depend on it from 5.10.y..
>> 
>> 4911610c7a1fe ("ext4: fix warning in ext4_dio_write_end_io()")
>> f8a7c342326f6 ("ext4: dax: fix overflowing extents beyond inode size when partially writing")
>> dde4c1e1663b6 ("ext4: properly sync file size update after O_SYNC direct
>> IO")
>
> Looks sensible to me. Another possibility would be to backport commit
> 936e114a245b6e3 ("iomap: update ki_pos a little later in
> iomap_dio_complete") to 5.10-stable. We've done this for other stable
> branches which had this issue and so far I didn't hear about any fallout
> from that.

Sure, I can backport that today, if any blockers will send the reverts
instead.

- MNAdam

