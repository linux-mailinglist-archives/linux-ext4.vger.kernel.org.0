Return-Path: <linux-ext4+bounces-5613-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B2E9F09E1
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Dec 2024 11:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFE96188CA80
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Dec 2024 10:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8831BBBEE;
	Fri, 13 Dec 2024 10:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tv/3FauS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ksx2RuHK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762011B392A
	for <linux-ext4@vger.kernel.org>; Fri, 13 Dec 2024 10:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734086584; cv=none; b=OLXt55W0copd5VpnohdpO9uUuiRWUlkmZKcM5u4z+s5a+WGhE9EvUdNKBsW4uUG6IPkZXqHUGFu04Ym4q4OGBje9hKu1gHe5xdHTQJm0IVxjNpAxFkcA2HQatMiwXyfjOqgpd3nd4GBrCrfDCk1uEk3N6aMm7Ksse8zIIYLlDd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734086584; c=relaxed/simple;
	bh=aYzmxoIMFPXLUROeiO6Hg1noWYMECwHmgGfy9gk1VI0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FaRHb9ePKg9ALLoSbshaMHlQ8jgqb8E/33DrZ+FUpxx7E1txzZX+g0/A/RIbrb5uwMhzZ9KxFmVLWu2TUntW/S2o5mkhmqLTPRncUr5hiJj73jQ7dIx5G1jEwVpWth5BmkT2tx1QJxNm94+onyUJMPktZF0YEJ30U2vRP249nss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tv/3FauS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ksx2RuHK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734086580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4v7iI7NsdR7W7wI3JpdV5vWmxBirJALp5sc+8kyw1GU=;
	b=tv/3FauS2tZFkNX+Xpf41e+97r2jY578h6xXIgjIaO8Zruqbjmkfo1vHnlwLLZI4Ns1vzL
	GdwAdoutp8GrLb7Eu88I8AdeorE6IFPJlcsy8p7GnQnc9DAiSnLxysXrrHDcR5AvQJAQZb
	Xcdi/bO6jzIi7xfnUgq/xT8p+sP1qIKTWZXZ8lGnFcA1wx8uTHfoeRMcMfv1wTyOFJY+pS
	hUnHMu4QOC/Aj9CcR/BAR+yRWqhRD9V4wjIqgXPgk7VqgqPRYQTmJbphTH7PmDRnGiPSKM
	50iZF9FSRAes1Po49/+Q3wn2aLLxlSUrEuHBGqeU4keFP6VwQ/8jXn6dM8FzUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734086580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4v7iI7NsdR7W7wI3JpdV5vWmxBirJALp5sc+8kyw1GU=;
	b=ksx2RuHKHeyUpzrATTiczcoFIxOazBpzr/wc5/beWTteLjyDwIqhB846HZIPvkd+/rVDWO
	LuDwNdF5bwh3evDA==
To: David Woodhouse <dwmw2@infradead.org>, Stefan Hajnoczi
 <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: "x86@kernel.org" <x86@kernel.org>, hpa <hpa@zytor.com>, dyoung
 <dyoung@redhat.com>, kexec <kexec@lists.infradead.org>, linux-ext4
 <linux-ext4@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, eperezma <eperezma@redhat.com>,
 Paolo Bonzini <bonzini@redhat.com>, ming.lei@redhat.com, Petr Mladek
 <pmladek@suse.com>, John Ogness <jogness@linutronix.de>, Peter Zijlstra
 <peterz@infradead.org>, Jens Axboe <axboe@kernel.dk>
Subject: Re: Lockdep warnings on kexec (virtio_blk, hrtimers)
In-Reply-To: <adf6981fcfd3b23d0a293404879598e8fcf072f6.camel@infradead.org>
References: <1f631458c180c975c238d4d33d333f9fa9a4d2a3.camel@infradead.org>
 <CACGkMEtOdYorGPdSjxC1Lb1LJtZ+ZqHam3agHJ6JdpS-tE1qAQ@mail.gmail.com>
 <20241211124240.GA310916@fedora>
 <7717fe2ac0ce5f0a2c43fdab8b11f4483d54a2a4.camel@infradead.org>
 <87ldwl9g93.ffs@tglx>
 <10f5d22150b548ec271e0a847ba2eb91139e6f61.camel@infradead.org>
 <87a5d0aibc.ffs@tglx>
 <dd06cd643ee7fa0be08ac3082cff443b8bfbfb58.camel@infradead.org>
 <874j38a16p.ffs@tglx>
 <9c4b189656a0a773227a11568171903989130bb7.camel@infradead.org>
 <adf6981fcfd3b23d0a293404879598e8fcf072f6.camel@infradead.org>
Date: Fri, 13 Dec 2024 11:42:59 +0100
Message-ID: <871pybamoc.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Dec 13 2024 at 09:43, David Woodhouse wrote:
> On Fri, 2024-12-13 at 09:31 +0000, David Woodhouse wrote:
>> 
>> (gdb) p sysrq_handle_showstate('t')
>> 
>> That didn't work. Maybe if I'd actually had no_console_suspend on this
>> boot. Will try again.
>
> With your fix I get the same thing (both CPUs in idle thread). And with
> no_console_suspend on the command line, 'p sysrq_handle_showstate('t')'
> does work...
>
> [  113.462898] task:loadret         state:D stack:0     pid:707   tgid:707   ppid:531    flags:0x00004002
> [  113.463615] Call Trace:
> [  113.463841]  <TASK>
> [  113.464029]  __schedule+0x502/0x1a10
> [  113.464961]  schedule+0x3a/0x140
> [  113.465234]  schedule_timeout+0xcc/0x110
> [  113.465580]  __wait_for_common+0x91/0x1c0
> [  113.466304]  cpuhp_kick_ap_work+0x13e/0x390
> [  113.466657]  _cpu_down+0xd4/0x370
> [  113.466936]  freeze_secondary_cpus.cold+0x3f/0xd4
> [  113.467326]  kernel_kexec+0xa2/0x1a0

That's the control thread on CPU0. The hotplug thread on CPU1 is stuck
here:

 task:cpuhp/1         state:D stack:0     pid:24    tgid:24    ppid:2      flags:0x00004000
 Call Trace:
  <TASK>
  __schedule+0x51f/0x1a80
  schedule+0x3a/0x140
  schedule_timeout+0x90/0x110
  msleep+0x2b/0x40
  blk_mq_hctx_notify_offline+0x160/0x3a0
  cpuhp_invoke_callback+0x2a8/0x6c0
  cpuhp_thread_fun+0x1ed/0x270
  smpboot_thread_fn+0xda/0x1d0

So something with those blk_mq fixes went sideways.

Thanks,

        tglx

