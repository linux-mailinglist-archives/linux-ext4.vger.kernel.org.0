Return-Path: <linux-ext4+bounces-7621-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AFDAA69D2
	for <lists+linux-ext4@lfdr.de>; Fri,  2 May 2025 06:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A90DE7A2937
	for <lists+linux-ext4@lfdr.de>; Fri,  2 May 2025 04:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8AB1A23A5;
	Fri,  2 May 2025 04:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XPA0qyp2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9538219D07B;
	Fri,  2 May 2025 04:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746160138; cv=none; b=q45XBNfkS77VkRqG4S/glxE4mHR6+z65qsVli2XkJupRa1GNTlgGqGUCnyt0Hm6niV/yxeNzua6f6ol2dYE4IAtegDC9t+St45xxCQNc2Bu5ws/VpmeWnXr1WUWEe7eC3vmaQCsVKBfZk0BBIUFWbK7ykeiY+T3IxSSW9QPMyz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746160138; c=relaxed/simple;
	bh=7orG9dZFrQELGGvUoY4zYyrw3ztyTbLK7Y75RPsrlwU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=jg1SBcI+a9jEXFFmOJj75r+9sQ4z9gRxgf0TEGGIiU+6DuRdmLDP/rAswABzd3fr8u2wIghsKfcJRrQgBk04OuL6u/G4mM+/BGtKvFS/pDRtLuUAN3ZkACx07QM8aBu9Ux7B5kAAqYb0+ICNswKbp9/oAf7zGNIJa3J8PG1uwpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XPA0qyp2; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-301918a4e3bso1855639a91.3;
        Thu, 01 May 2025 21:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746160136; x=1746764936; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nICllbPrXc2EBQBnG+6btLl3oHenOUIrwyECtKpec80=;
        b=XPA0qyp2IPlpufwaozE67sQnH4EdBM7H+aZ99h+5Tohj/nQAqhlpnSXbhsEnWIeXE8
         42U1EMIGejEaLMclM+Esf37Hhodj75vunsY7e2g86VVeHoeTbFphsiueniPEgnfkceRO
         flKOjndlaCMscP5vnbaRW2KwaGuUvQslh2INv1agkFr+yqN/XVef994pa5CrqNDF3eFU
         UI45Nt/Pnjyd2pkr3mS7neVTunXjXdA8ya9spXoN8+WsZ2b52kXTCR2je94zlVVR8WsO
         8bF2PYi0fUWsb+mHpfYvOGRhFSNixe9F/rFpZhHKSKM5WyieryG9QL3ntqfi9KJ+8NAU
         B1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746160136; x=1746764936;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nICllbPrXc2EBQBnG+6btLl3oHenOUIrwyECtKpec80=;
        b=V4G8Ru0Xq2EYTlSDlHxeCbB6iq+ReWtlteGJL/RWQIgfNnlHuRdJVJCgnKa5uXrx3E
         65/XsZo05SarEWt21W34YE8765cyO751dz7A33j+8wmXFeJ7R3SxOyq3A3t11gU7JaPl
         +af1AWEW8X2SzuSLH7V9IwLHkVT1I4rZ3QK8Ez7vVSrhkDUHoAPLZdNSU4IhV477exuK
         nde55edWadvfNbsahv/8PQjbDmHAjdpanTlXkjjKzDs4ZDpMzo6O5fqBDjY6VloofVG7
         julARC3wzvrr7AACQBfe4hAKRjBBeDjkmxrn8/tfH1hmJOrEk2Qun8QCSu3ODIRYr6Zj
         NG/w==
X-Forwarded-Encrypted: i=1; AJvYcCXCyMuT/jHJBHftF7tMGbtSlTJkCu0NBGAO8mbWrcxWjNLPPq9kLEIsH5oDbkG5y2KdSdQkjutr@vger.kernel.org, AJvYcCXYswwSBsEJ066hvBJtklCyTMLw12+PUL3txXU8rk4yp/a00ljdIw0P0psL2qiSR1BJyiLyQ2vacFV/fg==@vger.kernel.org, AJvYcCXq/6pvNnf0sNqvEV5bYJBV1Va6SX52TMX/tbg4VQ2wEjlE2WVdnapXBv0GTJHNSTy564vxkzqe9MCy@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2cCnylK3PxBcB2Eu+ZsgAD8gltCw8PgMaD8qXtsMc2Ux72TQh
	pMXQs1u8WXE8VW+4bwCCuyk+7rwUNgwXuK5eBXhvXJCc9iLNt4ad
X-Gm-Gg: ASbGncuIqCHFdBLCoDyhqPdEaoD0vT8xSehoXVZSQINI318BMa1iKHPg8nMWB24sCv8
	1VvRJHx2nrF/o03V2t/Zh0zfzBmWS90JM+wX//c+fGdrKKaVYqZr+UApQD8Zsh2CGl73eZ0ppG/
	fSAXqBHxdwuLwb2bfbjyo6e6/bM3H+zIAa4/YZCjJq+/Lly+D1AyTGpi2Uu6IjoRQ218qbWke/X
	j+wK74UpwF+fWV1yy6Z0mWxRy5cQ/J8jAj3MXkBtzz94SBcVZVu6BGyB/3T25I3r5jN79Fonzvp
	rpCKu+2quy4l17Wj45Vwje+UXK7AwTg2Cg==
X-Google-Smtp-Source: AGHT+IFUStdApO5eqkJRR6pViDWXnfmB0N0ZvuUrQOZ10WmoGS0rkEd0wBLoMly0tSlHHl6uG2Cg7Q==
X-Received: by 2002:a17:90b:51d1:b0:2fe:6942:3710 with SMTP id 98e67ed59e1d1-30a4e578b72mr2309724a91.3.1746160135699;
        Thu, 01 May 2025 21:28:55 -0700 (PDT)
Received: from dw-tp ([171.76.84.163])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e10938cd8sm4791775ad.225.2025.05.01.21.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 21:28:55 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Zorro Lang <zlang@redhat.com>
Cc: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>, fstests@vger.kernel.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org, david@fromorbit.com, hch@infradead.org
Subject: Re: [PATCH v3 1/2] common: Move exit related functions to a common/exit
In-Reply-To: <20250501091053.ghovsgjb52yvb7rj@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Date: Fri, 02 May 2025 09:53:42 +0530
Message-ID: <878qnfr67l.fsf@gmail.com>
References: <cover.1746015588.git.nirjhar.roy.lists@gmail.com> <7363438118ab8730208ba9f35e81449b2549f331.1746015588.git.nirjhar.roy.lists@gmail.com> <87cyctqasl.fsf@gmail.com> <20250501091053.ghovsgjb52yvb7rj@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

Zorro Lang <zlang@redhat.com> writes:

> On Thu, May 01, 2025 at 08:47:46AM +0530, Ritesh Harjani wrote:
>> "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com> writes:
>> 
>> > Introduce a new file common/exit that will contain all the exit
>> > related functions. This will remove the dependencies these functions
>> > have on other non-related helper files and they can be indepedently
>> > sourced. This was suggested by Dave Chinner[1].
>> > While moving the exit related functions, remove _die() and die_now()
>> > and replace die_now with _fatal(). It is of no use to keep the
>> > unnecessary wrappers.
>> >
>> > [1] https://lore.kernel.org/linux-xfs/Z_UJ7XcpmtkPRhTr@dread.disaster.area/
>> > Suggested-by: Dave Chinner <david@fromorbit.com>
>> > Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
>> > ---
>> >  check           |  2 ++
>> >  common/config   | 17 -----------------
>> >  common/exit     | 39 +++++++++++++++++++++++++++++++++++++++
>> >  common/preamble |  3 +++
>> >  common/punch    | 39 +++++++++++++++++----------------------
>> >  common/rc       | 28 ----------------------------
>> >  6 files changed, 61 insertions(+), 67 deletions(-)
>> >  create mode 100644 common/exit
>> >
>> > diff --git a/check b/check
>> > index 9451c350..bd84f213 100755
>> > --- a/check
>> > +++ b/check
>> > @@ -46,6 +46,8 @@ export DIFF_LENGTH=${DIFF_LENGTH:=10}
>> >  
>> >  # by default don't output timestamps
>> >  timestamp=${TIMESTAMP:=false}
>> > +. common/exit
>> > +. common/test_names
>> 
>> So this gets sourced at the beginning of check script here.
>> 
>> >  
>> >  rm -f $tmp.list $tmp.tmp $tmp.grep $here/$iam.out $tmp.report.* $tmp.arglist
>> >  
>> <...>
>> > diff --git a/common/preamble b/common/preamble
>> > index ba029a34..51d03396 100644
>> > --- a/common/preamble
>> > +++ b/common/preamble
>> > @@ -33,6 +33,9 @@ _register_cleanup()
>> >  # explicitly as a member of the 'all' group.
>> >  _begin_fstest()
>> >  {
>> > +	. common/exit
>> > +	. common/test_names
>> > +
>> 
>> Why do we need to source these files here again? 
>> Isn't check script already sourcing both of this in the beginning
>> itself?
>
> The _begin_fstest is called at the beginning of each test case (e.g. generic/001).
> And "check" run each test cases likes:
>
>   cmd="generic/001"
>   ./$cmd
>
> So the imported things (by "check") can't help sub-case running

aah right. Each testcase is inoked by "exec ./$seq" and it won't have
the function definitions sourced from the previous shell process. So we
will need to source the necessary files again within the test execution.

-ritesh

