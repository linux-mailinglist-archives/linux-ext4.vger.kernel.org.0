Return-Path: <linux-ext4+bounces-4108-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF19972FF6
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Sep 2024 11:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C86621F24BB7
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Sep 2024 09:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B05D1891A0;
	Tue, 10 Sep 2024 09:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YH3jbB1d"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861D614F12C;
	Tue, 10 Sep 2024 09:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962176; cv=none; b=g3nuWIWhwvt8ALJSOCRiZN+qxR5aKDU4enM8Ho9IsTJwfY1AJLqW8WD9dYHNiw7M8JflkjPIPY2Mp1dq0X+yUvYjMZR6cQWN5NCKbGMv36yl2NJHi2gufs5CyjgSohQemPWcFBVpQ1VSIM9SOGRoHR6V5VbjWWwTY67Z3MGJpgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962176; c=relaxed/simple;
	bh=PUrx8/GHZDMwC+M8a3MvdbNkJtPsdRYr+TPlEkBHbIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MhmSiSk73CuFpDLY+rEFVkDUwJ9QxXOi6/yHd3kUi+n3W1al4/LNiUbK28RnUHwJJb2rZG0ERjASgga3r3HZpLiIAHkcbtHIKSXSn4R9hPOI6POVkwQWpJ0TqjSP+nmfMdV2i/LX34jKLKGBpRCQedTRO0OxylLw7dUZ5eHhH0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YH3jbB1d; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6c354091616so31617356d6.0;
        Tue, 10 Sep 2024 02:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725962173; x=1726566973; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=roKfj6CBD2UQOUOtyA4gjf+WNvWYxpn/sCg2YOe/DwY=;
        b=YH3jbB1ddph8tTa46+2JYd9vcppdIiK+R1NT+aILqC2A7RGApbWxp/5NScS7uUmcvL
         Y01K9XfpN4TYVSzg7yQdvNvpNWlzcWK2cI1onyiv8wE2I9hRB827pyIW57+5FC9yQSQG
         fysWoUFQFWOCWd1edDCv5C1qGu5vcLt5KSn0jMaaKtwIuFo1r+8Xt0HGxnSGlfQIjX5P
         bvbcimYplZ1F2eswBjVzeB4MaDby6ec10kJJHtc4ReWJ5Bhs1SexYvSpdzzyKQEoVkZL
         iO0h44hHp1wl8pIxEDYKOPEfXeE0pnhaE1KGuoFNKIr76F5zOl8lSfI34nPCikoGzBBM
         yXrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725962173; x=1726566973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=roKfj6CBD2UQOUOtyA4gjf+WNvWYxpn/sCg2YOe/DwY=;
        b=Py8GrsPBOKi8Oy6w12Q06CiSZ9SiMd4FENrLcJ2rZ84BbAoyPvaqD4I/+hA9WoDUhz
         y6igvLZXV/yrUwDB0qtoGtsdE1c82M0m6vkvl+FwK7l+twrg4UPSCqy+LePInFMj+BpO
         0EIoQFuiki8KYYrL0Gwe5qqKjfqJZNTEg7xci3iM9LVM9HuRUHXsUs65klO9lzO0rSnI
         tlRRuZL7h5jePgmRtNg85+EY42m17LmB+6pxONIvKaPq+FmoiG3PnGi7jEdxu5aDoMcW
         7lYmiKFY1dTb5I5lRqNNifvUHRDiKppgYNx1KWSxVytaAqPeVDr76fpfrYWdVFd0x7cn
         lKpA==
X-Forwarded-Encrypted: i=1; AJvYcCVnSI+MpGt8Mx5kcwQXcXgggGFN1q2IGo5bcB+egrLj3CK2qVNreaj5Mgio871WuKxMIvdHvl2PQUQW@vger.kernel.org
X-Gm-Message-State: AOJu0YyoDzCg2WXh0G1F431zlyjmbBc9HzN0rWBwBEin+Ant+qS/3IC6
	uY5ZtEJDN0Mr0NJrTN3j7fiND/+uo00ZiEElE+AaHwFS658gDqOo
X-Google-Smtp-Source: AGHT+IFbJb3T//+cq9Q4JRnEXAhbI68gYsqv2eUEJLtnL33G5JYViRQraVCJtfsTajEvEYStjv8YWw==
X-Received: by 2002:a05:6214:3a81:b0:6bf:79e5:b129 with SMTP id 6a1803df08f44-6c52851ba0bmr221983566d6.49.1725962173272;
        Tue, 10 Sep 2024 02:56:13 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c53477476fsm28732476d6.110.2024.09.10.02.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 02:56:12 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id B76C6120006F;
	Tue, 10 Sep 2024 05:48:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 10 Sep 2024 05:48:30 -0400
X-ME-Sender: <xms:7hXgZigQE13RCrtin2NzeqsOQYIVHZtxbQagokSiJib7BPK3_VU4hw>
    <xme:7hXgZjDtd55yaijw3SQySl2MfmxYOl78vaXwlZ_j3dSLYt2uhdKWA_key8V0TU_6I
    9ifMK0jurP_dntxCw>
X-ME-Received: <xmr:7hXgZqF1yXdfdec7uS8wVbIIxOn73DrJu7g0Ps_Xoomto1k1SKpeQfR-T9-95g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeiledgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedvteeh
    uddujedvkedtkeefgedvvdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdo
    mhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejke
    ehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgr
    mhgvpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    gsohhtthgrrgifvghsohhmvgeifeefsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhi
    nhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepph
    gvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepmhhinhhgohesrhgv
    ughhrghtrdgtohhmpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehlohhnghhmrghnsehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhig
    qdgvgihtgeesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehshiiikhgrlh
    hlvghrsehgohhoghhlvghgrhhouhhpshdrtghomhdprhgtphhtthhopegsohhquhhnsehf
    ihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:7hXgZrQnxVOPf-6ZuZRKazpQl5hoIFleQSFNtAxkJOFshO-Uuz9Vqw>
    <xmx:7hXgZvxj0bqh3tWjD1qoRRxdflikccaelq_15V_dglmBYtxPAiWwmg>
    <xmx:7hXgZp6WMuD1pBcQS_0TP77lWozgAvgZrsCwh1GoKdZx3ALkGSNBIQ>
    <xmx:7hXgZsymITmjsd8oifQFFDatboPhBPaX5STNwLZtVfn1gljmrbjZwQ>
    <xmx:7hXgZrgZ8EM-jxffltuFVI0Xi1iaubMXZnZL9vvHIiss2YMnMzj7oDqL>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Sep 2024 05:48:30 -0400 (EDT)
Date: Tue, 10 Sep 2024 02:47:26 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Ahmed Ehab <bottaawesome633@gmail.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, linux-ext4@vger.kernel.org,
	syzkaller@googlegroups.com
Subject: Re: [PATCH v8 2/2] locking/lockdep: Test no new string literal is
 created in lockdep_set_subclass()
Message-ID: <ZuAVrkMQvk41PNKH@boqun-archlinux>
References: <20240905011220.356973-1-bottaawesome633@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905011220.356973-1-bottaawesome633@gmail.com>

Hi Ahmed,

On Thu, Sep 05, 2024 at 04:12:20AM +0300, Ahmed Ehab wrote:
> Add a test case to ensure that no new name string literal will be
> created in lockdep_set_subclass(), otherwise a warning will be triggered
> in look_up_lock_class(). Add this to catch the problem in the future. 
> 

This overall looks good to me, I'm going to take it and create a PR for
tip in next release. However, please note a few things:

* Since you only send one of the patch from your original series, you
  should avoid use "2/2" in the title, because it could be confusing
  whether there is "1/2" lost in sending. If you want to make sure
  people aware that this is a continued work of the patch #2 in your
  original series, you can put some description after the following
  "---"

* You need also to put changes between patch versions after "---" so
  that people can know the context, for example, I have no idea why you
  send a v8 after v7 and what's the delta here. Here is an example of
  how to document the delta:

  	https://lore.kernel.org/rust-for-linux/20240827-static-mutex-v2-1-17fc32b20332@google.com/

Regards,
Boqun

> Signed-off-by: Ahmed Ehab <bottaawesome633@gmail.com>
> ---
>  lib/locking-selftest.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
> index 6f6a5fc85b42..0783ee97c971 100644
> --- a/lib/locking-selftest.c
> +++ b/lib/locking-selftest.c
> @@ -2710,6 +2710,44 @@ static void local_lock_3B(void)
>  
>  }
>  
> +#if CONFIG_DEBUG_LOCK_ALLOC
> +static inline const char *rw_semaphore_lockdep_name(struct rw_semaphore *rwsem)
> +{
> +	return rwsem->dep_map.name;
> +}
> +#else
> +static inline const char *rw_semaphore_lockdep_name(struct rw_semaphore *rwsem)
> +{
> +	return NULL;
> +}
> +#endif
> +
> +static void lock_class_subclass_X1(void)
> +{
> +	const char *name_before_setting_subclass = rw_semaphore_lockdep_name(&rwsem_X1);
> +	const char *name_after_setting_subclass;
> +
> +	lockdep_set_subclass(&rwsem_X1, 1);
> +	name_after_setting_subclass = rw_semaphore_lockdep_name(&rwsem_X1);
> +	DEBUG_LOCKS_WARN_ON(name_before_setting_subclass != name_after_setting_subclass);
> +}
> +
> +/*
> + * after setting the subclass the lockdep_map.name changes
> + * if we initialize a new string literal for the subclass
> + * we will have a new name pointer
> + */
> +static void class_subclass_X1_name_test(void)
> +{
> +	printk("  --------------------------------------------------------------------------\n");
> +	printk("  | class and subclass name test|\n");
> +	printk("  ---------------------\n");
> +
> +	print_testname("lock class and subclass same name");
> +	dotest(lock_class_subclass_X1, SUCCESS, LOCKTYPE_RWSEM);
> +	pr_cont("\n");
> +}
> +
>  static void local_lock_tests(void)
>  {
>  	printk("  --------------------------------------------------------------------------\n");
> @@ -2920,6 +2958,8 @@ void locking_selftest(void)
>  	dotest(hardirq_deadlock_softirq_not_deadlock, FAILURE, LOCKTYPE_SPECIAL);
>  	pr_cont("\n");
>  
> +	class_subclass_X1_name_test();
> +
>  	if (unexpected_testcase_failures) {
>  		printk("-----------------------------------------------------------------\n");
>  		debug_locks = 0;
> -- 
> 2.46.0
> 

