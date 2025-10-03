Return-Path: <linux-ext4+bounces-10628-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B6FBB7B1B
	for <lists+linux-ext4@lfdr.de>; Fri, 03 Oct 2025 19:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E6451B202E4
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Oct 2025 17:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511562DA751;
	Fri,  3 Oct 2025 17:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZPyibytD"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473922D8DA9
	for <linux-ext4@vger.kernel.org>; Fri,  3 Oct 2025 17:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759511986; cv=none; b=eWpOhZB3ncP30C2Bk5aqXJc1CFcYEAPyyjO2+BRXlSH/IdiAEM/HAZiSIXSQ8/5Oi5MK4UkYN98D3G6TYECcWFGDUA/kSwRQHvaerowa/I7ZxvmvqxG08V0b9Ugg6f2q7WCMvc3+NQU9L6c3b7KT8FwCyPh/6jJU0N05QdfQu5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759511986; c=relaxed/simple;
	bh=ZlDdnaJLI0DghoLSqANwhmQOy2tH7FlR0vrRN+UESrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sReHSB2Wk2duSHA8GD/+D7oU1M9W2LGi/7i3/wG8M0PYkDI4V1NI1gOEcRFO3j51UPXZQzcQDsS+3d2FH0U2CDfj7TCQCy8+S+GqPMKNXzi2r8ohhG0R3eP05+nfZj4I6awi0tasXFrN9z1GAUc7EiF2HFoLagS8Kxlb54z9TcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZPyibytD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759511982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7Xdb0k4tjJddU78KLOt0p9ISsslcVjmrtfJva6RJu5E=;
	b=ZPyibytDwyr3vfUNKH19l7UkqR6xX2teI4rlWpsOUfiR8ojAVmciSq3pjqjofn+2ytx1cT
	fmTAuj/bCD0emICcVB87bDNI6rm2h5UieSrAWH4CLUH0iN1Jez/O8xdzcdvVB5QWMF4V35
	Sq5CWE0Q73MWaP77KykZBiyACsDnHVY=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-zbrok7LpO4Oj1FGvhmes1Q-1; Fri, 03 Oct 2025 13:19:40 -0400
X-MC-Unique: zbrok7LpO4Oj1FGvhmes1Q-1
X-Mimecast-MFC-AGG-ID: zbrok7LpO4Oj1FGvhmes1Q_1759511980
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-28e8d1d9b13so27829635ad.0
        for <linux-ext4@vger.kernel.org>; Fri, 03 Oct 2025 10:19:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759511980; x=1760116780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Xdb0k4tjJddU78KLOt0p9ISsslcVjmrtfJva6RJu5E=;
        b=C3Y5d3T/9YNrr4oJkcvT4KR01+g32+hnAiktECDCRZoIIOjRuWDMeUKSeKZ8lsF6qs
         8QYcVB6XL/4dKA84TWfBgGNQcFSMHKJbPe/jnzPG+58KK0ElGNs6bVBap1Yao4sqAWvg
         vE4J/rGoPNAZFXfspTGLXmP4X8vmncO615dd4t2jlxiicLQG/Mm9Npel5sehK10jZO3v
         8gk7got4PEzHdTmNLcprEsdIb9xQAMzOztGA9P0/hyMogPgE0kMPEFZLqNkKaCbuNCCO
         J+6BfzMPFYQZk2//UgKA4z4lfRUXUDyCqBjV+baSWHFMJWWGCmGRnRWTNpTzhv9kjSzu
         8vgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcOwXoxfF1uHQlwOmlnIe18HPih4M5TaxLi2KqFVBtxJJcpW8Hh3rDGPFNba5WIneUViLQYnrGTLtB@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbkb04ztoadT5RvP0ojN2N3WgbJEOg04E3RrXctKkPi/0aJuq+
	yFWSKAx11OqTLJjyH7c8w4qDtCECH8807av+i95FL1fWetg90R25KY5SM2ki7aiMXBG6XUKkUf4
	Gg9/XKbLZdTLWcXrR6WxY7yb7vf5qK0rE7+MchmcGkuJ2sW5Kz96gQV5s0xI1PIY=
X-Gm-Gg: ASbGnctpN86rcAhaNrs0co1+Hi0Vm7U/Q7URECexAs4uXoNH5YxJksfHrFPi8lUWac8
	TvxYl8wApCiqbuuXGADX0ZRhf4GXAAW5Zo2C20dmTIzTEYJDJ/RJ4dsNyFojIX/1y5sTHckxef0
	D1NmtWeofGyAyy9FjQwwtjGJSyqBa4qfUK1Gkb3IgyQCtSpJJXLqL4qQae8vc2Tz31KrANVZr5b
	Fr4An0KlvCEEfa54ifKGVZO0kZR7q5+Mfjep4gF4ewj4HGQxqCnwbqpAMUM6wLF2FjfKSdSnSaX
	o0uor39fqb9MCkL7JUFKwFGrNjRtgntth+jQsxvOxfDktrilLSSwA/9QhmuPsdLNHEEPgTNEHjs
	iYK6GIAIJBA==
X-Received: by 2002:a17:902:c94f:b0:267:b6f9:2ce with SMTP id d9443c01a7336-28e9a6dc5cbmr38766715ad.41.1759511979242;
        Fri, 03 Oct 2025 10:19:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIQTruVjpbnJZ1ZdZmYWDolGWdJgYiS/Jdec83Xw518wtBXVYujfvVLgFctuBJpUsOT8ZIeg==
X-Received: by 2002:a17:902:c94f:b0:267:b6f9:2ce with SMTP id d9443c01a7336-28e9a6dc5cbmr38766225ad.41.1759511978516;
        Fri, 03 Oct 2025 10:19:38 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a4e211bbsm5135133a91.0.2025.10.03.10.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 10:19:38 -0700 (PDT)
Date: Sat, 4 Oct 2025 01:19:32 +0800
From: Zorro Lang <zlang@redhat.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
	djwong@kernel.org, john.g.garry@oracle.com, tytso@mit.edu,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v7 04/12] ltp/fsx.c: Add atomic writes support to fsx
Message-ID: <20251003171932.pxzaotlafhwqsg5v@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1758264169.git.ojaswin@linux.ibm.com>
 <c3a040b249485b02b569b9269b649d02d721d995.1758264169.git.ojaswin@linux.ibm.com>
 <20250928131924.b472fjxwir7vphsr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <aN683ZHUzA5qPVaJ@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aN683ZHUzA5qPVaJ@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>

On Thu, Oct 02, 2025 at 11:26:45PM +0530, Ojaswin Mujoo wrote:
> On Sun, Sep 28, 2025 at 09:19:24PM +0800, Zorro Lang wrote:
> > On Fri, Sep 19, 2025 at 12:17:57PM +0530, Ojaswin Mujoo wrote:
> > > Implement atomic write support to help fuzz atomic writes
> > > with fsx.
> > > 
> > > Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > > Reviewed-by: John Garry <john.g.garry@oracle.com>
> > > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > > ---
> > 
> > Hmm... this patch causes more regular fsx test cases fail on old kernel,
> > (e.g. g/760, g/617, g/263 ...) except set "FSX_AVOID=-a". Is there a way
> > to disable "atomic write" automatically if it's not supported by current
> > system?
> 
> Hi Zorro, 
> Sorry for being late, I've been on vacation this week.
> 
> Yes so by design we should be automatically disabling atomic writes when
> they are not supported by the stack but seems like the issue is that
> when we do disable it we print some extra messages to stdout/err which
> show up in the xfstests output causing failure.
> 
> I can think of 2 ways around this:
> 
> 1. Don't print anything and just silently drop atomic writes if stack
> doesn't support them.
> 
> 2. Make atomic writes as a default off instead of default on feature but
> his loses a bit of coverage as existing tests wont get atomic write
> testing free of cost any more.

Hi Ojaswin,

Please have a nice vacation :)

It's not the "extra messages" cause failure, those "quiet" failures can be fixed
by:

diff --git a/ltp/fsx.c b/ltp/fsx.c
index bdb87ca90..0a035b37b 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -1847,8 +1847,9 @@ int test_atomic_writes(void) {
        struct statx stx;
 
        if (o_direct != O_DIRECT) {
-               fprintf(stderr, "main: atomic writes need O_DIRECT (-Z), "
-                               "disabling!\n");
+               if (!quiet)
+                       fprintf(stderr, "main: atomic writes need O_DIRECT (-Z), "
+                                       "disabling!\n");
                return 0;
        }
 
@@ -1867,8 +1868,9 @@ int test_atomic_writes(void) {
                return 1;
        }
 
-       fprintf(stderr, "main: IO Stack does not support "
-                       "atomic writes, disabling!\n");
+       if (!quiet)
+               fprintf(stderr, "main: IO Stack does not support "
+                               "atomic writes, disabling!\n");
        return 0;
 }

But I hit more read or write failures e.g. [1], this failure can't be
reproduced with FSX_AVOID=-a. Is it a atomic write bug or an unexpected
test failure?

Thanks,
Zorro

[1]
--- /dev/fd/63	2025-09-26 19:20:35.426617312 -0400
+++ generic/263.out.bad	2025-09-26 19:20:35.116617862 -0400
@@ -1,3 +1,337 @@
 QA output created by 263
 fsx -N 10000 -o 8192 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z
-fsx -N 10000 -o 128000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z
+Seed set to 1
+main: filesystem does not support exchange range, disabling!
+skipping zero length punch hole
+truncating to largest ever: 0x50e00
+fallocating to largest ever: 0x74d54
+fallocating to largest ever: 0x759e7
+zero_range to largest ever: 0x78242
+READ BAD DATA: offset = 0x1c000, size = 0x1803, fname = /mnt/xfstests/test/junk
+OFFSET      GOOD    BAD     RANGE
+0x1c000     0x0000  0xcdcd  0x0
+operation# (mod 256) for the bad data may be 205
+0x1c001     0x0000  0xcdcd  0x1
+operation# (mod 256) for the bad data may be 205
+0x1c002     0x0000  0xcdcd  0x2
+operation# (mod 256) for the bad data may be 205
+0x1c003     0x0000  0xcdcd  0x3
+operation# (mod 256) for the bad data may be 205
+0x1c004     0x0000  0xcdcd  0x4
+operation# (mod 256) for the bad data may be 205
+0x1c005     0x0000  0xcdcd  0x5
+operation# (mod 256) for the bad data may be 205
+0x1c006     0x0000  0xcdcd  0x6
+operation# (mod 256) for the bad data may be 205
+0x1c007     0x0000  0xcdcd  0x7
+operation# (mod 256) for the bad data may be 205
+0x1c008     0x0000  0xcdcd  0x8
+operation# (mod 256) for the bad data may be 205
+0x1c009     0x0000  0xcdcd  0x9
+operation# (mod 256) for the bad data may be 205
+0x1c00a     0x0000  0xcdcd  0xa
+operation# (mod 256) for the bad data may be 205
+0x1c00b     0x0000  0xcdcd  0xb
+operation# (mod 256) for the bad data may be 205
+0x1c00c     0x0000  0xcdcd  0xc
+operation# (mod 256) for the bad data may be 205
+0x1c00d     0x0000  0xcdcd  0xd
+operation# (mod 256) for the bad data may be 205
+0x1c00e     0x0000  0xcdcd  0xe
+operation# (mod 256) for the bad data may be 205
+0x1c00f     0x0000  0xcdcd  0xf
+operation# (mod 256) for the bad data may be 205
+LOG DUMP (290 total operations):
+1(  1 mod 256): SKIPPED (no operation)
+2(  2 mod 256): WRITE    0x20400 thru 0x209ff	(0x600 bytes) HOLE	***WWWW
+3(  3 mod 256): MAPWRITE 0x69200 thru 0x6968f	(0x490 bytes)
+4(  4 mod 256): SKIPPED (no operation)
+5(  5 mod 256): SKIPPED (no operation)
+6(  6 mod 256): WRITE    0x57000 thru 0x57fff	(0x1000 bytes)
+7(  7 mod 256): TRUNCATE DOWN	from 0x69690 to 0x50e00
+8(  8 mod 256): WRITE    0x3ac00 thru 0x3b5ff	(0xa00 bytes)
+9(  9 mod 256): SKIPPED (no operation)
+10( 10 mod 256): SKIPPED (no operation)
+11( 11 mod 256): FALLOC   0x13346 thru 0x13898	(0x552 bytes) INTERIOR
+12( 12 mod 256): SKIPPED (no operation)
+13( 13 mod 256): TRUNCATE DOWN	from 0x50e00 to 0x21600
+14( 14 mod 256): SKIPPED (no operation)
+15( 15 mod 256): WRITE    0x4de00 thru 0x4edff	(0x1000 bytes) HOLE
+16( 16 mod 256): MAPREAD  0x34000 thru 0x35b18	(0x1b19 bytes)
+17( 17 mod 256): INSERT 0x18000 thru 0x18fff	(0x1000 bytes)
+18( 18 mod 256): SKIPPED (no operation)
+19( 19 mod 256): ZERO     0x423c thru 0x4d76	(0xb3b bytes)
+20( 20 mod 256): SKIPPED (no operation)
+21( 21 mod 256): SKIPPED (no operation)
+22( 22 mod 256): MAPWRITE 0x15c00 thru 0x16fcc	(0x13cd bytes)
+23( 23 mod 256): COLLAPSE 0x39000 thru 0x39fff	(0x1000 bytes)
+24( 24 mod 256): SKIPPED (no operation)
+25( 25 mod 256): FALLOC   0xc95d thru 0xd6bc	(0xd5f bytes) INTERIOR
+26( 26 mod 256): SKIPPED (no operation)
+27( 27 mod 256): DEDUPE 0x4c000 thru 0x4cfff	(0x1000 bytes) to 0x0 thru 0xfff
+28( 28 mod 256): SKIPPED (no operation)
+29( 29 mod 256): SKIPPED (no operation)
+30( 30 mod 256): WRITE    0x66000 thru 0x66fff	(0x1000 bytes) HOLE
+31( 31 mod 256): SKIPPED (no operation)
+32( 32 mod 256): WRITE    0x66600 thru 0x679ff	(0x1400 bytes) EXTEND
+33( 33 mod 256): FALLOC   0x1eb35 thru 0x1fd32	(0x11fd bytes) INTERIOR
+34( 34 mod 256): PUNCH    0x51265 thru 0x525e0	(0x137c bytes)
+35( 35 mod 256): MAPWRITE 0x63400 thru 0x63c56	(0x857 bytes)
+36( 36 mod 256): SKIPPED (no operation)
+37( 37 mod 256): SKIPPED (no operation)
+38( 38 mod 256): MAPREAD  0x4d000 thru 0x4e8b1	(0x18b2 bytes)
+39( 39 mod 256): ZERO     0x2b418 thru 0x2b96c	(0x555 bytes)
+40( 40 mod 256): READ     0x39000 thru 0x39fff	(0x1000 bytes)
+41( 41 mod 256): READ     0x2b000 thru 0x2bfff	(0x1000 bytes)
+42( 42 mod 256): WRITE    0x29000 thru 0x299ff	(0xa00 bytes)
+43( 43 mod 256): SKIPPED (no operation)
+44( 44 mod 256): SKIPPED (no operation)
+45( 45 mod 256): WRITE    0x17000 thru 0x17fff	(0x1000 bytes)
+46( 46 mod 256): WRITE    0x2f800 thru 0x313ff	(0x1c00 bytes)
+47( 47 mod 256): SKIPPED (no operation)
+48( 48 mod 256): PUNCH    0x4d698 thru 0x4f5b1	(0x1f1a bytes)
+49( 49 mod 256): SKIPPED (no operation)
+50( 50 mod 256): ZERO     0x4e2de thru 0x4fd40	(0x1a63 bytes)
+51( 51 mod 256): WRITE    0x7000 thru 0x7fff	(0x1000 bytes)
+52( 52 mod 256): ZERO     0x20849 thru 0x22574	(0x1d2c bytes)
+53( 53 mod 256): MAPREAD  0x18000 thru 0x180f5	(0xf6 bytes)
+54( 54 mod 256): WRITE    0x3d200 thru 0x3e7ff	(0x1600 bytes)
+55( 55 mod 256): SKIPPED (no operation)
+56( 56 mod 256): READ     0x4a000 thru 0x4afff	(0x1000 bytes)
+57( 57 mod 256): WRITE    0xc000 thru 0xcfff	(0x1000 bytes)
+58( 58 mod 256): WRITE    0x3dc00 thru 0x3f7ff	(0x1c00 bytes)
+59( 59 mod 256): TRUNCATE DOWN	from 0x67a00 to 0x50800
+60( 60 mod 256): TRUNCATE DOWN	from 0x50800 to 0x16a00	******WWWW
+61( 61 mod 256): WRITE    0x2aa00 thru 0x2c7ff	(0x1e00 bytes) HOLE	***WWWW
+62( 62 mod 256): WRITE    0x18000 thru 0x18fff	(0x1000 bytes)
+63( 63 mod 256): PUNCH    0x21b7f thru 0x223db	(0x85d bytes)
+64( 64 mod 256): SKIPPED (no operation)
+65( 65 mod 256): SKIPPED (no operation)
+66( 66 mod 256): ZERO     0x1a7f4 thru 0x1b577	(0xd84 bytes)
+67( 67 mod 256): PUNCH    0x2b961 thru 0x2bc67	(0x307 bytes)
+68( 68 mod 256): READ     0x18000 thru 0x18fff	(0x1000 bytes)
+69( 69 mod 256): WRITE    0x21200 thru 0x229ff	(0x1800 bytes)
+70( 70 mod 256): MAPWRITE 0x22400 thru 0x22b7a	(0x77b bytes)
+71( 71 mod 256): MAPWRITE 0x38e00 thru 0x3a8a6	(0x1aa7 bytes)
+72( 72 mod 256): FALLOC   0x74270 thru 0x74d54	(0xae4 bytes) EXTENDING
+73( 73 mod 256): WRITE    0x12000 thru 0x12fff	(0x1000 bytes)
+74( 74 mod 256): TRUNCATE DOWN	from 0x74d54 to 0x4e000
+75( 75 mod 256): SKIPPED (no operation)
+76( 76 mod 256): TRUNCATE UP	from 0x4e000 to 0x70e00
+77( 77 mod 256): COPY 0x3c000 thru 0x3cfff	(0x1000 bytes) to 0x43600 thru 0x445ff
+78( 78 mod 256): ZERO     0x6323d thru 0x64af5	(0x18b9 bytes)
+79( 79 mod 256): MAPREAD  0x51000 thru 0x5119f	(0x1a0 bytes)
+80( 80 mod 256): MAPREAD  0x6d000 thru 0x6e285	(0x1286 bytes)
+81( 81 mod 256): WRITE    0x9000 thru 0x9fff	(0x1000 bytes)
+82( 82 mod 256): FALLOC   0x19973 thru 0x1a711	(0xd9e bytes) INTERIOR
+83( 83 mod 256): COPY 0x20000 thru 0x20fff	(0x1000 bytes) to 0xe00 thru 0x1dff
+84( 84 mod 256): SKIPPED (no operation)
+85( 85 mod 256): SKIPPED (no operation)
+86( 86 mod 256): COPY 0xc000 thru 0xcfff	(0x1000 bytes) to 0x36e00 thru 0x37dff
+87( 87 mod 256): WRITE    0x18000 thru 0x18fff	(0x1000 bytes)
+88( 88 mod 256): FALLOC   0x57797 thru 0x5818a	(0x9f3 bytes) INTERIOR
+89( 89 mod 256): WRITE    0x70200 thru 0x71bff	(0x1a00 bytes) EXTEND
+90( 90 mod 256): PUNCH    0x22525 thru 0x2408f	(0x1b6b bytes)
+91( 91 mod 256): ZERO     0x710bf thru 0x729b6	(0x18f8 bytes)
+92( 92 mod 256): DEDUPE 0x14000 thru 0x14fff	(0x1000 bytes) to 0x8000 thru 0x8fff
+93( 93 mod 256): WRITE    0x6b800 thru 0x6bbff	(0x400 bytes)
+94( 94 mod 256): ZERO     0x5caa5 thru 0x5e066	(0x15c2 bytes)
+95( 95 mod 256): MAPWRITE 0x3d000 thru 0x3d7ef	(0x7f0 bytes)
+96( 96 mod 256): READ     0x30000 thru 0x30fff	(0x1000 bytes)
+97( 97 mod 256): PUNCH    0x1e513 thru 0x204d1	(0x1fbf bytes)
+98( 98 mod 256): FALLOC   0x67904 thru 0x690c7	(0x17c3 bytes) INTERIOR
+99( 99 mod 256): MAPREAD  0x44000 thru 0x44e08	(0xe09 bytes)
+100(100 mod 256): WRITE    0x1200 thru 0x1dff	(0xc00 bytes)
+101(101 mod 256): ZERO     0x6e649 thru 0x70552	(0x1f0a bytes)
+102(102 mod 256): SKIPPED (no operation)
+103(103 mod 256): SKIPPED (no operation)
+104(104 mod 256): WRITE    0x2b800 thru 0x2bfff	(0x800 bytes)
+105(105 mod 256): READ     0x64000 thru 0x64fff	(0x1000 bytes)
+106(106 mod 256): SKIPPED (no operation)
+107(107 mod 256): SKIPPED (no operation)
+108(108 mod 256): SKIPPED (no operation)
+109(109 mod 256): WRITE    0x6e400 thru 0x6ebff	(0x800 bytes)
+110(110 mod 256): PUNCH    0x504ed thru 0x51d71	(0x1885 bytes)
+111(111 mod 256): MAPWRITE 0x19800 thru 0x1ac57	(0x1458 bytes)
+112(112 mod 256): WRITE    0x51800 thru 0x521ff	(0xa00 bytes)
+113(113 mod 256): ZERO     0x205b9 thru 0x20d56	(0x79e bytes)
+114(114 mod 256): SKIPPED (no operation)
+115(115 mod 256): SKIPPED (no operation)
+116(116 mod 256): COLLAPSE 0x39000 thru 0x39fff	(0x1000 bytes)
+117(117 mod 256): SKIPPED (no operation)
+118(118 mod 256): MAPWRITE 0x74000 thru 0x75217	(0x1218 bytes)
+119(119 mod 256): COPY 0x6000 thru 0x6fff	(0x1000 bytes) to 0x29000 thru 0x29fff
+120(120 mod 256): SKIPPED (no operation)
+121(121 mod 256): COLLAPSE 0x1a000 thru 0x1afff	(0x1000 bytes)
+122(122 mod 256): SKIPPED (no operation)
+123(123 mod 256): WRITE    0x1b600 thru 0x1bfff	(0xa00 bytes)
+124(124 mod 256): INSERT 0x70000 thru 0x70fff	(0x1000 bytes)
+125(125 mod 256): FALLOC   0x21210 thru 0x2293d	(0x172d bytes) INTERIOR
+126(126 mod 256): COPY 0x21000 thru 0x21fff	(0x1000 bytes) to 0x23000 thru 0x23fff
+127(127 mod 256): MAPWRITE 0x33200 thru 0x342a3	(0x10a4 bytes)
+128(128 mod 256): TRUNCATE DOWN	from 0x75218 to 0x49c00
+129(129 mod 256): WRITE    0x11200 thru 0x12bff	(0x1a00 bytes)
+130(130 mod 256): TRUNCATE DOWN	from 0x49c00 to 0x32800
+131(131 mod 256): DEDUPE 0xa000 thru 0xafff	(0x1000 bytes) to 0x2b000 thru 0x2bfff
+132(132 mod 256): SKIPPED (no operation)
+133(133 mod 256): FALLOC   0x56e33 thru 0x57d67	(0xf34 bytes) PAST_EOF
+134(134 mod 256): MAPREAD  0xc000 thru 0xdedd	(0x1ede bytes)
+135(135 mod 256): READ     0x21000 thru 0x21fff	(0x1000 bytes)
+136(136 mod 256): FALLOC   0x34071 thru 0x34b27	(0xab6 bytes) EXTENDING
+137(137 mod 256): ZERO     0x4db33 thru 0x4f0da	(0x15a8 bytes)
+138(138 mod 256): FALLOC   0xf70b thru 0x10eda	(0x17cf bytes) INTERIOR
+139(139 mod 256): PUNCH    0xdba7 thru 0xf1c7	(0x1621 bytes)
+140(140 mod 256): SKIPPED (no operation)
+141(141 mod 256): MAPWRITE 0x25800 thru 0x27422	(0x1c23 bytes)
+142(142 mod 256): READ     0x1f000 thru 0x1ffff	(0x1000 bytes)
+143(143 mod 256): TRUNCATE UP	from 0x34b27 to 0x45e00
+144(144 mod 256): PUNCH    0x3ba91 thru 0x3ccf2	(0x1262 bytes)
+145(145 mod 256): COLLAPSE 0x16000 thru 0x16fff	(0x1000 bytes)
+146(146 mod 256): COLLAPSE 0x17000 thru 0x17fff	(0x1000 bytes)
+147(147 mod 256): WRITE    0x2b200 thru 0x2c7ff	(0x1600 bytes)
+148(148 mod 256): ZERO     0x285f2 thru 0x292fa	(0xd09 bytes)
+149(149 mod 256): CLONE 0x9000 thru 0x9fff	(0x1000 bytes) to 0x2000 thru 0x2fff
+150(150 mod 256): ZERO     0x7030e thru 0x71879	(0x156c bytes)
+151(151 mod 256): SKIPPED (no operation)
+152(152 mod 256): WRITE    0x6000 thru 0x6fff	(0x1000 bytes)
+153(153 mod 256): SKIPPED (no operation)
+154(154 mod 256): FALLOC   0x5669 thru 0x6fcb	(0x1962 bytes) INTERIOR
+155(155 mod 256): WRITE    0x76600 thru 0x76bff	(0x600 bytes) HOLE
+156(156 mod 256): ZERO     0x4c77 thru 0x5f94	(0x131e bytes)
+157(157 mod 256): MAPREAD  0x50000 thru 0x512c3	(0x12c4 bytes)
+158(158 mod 256): DEDUPE 0x5000 thru 0x5fff	(0x1000 bytes) to 0x62000 thru 0x62fff
+159(159 mod 256): COLLAPSE 0x4c000 thru 0x4cfff	(0x1000 bytes)
+160(160 mod 256): FALLOC   0x6dbe1 thru 0x6f58f	(0x19ae bytes) INTERIOR
+161(161 mod 256): TRUNCATE DOWN	from 0x75c00 to 0x4a00	******WWWW
+162(162 mod 256): SKIPPED (no operation)
+163(163 mod 256): ZERO     0x2034f thru 0x21e10	(0x1ac2 bytes)
+164(164 mod 256): MAPREAD  0x1a000 thru 0x1bd44	(0x1d45 bytes)
+165(165 mod 256): PUNCH    0x104d9 thru 0x10d5c	(0x884 bytes)
+166(166 mod 256): TRUNCATE UP	from 0x21e11 to 0x4e200
+167(167 mod 256): WRITE    0x75800 thru 0x759ff	(0x200 bytes) HOLE
+168(168 mod 256): MAPWRITE 0x36c00 thru 0x389ee	(0x1def bytes)
+169(169 mod 256): WRITE    0x6da00 thru 0x6edff	(0x1400 bytes)
+170(170 mod 256): ZERO     0x592e2 thru 0x5a0af	(0xdce bytes)
+171(171 mod 256): SKIPPED (no operation)
+172(172 mod 256): SKIPPED (no operation)
+173(173 mod 256): SKIPPED (no operation)
+174(174 mod 256): WRITE    0x30000 thru 0x30fff	(0x1000 bytes)
+175(175 mod 256): SKIPPED (no operation)
+176(176 mod 256): ZERO     0x41a29 thru 0x42580	(0xb58 bytes)
+177(177 mod 256): SKIPPED (no operation)
+178(178 mod 256): SKIPPED (no operation)
+179(179 mod 256): MAPWRITE 0x47600 thru 0x4901a	(0x1a1b bytes)
+180(180 mod 256): ZERO     0x6acd0 thru 0x6b5f3	(0x924 bytes)
+181(181 mod 256): WRITE    0x43000 thru 0x43fff	(0x1000 bytes)
+182(182 mod 256): SKIPPED (no operation)
+183(183 mod 256): SKIPPED (no operation)
+184(184 mod 256): MAPREAD  0x38000 thru 0x3854c	(0x54d bytes)
+185(185 mod 256): READ     0x7000 thru 0x7fff	(0x1000 bytes)
+186(186 mod 256): SKIPPED (no operation)
+187(187 mod 256): SKIPPED (no operation)
+188(188 mod 256): MAPREAD  0x18000 thru 0x1805b	(0x5c bytes)
+189(189 mod 256): TRUNCATE DOWN	from 0x75a00 to 0x49800
+190(190 mod 256): ZERO     0x51bfe thru 0x5369f	(0x1aa2 bytes)
+191(191 mod 256): FALLOC   0x74f96 thru 0x759e7	(0xa51 bytes) EXTENDING
+192(192 mod 256): WRITE    0x35000 thru 0x35fff	(0x1000 bytes)
+193(193 mod 256): WRITE    0x45000 thru 0x451ff	(0x200 bytes)
+194(194 mod 256): SKIPPED (no operation)
+195(195 mod 256): MAPREAD  0x57000 thru 0x58600	(0x1601 bytes)
+196(196 mod 256): SKIPPED (no operation)
+197(197 mod 256): FALLOC   0x50aa4 thru 0x5181a	(0xd76 bytes) INTERIOR
+198(198 mod 256): WRITE    0x2ec00 thru 0x307ff	(0x1c00 bytes)
+199(199 mod 256): TRUNCATE DOWN	from 0x759e7 to 0x32600
+200(200 mod 256): DEDUPE 0x1b000 thru 0x1bfff	(0x1000 bytes) to 0x18000 thru 0x18fff
+201(201 mod 256): WRITE    0x38200 thru 0x389ff	(0x800 bytes) HOLE
+202(202 mod 256): READ     0x30000 thru 0x30fff	(0x1000 bytes)
+203(203 mod 256): WRITE    0x3dc00 thru 0x3f5ff	(0x1a00 bytes) HOLE
+204(204 mod 256): SKIPPED (no operation)
+205(205 mod 256): ZERO     0x6dbe6 thru 0x6e6aa	(0xac5 bytes)
+206(206 mod 256): WRITE    0x46800 thru 0x475ff	(0xe00 bytes) HOLE
+207(207 mod 256): SKIPPED (no operation)
+208(208 mod 256): MAPREAD  0x1000 thru 0x1658	(0x659 bytes)
+209(209 mod 256): SKIPPED (no operation)
+210(210 mod 256): SKIPPED (no operation)
+211(211 mod 256): TRUNCATE DOWN	from 0x47600 to 0x22200
+212(212 mod 256): SKIPPED (no operation)
+213(213 mod 256): FALLOC   0x69700 thru 0x6b675	(0x1f75 bytes) EXTENDING
+214(214 mod 256): TRUNCATE DOWN	from 0x6b675 to 0x3f400
+215(215 mod 256): READ     0x24000 thru 0x24fff	(0x1000 bytes)
+216(216 mod 256): WRITE    0xea00 thru 0x105ff	(0x1c00 bytes)
+217(217 mod 256): FALLOC   0xc67b thru 0xde4b	(0x17d0 bytes) INTERIOR
+218(218 mod 256): SKIPPED (no operation)
+219(219 mod 256): MAPWRITE 0x3e200 thru 0x3f9fe	(0x17ff bytes)
+220(220 mod 256): TRUNCATE DOWN	from 0x3f9ff to 0xe200	******WWWW
+221(221 mod 256): PUNCH    0x7e84 thru 0x92c8	(0x1445 bytes)
+222(222 mod 256): FALLOC   0x1e61b thru 0x1e747	(0x12c bytes) EXTENDING
+223(223 mod 256): INSERT 0xd000 thru 0xdfff	(0x1000 bytes)
+224(224 mod 256): TRUNCATE DOWN	from 0x1f747 to 0xe000	******WWWW
+225(225 mod 256): CLONE 0xa000 thru 0xafff	(0x1000 bytes) to 0x2f000 thru 0x2ffff
+226(226 mod 256): CLONE 0x26000 thru 0x26fff	(0x1000 bytes) to 0x1b000 thru 0x1bfff
+227(227 mod 256): SKIPPED (no operation)
+228(228 mod 256): ZERO     0x2c6f7 thru 0x2e4be	(0x1dc8 bytes)
+229(229 mod 256): WRITE    0x6d400 thru 0x6ddff	(0xa00 bytes) HOLE
+230(230 mod 256): ZERO     0x1873 thru 0x1c7a	(0x408 bytes)
+231(231 mod 256): MAPWRITE 0x44400 thru 0x447d5	(0x3d6 bytes)
+232(232 mod 256): WRITE    0x4b000 thru 0x4bfff	(0x1000 bytes)
+233(233 mod 256): ZERO     0x6ed0 thru 0x82c8	(0x13f9 bytes)
+234(234 mod 256): SKIPPED (no operation)
+235(235 mod 256): TRUNCATE DOWN	from 0x6de00 to 0x4c600
+236(236 mod 256): WRITE    0x19a00 thru 0x1a3ff	(0xa00 bytes)
+237(237 mod 256): READ     0x38000 thru 0x38fff	(0x1000 bytes)
+238(238 mod 256): TRUNCATE UP	from 0x4c600 to 0x52a00
+239(239 mod 256): WRITE    0x77a00 thru 0x78dff	(0x1400 bytes) HOLE
+240(240 mod 256): TRUNCATE DOWN	from 0x78e00 to 0x5f600
+241(241 mod 256): PUNCH    0x30dcd thru 0x32305	(0x1539 bytes)
+242(242 mod 256): SKIPPED (no operation)
+243(243 mod 256): ZERO     0x76374 thru 0x78241	(0x1ece bytes)
+244(244 mod 256): SKIPPED (no operation)
+245(245 mod 256): FALLOC   0x695c5 thru 0x6a2e6	(0xd21 bytes) INTERIOR
+246(246 mod 256): MAPWRITE 0x5ac00 thru 0x5b185	(0x586 bytes)
+247(247 mod 256): WRITE    0x31200 thru 0x313ff	(0x200 bytes)
+248(248 mod 256): SKIPPED (no operation)
+249(249 mod 256): TRUNCATE DOWN	from 0x78242 to 0xf200	******WWWW
+250(250 mod 256): FALLOC   0x65000 thru 0x66f26	(0x1f26 bytes) PAST_EOF
+251(251 mod 256): WRITE    0x45400 thru 0x467ff	(0x1400 bytes) HOLE	***WWWW
+252(252 mod 256): SKIPPED (no operation)
+253(253 mod 256): SKIPPED (no operation)
+254(254 mod 256): MAPWRITE 0x4be00 thru 0x4daee	(0x1cef bytes)
+255(255 mod 256): MAPREAD  0xc000 thru 0xcae9	(0xaea bytes)
+256(  0 mod 256): READ     0x3e000 thru 0x3efff	(0x1000 bytes)
+257(  1 mod 256): SKIPPED (no operation)
+258(  2 mod 256): INSERT 0x45000 thru 0x45fff	(0x1000 bytes)
+259(  3 mod 256): ZERO     0x1d7d5 thru 0x1f399	(0x1bc5 bytes)	******ZZZZ
+260(  4 mod 256): TRUNCATE DOWN	from 0x4eaef to 0x11200	******WWWW
+261(  5 mod 256): WRITE    0x43000 thru 0x43fff	(0x1000 bytes) HOLE	***WWWW
+262(  6 mod 256): WRITE    0x2200 thru 0x31ff	(0x1000 bytes)
+263(  7 mod 256): WRITE    0x15000 thru 0x15fff	(0x1000 bytes)
+264(  8 mod 256): WRITE    0x2e400 thru 0x2e7ff	(0x400 bytes)
+265(  9 mod 256): COPY 0xd000 thru 0xdfff	(0x1000 bytes) to 0x1d800 thru 0x1e7ff	******EEEE
+266( 10 mod 256): CLONE 0x2a000 thru 0x2afff	(0x1000 bytes) to 0x21000 thru 0x21fff
+267( 11 mod 256): MAPREAD  0x31000 thru 0x31d0a	(0xd0b bytes)
+268( 12 mod 256): SKIPPED (no operation)
+269( 13 mod 256): WRITE    0x25000 thru 0x25fff	(0x1000 bytes)
+270( 14 mod 256): SKIPPED (no operation)
+271( 15 mod 256): MAPREAD  0x30000 thru 0x30577	(0x578 bytes)
+272( 16 mod 256): PUNCH    0x1a267 thru 0x1c093	(0x1e2d bytes)
+273( 17 mod 256): MAPREAD  0x1f000 thru 0x1f9c9	(0x9ca bytes)
+274( 18 mod 256): WRITE    0x40800 thru 0x40dff	(0x600 bytes)
+275( 19 mod 256): SKIPPED (no operation)
+276( 20 mod 256): MAPWRITE 0x20600 thru 0x22115	(0x1b16 bytes)
+277( 21 mod 256): MAPWRITE 0x3d000 thru 0x3ee5a	(0x1e5b bytes)
+278( 22 mod 256): WRITE    0x2ee00 thru 0x2efff	(0x200 bytes)
+279( 23 mod 256): WRITE    0x76200 thru 0x769ff	(0x800 bytes) HOLE
+280( 24 mod 256): SKIPPED (no operation)
+281( 25 mod 256): SKIPPED (no operation)
+282( 26 mod 256): MAPREAD  0xa000 thru 0xa5e7	(0x5e8 bytes)
+283( 27 mod 256): SKIPPED (no operation)
+284( 28 mod 256): SKIPPED (no operation)
+285( 29 mod 256): SKIPPED (no operation)
+286( 30 mod 256): SKIPPED (no operation)
+287( 31 mod 256): COLLAPSE 0x11000 thru 0x11fff	(0x1000 bytes)
+288( 32 mod 256): COPY 0x5d000 thru 0x5dfff	(0x1000 bytes) to 0x4ca00 thru 0x4d9ff
+289( 33 mod 256): TRUNCATE DOWN	from 0x75a00 to 0x1e400
+290( 34 mod 256): MAPREAD  0x1c000 thru 0x1d802	(0x1803 bytes)	***RRRR***
+Log of operations saved to "/mnt/xfstests/test/junk.fsxops"; replay with --replay-ops
+Correct content saved for comparison
+(maybe hexdump "/mnt/xfstests/test/junk" vs "/mnt/xfstests/test/junk.fsxgood")

Thanks,
Zorro

> 
> Regards,
> ojaswin
> 
> > Thanks,
> > Zorro
> > 
> > >  ltp/fsx.c | 115 +++++++++++++++++++++++++++++++++++++++++++++++++++---
> > >  1 file changed, 110 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/ltp/fsx.c b/ltp/fsx.c
> > > index 163b9453..bdb87ca9 100644
> > > --- a/ltp/fsx.c
> > > +++ b/ltp/fsx.c
> > > @@ -40,6 +40,7 @@
> > >  #include <liburing.h>
> > >  #endif
> > >  #include <sys/syscall.h>
> > > +#include "statx.h"
> > >  
> > >  #ifndef MAP_FILE
> > >  # define MAP_FILE 0
> > > @@ -49,6 +50,10 @@
> > >  #define RWF_DONTCACHE	0x80
> > >  #endif
> > >  
> > > +#ifndef RWF_ATOMIC
> > > +#define RWF_ATOMIC	0x40
> > > +#endif
> > > +
> > >  #define NUMPRINTCOLUMNS 32	/* # columns of data to print on each line */
> > >  
> > >  /* Operation flags (bitmask) */
> > > @@ -110,6 +115,7 @@ enum {
> > >  	OP_READ_DONTCACHE,
> > >  	OP_WRITE,
> > >  	OP_WRITE_DONTCACHE,
> > > +	OP_WRITE_ATOMIC,
> > >  	OP_MAPREAD,
> > >  	OP_MAPWRITE,
> > >  	OP_MAX_LITE,
> > > @@ -200,6 +206,11 @@ int	uring = 0;
> > >  int	mark_nr = 0;
> > >  int	dontcache_io = 1;
> > >  int	hugepages = 0;                  /* -h flag */
> > > +int	do_atomic_writes = 1;		/* -a flag disables */
> > > +
> > > +/* User for atomic writes */
> > > +int awu_min = 0;
> > > +int awu_max = 0;
> > >  
> > >  /* Stores info needed to periodically collapse hugepages */
> > >  struct hugepages_collapse_info {
> > > @@ -288,6 +299,7 @@ static const char *op_names[] = {
> > >  	[OP_READ_DONTCACHE] = "read_dontcache",
> > >  	[OP_WRITE] = "write",
> > >  	[OP_WRITE_DONTCACHE] = "write_dontcache",
> > > +	[OP_WRITE_ATOMIC] = "write_atomic",
> > >  	[OP_MAPREAD] = "mapread",
> > >  	[OP_MAPWRITE] = "mapwrite",
> > >  	[OP_TRUNCATE] = "truncate",
> > > @@ -422,6 +434,7 @@ logdump(void)
> > >  				prt("\t***RRRR***");
> > >  			break;
> > >  		case OP_WRITE_DONTCACHE:
> > > +		case OP_WRITE_ATOMIC:
> > >  		case OP_WRITE:
> > >  			prt("WRITE    0x%x thru 0x%x\t(0x%x bytes)",
> > >  			    lp->args[0], lp->args[0] + lp->args[1] - 1,
> > > @@ -1073,6 +1086,25 @@ update_file_size(unsigned offset, unsigned size)
> > >  	file_size = offset + size;
> > >  }
> > >  
> > > +static int is_power_of_2(unsigned n) {
> > > +	return ((n & (n - 1)) == 0);
> > > +}
> > > +
> > > +/*
> > > + * Round down n to nearest power of 2.
> > > + * If n is already a power of 2, return n;
> > > + */
> > > +static int rounddown_pow_of_2(int n) {
> > > +	int i = 0;
> > > +
> > > +	if (is_power_of_2(n))
> > > +		return n;
> > > +
> > > +	for (; (1 << i) < n; i++);
> > > +
> > > +	return 1 << (i - 1);
> > > +}
> > > +
> > >  void
> > >  dowrite(unsigned offset, unsigned size, int flags)
> > >  {
> > > @@ -1081,6 +1113,27 @@ dowrite(unsigned offset, unsigned size, int flags)
> > >  	offset -= offset % writebdy;
> > >  	if (o_direct)
> > >  		size -= size % writebdy;
> > > +	if (flags & RWF_ATOMIC) {
> > > +		/* atomic write len must be between awu_min and awu_max */
> > > +		if (size < awu_min)
> > > +			size = awu_min;
> > > +		if (size > awu_max)
> > > +			size = awu_max;
> > > +
> > > +		/* atomic writes need power-of-2 sizes */
> > > +		size = rounddown_pow_of_2(size);
> > > +
> > > +		/* atomic writes need naturally aligned offsets */
> > > +		offset -= offset % size;
> > > +
> > > +		/* Skip the write if we are crossing max filesize */
> > > +		if ((offset + size) > maxfilelen) {
> > > +			if (!quiet && testcalls > simulatedopcount)
> > > +				prt("skipping atomic write past maxfilelen\n");
> > > +			log4(OP_WRITE_ATOMIC, offset, size, FL_SKIPPED);
> > > +			return;
> > > +		}
> > > +	}
> > >  	if (size == 0) {
> > >  		if (!quiet && testcalls > simulatedopcount && !o_direct)
> > >  			prt("skipping zero size write\n");
> > > @@ -1088,7 +1141,10 @@ dowrite(unsigned offset, unsigned size, int flags)
> > >  		return;
> > >  	}
> > >  
> > > -	log4(OP_WRITE, offset, size, FL_NONE);
> > > +	if (flags & RWF_ATOMIC)
> > > +		log4(OP_WRITE_ATOMIC, offset, size, FL_NONE);
> > > +	else
> > > +		log4(OP_WRITE, offset, size, FL_NONE);
> > >  
> > >  	gendata(original_buf, good_buf, offset, size);
> > >  	if (offset + size > file_size) {
> > > @@ -1108,8 +1164,9 @@ dowrite(unsigned offset, unsigned size, int flags)
> > >  		       (monitorstart == -1 ||
> > >  			(offset + size > monitorstart &&
> > >  			(monitorend == -1 || offset <= monitorend))))))
> > > -		prt("%lld write\t0x%x thru\t0x%x\t(0x%x bytes)\tdontcache=%d\n", testcalls,
> > > -		    offset, offset + size - 1, size, (flags & RWF_DONTCACHE) != 0);
> > > +		prt("%lld write\t0x%x thru\t0x%x\t(0x%x bytes)\tdontcache=%d atomic_wr=%d\n", testcalls,
> > > +		    offset, offset + size - 1, size, (flags & RWF_DONTCACHE) != 0,
> > > +		    (flags & RWF_ATOMIC) != 0);
> > >  	iret = fsxwrite(fd, good_buf + offset, size, offset, flags);
> > >  	if (iret != size) {
> > >  		if (iret == -1)
> > > @@ -1785,6 +1842,36 @@ do_dedupe_range(unsigned offset, unsigned length, unsigned dest)
> > >  }
> > >  #endif
> > >  
> > > +int test_atomic_writes(void) {
> > > +	int ret;
> > > +	struct statx stx;
> > > +
> > > +	if (o_direct != O_DIRECT) {
> > > +		fprintf(stderr, "main: atomic writes need O_DIRECT (-Z), "
> > > +				"disabling!\n");
> > > +		return 0;
> > > +	}
> > > +
> > > +	ret = xfstests_statx(AT_FDCWD, fname, 0, STATX_WRITE_ATOMIC, &stx);
> > > +	if (ret < 0) {
> > > +		fprintf(stderr, "main: Statx failed with %d."
> > > +			" Failed to determine atomic write limits, "
> > > +			" disabling!\n", ret);
> > > +		return 0;
> > > +	}
> > > +
> > > +	if (stx.stx_attributes & STATX_ATTR_WRITE_ATOMIC &&
> > > +	    stx.stx_atomic_write_unit_min > 0) {
> > > +		awu_min = stx.stx_atomic_write_unit_min;
> > > +		awu_max = stx.stx_atomic_write_unit_max;
> > > +		return 1;
> > > +	}
> > > +
> > > +	fprintf(stderr, "main: IO Stack does not support "
> > > +			"atomic writes, disabling!\n");
> > > +	return 0;
> > > +}
> > > +
> > >  #ifdef HAVE_COPY_FILE_RANGE
> > >  int
> > >  test_copy_range(void)
> > > @@ -2356,6 +2443,12 @@ have_op:
> > >  			goto out;
> > >  		}
> > >  		break;
> > > +	case OP_WRITE_ATOMIC:
> > > +		if (!do_atomic_writes) {
> > > +			log4(OP_WRITE_ATOMIC, offset, size, FL_SKIPPED);
> > > +			goto out;
> > > +		}
> > > +		break;
> > >  	}
> > >  
> > >  	switch (op) {
> > > @@ -2385,6 +2478,11 @@ have_op:
> > >  			dowrite(offset, size, 0);
> > >  		break;
> > >  
> > > +	case OP_WRITE_ATOMIC:
> > > +		TRIM_OFF_LEN(offset, size, maxfilelen);
> > > +		dowrite(offset, size, RWF_ATOMIC);
> > > +		break;
> > > +
> > >  	case OP_MAPREAD:
> > >  		TRIM_OFF_LEN(offset, size, file_size);
> > >  		domapread(offset, size);
> > > @@ -2511,13 +2609,14 @@ void
> > >  usage(void)
> > >  {
> > >  	fprintf(stdout, "usage: %s",
> > > -		"fsx [-dfhknqxyzBEFHIJKLORWXZ0]\n\
> > > +		"fsx [-adfhknqxyzBEFHIJKLORWXZ0]\n\
> > >  	   [-b opnum] [-c Prob] [-g filldata] [-i logdev] [-j logid]\n\
> > >  	   [-l flen] [-m start:end] [-o oplen] [-p progressinterval]\n\
> > >  	   [-r readbdy] [-s style] [-t truncbdy] [-w writebdy]\n\
> > >  	   [-A|-U] [-D startingop] [-N numops] [-P dirpath] [-S seed]\n\
> > >  	   [--replay-ops=opsfile] [--record-ops[=opsfile]] [--duration=seconds]\n\
> > >  	   ... fname\n\
> > > +	-a: disable atomic writes\n\
> > >  	-b opnum: beginning operation number (default 1)\n\
> > >  	-c P: 1 in P chance of file close+open at each op (default infinity)\n\
> > >  	-d: debug output for all operations\n\
> > > @@ -3059,9 +3158,13 @@ main(int argc, char **argv)
> > >  	setvbuf(stdout, (char *)0, _IOLBF, 0); /* line buffered stdout */
> > >  
> > >  	while ((ch = getopt_long(argc, argv,
> > > -				 "0b:c:de:fg:hi:j:kl:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
> > > +				 "0ab:c:de:fg:hi:j:kl:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
> > >  				 longopts, NULL)) != EOF)
> > >  		switch (ch) {
> > > +		case 'a':
> > > +			prt("main(): Atomic writes disabled\n");
> > > +			do_atomic_writes = 0;
> > > +			break;
> > >  		case 'b':
> > >  			simulatedopcount = getnum(optarg, &endp);
> > >  			if (!quiet)
> > > @@ -3475,6 +3578,8 @@ main(int argc, char **argv)
> > >  		exchange_range_calls = test_exchange_range();
> > >  	if (dontcache_io)
> > >  		dontcache_io = test_dontcache_io();
> > > +	if (do_atomic_writes)
> > > +		do_atomic_writes = test_atomic_writes();
> > >  
> > >  	while (keep_running())
> > >  		if (!test())
> > > -- 
> > > 2.49.0
> > > 
> > 
> 


