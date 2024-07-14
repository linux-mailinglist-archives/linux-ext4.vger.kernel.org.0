Return-Path: <linux-ext4+bounces-3251-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D082F930BF4
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Jul 2024 00:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 004CB1C21010
	for <lists+linux-ext4@lfdr.de>; Sun, 14 Jul 2024 22:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA27813D530;
	Sun, 14 Jul 2024 22:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxlMnay2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66DE22313;
	Sun, 14 Jul 2024 22:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720995434; cv=none; b=HN6ZY1dGEwK7l590zYaw0ow8Vmchqe5enU9f2xbA3dndxmzBEoUBuRFWSReN7/vKX37fr/+iCJmnXRylLp0s3qQlqmfoc7xbYVeWwKj5SiM2PxusvR4yLUBhtrV4YbLT8b3vM8fnmiKKDQTvQZvXf6C2i6s9vBRsYxTq1qnpJDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720995434; c=relaxed/simple;
	bh=RusYwsh6gr/hm4CtP7HyMGGFL1HPJkLm4O6NWMUILuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkNiet+BANUswnofeHEwswehsJDK13TB3KNOojjHWP2aH9YhoXNoICdhLezvqEahYCo64UiXldGlWB4NSh51hVztdvhWasrwxqBFSqpAGGVrcDnyidSeP3+eQ1d0GY5SY+wxuCrrE6fuqXFsob79zH2LyYg3P0V7VwfDpplv/tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hxlMnay2; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6b61689d7c9so24228716d6.2;
        Sun, 14 Jul 2024 15:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720995432; x=1721600232; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9d14tu8UM/7LR69vv692GAIifPe3a2v2W5S5B8IbTY=;
        b=hxlMnay2i0jZ/VfVpdHqBDbxpHPAYqdZjOVz9gsrYmiVy93fdpRxQuORat/jEOKLgr
         12ak+70PirPNT/ZuLDytuSm9b7ikTsQyZYdt5l24mnLAOkKLLNPxjVTVnYDEiEeLzv0x
         FfHvQQCHXMsy2Cf27aA3ECOIdpYNMo384K0oTDxKFzEhi3OpKnPOhS138r5cA6NKJiY7
         rzUDrXLCnoEeCEEgSRhN+9WdGXlqOl5TfXuuvOBHmeOpKYQJ33ibxLLpsIqnD2inrlqa
         AW4mvhiI+Tv1XMi2I8KmLuA5LBzUo/abmz7pH5DqgtbQRu3/wQjigQMpRR5zoz1gmBWs
         H3NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720995432; x=1721600232;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z9d14tu8UM/7LR69vv692GAIifPe3a2v2W5S5B8IbTY=;
        b=ku7kF6Ee0dTz9HrVnb9qpAZXKzJKRJA2lAzooDUh/R9I3ke2RhetX49TqS9qLao3vf
         ma2o7lJP9zS6UXwPH3f1YWWCjj5sPb96VSLcbBpptG1PektW7+eZx/w4+KPIDB1f0H0W
         5qJvmH0JOzYk88WSSrWoiO9vtcuBtFwMbRqYv+FRnds6bLJLDYs/IRF4urnFiE0MNW1d
         m/GlAuiJzfcQ+ceZkW53/1k/ojd/E43a6G7X+kAakyxG8R5PLt+mZ25UF7LI28EHs6HY
         TFnBJ3X362AcVmadomFW/PVww3bKWz5NZ9eCyPuuTOrEptq2SwBHx3HpkvfbV9EFH8rY
         Xy4A==
X-Forwarded-Encrypted: i=1; AJvYcCWDlHPmDt3bnxIDa/9yDQrJ+QdKcWUpbov5ck17Vq3n5P67Sswhb+g4SVuLfLIDXdfd1jh0kySGDfNXqGMHvFejwLZpXhwxxNSc2kbyUwGnBRXrbdjBSt1rHX4toq8WmQ/FOg==
X-Gm-Message-State: AOJu0YyRac0n4ry1skEYmpL0AiFNIowJRIGF6pxSJr37kaiGrkuTK5e2
	JA1WSmcJIxh7xIDAv8QsLSOLYBqEPOm/vJbV0PKkNyQ7HrRFWzJS
X-Google-Smtp-Source: AGHT+IHWJrJ+c3zyWwuDtaZs8dw+4awkboFYksDvOYayRTuBAbVk78SuwI78a5BgBeUgrq/Xje/OdQ==
X-Received: by 2002:a05:6214:5012:b0:6b5:e60c:76dc with SMTP id 6a1803df08f44-6b61bca39d5mr271730846d6.19.1720995431649;
        Sun, 14 Jul 2024 15:17:11 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b76195027asm16106626d6.1.2024.07.14.15.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 15:17:09 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 1BFC0120007E;
	Sun, 14 Jul 2024 18:01:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sun, 14 Jul 2024 18:01:53 -0400
X-ME-Sender: <xms:z0qUZgV30bmXZmJKwCRwNf6OeK1tQubeaIrrffTBnBlpAg7_djqQBg>
    <xme:0EqUZklHsKWDSM_-a-oFiBo6d9MG9ihim3j0eqWtd9j8MhY-joUs_wcoHZGO5cGLt
    hoGgVtQXCa3mjCfsw>
X-ME-Received: <xmr:0EqUZkZIxug932LYIfQ8gfCWj48vLz6qFHDxW6c8U8a_4hDp4kLkIffPXvk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgedugddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepkeelleffheetudehvdeuteffffeuteefueekhfdtlefhjeehkeetgeduheej
    feetnecuffhomhgrihhnpeguvghppghmrghprdhnrghmvgenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquh
    hnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:0EqUZvUVx9rmEeXp4-ERkxBUD6mscLMslI2W_wgJ0luS33Cl0KeICg>
    <xmx:0EqUZqk7nvQkRDh524RSJcXW1PxMxjT6G5hLCH0oGvrDaqUx-pd_qg>
    <xmx:0EqUZkfZq1-oz2aUY-fdLLfcqf9FosT2ynTIOShhWs_7nYTHqWm8lw>
    <xmx:0EqUZsHecnM280xgjWpIgIQUSio8aZ11aexMB0VeuZd8qUIc8D63tg>
    <xmx:0UqUZgkLpxysVR2MYoA4RjN-3Kzm4fni_wzPK5RDPuUdEVXoAPf8oMME>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Jul 2024 18:01:51 -0400 (EDT)
Date: Sun, 14 Jul 2024 15:00:16 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: botta633 <bottaawesome633@gmail.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, linux-ext4@vger.kernel.org,
	syzkaller@googlegroups.com,
	syzbot+7f4a6f7f7051474e40ad@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] ext4: Testing lock class and subclass got the same
 name pointer
Message-ID: <ZpRKcHNZfsMuACRG@boqun-archlinux>
References: <20240714051427.114044-1-bottaawesome633@gmail.com>
 <20240714051427.114044-2-bottaawesome633@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240714051427.114044-2-bottaawesome633@gmail.com>

On Sun, Jul 14, 2024 at 08:14:27AM +0300, botta633 wrote:

First, the subsystem tag also needs to be "locking/lockdep" or
"lockdep".

> Checking if the lockdep_map->name will change when setting the subclass.
> It shouldn't change so that the lock class and subclass will have the same name
> 

Could you make the commit log wrapped at 75 columns?

> 
> Reported-by: <syzbot+7f4a6f7f7051474e40ad@syzkaller.appspotmail.com>
> Fixes: fd5e3f5fe27
> Cc: <stable@vger.kernel.org>

Since this is only adding test for a bug fix, you don't need to put
these tags here.

> Signed-off-by: botta633 <bottaawesome633@gmail.com>

Again, could you please put your name here?

Also seems that you send two patch #2, one is with the proper version
number "v2", but not in-reply-to the patch #1, the other doesn't have
the correct version number but has the correct "in-reply-to" field.
Could you use the correct version number and "in-reply-to" next time?

> ---
>  lib/locking-selftest.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
> index 6f6a5fc85b42..1d7885205f36 100644
> --- a/lib/locking-selftest.c
> +++ b/lib/locking-selftest.c
> @@ -2710,12 +2710,24 @@ static void local_lock_3B(void)
>  
>  }
>  
> +static void class_subclass_X1_name(void)
> +{
> +	const char *name_before_subclass = rwsem_X1.dep_map.name;
> +	const char *name_after_subclass;
> +
> +	WARN_ON(!rwsem_X1.dep_map.name);
> +	lockdep_set_subclass(&rwsem_X1, 1);
> +	WARN_ON(name_before_subclass != name_after_subclass);

Could you add some comments here explaining your test? For example,
where name_after_subclass gets set?

> +}
> +
>  static void local_lock_tests(void)
>  {

Please don't add this test into another test, you could directly call
your class_subclass_X1_name() (maybe rename it to *_test()) in
lockding_selftest() function.

Besides, make sure you run the test with and without your modification
in patch #1, and confirm this is the test that could verify your fix.

Regards,
Boqun

>  	printk("  --------------------------------------------------------------------------\n");
>  	printk("  | local_lock tests |\n");
>  	printk("  ---------------------\n");
>  
> +	init_class_X(&lock_X1, &rwlock_X1, &mutex_X1, &rwsem_X1);
> +
>  	print_testname("local_lock inversion  2");
>  	dotest(local_lock_2, SUCCESS, LOCKTYPE_LL);
>  	pr_cont("\n");
> @@ -2727,6 +2739,10 @@ static void local_lock_tests(void)
>  	print_testname("local_lock inversion 3B");
>  	dotest(local_lock_3B, FAILURE, LOCKTYPE_LL);
>  	pr_cont("\n");
> +
> +	print_testname("Class and subclass");
> +	dotest(class_subclass_X1_name, SUCCESS, LOCKTYPE_RWSEM);
> +	pr_cont("\n");
>  }
>  
>  static void hardirq_deadlock_softirq_not_deadlock(void)
> -- 
> 2.45.2
> 

