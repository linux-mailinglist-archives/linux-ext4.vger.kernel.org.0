Return-Path: <linux-ext4+bounces-4677-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE5A9A70CA
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Oct 2024 19:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B104B238EF
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Oct 2024 17:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F411F1E7C32;
	Mon, 21 Oct 2024 17:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="mqChRkBi"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A5B137750
	for <linux-ext4@vger.kernel.org>; Mon, 21 Oct 2024 17:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729530969; cv=none; b=bmaxgc2hrBWx0/wXMtp9ivWVLHglk4XjDN/7TaQ1w6rQsCzCPNWH0E/JFLYGNu6+DBObSzcDcAmugfgIxvFxQalZAWxmFMXqxxhKUMpmzPvkih53is1HsCPHRudKYslhZesCBTqvjOGBYRsJXy+wwGeAB3FhSct8hNbNF5Q6p4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729530969; c=relaxed/simple;
	bh=bVvF8BK8M+5QIjBD2Fv5aF2gpMYaQ/zaTb6HvAn0D3Q=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q8tBWCz4gq+MWMBr21NrZnD+Dw3DEOotaVeGhanBiAmqITgbmgXdGVuWX9HdzJFvdImsqQfhXh+PlrUdF9t6tNCxOvyL4uMgDA8To7YJDohsVyKe/C/teOA8v4I1IrDynHi9FUDIccFLmEanq9NOgNELJKj9uF4mf8mZPg/RV0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=mqChRkBi; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729530968; x=1761066968;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=dg23S5s99YSBjA4rioGRUCAi2dBXXUeQDYkGrUViYVU=;
  b=mqChRkBiKCfuKrCKXFtmshQrDLVyQq8cMoGuDJdwGcpEc2YBbd/0uTmR
   BEh/adFphc0ST4FgD+bvRiBq0mVmC/rkkRBFMybm3jyrjDNxxaqpgWqBn
   V86OGxXLkcTFAxMJj7435I1vW0P4z0iG3gYORIqJ2sTAu8vjX8nNmhdKM
   8=;
X-IronPort-AV: E=Sophos;i="6.11,221,1725321600"; 
   d="scan'208";a="768968879"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 17:16:00 +0000
Received: from EX19MTAUEB001.ant.amazon.com [10.0.0.204:16216]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.25.38:2525] with esmtp (Farcaster)
 id 47f5c029-aff0-4539-9fbe-c56e78a2533c; Mon, 21 Oct 2024 17:16:00 +0000 (UTC)
X-Farcaster-Flow-ID: 47f5c029-aff0-4539-9fbe-c56e78a2533c
Received: from EX19EXOUEC001.ant.amazon.com (10.252.135.173) by
 EX19MTAUEB001.ant.amazon.com (10.252.135.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 21 Oct 2024 17:16:00 +0000
Received: from EX19MTAUEB001.ant.amazon.com (10.252.135.35) by
 EX19EXOUEC001.ant.amazon.com (10.252.135.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 21 Oct 2024 17:15:59 +0000
Received: from email-imr-corp-prod-pdx-1box-2b-8c2c6aed.us-west-2.amazon.com
 (10.43.8.2) by mail-relay.amazon.com (10.252.135.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Mon, 21 Oct 2024 17:15:59 +0000
Received: from dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com (dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com [10.15.1.225])
	by email-imr-corp-prod-pdx-1box-2b-8c2c6aed.us-west-2.amazon.com (Postfix) with ESMTP id 454CCA0597;
	Mon, 21 Oct 2024 17:15:59 +0000 (UTC)
Received: by dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com (Postfix, from userid 23907357)
	id CCEB69B6B; Mon, 21 Oct 2024 19:15:58 +0200 (CEST)
From: Mahmoud Adam <mngyadam@amazon.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: <jack@suse.cz>, <hch@lst.de>, <sashal@kernel.org>, <tytso@mit.edu>,
	<linux-ext4@vger.kernel.org>, <regressions@lists.linux.dev>
Subject: Re: [5.10.y] Regression in EXT3/4 with v5.10.227, LTP preadv03 is
 failing
In-Reply-To: <2024102130-thieving-parchment-7885@gregkh> (Greg KH's message of
	"Mon, 21 Oct 2024 18:49:43 +0200")
References: <lrkyqy12hpikl.fsf@dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com>
	<2024102130-thieving-parchment-7885@gregkh>
Date: Mon, 21 Oct 2024 19:15:58 +0200
Message-ID: <lrkyqldyhpeb5.fsf@dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Greg KH <gregkh@linuxfoundation.org> writes:

> On Mon, Oct 21, 2024 at 05:43:54PM +0200, Mahmoud Adam wrote:
>> 
>> Hello,
>> 
>>   In the latest 5.10.227 we see LTP preadv03 failing on EXT3/4, when
>> bisected it was found that the commit dde4c1e1663b6 ("ext4: properly
>> sync file size update after O_SYNC direct IO") is causing it
>> 
>> This seems similar to what occurred before[1] and if I understand
>> correctly it was because of missing dependency backport 936e114a245b6
>> ("iomap: update ki_pos a little later in iomap_dio_complete") which was
>> then backported to 5.15 & 6.1 but not to 5.10.
>> 
>> *This is not failing on 5.15 nor 6.1, and it does fail consistently in x86-64 & ARM
>> 
>> [1]: https://lore.kernel.org/all/20231205122122.dfhhoaswsfscuhc3@quack3/
>> 
>
>
> What do you suggest be done?
>

I think as an urgent fix I would suggest reverting the mentioned commit
and commits that depend on it from 5.10.y..

4911610c7a1fe ("ext4: fix warning in ext4_dio_write_end_io()")
f8a7c342326f6 ("ext4: dax: fix overflowing extents beyond inode size when partially writing")
dde4c1e1663b6 ("ext4: properly sync file size update after O_SYNC direct
IO")

maybe someone from the ext4 side confirm that as well?

thanks,
MNAdam

