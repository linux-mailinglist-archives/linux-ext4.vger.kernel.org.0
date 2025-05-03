Return-Path: <linux-ext4+bounces-7634-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1CFAA7E3B
	for <lists+linux-ext4@lfdr.de>; Sat,  3 May 2025 05:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A8221BA14E7
	for <lists+linux-ext4@lfdr.de>; Sat,  3 May 2025 03:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956F615B102;
	Sat,  3 May 2025 03:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQa6sj+X"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45411128816;
	Sat,  3 May 2025 03:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746241728; cv=none; b=SmJPoHEoe40tuQT+0469kHWzrMmmuK1XRtDglLESEksAfwL06ItHapXLGOec/C3fhsitCPon2GJfr37g4/pyvrVCBaAdHZcHDJF6Q9CKCvB96KqYY7gj2EcGLXjyrt4PxH1D0DpVUHRnYpdRblz4ilyHO0cZ2KEcfJo8hsaF9SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746241728; c=relaxed/simple;
	bh=rQnStuc5a2kIok/ioAReZgBqDdgrldUKNzAKN5ccTBE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=T34WofmtlA7DItYLP6IumgUAtVsGPc8E+S9+/QJxiDBO6ch8C1mLGltWIjF2MioEkqMlg4ZsiDQIw0jF63ZxFR1yDf/Vowe8JYhbtgoR1AhgZ9ptLCf8KhheuE1alkYdygXbnPs1b3CDLHbFAte4Ww7ENiZf5cWxmmdBeZ4BNjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQa6sj+X; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22c33e4fdb8so28700065ad.2;
        Fri, 02 May 2025 20:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746241725; x=1746846525; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ohBr7B7TzXFUzsbzk39OFrbATOwKxfYyQBsGv+i7gVM=;
        b=YQa6sj+XRcKi4NHOyW4KBFHe66+CxStLIwb6+2Uh31ZSWJOh+Rg05+jtQKpFZ0HlYc
         jghuNNDVyxUS5e3jPpnY9sOvEU4oJ/Lz8gIuDZ7Z1oUCairpExfEVxQBAmkOnLRuOANb
         sO/ISH/deWP8ktskzTNdClV2tJZJDKvGVG/yL9uinLtuqEIA1EzSDdhWcfUDQuv8Aye3
         sOuOjAOKzfvlrhYAbxARa6LQ/M/GIkw406ZKdr5gXnk9JVvwPjpn+mTIPRkU90RbgiA0
         D1MiIrkZw90yLHIpIkMY689PHF5ZRuLf4yRY50evEB63zG/5nWUWyweMG6NA7UAZt/pw
         QmHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746241725; x=1746846525;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ohBr7B7TzXFUzsbzk39OFrbATOwKxfYyQBsGv+i7gVM=;
        b=aJnVUaYDhGVmh09Tzh/1MPUW/lx6QHyou2iY8b2mJhpXL2fi2AOVNYW38OHPsl69lF
         V7hubQk/dF8IZ+6roO03uJTJoC6uhfnGopE0lKH5mbLYz8DLftLmDplE2IKAGo6fx7Mm
         wJ6MgQltczPMJeo+xeTaF5kejrHGTcEzCm7YgupOTxDHLAnaB/jIAjsKaUX5FyfcF5NT
         pMgttvsmY5nOKMhgPL8Bn6qbrNyYkeh+mvGEctOj8gjyaiaykZmXZgWTgn1KyFHX35c6
         pcns3eiW/E3jvR49YcdxvJFCT63YbcyaVp3WXqGVaEZLM2LtemMfH3B7q9iO5NDtVVD1
         EPvA==
X-Forwarded-Encrypted: i=1; AJvYcCUWIrY2mAR1GqhVGfHh+X5/r+AUV/m74YU87B7LJ2Xkr/nmGiLY3OT17W5H+og4sgMEe+bhKzXaZJBUHA==@vger.kernel.org, AJvYcCX/hadbDQgBzkwf6GshcVehShylC65kuWioxl9zKvESMaG5XZKGG3EAya4i4sOm+Oo1HzuOrxeByEjH@vger.kernel.org, AJvYcCXnbZqOz+aIMxRJ8jEn0YCyJSWJQbaNLm28WCW8d5V0E6j4UyG7QRi7Lq4WtYpOvPgA7ibizJ7M@vger.kernel.org
X-Gm-Message-State: AOJu0YzqgsdQqzkYuGIyk+IeyeFI9dCarTyZJELSO8dctfVOV2oNZX8W
	mrPDaE1gZfaGuuJTgXToQLvdmh6QHzG4Lo4lhpOjxT4aZ54DizDR
X-Gm-Gg: ASbGncs9QrmGDjMSbf+t8G7nFcE2B2d2KCyxsFfGjHbQh6LIxxUIDkmH4Me3ZNE4faD
	ZkTmTfBAozI2iDdpJsvqIN1nAKIPxpoP3PJ4uz3BdaYH/JNkGS3yUC9LrmCE5FnGhspP/YQ3TJ8
	nmaJXoy6MRsphrXHxshvWx/ecJSBt64U/zELhnxBF5L+NtgIlquD+6YK5z6nwwe9WBfdgk1hrk2
	tHSG51Uy7WN2j4/R54IJjdLQb3d4424iYUQPBLy9fL2N8pNp7jL1dXLcwnDtk+E1mX4xp7yFvxD
	FtaQSV4Potzdd5S1EDmSxD5O/8bD11am+w==
X-Google-Smtp-Source: AGHT+IETZac4TjMuuDsYed/kfbcVh7a9/Yd02ihtD6/WHApYi/EYBepcT2rtTOrQh4SOeT0vzr5p6A==
X-Received: by 2002:a17:903:f90:b0:224:11fc:40c0 with SMTP id d9443c01a7336-22e1030c7b4mr76242925ad.11.1746241725340;
        Fri, 02 May 2025 20:08:45 -0700 (PDT)
Received: from dw-tp ([171.76.84.163])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e15228cf4sm15222785ad.176.2025.05.02.20.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 20:08:44 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Zorro Lang <zlang@redhat.com>
Cc: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>, fstests@vger.kernel.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org, david@fromorbit.com, hch@infradead.org
Subject: Re: [PATCH v3 1/2] common: Move exit related functions to a common/exit
In-Reply-To: <878qnfr67l.fsf@gmail.com>
Date: Sat, 03 May 2025 08:36:00 +0530
Message-ID: <8734dmqtpj.fsf@gmail.com>
References: <cover.1746015588.git.nirjhar.roy.lists@gmail.com> <7363438118ab8730208ba9f35e81449b2549f331.1746015588.git.nirjhar.roy.lists@gmail.com> <87cyctqasl.fsf@gmail.com> <20250501091053.ghovsgjb52yvb7rj@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com> <878qnfr67l.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

Ritesh Harjani (IBM) <ritesh.list@gmail.com> writes:

> Zorro Lang <zlang@redhat.com> writes:
>
>> On Thu, May 01, 2025 at 08:47:46AM +0530, Ritesh Harjani wrote:
>>> "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com> writes:
>>> 
>>> > Introduce a new file common/exit that will contain all the exit
>>> > related functions. This will remove the dependencies these functions
>>> > have on other non-related helper files and they can be indepedently
>>> > sourced. This was suggested by Dave Chinner[1].
>>> > While moving the exit related functions, remove _die() and die_now()
>>> > and replace die_now with _fatal(). It is of no use to keep the
>>> > unnecessary wrappers.
>>> >
>>> > [1] https://lore.kernel.org/linux-xfs/Z_UJ7XcpmtkPRhTr@dread.disaster.area/
>>> > Suggested-by: Dave Chinner <david@fromorbit.com>
>>> > Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
>>> > ---
>>> >  check           |  2 ++
>>> >  common/config   | 17 -----------------
>>> >  common/exit     | 39 +++++++++++++++++++++++++++++++++++++++
>>> >  common/preamble |  3 +++
>>> >  common/punch    | 39 +++++++++++++++++----------------------
>>> >  common/rc       | 28 ----------------------------
>>> >  6 files changed, 61 insertions(+), 67 deletions(-)
>>> >  create mode 100644 common/exit
>>> >
>>> > diff --git a/check b/check
>>> > index 9451c350..bd84f213 100755
>>> > --- a/check
>>> > +++ b/check
>>> > @@ -46,6 +46,8 @@ export DIFF_LENGTH=${DIFF_LENGTH:=10}
>>> >  
>>> >  # by default don't output timestamps
>>> >  timestamp=${TIMESTAMP:=false}
>>> > +. common/exit
>>> > +. common/test_names
>>> 
>>> So this gets sourced at the beginning of check script here.
>>> 
>>> >  
>>> >  rm -f $tmp.list $tmp.tmp $tmp.grep $here/$iam.out $tmp.report.* $tmp.arglist
>>> >  
>>> <...>
>>> > diff --git a/common/preamble b/common/preamble
>>> > index ba029a34..51d03396 100644
>>> > --- a/common/preamble
>>> > +++ b/common/preamble
>>> > @@ -33,6 +33,9 @@ _register_cleanup()
>>> >  # explicitly as a member of the 'all' group.
>>> >  _begin_fstest()
>>> >  {
>>> > +	. common/exit
>>> > +	. common/test_names
>>> > +
>>> 
>>> Why do we need to source these files here again? 
>>> Isn't check script already sourcing both of this in the beginning
>>> itself?
>>
>> The _begin_fstest is called at the beginning of each test case (e.g. generic/001).
>> And "check" run each test cases likes:
>>
>>   cmd="generic/001"
>>   ./$cmd
>>
>> So the imported things (by "check") can't help sub-case running
>
> aah right. Each testcase is inoked by "exec ./$seq" and it won't have

Ok. To be accurate, it is... 

bash -c "<...>; exec ./$seq"

& not just 

exec ./$seq

-ritesh

