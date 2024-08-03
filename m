Return-Path: <linux-ext4+bounces-3624-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B29A0946694
	for <lists+linux-ext4@lfdr.de>; Sat,  3 Aug 2024 02:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CDEE282F50
	for <lists+linux-ext4@lfdr.de>; Sat,  3 Aug 2024 00:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED724C84;
	Sat,  3 Aug 2024 00:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGFW9qga"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983C8A929;
	Sat,  3 Aug 2024 00:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722646294; cv=none; b=Z0CRPQVqG7kpNN91sD+EZP5kJ5DGpW6884ZXImmS4Sf+9BDnzJwWZNYE6oarapwBtGz2QClwgXX+8bXEIw/oGtBRWwoB7iqFcIb9MXqpHMmSRGgjSOVuRkc76nRdyKss0kO0iePHuI+ZKUIOj4L7YbJBB9og311EMmaFJrMAaMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722646294; c=relaxed/simple;
	bh=pY96aYg32/nPw1XpFjrJmIvvF5VZbmfOnUTt7fs5/q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=amLnMPpmCkTRkxERAO6HRNL/qh1zwu+yXYjMQKn1WdHCvvV927h7ibk7rz43PkTTaPIslGTS46QZ2JLcpTLpO5q58XTtZqvHdRbnO0b6ludmHDx4Vbzo0RG/LXpfeZZX6DALEprg0bo7/N7P2h6xtA5K0ymOUgHnd4Uy+2lC9FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HGFW9qga; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7a1e4c75488so507468685a.0;
        Fri, 02 Aug 2024 17:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722646290; x=1723251090; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQ5SH8pjLBofgxa3lURHlA5+O1awYpQHzkcfwFFENrA=;
        b=HGFW9qgaCR4vIs2RuK+m38P4qzrb4QtN8Kt+dXyJCm/7l+4Ow7K+IkEbycgbM2aHdv
         dQES3yU/yf+nEWY36BRtLOF7+1/cMrn61aYQ5tIvoUNbw3ZfPjeQ2T6O+tVFFKJIDaZC
         R8xEmXAip+F7CIis89N33id2OSEsOQ141f0Ig2glj2ACmLyPqBqHsbpbfB8abrhwLb5w
         aQYQGjEY2BgOrRdWyyQQH5MYGEy0uEGQVugue7PbNkVlePrhYV1Uk6YQ5ztpSrZkbRXF
         iKsnTWRfK+L86m2XsJ0Ve7btQrh57+zfXxmO/Qe6WITM3P5Rr5CBXAIxkaYJN6syUtSM
         7N9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722646290; x=1723251090;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TQ5SH8pjLBofgxa3lURHlA5+O1awYpQHzkcfwFFENrA=;
        b=L5GUfVyRkyfdH4W7v2DSIQSxBTQb+F02Jaahcg37kD9cmfQUNFfXPf9QtIfR7xCZxz
         XkBKqQofB6n9ZnR7ZXAj5zdWYClnBqSZQCjIBWNq9HrRg5t1Do7XeZxBz4TRj84qCr/o
         Apj2alZPvEbBYgZC+g96YsLbGMF1+U+gXRS/opsNHaToYz8+Bq0J426F/FdZQwkOI2uO
         E5I4ZkTzWGitJaDDkbR3Ah7soMpM8F9oVvZwO8wzAy0uMntEOCy/f1G/yEeytWRw5mR1
         AOIZAlPQRBQuA54t3YUbhyBdpYsPKXzib68V6oJucdGku5f7Y38QgJIle/lx4fy1c2Dx
         39Xg==
X-Forwarded-Encrypted: i=1; AJvYcCWeuO1vBewp5atLZRXDdBso8A75FnBccxLLvpBwexcxvPOIwBJX8PFkLQcL5Qfi58M5XOAxSgQglzs9DFdxKqAg80pfjz3y+kxuRoA8owdLGD827XLwGx9vgWHV/Y4sunNwvQ==
X-Gm-Message-State: AOJu0Yzy0W0X4zU3T2BdicvU+gyz/TFO/cw/s0T1D0lGQWOtOwE0eFjq
	4Gwk7YU47V05vemdlJi+silQpfXcM5BNagV4ZGGJDjtJoDCE2m9a
X-Google-Smtp-Source: AGHT+IFdsjMUvV+iGbAQHXaLtooE3GQF9aY7QdpknGE0opLbaFTs4N7CXmbPb0VloScFpSk8TjkjRw==
X-Received: by 2002:a05:620a:f01:b0:79d:5c31:718c with SMTP id af79cd13be357-7a34ef032f5mr569864685a.27.1722646290473;
        Fri, 02 Aug 2024 17:51:30 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a34f76f1d7sm130938885a.92.2024.08.02.17.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 17:51:30 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfauth.nyi.internal (Postfix) with ESMTP id A6EB31200069;
	Fri,  2 Aug 2024 20:51:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 02 Aug 2024 20:51:29 -0400
X-ME-Sender: <xms:EX-tZhx7nqZ6mVAz9si0Rt99HSuYfAMyFdZsFSf-KBMnEcoTQEpN3A>
    <xme:EX-tZhSv22EGxN-HpDJqPqTIl8PqZ_R8xSUUYH3y0MXAYyDgumk7dknab-HzxWuCU
    1NBKFvdrVresB3CeQ>
X-ME-Received: <xmr:EX-tZrXbpb-0wZMIa5Rqa2Act1J9BvpDisSk_j5Vc5VM8SL7wic7joLel24>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkedugdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepfedvgfffuefgjeffgeeuvedtfeeuheegfeettdeifedtgeffleetteelteet
    feeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpuggvphgpmhgrphdrnhgrmhgvne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgvpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:EX-tZjiWwmIdV1DC7xp9x6FZC_Nsy4SfbxQmmeWn5UaCk9c6HIjETg>
    <xmx:EX-tZjAKtCeb6rBwTbkCr_KxKHuQA4jjfulDFyU2a-8bH-xUO_vRRA>
    <xmx:EX-tZsIS9i2mEu9Ichv3pMQCpaSXfUWKn2Z6N_1B8eQ5eBrzFSvNkw>
    <xmx:EX-tZiDaFaD7RkNNQmsHTroD1wUDgSnHmh-RBlY3aUuSarxMlKdqrQ>
    <xmx:EX-tZnxsd6nJyFHW2rbg7N4B4sDkznPJg8qIJpjB85csvV_RjL6EydTw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Aug 2024 20:51:29 -0400 (EDT)
Date: Fri, 2 Aug 2024 17:50:37 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: botta633 <bottaawesome633@gmail.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, linux-ext4@vger.kernel.org,
	syzkaller@googlegroups.com,
	syzbot+7f4a6f7f7051474e40ad@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 2/2] locking/lockdep: Testing lock class and subclass
 got the same name pointer
Message-ID: <Zq1-3bClxgBlhnoq@boqun-archlinux>
References: <20240715132638.3141-1-bottaawesome633@gmail.com>
 <20240715132638.3141-2-bottaawesome633@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715132638.3141-2-bottaawesome633@gmail.com>

On Mon, Jul 15, 2024 at 04:26:38PM +0300, botta633 wrote:
> From: Ahmed Ehab <bottaawesome633@gmail.com>
> 
> Checking if the lockdep_map->name will change when setting the subclass.
> It shouldn't change so that the lock class and subclass will have the same
> name
> 
> Reported-by: <syzbot+7f4a6f7f7051474e40ad@syzkaller.appspotmail.com>
> Fixes: de8f5e4f2dc1f ("lockdep: Introduce wait-type checks")
> Cc: <stable@vger.kernel.org>

You seems to miss my comment at v2:

	https://lore.kernel.org/lkml/ZpRKcHNZfsMuACRG@boqun-archlinux/	

, i.e. you don't need the Reported-by, Fixes and Cc tag for the patch
that adds a test case.

> Signed-off-by: Ahmed Ehab <bottaawesome633@gmail.com>
> ---
> v3->v4:
>     - Fixed subject line truncation.
> 
>  lib/locking-selftest.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
> index 6f6a5fc85b42..aeed613799ca 100644
> --- a/lib/locking-selftest.c
> +++ b/lib/locking-selftest.c
> @@ -2710,6 +2710,25 @@ static void local_lock_3B(void)
>  
>  }
>  
> + /** 

^ there is a tailing space here, next time you can detect this by using
checkpatch. Also "/**" style is especially for function signature
comment, you could just use a "/*" here.

> +  * after setting the subclass the lockdep_map.name changes
> +  * if we initialize a new string literal for the subclass
> +  * we will have a new name pointer
> +  */
> +static void class_subclass_X1_name_test(void)
> +{
> +	printk("  --------------------------------------------------------------------------\n");
> +	printk("  | class and subclass name test|\n");
> +	printk("  ---------------------\n");
> +	const char *name_before_setting_subclass = rwsem_X1.dep_map.name;
> +	const char *name_after_setting_subclass;
> +
> +	WARN_ON(!rwsem_X1.dep_map.name);
> +	lockdep_set_subclass(&rwsem_X1, 1);
> +	name_after_setting_subclass = rwsem_X1.dep_map.name;
> +	WARN_ON(name_before_setting_subclass != name_after_setting_subclass);
> +}
> +
>  static void local_lock_tests(void)
>  {
>  	printk("  --------------------------------------------------------------------------\n");
> @@ -2916,6 +2935,8 @@ void locking_selftest(void)
>  
>  	local_lock_tests();
>  
> +	class_subclass_X1_name_test();
> +

I got this in the serial log:

[    0.619454]   --------------------------------------------------------------------------
[    0.621463]   | local_lock tests |
[    0.622326]   ---------------------
[    0.623211]           local_lock inversion  2:  ok  |
[    0.624904]           local_lock inversion 3A:  ok  |
[    0.626740]           local_lock inversion 3B:  ok  |
[    0.628492]   --------------------------------------------------------------------------
[    0.630513]   | class and subclass name test|
[    0.631614]   ---------------------
[    0.632502]       hardirq_unsafe_softirq_safe:  ok  |

two problems here:

1)	The "class and subclass name test" line interrupts the output of
	testsuite "local_lock tests".

2)	Instead of a WARN_ON(), could you look into using dotest() to
	print "ok" if the test passes, which is consistent with other
	tests.

Could you please fix all above problems and send another version of this
patch (no need to resend the first one)? Thanks!

Regards,
Boqun

>  	print_testname("hardirq_unsafe_softirq_safe");
>  	dotest(hardirq_deadlock_softirq_not_deadlock, FAILURE, LOCKTYPE_SPECIAL);
>  	pr_cont("\n");
> -- 
> 2.45.2
> 

