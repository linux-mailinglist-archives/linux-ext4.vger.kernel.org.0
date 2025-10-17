Return-Path: <linux-ext4+bounces-10948-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5ECBEA894
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Oct 2025 18:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1957E5A3E6C
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Oct 2025 16:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D94F27A477;
	Fri, 17 Oct 2025 16:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XbKkRN98"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A5D253B42
	for <linux-ext4@vger.kernel.org>; Fri, 17 Oct 2025 16:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760716896; cv=none; b=Qbs2u4DYlRIlxALCVpU27RlpFWU4TWaeriXI2mi+R+SiYerFE1HWRe+I8Bc/HXn0w8t9tIWEx3zLCWF1cuhdfqlaQBPb1i06gkAvrVRtkGYT7igXYhSvMqQ09pFETC5x54r+YXNAGpz7Pty988yqdRTTAGfbem9PriDLMccW0LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760716896; c=relaxed/simple;
	bh=HoeiLfIrc5U2hWrVckbtfuJXGVRkimJ+ztFECOU/pEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m6zEcHhCqXCjj5S8AYyeSRkN49Fcy3/6mJIiWnokVQ99//kJ/v8QKWT+dxr8MU8Mah2jkv6/MQcMZlzq/lKOLPx9m/3nRhEnLL+yfvruLPxCjenxzevGYhQ3xYhYojJvHcRKoZ2mE91b5SsUgnPC9+FxHi16rfWgl/G/oPj0aA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XbKkRN98; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760716892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PIkjHtG8K2O56AwzyHsc10sFHSt5l26FlguwiupKYTA=;
	b=XbKkRN98RXOBlmgqdZUSnooQ2m8Ha3FOr8h7e+fSvTqOR1QfVMRoCwyYpYoCxfWpBB+28x
	T4osg8x7iA0FV67GqztSWpnGuqP8WydBtp4bDA8LmFpSS43DF2qlNrwtNoO9YpYiOlV+FW
	Bzk9gkb8XLoSXUIC05kA3topUwNdZX0=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-UURKd1VYPgONWhv5Fjg1BQ-1; Fri, 17 Oct 2025 12:01:31 -0400
X-MC-Unique: UURKd1VYPgONWhv5Fjg1BQ-1
X-Mimecast-MFC-AGG-ID: UURKd1VYPgONWhv5Fjg1BQ_1760716890
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7a144677fd9so3749026b3a.3
        for <linux-ext4@vger.kernel.org>; Fri, 17 Oct 2025 09:01:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760716890; x=1761321690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PIkjHtG8K2O56AwzyHsc10sFHSt5l26FlguwiupKYTA=;
        b=Lcv6tU8gOTAEEsWN6QaYyOYMCRm9yq85WWDec7hN6nq1ehnlL/xRA+/8f/emkuuR5s
         YgspsKpwoIOqWLPTK/JqwyDMzjHbF44F4v3cHK5O6lW/udw4V9gXpCiRXLLkGGAh3YpE
         BSt5TfdnArffPXKlnmj04QgLoyndvkmS+i28n++ai6haAwr6gmGCJK1Q21aMWxaBn3V7
         MU5O+x0sl9n61Yv8KcQOs4ApaKspEUbzeLRIEI1FaZooW6dso8v7yIiNQSvtG3LAqIRc
         CwG0B5MSgq0t7jeuTKAo/ihXqbEEtGjIUKYMmGnD3AP8OSpFtQVBr+HPiVJejp1kecXg
         GwzA==
X-Forwarded-Encrypted: i=1; AJvYcCUseUNH3qwVnIHkuFOXXSvj2FcPFGGI1Rd3DR17dGNP+Tt7mx25lJji5ebs1cH/J4VJCsOL7j09yxlJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzJesTMehcXWWxifVaFGs84dNeoP+PkuO49j+3/wlLr1QvvxmtJ
	zhZ4t28Dk1F2cgWcFBu9Uh6Ei8J6R0ZQfme0fMm6286a40/VrewdBiQEkTXbf0MLeJ6S6dYvDqV
	MdajE8NzDKIr2lbicopeuFms/+qbJsjR4YQCxB+FUiKNVxT++hHKixpd2hemyOHU=
X-Gm-Gg: ASbGncv+QM7x4BSLjV6pzW/+eEDsmm1z3Je3g13bl2wDf7I1YoubtdqIWJ/ImKsQyQE
	VIfbmJIgI6ssKlwmeid36U+OZhQjvCUHVsmCQg4AlFojsWwzRH+dbCVxEZYyeCKWmTpO29yzbVe
	QcXlznFZCSX9doMITjwroFwMdQhrdxvUycPlXC3V5Yw3u7cZQREVs6ICzTLCE9xC8eSoef+9pQ4
	j+V+lR6kTbX2Dbmlll/DgScXTm4XMrTCmalp0GYTd674cUvaZeFoOeNKbS9uQAtk1kdtWUCLzF7
	gKh29WMnxuxWP+KYofYWXSPyrlU2khiQiA1/fycRo5M7y4CeauoiiFIYF4Cgovs09g7J0iTCuYh
	Mfa6qWjAfQlJnYXErDhRAuqnwclfIOAkzFpeu6Kk=
X-Received: by 2002:a05:6a00:813:b0:781:2069:1eea with SMTP id d2e1a72fcca58-7a220d41244mr5674144b3a.24.1760716890226;
        Fri, 17 Oct 2025 09:01:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEV+vF1WeoqYbB1sX6jUBw8yccaOQtpuaHsR9tjJiwRF9RrFequccajAP9k3CeRwHGbg0rrtw==
X-Received: by 2002:a05:6a00:813:b0:781:2069:1eea with SMTP id d2e1a72fcca58-7a220d41244mr5674068b3a.24.1760716889494;
        Fri, 17 Oct 2025 09:01:29 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b0606f0sm26765866b3a.15.2025.10.17.09.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 09:01:28 -0700 (PDT)
Date: Sat, 18 Oct 2025 00:01:22 +0800
From: Zorro Lang <zlang@redhat.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
	djwong@kernel.org, john.g.garry@oracle.com, tytso@mit.edu,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v7 04/12] ltp/fsx.c: Add atomic writes support to fsx
Message-ID: <20251017160122.iqpowv6q2mxahlbj@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1758264169.git.ojaswin@linux.ibm.com>
 <c3a040b249485b02b569b9269b649d02d721d995.1758264169.git.ojaswin@linux.ibm.com>
 <20250928131924.b472fjxwir7vphsr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <aN683ZHUzA5qPVaJ@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <20251003171932.pxzaotlafhwqsg5v@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <aOJrNHcQPD7bgnfB@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <20251005153956.zofernclbbva3xt6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <aOPCAzx0diQy7lFN@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <aOTkVmyEV8i_eQx6@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOTkVmyEV8i_eQx6@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>

On Tue, Oct 07, 2025 at 03:28:46PM +0530, Ojaswin Mujoo wrote:
> On Mon, Oct 06, 2025 at 06:50:03PM +0530, Ojaswin Mujoo wrote:
> > On Sun, Oct 05, 2025 at 11:39:56PM +0800, Zorro Lang wrote:
> > > On Sun, Oct 05, 2025 at 06:27:24PM +0530, Ojaswin Mujoo wrote:
> > > > On Sat, Oct 04, 2025 at 01:19:32AM +0800, Zorro Lang wrote:
> > > > > On Thu, Oct 02, 2025 at 11:26:45PM +0530, Ojaswin Mujoo wrote:
> > > > > > On Sun, Sep 28, 2025 at 09:19:24PM +0800, Zorro Lang wrote:
> > > > > > > On Fri, Sep 19, 2025 at 12:17:57PM +0530, Ojaswin Mujoo wrote:
> > > > > > > > Implement atomic write support to help fuzz atomic writes
> > > > > > > > with fsx.
> > > > > > > > 
> > > > > > > > Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > > > > > > > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > > > > > > > Reviewed-by: John Garry <john.g.garry@oracle.com>
> > > > > > > > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > > > > > > > ---
> > > > > > > 
> > > > > > > Hmm... this patch causes more regular fsx test cases fail on old kernel,
> > > > > > > (e.g. g/760, g/617, g/263 ...) except set "FSX_AVOID=-a". Is there a way
> > > > > > > to disable "atomic write" automatically if it's not supported by current
> > > > > > > system?
> > > > > > 
> > > > > > Hi Zorro, 
> > > > > > Sorry for being late, I've been on vacation this week.
> > > > > > 
> > > > > > Yes so by design we should be automatically disabling atomic writes when
> > > > > > they are not supported by the stack but seems like the issue is that
> > > > > > when we do disable it we print some extra messages to stdout/err which
> > > > > > show up in the xfstests output causing failure.
> > > > > > 
> > > > > > I can think of 2 ways around this:
> > > > > > 
> > > > > > 1. Don't print anything and just silently drop atomic writes if stack
> > > > > > doesn't support them.
> > > > > > 
> > > > > > 2. Make atomic writes as a default off instead of default on feature but
> > > > > > his loses a bit of coverage as existing tests wont get atomic write
> > > > > > testing free of cost any more.
> > > > > 
> > > > > Hi Ojaswin,
> > > > > 
> > > > > Please have a nice vacation :)
> > > > > 
> > > > > It's not the "extra messages" cause failure, those "quiet" failures can be fixed
> > > > > by:
> > > > 
> > > > Oh okay got it.
> > > > 
> > > > > 
> > > > > diff --git a/ltp/fsx.c b/ltp/fsx.c
> > > > > index bdb87ca90..0a035b37b 100644
> > > > > --- a/ltp/fsx.c
> > > > > +++ b/ltp/fsx.c
> > > > > @@ -1847,8 +1847,9 @@ int test_atomic_writes(void) {
> > > > >         struct statx stx;
> > > > >  
> > > > >         if (o_direct != O_DIRECT) {
> > > > > -               fprintf(stderr, "main: atomic writes need O_DIRECT (-Z), "
> > > > > -                               "disabling!\n");
> > > > > +               if (!quiet)
> > > > > +                       fprintf(stderr, "main: atomic writes need O_DIRECT (-Z), "
> > > > > +                                       "disabling!\n");
> > > > >                 return 0;
> > > > >         }
> > > > >  
> > > > > @@ -1867,8 +1868,9 @@ int test_atomic_writes(void) {
> > > > >                 return 1;
> > > > >         }
> > > > >  
> > > > > -       fprintf(stderr, "main: IO Stack does not support "
> > > > > -                       "atomic writes, disabling!\n");
> > > > > +       if (!quiet)
> > > > > +               fprintf(stderr, "main: IO Stack does not support "
> > > > > +                               "atomic writes, disabling!\n");
> > > > >         return 0;
> > > > >  }
> > > > 
> > > > > 
> > > > > But I hit more read or write failures e.g. [1], this failure can't be
> > > > > reproduced with FSX_AVOID=-a. Is it a atomic write bug or an unexpected
> > > > > test failure?
> > > > > 
> > > > > Thanks,
> > > > > Zorro
> > > > > 
> > > > 
> > > > <...>
> > > > 
> > > > > +244(244 mod 256): SKIPPED (no operation)
> > > > > +245(245 mod 256): FALLOC   0x695c5 thru 0x6a2e6	(0xd21 bytes) INTERIOR
> > > > > +246(246 mod 256): MAPWRITE 0x5ac00 thru 0x5b185	(0x586 bytes)
> > > > > +247(247 mod 256): WRITE    0x31200 thru 0x313ff	(0x200 bytes)
> > > > > +248(248 mod 256): SKIPPED (no operation)
> > > > > +249(249 mod 256): TRUNCATE DOWN	from 0x78242 to 0xf200	******WWWW
> > > > > +250(250 mod 256): FALLOC   0x65000 thru 0x66f26	(0x1f26 bytes) PAST_EOF
> > > > > +251(251 mod 256): WRITE    0x45400 thru 0x467ff	(0x1400 bytes) HOLE	***WWWW
> > > > > +252(252 mod 256): SKIPPED (no operation)
> > > > > +253(253 mod 256): SKIPPED (no operation)
> > > > > +254(254 mod 256): MAPWRITE 0x4be00 thru 0x4daee	(0x1cef bytes)
> > > > > +255(255 mod 256): MAPREAD  0xc000 thru 0xcae9	(0xaea bytes)
> > > > > +256(  0 mod 256): READ     0x3e000 thru 0x3efff	(0x1000 bytes)
> > > > > +257(  1 mod 256): SKIPPED (no operation)
> > > > > +258(  2 mod 256): INSERT 0x45000 thru 0x45fff	(0x1000 bytes)
> > > > > +259(  3 mod 256): ZERO     0x1d7d5 thru 0x1f399	(0x1bc5 bytes)	******ZZZZ
> > > > > +260(  4 mod 256): TRUNCATE DOWN	from 0x4eaef to 0x11200	******WWWW
> > > > > +261(  5 mod 256): WRITE    0x43000 thru 0x43fff	(0x1000 bytes) HOLE	***WWWW
> > > > > +262(  6 mod 256): WRITE    0x2200 thru 0x31ff	(0x1000 bytes)
> > > > > +263(  7 mod 256): WRITE    0x15000 thru 0x15fff	(0x1000 bytes)
> > > > > +264(  8 mod 256): WRITE    0x2e400 thru 0x2e7ff	(0x400 bytes)
> > > > > +265(  9 mod 256): COPY 0xd000 thru 0xdfff	(0x1000 bytes) to 0x1d800 thru 0x1e7ff	******EEEE
> > > > > +266( 10 mod 256): CLONE 0x2a000 thru 0x2afff	(0x1000 bytes) to 0x21000 thru 0x21fff
> > > > > +267( 11 mod 256): MAPREAD  0x31000 thru 0x31d0a	(0xd0b bytes)
> > > > > +268( 12 mod 256): SKIPPED (no operation)
> > > > > +269( 13 mod 256): WRITE    0x25000 thru 0x25fff	(0x1000 bytes)
> > > > > +270( 14 mod 256): SKIPPED (no operation)
> > > > > +271( 15 mod 256): MAPREAD  0x30000 thru 0x30577	(0x578 bytes)
> > > > > +272( 16 mod 256): PUNCH    0x1a267 thru 0x1c093	(0x1e2d bytes)
> > > > > +273( 17 mod 256): MAPREAD  0x1f000 thru 0x1f9c9	(0x9ca bytes)
> > > > > +274( 18 mod 256): WRITE    0x40800 thru 0x40dff	(0x600 bytes)
> > > > > +275( 19 mod 256): SKIPPED (no operation)
> > > > > +276( 20 mod 256): MAPWRITE 0x20600 thru 0x22115	(0x1b16 bytes)
> > > > > +277( 21 mod 256): MAPWRITE 0x3d000 thru 0x3ee5a	(0x1e5b bytes)
> > > > > +278( 22 mod 256): WRITE    0x2ee00 thru 0x2efff	(0x200 bytes)
> > > > > +279( 23 mod 256): WRITE    0x76200 thru 0x769ff	(0x800 bytes) HOLE
> > > > > +280( 24 mod 256): SKIPPED (no operation)
> > > > > +281( 25 mod 256): SKIPPED (no operation)
> > > > > +282( 26 mod 256): MAPREAD  0xa000 thru 0xa5e7	(0x5e8 bytes)
> > > > > +283( 27 mod 256): SKIPPED (no operation)
> > > > > +284( 28 mod 256): SKIPPED (no operation)
> > > > > +285( 29 mod 256): SKIPPED (no operation)
> > > > > +286( 30 mod 256): SKIPPED (no operation)
> > > > > +287( 31 mod 256): COLLAPSE 0x11000 thru 0x11fff	(0x1000 bytes)
> > > > > +288( 32 mod 256): COPY 0x5d000 thru 0x5dfff	(0x1000 bytes) to 0x4ca00 thru 0x4d9ff
> > > > > +289( 33 mod 256): TRUNCATE DOWN	from 0x75a00 to 0x1e400
> > > > > +290( 34 mod 256): MAPREAD  0x1c000 thru 0x1d802	(0x1803 bytes)	***RRRR***
> > > > > +Log of operations saved to "/mnt/xfstests/test/junk.fsxops"; replay with --replay-ops
> > > > > +Correct content saved for comparison
> > > > > +(maybe hexdump "/mnt/xfstests/test/junk" vs "/mnt/xfstests/test/junk.fsxgood")
> > > > > 
> > > > > Thanks,
> > > > > Zorro
> > > > 
> > > > Hi Zorro, just to confirm is this on an older kernel that doesnt support
> > > > RWF_ATOMIC or on a kernle that does support it.
> > > 
> > > I tested on linux 6.16 and current latest linux v6.17+ (will be 6.18-rc1 later).
> > > About the RWF_ATOMIC flag in my system:
> > > 
> > > # grep -rsn RWF_ATOMIC /usr/include/
> > > /usr/include/bits/uio-ext.h:51:#define RWF_ATOMIC       0x00000040 /* Write is to be issued with torn-write
> > > /usr/include/linux/fs.h:424:#define RWF_ATOMIC  ((__kernel_rwf_t)0x00000040)
> > > /usr/include/linux/fs.h:431:                     RWF_APPEND | RWF_NOAPPEND | RWF_ATOMIC |\
> > > /usr/include/xfs/linux.h:236:#ifndef RWF_ATOMIC
> > > /usr/include/xfs/linux.h:237:#define RWF_ATOMIC ((__kernel_rwf_t)0x00000040)
> > 
> > Hi Zorro, thanks for checking this. So correct me if im wrong but I
> > understand that you have run this test on an atomic writes enabled 
> > kernel where the stack also supports atomic writes.
> > 
> > Looking at the bad data log:
> > 
> > 	+READ BAD DATA: offset = 0x1c000, size = 0x1803, fname = /mnt/xfstests/test/junk
> > 	+OFFSET      GOOD    BAD     RANGE
> > 	+0x1c000     0x0000  0xcdcd  0x0
> > 	+operation# (mod 256) for the bad data may be 205
> > 
> > We see that 0x0000 was expected but we got 0xcdcd. Now the operation
> > that caused this is indicated to be 205, but looking at that operation:
> > 
> > +205(205 mod 256): ZERO     0x6dbe6 thru 0x6e6aa	(0xac5 bytes)
> > 
> > This doesn't even overlap the range that is bad. (0x1c000 to 0x1c00f).
> > Infact, it does seem like an unlikely coincidence that the actual data
> > in the bad range is 0xcdcd which is something xfs_io -c "pwrite" writes
> > to default (fsx writes random data in even offsets and operation num in
> > odd).
> > 
> > I am able to replicate this but only on XFS but not on ext4 (atleast not
> > in 20 runs).  I'm trying to better understand if this is a test issue or
> > not. Will keep you update.
> > 
> > I'm not sure how this will affect the upcoming release, if you want
> > shall I send a small patch to make the atomic writes feature default off
> > instead of default on till we root cause this?
> > 
> > Regards,
> > Ojaswin
> 
> Hi Zorro,
> 
> So I'm able to narrow down the opoerations and replicate it via the
> following replay file:
> 
> # -----
> # replay.fsxops
> # -----
> write_atomic 0x57000 0x1000 0x69690
> write_atomic 0x66000 0x1000 0x4de00
> write_atomic 0x18000 0x1000 0x2c800
> copy_range 0x20000 0x1000 0xe00 0x70e00
> write_atomic 0x18000 0x1000 0x70e00
> copy_range 0x21000 0x1000 0x23000 0x74218
> truncate 0x0 0x11200 0x4daef *
> write_atomic 0x43000 0x1000 0x11200 *
> write_atomic 0x15000 0x1000 0x44000
> copy_range 0xd000 0x1000 0x1d800 0x44000
> mapread 0x1c000 0x1803 0x1e400 *
> 
> 
> Command: ./ltp/fsx -N 10000 -o 8192 -l 500000 -r 4096 -t 512 -w 512 -Z -FKuHzI --replay-ops replay.fsxops $MNT/junk
> 
> $MNT/junk is always opened O_TRUNC and is an on an XFS FS where the
> disk is non-atomic so all RWF_ATOMIC writes are software emulated.
> 
> Here are the logs generated for this run:
> 
> Seed set to 1
> main: filesystem does not support exchange range, disabling!
> 
> READ BAD DATA: offset = 0x1c000, size = 0x1803, fname = /mnt/test/junk
> OFFSET      GOOD    BAD     RANGE
> 0x1d000     0x0000  0xf322  0x0
> operation# (mod 256) for the bad data may be 243
> 0x1d001     0x0000  0x22f3  0x1
> operation# (mod 256) for the bad data may be 243
> 0x1d002     0x0000  0xf391  0x2
> operation# (mod 256) for the bad data may be 243
> 0x1d003     0x0000  0x91f3  0x3
> <... a few more such lines ..>
> 
> LOG DUMP (11 total operations):
> openat(AT_FDCWD, "/mnt/test/junk.fsxops", O_WRONLY|O_CREAT|O_TRUNC, 0666) = 7
> 1(  1 mod 256): WRITE    0x57000 thru 0x57fff   (0x1000 bytes) HOLE     ***WWWW ATOMIC
> 2(  2 mod 256): WRITE    0x66000 thru 0x66fff   (0x1000 bytes) HOLE ATOMIC
> 3(  3 mod 256): WRITE    0x18000 thru 0x18fff   (0x1000 bytes) ATOMIC
> 4(  4 mod 256): COPY 0x20000 thru 0x20fff       (0x1000 bytes) to 0xe00 thru 0x1dff
> 5(  5 mod 256): WRITE    0x18000 thru 0x18fff   (0x1000 bytes) ATOMIC
> 6(  6 mod 256): COPY 0x21000 thru 0x21fff       (0x1000 bytes) to 0x23000 thru 0x23fff
> 7(  7 mod 256): TRUNCATE DOWN   from 0x67000 to 0x11200 ******WWWW
> 8(  8 mod 256): WRITE    0x43000 thru 0x43fff   (0x1000 bytes) HOLE     ***WWWW ATOMIC
> 9(  9 mod 256): WRITE    0x15000 thru 0x15fff   (0x1000 bytes) ATOMIC
> 10( 10 mod 256): COPY 0xd000 thru 0xdfff        (0x1000 bytes) to 0x1d800 thru 0x1e7ff
> 11( 11 mod 256): MAPREAD  0x1c000 thru 0x1d802  (0x1803 bytes)  ***RRRR***
> Log of operations saved to "/mnt/test/junk.fsxops"; replay with --replay-ops
> Correct content saved for comparison
> (maybe hexdump "/mnt/test/junk" vs "/mnt/test/junk.fsxgood")
> +++ exited with 110 +++
> 
> We can see that the bad data is detected in the final MAPREAD operation
> and and bad offset is at 0x1d000. If we look at the operations dump
> above its clear that none of the operations should be modifying the
> 0x1d000 so we should have been reading 0s but yet we see some junk data
> there in the file:
> 
> $ hexdump /mnt/test/junk -s 0x1c000 -n0x1020
> 001c000 0000 0000 0000 0000 0000 0000 0000 0000
> *
> 001d000 22f3 91f3 7ff3 3af3 39f3 23f3 6df3 c2f3
> 001d010 c5f3 f6f3 a6f3 1ef3 58f3 40f3 32f3 5ff3
> 001d020
> 
> Another thing to not is that I can't reproduce the above on scsi-debug
> device.  @Darrick, @John, could this be an issue in kernel?

Hi Ojaswin,

If we can be sure this's a kernel bug, rather than a fstests (patch) issue, I think we
can merge this patchset to expose this bug. Does this make sense to you and others?

Thanks,
Zorro

> 
> Regards,
> ojaswin
> > 
> > > 
> > > Thanks,
> > > Zorro
> > > 
> > > > 
> > > > Regards,
> > > > ojaswin
> > > > 
> > > 
> 


