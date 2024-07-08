Return-Path: <linux-ext4+bounces-3142-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B2892ACE7
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Jul 2024 02:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D394C1F22152
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Jul 2024 00:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E36631;
	Tue,  9 Jul 2024 00:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GiRuXzm0"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434A7382;
	Tue,  9 Jul 2024 00:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720483575; cv=none; b=HrXlMC8o2PHyWjSfxixytb4F7u+QogfgMAYk1w4Ichl8G4Bu/nWV+Wda5LHVKLCQOYoCzwQPB9vCwJqMDIp/Ylp3yaWcUsntY0/UaXTn3h/uv4j+YCUwdIPvisUrvuN1giPiZa6r196Q4fJSLjRqfCoRVkjfRekyUzNqqH4UNhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720483575; c=relaxed/simple;
	bh=R9um6fVugVQts5vQq8DrMeOdp7Wyg3dhnpXhSlOimME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NsgvcLnnUok6h9YToP+n/sm8D1swtkWmBQCfWnUOWSdmtthqpbccHaM9Cx2nE2hx4uIO/Tjm0E8WFUVt3oce5OHGoyqANkSL3KeXWHOXcZ4Y59eDHtyyP5L4P5PxBVbLO5jgmXrSWQK7/3Iy2WQ/Y8z7Rl5UM7invFJMVJTotZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GiRuXzm0; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-79eff7b0524so182465185a.1;
        Mon, 08 Jul 2024 17:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720483573; x=1721088373; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=f4s9dyAk9gA4Urs+HScnWn9QMDcTw0a4uUhZubvcwsU=;
        b=GiRuXzm0rgBjLs/gwtdfj4K0dyGkFdC+ZmdFkBhct5AMBsZVhL1pinIuxhz8yqn+yZ
         dJNSPvyE63midx2O7isYIrXJl87UnVzcI/6HvII+QCR/wEevjk9s0v8CItGcS2kssFEm
         KyHt2LCOpsfybQPycvMWv1trpahaoQxPXReElsD2pBGDjhXoy4aA2+KiMHb8uq35Nkzm
         l1ErLaccLC6vgbnPDMDcLHRr6hGR7rGaJpmn6KeXD1qjGFB4pmi2tIDnng0z13VTeJc0
         KJOMMNLAJaltIspyqaHtUkJ70Xfl818kacR5grlw84Kbmg1Cwg3kqQq2V9pXYTeOzw/9
         8oCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720483573; x=1721088373;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f4s9dyAk9gA4Urs+HScnWn9QMDcTw0a4uUhZubvcwsU=;
        b=WGsKAvOc+K2TqXYRaOwFbVjCFJ0stRIvFIvdTKBzc8LvdNyipJFx/CrAUrYeNduvca
         jWG0N8W+MG4Iiq46nOojy3lmHws7RpeDjXx/ttgCQRmit7bTGEuQ2OLQGVU+mDQ9Bvkb
         RbqJvjRcGMmu5nq858x6Eb6ALD1mwqLMyDAN6LwTEycFLH35+ZYfYqjaUvxJTqjl61yt
         jyE0u+Dqh9Xrkp4lPfgqI0CdkAIUniqcbBGvxdAoYMiJe8sAqpUqaC1TZRnX/93XuWkC
         eXou2cO6otL5k4zmcxxLs7sn5oqbQSXLr9lYaQxC9eoGoCcRbItQpm0HCe40P5GhbeuX
         LnKg==
X-Forwarded-Encrypted: i=1; AJvYcCU4yaFrtdEYXSTlUVMTLDRADNSxelq4rSDt76fPHDsCr40+WojamPzc034NEIlmnk0c2VgAgdxss2cTbsva+OTP0CgB4lWYIN6XEQ==
X-Gm-Message-State: AOJu0YwBLBofBuFWLu8Sl61aO78DoXUex5AXc5WhpRLBukShKkLxiMgI
	epAv6LXIy/2zLPUgM646NH1oSCRpE0jY3lOOWh8r/KIyzlhjcWcp
X-Google-Smtp-Source: AGHT+IF5mu5L0izgHwLELDIslDTOMrKUlc5OuXKYSMGIiKjD64e2aY13s7xCYeXiG8epwaEvQspb0g==
X-Received: by 2002:a05:620a:21c5:b0:79e:f9f4:3e99 with SMTP id af79cd13be357-79f1b566e2bmr121510885a.1.1720483573078;
        Mon, 08 Jul 2024 17:06:13 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f1908959esm40437785a.77.2024.07.08.17.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 17:06:12 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfauth.nyi.internal (Postfix) with ESMTP id CDA2E1200071;
	Mon,  8 Jul 2024 19:56:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 08 Jul 2024 19:56:56 -0400
X-ME-Sender: <xms:x3yMZjhQqPvOgpJBZym5Q42-1aZI-svnGbzjFpBmItkmLso-DV3ZMg>
    <xme:x3yMZgCUUiqAWYZ62R_fBQ-Cj_r93bjYLxHA71TpOEhIkLZvaLOZ5yCCOWfoHWoNl
    bzbYBP7E2bT-s8SeQ>
X-ME-Received: <xmr:x3yMZjFcgZ3eaNFHHjHzsnhNj1pbyTGWx5gvZ_QU6BVXR2-i5WY2S4s0B8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekgddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtvdffjeekheelieeggeekleeiuefhffegfeeiieetffdvtdeltdelhffh
    jeekteenucffohhmrghinhepshihiihkrghllhgvrhdrrghpphhsphhothdrtghomhdpkh
    gvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqie
    elvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdr
    tghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:x3yMZgSz9wifKmGioWlCZQWeHZOp8kWFclktk7A-6CWxuysNdaInwA>
    <xmx:x3yMZgyVQBjFtgGeocvbmFNputYvTgUyXLokVKW8v9W_j32OgENnrQ>
    <xmx:x3yMZm7aXqlfzx0_9q3LkDRqVAwrxw6wma7exGkenvkKT8AN60K7NA>
    <xmx:x3yMZlxmp4nIoRMAI40O25LsYB_s-lOG_Gkjk4ZIYX1AWh0Wkig-WQ>
    <xmx:yHyMZggKvi9iC1rhTMCMQgx_1psuVvpK1XFizSIwvqvSfHHEnmkFQTRK>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jul 2024 19:56:55 -0400 (EDT)
Date: Mon, 8 Jul 2024 16:55:38 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: ahmed Ehab <bottaawesome633@gmail.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, linux-ext4@vger.kernel.org,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	syzkaller@googlegroups.com, "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] Forcing subclasses to have same name pointer as their
 parent class
Message-ID: <Zox8ep23zUSzbFMZ@boqun-archlinux>
References: <20240704003224.22832-1-bottaawesome633@gmail.com>
 <ZoXUgdUkD-GtKfKJ@boqun-archlinux>
 <CA+6bSasi4W8zEXu+gqGnpvJpFg0EDeW7fwnFMCqYeFH0hcCGag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+6bSasi4W8zEXu+gqGnpvJpFg0EDeW7fwnFMCqYeFH0hcCGag@mail.gmail.com>

On Tue, Jul 09, 2024 at 02:26:05AM +0300, ahmed Ehab wrote:
> Hi,
>  thanks for the great feedback.
> 
> 
> 
> 
> * Last but not the least, could you try to add a test case in
> lib/locking-selftest.c to ensure the issue you fixed won't        happen
> again? This could be tricky, since you will need to fight        against
> the compiler to generate two string literals with the        same content.*
> I added a test case, but I am not sure how to run this test file as it
> doesn't seem to be part of the kselftests. I compiled it successfully by
> setting the lock debugging option but couldn't get it to run.
> 

My usual approach is: set CONFIG_DEBUG_LOCKING_API_SELFTESTS=y, compile
a kernel, and boot it in qemu, the test result will show in serial log
of the VM. Hope that helps.

Regards,
Boqun

> Regards,
> Ahmed
> 
> On Thu, Jul 4, 2024 at 1:46 AM Boqun Feng <boqun.feng@gmail.com> wrote:
> 
> > Hi,
> >
> > On Thu, Jul 04, 2024 at 03:32:24AM +0300, botta633 wrote:
> > > Preventing Lockdep_set_subclass from creating a new instance of the
> > > string literal. Hence, we will always have the class->name. This
> > > prevents kernel panics when locking up a lock class while comparing
> > > class locks and class names.
> >
> > Good catch! Thanks.
> >
> > >
> > >
> >
> > Please remove the extra blank line here.
> >
> > > Signed-off-by: botta633 <bottaawesome633@gmail.com>
> >
> > Do you mind putting your real name here? Besides, IIUC, this is fixing:
> >
> >         https://syzkaller.appspot.com/bug?extid=7f4a6f7f7051474e40ad
> >
> >
> > , right? If so, there are some more things:
> >
> > *       Copy ext4 and syzkaller people, so that you could get more
> >         tests.
> >
> > *       Since this is a bug fix, could you please figure out which
> >         commit introduces the issue, so that you can put a correct
> >         "Fixes:" tag along with your signed-off-by?
> >
> > *       Since the issue was reported by syzkaller, you should put their
> >         "Reported-by" tag, they have an example in the website I paste
> >         above.
> >
> > *       Please also Cc stable mail list so that the fix can be
> >         backported, you can find the information on "Cc: stable" tag at:
> >
> >                 https://docs.kernel.org/process/stable-kernel-rules.html
> >
> > *       Last but not the least, could you try to add a test case in
> >         lib/locking-selftest.c to ensure the issue you fixed won't
> >         happen again? This could be tricky, since you will need to fight
> >         against the compiler to generate two string literals with the
> >         same content.
> >
> > [Cc ext4 and syzkaller]
> >
> > Regards,
> > Boqun
> >
> > > ---
> > >  include/linux/lockdep.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> > > index 08b0d1d9d78b..df8fa5929de7 100644
> > > --- a/include/linux/lockdep.h
> > > +++ b/include/linux/lockdep.h
> > > @@ -173,7 +173,7 @@ static inline void lockdep_init_map(struct
> > lockdep_map *lock, const char *name,
> > >                             (lock)->dep_map.lock_type)
> > >
> > >  #define lockdep_set_subclass(lock, sub)
> >       \
> > > -     lockdep_init_map_type(&(lock)->dep_map, #lock,
> > (lock)->dep_map.key, sub,\
> > > +     lockdep_init_map_type(&(lock)->dep_map, (lock)->dep_map.name,
> > (lock)->dep_map.key, sub,\
> > >                             (lock)->dep_map.wait_type_inner,          \
> > >                             (lock)->dep_map.wait_type_outer,          \
> > >                             (lock)->dep_map.lock_type)
> > > --
> > > 2.45.2
> > >
> >

