Return-Path: <linux-ext4+bounces-13601-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8M5SKklHhmkhLgQAu9opvQ
	(envelope-from <linux-ext4+bounces-13601-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 06 Feb 2026 20:55:53 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10814102ECE
	for <lists+linux-ext4@lfdr.de>; Fri, 06 Feb 2026 20:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CB643014139
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Feb 2026 19:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1376C33121E;
	Fri,  6 Feb 2026 19:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rocketmail.com header.i=@rocketmail.com header.b="fIIFSccY"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sonic313-9.consmr.mail.ne1.yahoo.com (sonic313-9.consmr.mail.ne1.yahoo.com [66.163.185.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FED1C84DE
	for <linux-ext4@vger.kernel.org>; Fri,  6 Feb 2026 19:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770407750; cv=none; b=AuUkifm5xWovL80CR8zJ+gPTEQk/PPAWhUp19C28R2kVTPpllh5F9t6Exd3hEpjHeV76/C6/X9dLMAyLcYtZ5BP0Q9jgL93MQV0ugkyeQR0foh6cZxxIuzxinqB6gHBmbeVfZpEgxAwcdjrTfL3whU6b2FmcVlqCPF09heSYhiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770407750; c=relaxed/simple;
	bh=Qznso+gOEdVKc1UWF3AswxDe3QvhPDsvwvlm84ujxMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hm4vCZmq64JQu+0EySrP+6EG9wJfCVkykoE0XK3U4PFNMc4UAHjBRD1tQaUqg/38KP8X8rrnZHLhnCHwTYymGdl9pZmLKGzKkFPAzSX/S/oDw4PSHd+m11oyidNP6/J2Xv3PcGMMjArySD991nbGP1wnizifToCTP0L9tNf+99M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rocketmail.com; spf=pass smtp.mailfrom=rocketmail.com; dkim=pass (2048-bit key) header.d=rocketmail.com header.i=@rocketmail.com header.b=fIIFSccY; arc=none smtp.client-ip=66.163.185.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rocketmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rocketmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1770407749; bh=MMn6NE6Jpdx5f/iKl7GfVAcNZfgnwSDTsK9q6cp9FLY=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=fIIFSccYWcQCMVUbTHyFkkni7E/RtKzEGVwkzkTHXK+yLcJPnvZNBx6DRl6WomEnRP5RSE+Dk3PZ89+N4s28EV4F22kh2r6ZAwFpwF8fIGw1GQjBqBUtLArr0HTbKPQ5gTANBQ7LXNZtfyj8o6UHvcWE0prhU9yhkjH5DrzrgwzVOPZYkF1da/H/dnoQdHpe7OzvyFhHCa6g52IYey48hoH4W464heck3fdYvozrdudg8kw5eMPQfBTEIRShWdvo87u73frtFy6Uodi4VnbBgHOND6AShOlkGHIfQhazHeW99LbcRpudjseigXW28TDQtiKV8533BKFcxYLDjn4Hsw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1770407749; bh=7Tl/fx9PXoQcEIinK2kGWMP0+KbdU4wqbwcDF65a2UP=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=lfTKT5dmgkU45xbjrYQxHatV+xZmxAUU+1Go0DDjPlBFFqHGxVnjO6vRfccquOFL1mfCGAbi+vznlK5h4Sq9XVt2JzvsYu0CQHuRri55r5BXWOB29FeAoagyZP4M3FFbBybIZ4J2k1nRpsEqC92VOfVy+lLepGqzyIRY6y/eKepH1iylYIRrIOfbcj+yaPRggQIziYXmMrMJC4952NGdgkxKKprmkL/VYpkhF29pb+z9RAB1DtNIh+MQ1eYdO8oMGzQqyk1ItIHkith/A3whpgKBfxgyR7DR+K7986Kq1hzCxDC/Cwl01yDYuASP08gJquFF36yoDaCyJkKap3lANw==
X-YMail-OSG: A2_WwtwVM1k3b78TRwrr3AO1mMQeqzfY6ZBgsNeb2TYRFnBfHJb2a_Y4Lf6E0H0
 714Q51VIPHaYXHnFHV0IhxWov8avc.QZIAbVWhhSd.M1tFiCm5HDNXjcjVAf9FltoGkoJP6OLPQQ
 dQd0u0999qN6MYnuR7uFDpP_x2LJLY6gakTWZIsXDSPAs0PHupLG6ytvgBsbsZ7hFGW8GCIIqXVm
 .5ZaRDr4Fc9MZ9FkOR2_F2XaEWL9CAFMub5FTJcnYmWxk8Ha.1i7Z744NUu5uZ.b4wHYf6YrvG7E
 EiQZhaVdzXzI9TieqjKOHTbtLg20VWKMmoZMPmYcosn9wn1IiuHdiD.HQTJm4edL_zfuINAIboti
 58w6Lx5TGWrDFQjQV9lZVeE.Mxuo_xXFsJ5020pm0Py1LFgocJMHrJrb81czJsDLIoZbQ3ZFUB4V
 x9tyStDBvOFlbZix_SBs9h9wxFceE5gH4IUqXQTnMX1pLDPGI0x8W_wK0jUK_bnKyHzdN3nNMBQ9
 JjhABQkPmn68npgn83NMxbN70t4XEUKlR7xPAAWF1BPuD7vqW8LYjqWYPfXwkUwkVEWLKMMTbZYm
 Tkxf5t4KOExD96dMv8kACF6xj3xIsBKT9.wV684RNII1riiL5i2wcNfIIO7tTpVnMNFtTqLz0EQr
 9u8D87Fs3nd5cR1nakO1rxrdl0L5NuF2f8n1idrlsDWaCv0mgiiI_PqXvfGoWkE2KXaljQPZoqRr
 0i49mGZE_I7.Kvt4DnRAwfQKULN5enZcfn0HethJK9aAmf5nIDRGeMQH7IMgwC2ADnfJx2PqDk_j
 hHOBgM7HRXD5IDqXlVVLKYjns_On.Y6mmiLd9tOYA03bDwU1TLaR7Ohd2miuRAG1_e8FQiI7niBV
 WRlS_uWSNQ40F3JAeu8xRvKwZ9ObJ8FjSiRXc1Fz86pN.s7rLvyfRDjG_FA460NiV1R6hpyS8Kkn
 OUoL5UJiSBieJS1cc.6499H0s3RaeIA_PO54BkYOa1P6d4bvvtIMDbkIZa5OvZfaOduO4Lq2i55E
 ycbG5A.JS8T9eTvPxo2NS_e2Zx.mhkxguONwCBLU47PHrlthRhu3JED4.323kIdI7oGb5J4L7nnt
 tTr0z6C2ZbtV0ZQY3M68mKlBhAYGe6S7xpyMuBZ31hhoa86t8nzQYvbdjbzgGCvQGgASxTOQvmyx
 Vve1I2zQfloGmDZlAtUMU7jc7_qc7B3R3uHk7nNH15L1O.ggSfHSw2OwF_BqA6uE9zDIuAwnka8E
 KOf_i5SsPaC3DWmezyqW4LuTXs4A.CMDUlyAIshXKCw.5W.VWkPrjL8tWYb8wXcFqZCNwDoDZ1D2
 EpSZcvAYxaRzr3Wf2bIS7t0ZMov.p2jGo5wO9i52cdWALogtlAoBR9ILDwjedHAv4a8OUBijF1Ph
 UJ5O2qtpNokTStpta0OPc6r_vT56GDasPwzbce2MPlY9FRvTTbMFiRR6yMGKiVE_ws5qgxq9wSEn
 hZLuPd0B65c0DwIhxSsi2kUpWA0TGZvZpNcWHd58Wlq_EPiQHRXAXjOfxcmwYqrkle07G7u8Es8S
 9umoUIrtT.Tvm_m4fKtjk16xlChGebHqFO7Zvjx4m3JATAu0_euyNn2pyJs_0hxu75y4nHGsrNhl
 54ZH6LO_hzUFOSF7jcVwNytD3eNfN0O87AMZtcQnXTJXa_EqLrKmlKqf0zzL.gP8EEo6BaWP4f.e
 5YpzF1diFDHacBzOKTSVAn11GKfbbgmn59bMN5CnwkcIOCS.HsZykmL9G6UNqy3wB1YaCts2TvL2
 xAOmI4NDG0BiUAvx6U6fR5n0RGSNYNufiND2Aj7UOGKozg0D9JNoYKvlwyLgIVQmxZsX1EKZi2lG
 m_.tBTLrxyQccohZJw_kh_8_1CoBu7b7nCW8qygxJktVFHZmwU0ti8WMj.3xW4nIMiBChHwOXI3D
 l3naSI_Bi99b2JRkNdGv58c_h_26xkeI.QhHiXC9TYVRm_PWp72_oCagU6F0A.ZQ9UBFJ05i3tB0
 ezhIbi5jI4xH1UvPrqbAiQH0TjZHmMIAkCQu5X1ORjstbioHi9ukBjFqWNVYa62RpyxMxRiTlwci
 zhanJTcASgEvr9vawbmFMaVqiYeUQAhwY3mKxtRHlR07trGvsSI77CJGnQ39kOX5CkCUvnkxhodY
 sUTJ8wyJW9bSpyjS0WmnNCHfpXLTYwaalG.34L.XC2fheb4aUO8V472y0YECSa6x1rgkO0S2Hxnd
 yjqD5gDPgb_liAcBc6COXogK3Gls4Py.DX3L4pXHg
X-Sonic-MF: <mario_lohajner@rocketmail.com>
X-Sonic-ID: a4aa0e2a-ed77-497d-bfbb-f4b0b999eb66
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Fri, 6 Feb 2026 19:55:49 +0000
Received: by hermes--production-ir2-6fcf857f6f-4mj2c (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 70af6ba215ea17f83f6d2b29883ff657;
          Fri, 06 Feb 2026 19:25:26 +0000 (UTC)
Message-ID: <26d60068-d149-4c53-a432-8b9db6b7e6a5@rocketmail.com>
Date: Fri, 6 Feb 2026 20:25:24 +0100
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: add optional rotating block allocation policy
Content-Language: hr
To: Theodore Tso <tytso@mit.edu>
Cc: Baokun Li <libaokun1@huawei.com>, adilger.kernel@dilger.ca,
 linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yang Erkun <yangerkun@huawei.com>, libaokun9@gmail.com
References: <20260204033112.406079-1-mario_lohajner.ref@rocketmail.com>
 <20260204033112.406079-1-mario_lohajner@rocketmail.com>
 <c6a3faa7-299a-4f10-981d-693cdf55b930@huawei.com>
 <069704a4-2417-470a-bf32-0ee3afd1be6a@rocketmail.com>
 <9fc3443b-0eea-4917-909b-709113f5e706@huawei.com>
 <606941c7-2a0d-44c7-a848-188212686a78@rocketmail.com>
 <20260206014249.GH31420@macsyma.lan>
From: Mario Lohajner <mario_lohajner@rocketmail.com>
In-Reply-To: <20260206014249.GH31420@macsyma.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.25164 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rocketmail.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[rocketmail.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[huawei.com,dilger.ca,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-13601-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[rocketmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[rocketmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mario_lohajner@rocketmail.com,linux-ext4@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 10814102ECE
X-Rspamd-Action: no action

On 06. 02. 2026. 02:42, Theodore Tso wrote:
> On Thu, Feb 05, 2026 at 01:23:18PM +0100, Mario Lohajner wrote:
>> Let me briefly restate the intent, focusing on the fundamentals.
>>
>> Rotalloc is not wear leveling (and is intentionally not named as such).
>> It is a allocation policy whose goal is to reduce allocation hotspots by
>> enforcing mount-wide sequential allocation. Wear leveling, if any,
>> remains a device/firmware concern and is explicitly out of scope.
>> While WL motivated part of this work,
> 
> Yes, but *why* are you trying to reduce allocation hotspots?  What
> problem are you trying to solve?  And actually, you are making
> allocation hotspots *worse* since with global cursor, by definition
> there is a single, super-hotspot.  This will cause scalability issues
> on a system with multiple CPU's trying to write in parallel.
Greetings Ted,

First off, apologies for the delayed reply — your emails somehow ended 
up in my spam! I hope this doesn’t happen again.
Also, sorry for the lengthy responses; I really care to make my points 
clear.

I’m not proposing that ext4 should implement or control wear leveling.
WL clearly does (or does not) exist below the FS layer and is opaque to 
us (we have no way of knowing).
What is observable in practice, however, is persistent allocation 
locality near the beginning of the LBA space under real workloads, and a 
corresponding concentration of wear in that area, interestingly it seems 
to be vendor-agnostic. = The force within is very strong :-)

The elephant:
My concern is a potential policy interaction: filesystem locality
policies tend to concentrate hot metadata and early allocations. During
deallocation, we naturally discard/trim those blocks ASAP to make them
ready for write, thus optimizing for speed, while at the same time 
signaling them as free. Meanwhile, an underlying WL policy (if present) 
tries to consume free blocks opportunistically.
If these two interact poorly, the result can be a sustained bias toward
low-LBA hot regions (as observable in practice).
The elephant is in the room and is called “wear” / hotspots at the LBA 
start.


> 
>> the main added value of this patch is allocator separation.
>> The policy indirection (aka vectored allocator) allows allocation
>> strategies that are orthogonal to the regular allocator to operate
>> outside the hot path, preserving existing heuristics and improving
>> maintainability.
> 
> Allocator separation is not necessarily that an unalloyed good thing.
> By having duplicated code, it means that if we need to make a change
> in infrastructure code, we might now need to make it in multiple code
> paths.  It is also one more code path that we have to test and
> maintain.  So there is a real cost from the perspctive of the upstream
> maintenance perspective.

My goal was to keep the regular allocator intact and trivially clean.
Baokun noticed this well — I’m using all existing heuristics; the only
tweak I do is to ‘fix the goal’ (i.e., set where to start), which then
sequentially advances toward the region most likely to contain empty,
unused space, at which point allocations become nearly instantaneous.

Being orthogonal in principle, these two allocators/policies are meant 
to live independently of each other.

Alternatively, we could drop the separation entirely and add a few
conditional branches to the regular allocator to the same effect,
but this introduces overhead, potential branch mispredictions, and all 
the associated shenanigans (minor but not insignifficant).
Separation avoids that, at the minimal cost of maintaining 20-ish extra
lines of code.
(memory we have; time is scarce)

> 
> Also, because having a single global allocation point (your "cursor")
> is going to absolutely *trash* performance, especially for high speed
> NVMe devices connected to high count CPU's, it's not clear to me why
> performance is necessary for rotalloc.
> 
>> The rotating allocator itself is a working prototype.
>> It was written with minimal diff and clarity in mind to make the policy
>> reviewable. Refinements and simplifications are expected and welcome.
> 
> OK, so this sounds like it's not ready for prime time....

I don’t consider it “not ready for prime time.” It is a rather simple 
refinement of the existing allocator, producing clean, contiguous 
layouts with sequential allocation across the LBA space without increase 
in complexity and with equal or lower latency.
Further refinements are anticipated and welcome — not because the 
current approach is flawed, but because this seems like an area where we 
can reasonably ask whether it can be even better.

> 
>> Regarding discard/trim: while discard prepares blocks for reuse and
>> signals that a block is free, it does not implement wear leveling by
>> itself. Rotalloc operates at a higher layer; by promoting sequentiality,
>> it reduces block/group allocation hotspots regardless of underlying
>> device behavior.
>> Since it is not in line with the current allocator goals, it is
>> implemented as an optional policy.
> 
> Again, what is the high level goal of rotalloc?  What specific
> hardware and workload are you trying to optimize for?  If you want to
> impose a maintaince overhead on upstream, you need to justify why the
> mainteance overhead is worth it.  And so that means you need to be a
> bit more explicit about what specific real-world solution you are
> trying to solve....
> 
> 						- Ted

Again, we’re not focusing solely on wear leveling here, but since we
can’t influence the WL implementation itself, the only lever we have is
our own allocation policy.
The question I’m trying to sanity-check is whether we can avoid
reinforcing this pattern, and instead aim for an allocation strategy
that helps minimize the issue—or even avoid it entirely if possible.

Even though this pattern is clear in practice I’m not claiming this
applies universally, only that it appears often enough to be worth
discussing at the policy level. For that reason, it seems reasonable to
treat this as an optional policy choice, disabled by default.

Sincerely,
Mario

