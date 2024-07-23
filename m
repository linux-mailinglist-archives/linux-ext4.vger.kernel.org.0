Return-Path: <linux-ext4+bounces-3373-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76646939E89
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Jul 2024 12:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96C0EB212B5
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Jul 2024 10:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D370F14E2EF;
	Tue, 23 Jul 2024 10:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="AphzzP+s"
X-Original-To: linux-ext4@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070A314D28F;
	Tue, 23 Jul 2024 10:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721729093; cv=none; b=dpf84eVWxTcE/TWr13EziGWj4UfCjPa7+lA2WqgTf9VzRsitZgPYHdQq1DIZHn96pt4xvX2xplHmXEwMg6LZp/kqCxtb4KelXgPKSHB9UH11qzQ93KU3oPvzCRByILfBiC000XJxQp+PfmpBE8PENDQfCwAOH+I+htYMStrVWUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721729093; c=relaxed/simple;
	bh=+8I4TKsfEOavMjm8P/2ATDPszpj6Q9Jmp/XlpWDjeXs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=VeP0SI8q5wI+QBu1HvSMq0bb3qksXuI4vwMTcSxYx0xFLZRoE1G39Nzvs9L3sC5vONxqSa2uHdGJ0LCDjb43bqxfe+bGsuCvxcfoeQVfvS/uvUQqc5KDRXzYcn/8/TuEucI5uKIi5m1XypOiiAYz1l8Hs8EJrIYgv3kFhA+rK7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=AphzzP+s; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=pBRBtqKuHNX2rkdNL75agUq7iD+iQuYibTqU7iSRiVw=; t=1721729091;
	x=1722161091; b=AphzzP+s3NWRyhCA1wl7VC+6IxtX3sKu0tyCMwloknbcCI90d7zBzh51I7ag8
	aRkO1NduLCptzzTXc/KsG1CWzOUS2G8lWILezHnVdblamv9riBQmk7x0ILQrvwoQ2WzXrRMnl+rgP
	JaeV47s59NKMXJuRe1F1eqqYf6gAnNTe8NkwRcKslMDTwUOpM1xbwMfJggUqx7xgPbNTRIwbqVch3
	ipdp+IB91fapDd5ur9dYgD53hpsGVFKFMxRcsoCYyIrtfqJej5Hoa0/UVovwh8OZ9Uj4T9Rs/Iq6w
	AkRQnxNShSPQvQlVaMBGyA5F/hdCpATZLCoRpTlHzJqhaU288g==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sWCNu-0004Kg-LG; Tue, 23 Jul 2024 12:04:42 +0200
Message-ID: <108448f5-912f-4dac-bbba-19b1b58087b1@leemhuis.info>
Date: Tue, 23 Jul 2024 12:04:41 +0200
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: Linux 6.10 regression resulting in a crash when using an ext4
 filesystem
To: Greg KH <gregkh@linuxfoundation.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, "Artem S. Tashkinov"
 <aros@gmx.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-ext4@vger.kernel.org, xcreativ@gmail.com, madeisbaer@arcor.de,
 justinstitt@google.com, keescook@chromium.org,
 linux-hardening@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
 Kees Cook <kees@kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <500f38b2-ad30-4161-8065-a10e53bf1b02@gmx.com>
 <20240722041924.GB103010@frogsfrogsfrogs>
 <BEEA84E0-1CF5-4F06-BC5C-A0F97240D76D@kernel.org>
 <20240723041136.GC3222663@mit.edu>
Content-Language: en-US, de-DE
In-Reply-To: <20240723041136.GC3222663@mit.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1721729091;1fc44743;
X-HE-SMSGID: 1sWCNu-0004Kg-LG

On 23.07.24 06:11, Theodore Ts'o wrote:
> On Mon, Jul 22, 2024 at 12:06:59AM -0700, Kees Cook wrote:
>>> Is strscpy_pad appropriate if the @src parameter itself is a fixed
>>> length char[16] which isn't null terminated when the label itself is 16
>>> chars long?
>>
>> Nope; it needed memtostr_pad(). I sent the fix back at the end of May, but it only just recently landed:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=be27cd64461c45a6088a91a04eba5cd44e1767ef
> 
> Yeah, sorry, I was on vacation for 3.5 weeks starting just before
> Memorial day, and it took me a while to get caught up.  Unfortunately,
> I missed the bug in the strncpy extirpation patch, and it was't
> something that our regression tests caught.  (Sometimes, the
> old/deprecated ways are just more reliable; all of ext4's strncpy()
> calls were working and had been correct for decades.  :-P )
> 
> Anyway, Kees's bugfix is in Linus's tree, and it should be shortly be
> making its way to -stable.

Adding Greg and the stable list to the list of recipients: given that we
already have two reports about trouble due to this[1] he might want to
fast-track the fix (be27cd64461c45 ("ext4: use memtostr_pad() for
s_volume_name")) to 6.10.y, as it's not queued yet -- at least afaics
from looking at
https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/

Ciao, Thorsten

[1] https://bugzilla.kernel.org/show_bug.cgi?id=219072 and
https://bugzilla.kernel.org/show_bug.cgi?id=219078

