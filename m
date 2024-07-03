Return-Path: <linux-ext4+bounces-3103-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 306AE926BBC
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Jul 2024 00:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DB10B21A29
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jul 2024 22:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8A5191F69;
	Wed,  3 Jul 2024 22:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQsZnf5n"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8587914265C;
	Wed,  3 Jul 2024 22:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720046788; cv=none; b=m2uKW/aXyJH7DHXrmC4P0pY8IAswNNBK3GBEsJ7mpeA3J4nrTSQ7BlThUf98J7ZdO0ek37y0QOB86b/e4KjynK9hJgzUtcI+3f69aZGGvkLiUEzWfgNlIF5ZTwmb0SnoKlmNYDcp0xb217CYzA7+LXXfDLozjQi2IN9IKf9UKEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720046788; c=relaxed/simple;
	bh=gA7+VliSMoQlSbs6CV2YV/4Xrx/0Iq+N6gm0gQ63NHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fkGla/nFyxl6ey/qj9RnBo9N9Qdc9W2x9O30sBMQHlDLqO+fBC7KTC9saN5n0Ee/iHKjmj93nqrM9uCZqCeUpX2B20FUAIGCO2IMgy1oSb0v1jwKckNs6v5SvVqDsGfqTjZJu1d49IVcaGJp8jqbgn4MLFMpjQWMh/V1NSLvfnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQsZnf5n; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e0360f8901aso17751276.2;
        Wed, 03 Jul 2024 15:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720046785; x=1720651585; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1NR1sr/ZbZPbIrygTH2/gqn6qhtATWX6EGzQmK9ZnLY=;
        b=AQsZnf5nn6QOrMol5ZSHJ4Kw6BdQ5UicPwEajIqgq/eWkMKHBKPcscs1DHmxv+1I5r
         bRQ66I/GaoPrGOJ+uVKs8AhsAOUJW4c888X9zSyCq3hsN/8rWo2qTKtUhlFHUBf+VbYn
         SAopT4cVTs1OwTBjn0zn6l329KSIF8IgcPuSPErdsrthMNpyejH2zTjZdMAnbNDvec4Q
         +OkQTVfI+N7jXQoHrN1A4E36q0+EQYkcvzW+vXHulsioY5YGXgCbWOud/6I2YX8yWVEb
         waelb6xsxrmPR+FLmUdjyu6h1H4RkxEPNtf9iRkCLgFXke0JZ4/vy48mlfK1NvfW1Cnt
         mvIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720046785; x=1720651585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1NR1sr/ZbZPbIrygTH2/gqn6qhtATWX6EGzQmK9ZnLY=;
        b=YK1uDPf8dHRgvb/IoiirrNHXGzu2GNi6EPi2JSggW9ReCQ0eF/bMGK7l+oUfVym6Bl
         r+HyfOipMrAl9EB9AaHdcpUyutb4Q88Obhlhu61PHUPtrT4iFJ7fXRRn4/06LdUj+L1g
         bsQn+KdFD6hLNFN6uxsXiXSOjEEwAm28I2F9X7h/tFJIa8XftpAXb3ScCjhfzenVT0ma
         oAxqvqeoHOYlH2W7XlZCH8Lpc2weA5CR8l8eN4789xggenRQOXgCfnWKB+Z1g2stBuBO
         Mi+tRVrP0+5Bx8J/QEZ7l54InsfDteGuvRPPR+4qDOKWn0KJlDqyx0Uk2wTFHNO8Zp5m
         gJhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXHorNZoXITf39x5ZzsZR5VfWV9TN6eY9FRvTQGhaiFW+rNYyjlIjnzZd1RcubfdjQuHRyr9nqzL+TRuVUnGNOHfoAQu98TdjZJw==
X-Gm-Message-State: AOJu0Yx3jGkmJcy9JcgEJ/QXVxakPZ62nAGTNF98s6CoeWPpI9t1ywTt
	Y+qBZSAfKQ28TDKvILMM1lQpzax5Th2QCrN7Btvdyw7lSeBdQ9F0
X-Google-Smtp-Source: AGHT+IExAkct7vzhEMm0LI1KfE/PTZcCuuE2jma8x+8BFnYcDnOqpOFLAlcFxtmKBISUNpLtKW1JMg==
X-Received: by 2002:a25:a8a:0:b0:e03:a168:f132 with SMTP id 3f1490d57ef6-e03a168f33fmr5910295276.31.1720046785489;
        Wed, 03 Jul 2024 15:46:25 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b5dfc92d45sm11585156d6.142.2024.07.03.15.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 15:46:24 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfauth.nyi.internal (Postfix) with ESMTP id B79191200043;
	Wed,  3 Jul 2024 18:46:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 03 Jul 2024 18:46:23 -0400
X-ME-Sender: <xms:v9SFZrx_XtbK-YmDyDOjoYWTmPxohWsAuEywVmy5C-q_289ELl4w6Q>
    <xme:v9SFZjRnRT4ueTFnC9qKpR5Fb8BM3TqB46E8Gga1ITXXr14zkm5D88g46Rn-NfQGQ
    n1-TaXpQJoicXn6rg>
X-ME-Received: <xmr:v9SFZlUBlhEfZhkrGHuLpSP3qpqH706ahknh5UQGSz2NMC3NJlO4xqvKlmhzQg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekgddufecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepleeuvdehjeehledvtdegveefleejleegtdelkefgkedttdekhedvheegvdei
    tdetnecuffhomhgrihhnpehshiiikhgrlhhlvghrrdgrphhpshhpohhtrdgtohhmpdhkvg
    hrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeile
    dvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgt
    ohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:v9SFZlhbUHcdPHmwNFdklla1dY5XdKiopnYKyq0vQl86-zVmW1c4Tw>
    <xmx:v9SFZtC4q8BNcRAanbiCDL67mnwaPba5DcF7L6EHNSiH2kAYd2fPuw>
    <xmx:v9SFZuIsz5HmwPC3G9SO38xRuLPynuOJUpAqjymzrMvEwEJ9FtBldQ>
    <xmx:v9SFZsC5fgbK0kDTUbMdZYkhic74F-huTbKFQsZRb9P1prA8cGpt2w>
    <xmx:v9SFZpxjiGRpDeCj2_rfeNL_DXy_C7cthYJKNFF-K6NDGkj4bqri8eEs>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jul 2024 18:46:23 -0400 (EDT)
Date: Wed, 3 Jul 2024 15:45:21 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: botta633 <bottaawesome633@gmail.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, linux-ext4@vger.kernel.org,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	syzkaller@googlegroups.com, "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] Forcing subclasses to have same name pointer as their
 parent class
Message-ID: <ZoXUgdUkD-GtKfKJ@boqun-archlinux>
References: <20240704003224.22832-1-bottaawesome633@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704003224.22832-1-bottaawesome633@gmail.com>

Hi,

On Thu, Jul 04, 2024 at 03:32:24AM +0300, botta633 wrote:
> Preventing Lockdep_set_subclass from creating a new instance of the 
> string literal. Hence, we will always have the class->name. This
> prevents kernel panics when locking up a lock class while comparing
> class locks and class names.

Good catch! Thanks.

> 
> 

Please remove the extra blank line here.

> Signed-off-by: botta633 <bottaawesome633@gmail.com>

Do you mind putting your real name here? Besides, IIUC, this is fixing:

	https://syzkaller.appspot.com/bug?extid=7f4a6f7f7051474e40ad		

, right? If so, there are some more things:

*	Copy ext4 and syzkaller people, so that you could get more
	tests.

*	Since this is a bug fix, could you please figure out which
	commit introduces the issue, so that you can put a correct
	"Fixes:" tag along with your signed-off-by?

*	Since the issue was reported by syzkaller, you should put their
	"Reported-by" tag, they have an example in the website I paste
	above.

*	Please also Cc stable mail list so that the fix can be
	backported, you can find the information on "Cc: stable" tag at:

		https://docs.kernel.org/process/stable-kernel-rules.html

*	Last but not the least, could you try to add a test case in
	lib/locking-selftest.c to ensure the issue you fixed won't
	happen again? This could be tricky, since you will need to fight
	against the compiler to generate two string literals with the
	same content.

[Cc ext4 and syzkaller]

Regards,
Boqun

> ---
>  include/linux/lockdep.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> index 08b0d1d9d78b..df8fa5929de7 100644
> --- a/include/linux/lockdep.h
> +++ b/include/linux/lockdep.h
> @@ -173,7 +173,7 @@ static inline void lockdep_init_map(struct lockdep_map *lock, const char *name,
>  			      (lock)->dep_map.lock_type)
>  
>  #define lockdep_set_subclass(lock, sub)					\
> -	lockdep_init_map_type(&(lock)->dep_map, #lock, (lock)->dep_map.key, sub,\
> +	lockdep_init_map_type(&(lock)->dep_map, (lock)->dep_map.name, (lock)->dep_map.key, sub,\
>  			      (lock)->dep_map.wait_type_inner,		\
>  			      (lock)->dep_map.wait_type_outer,		\
>  			      (lock)->dep_map.lock_type)
> -- 
> 2.45.2
> 

