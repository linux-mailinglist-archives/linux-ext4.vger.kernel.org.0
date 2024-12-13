Return-Path: <linux-ext4+bounces-5621-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 141999F0D1B
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Dec 2024 14:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA29A1886F44
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Dec 2024 13:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEC91DFE2F;
	Fri, 13 Dec 2024 13:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1PT8OqZP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fz9B86ty"
X-Original-To: linux-ext4@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52AA1DFE33
	for <linux-ext4@vger.kernel.org>; Fri, 13 Dec 2024 13:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734095620; cv=none; b=iZN89ro/hEuBUVsiPVyW+6kv/T2yi6yzOADAAfZ1tHWqS8t2lxMxm8KnPdt/7is4DXClg/Bdy3tzqpTueD1iZtNDpChfEXL+/k/i1yCFrPevftbT+QmkJpZn+M2Y6LRD5koFfSBlbQ7VLjL5Lfw1R3yTBcseTDtR9+tys/gmZXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734095620; c=relaxed/simple;
	bh=RZmJfiJjR6gJISL5pbHD/WP2nKbEnBuPqbz+jQiKSAY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rPmx5qrVEybKGiRH0JBQHm2cCJ8LE+ruryiM8Je+k0Xvr3M1eeQ6pUKYhewSmhD7RLws9gkBgLX9ILy9rFAtA+O1c5/5PQ52ftzvE5GeRNXcbol3znXNY4seCJrJ9iYNnWmIor8J3lTl8A4efezkb9KQE8j0eduqp/OLPd3RTXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1PT8OqZP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Fz9B86ty; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734095616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oIvx1QOmnoMjv+UcZ5OW36K4SsjomKKCLj0cIrmikGw=;
	b=1PT8OqZP4YlYwzKN/9RwGZtgfH8YkO/Yfeu8wJPzgbOQMOf5P59wFBbtNVmF0J7XJbkr+5
	QnBolz+g+WURuyPH3hgDypXOYVKMY2e0PxLTiKz2EL0MBeNWqn/gP9jtFhwQJpWoUrS/F5
	6GMDJClGh+mwLBDzHQ6PBQnyfKnjnkVYTiKgZnJIIjGc3GmBOHdfYQjVnhXaA2AblHqPbK
	9zZbiFNW6LHQee7WRfdUbWTpxv/DWSHbyv9EX8S+q7c0/rY5WA1y30tGFFBaLNg5qEAvXu
	YbEAvGNJf5KgHq+8InbMWfFnqoH9D/67YyKNgZqMlCRHTssk4nsAub3lbC8sug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734095616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oIvx1QOmnoMjv+UcZ5OW36K4SsjomKKCLj0cIrmikGw=;
	b=Fz9B86tyD74Nta+QP4pC570ZJoZV5oa40phqYQC0eog9H2qWxA9VTZrbfFUenXoYb86oiV
	ED/q3tX5yJt6vRCw==
To: Peter Zijlstra <peterz@infradead.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Stefan Hajnoczi
 <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>, "x86@kernel.org"
 <x86@kernel.org>, hpa <hpa@zytor.com>, dyoung <dyoung@redhat.com>, kexec
 <kexec@lists.infradead.org>, linux-ext4 <linux-ext4@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Stefano Garzarella
 <sgarzare@redhat.com>, eperezma <eperezma@redhat.com>, Paolo Bonzini
 <bonzini@redhat.com>, ming.lei@redhat.com, Petr Mladek <pmladek@suse.com>,
 John Ogness <jogness@linutronix.de>
Subject: Re: Lockdep warnings on kexec (virtio_blk, hrtimers)
In-Reply-To: <20241213112028.GE21636@noisy.programming.kicks-ass.net>
References: <1f631458c180c975c238d4d33d333f9fa9a4d2a3.camel@infradead.org>
 <CACGkMEtOdYorGPdSjxC1Lb1LJtZ+ZqHam3agHJ6JdpS-tE1qAQ@mail.gmail.com>
 <20241211124240.GA310916@fedora>
 <7717fe2ac0ce5f0a2c43fdab8b11f4483d54a2a4.camel@infradead.org>
 <87ldwl9g93.ffs@tglx>
 <10f5d22150b548ec271e0a847ba2eb91139e6f61.camel@infradead.org>
 <87a5d0aibc.ffs@tglx>
 <dd06cd643ee7fa0be08ac3082cff443b8bfbfb58.camel@infradead.org>
 <874j38a16p.ffs@tglx>
 <20241213112028.GE21636@noisy.programming.kicks-ass.net>
Date: Fri, 13 Dec 2024 14:13:36 +0100
Message-ID: <87seqr914v.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Dec 13 2024 at 12:20, Peter Zijlstra wrote:
> On Fri, Dec 13, 2024 at 01:14:54AM +0100, Thomas Gleixner wrote:
>
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -7276,7 +7276,7 @@ void rt_mutex_setprio(struct task_struct
>>  #if !defined(CONFIG_PREEMPTION) || defined(CONFIG_PREEMPT_DYNAMIC)
>>  int __sched __cond_resched(void)
>>  {
>> -	if (should_resched(0)) {
>> +	if (should_resched(0) && system_state != SYSTEM_SUSPEND) {
>>  		preempt_schedule_common();
>>  		return 1;
>>  	}
>
> Perhaps we should just do:
>
> 	if (should_resched(0) && !irqs_disabled())
>
> That's more or less what preemptible() does too. Yes, mucking about with
> IF is expensive, but it's only done if preempt_count is agreeing we
> should schedule, which it shouldn't be most of the time.

Makes sense. Let me write a real patch.

Thanks,

        tglx


