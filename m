Return-Path: <linux-ext4+bounces-8562-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F67AE1862
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Jun 2025 11:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 418857A1E92
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Jun 2025 09:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D90E280CD3;
	Fri, 20 Jun 2025 09:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MTe0N6uQ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA991280A5A
	for <linux-ext4@vger.kernel.org>; Fri, 20 Jun 2025 09:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750413568; cv=none; b=iLYrr79a/4J3fUFqjWeC5LlQu2uNrfPAPH+lSynntmSK8E4YTyoglwi/YlBmQkGH5OERhmmW0mAhC8/Y5P4KL0XP0SH5F1X/bp+D/TAzeHiAcyKB5JA0rZWH4pZFNS8msMRVHJWWlopt7ABkmE1GTs4NmHJkxLtCT/qnrna6khE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750413568; c=relaxed/simple;
	bh=OzVbpjI8C6JTha7ddFw5nS3D/50BZY32rnlkq7C43LM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjbXp+FWCrJoyCh6hzN4m+FTw4R6h6Mht9OP1FFVNizJqBYIWgMgs9ueLMf8ryFmNtVetZWbwREbVwB2r26O54x/TtUVSc8wbGm2rU0Pm5SfhxuB+L9/znaHNP7G2WsVXPzlNGqbVomb5LsDBVozeXuUVoerN6322GyHRVgjg0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MTe0N6uQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750413564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dfszn5yGEBNpQXiNBQPNMo3E2l6PzQ3VV8xBzk6sGCk=;
	b=MTe0N6uQxWgEN0P/oKxzuYzTxJIS1muwF/pMutV6dVnq/WiRykgDsb5w2vSCC2v6ncWqH7
	EN+p2j+u0I++HfbfGpCw0JAaffjZdcGKcq9fcTinOGr8JQ0ZArkwsGR9CzZWmrys2qmCkH
	elLOqwnBi2Ck6E5tehA9+QOQjQj61Zw=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-5HX4el0kOceAv9YLnLRjsQ-1; Fri, 20 Jun 2025 05:59:23 -0400
X-MC-Unique: 5HX4el0kOceAv9YLnLRjsQ-1
X-Mimecast-MFC-AGG-ID: 5HX4el0kOceAv9YLnLRjsQ_1750413562
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-235dd77d11fso17803155ad.0
        for <linux-ext4@vger.kernel.org>; Fri, 20 Jun 2025 02:59:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750413562; x=1751018362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dfszn5yGEBNpQXiNBQPNMo3E2l6PzQ3VV8xBzk6sGCk=;
        b=nAvlLhaTQOuY09mWKIxDU6EdwuflbXr+DhOT3ew137iqa54VSyFCqQBjs9MOO3Hza3
         gzYiiKVqZRCa7yslKI7WWB0N4NJqV5VO6qAP9SlJkZh+5F69EXqIMk52K8bBXAFioXAN
         KHGCiEHdbfd1wriVi8mzg6GDWF1iXFuRSMpBjI89jpomqegMfwECejfZZji0usGeb1w+
         UjSZcLYl44IeaOj5R+akQcZNTEGoF/PKlgHqmseiMxEFG2+Rv1JhnwOj7YoPVh++8G8T
         x0uMeVFrNAPTWq1UC5Q7DCp2Gtkil0ybVS2zXtIkYnoo88p8mklcAKY8v8UK2j6c/We2
         ogwA==
X-Forwarded-Encrypted: i=1; AJvYcCUcbRuWdGx0qH+sLT2eSe9eXlYCoo3U79UD5shN2J1b7OZuVQwG5J2sBoMJ8xrxgJwENTLypxpnMRVW@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4mR+oPBt5ygmVcnVFSPjA+mDjhUL6YGhQrWugwbuc+M3tpUcO
	H6aNjMpYRFuGCO7r2i1lbAX7xZ0NVuuxVcGzVMA1cw7P1KBuYT9GsHFSCLNBpibDOW5lxlqJoec
	y8wALX82zIjawhC7JKnvc/C45NafYg5sVDJPrf6j5ELR0CAcBmxxay9nd2k+w8zqA7+SM9O8=
X-Gm-Gg: ASbGncu+rb7Pc79s8CLdF8jA/gosADPjdMIvxBwDN/g/f30BcRgZVrCq7Fte+pfXmAd
	H3bp9oKUYrVR/kbx2nuXaksg25z87Mi1L7hX1PDaggAMmyCGPiLoYsB1zc14OXCxNQ9WLfHBj/q
	5FiFV12IcC2MNu7imF9T2/NkZ3FogQvm4ZWQcxMaPbpOU2H7w+lwITrXqmA8jiT1m7ULGwxgNTd
	MXvInr/DUh9ipPZBYWwviF24aIG+ai74in+hzb40m6ujjfpEmtreKm0oLh0b6LRc/p7i+ZXcWT8
	ps6sXtmfR0TYs5Cx4GtlQlf8k02i6DJvtIJTKtSBCDvyJX6ABnznzLraCTzXEZE=
X-Received: by 2002:a17:902:f546:b0:235:1171:6d1d with SMTP id d9443c01a7336-237d9778c44mr31617045ad.9.1750413561927;
        Fri, 20 Jun 2025 02:59:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHe6z1jCt9P29nd5bUp1KMM+UoUc1b4iN34jdhHXF/ipj6Fp8eU7N6oZJoYF8siY9bRNwkuGw==
X-Received: by 2002:a17:902:f546:b0:235:1171:6d1d with SMTP id d9443c01a7336-237d9778c44mr31616645ad.9.1750413561369;
        Fri, 20 Jun 2025 02:59:21 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d861061dsm14099045ad.118.2025.06.20.02.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 02:59:20 -0700 (PDT)
Date: Fri, 20 Jun 2025 17:59:16 +0800
From: Zorro Lang <zlang@redhat.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
	djwong@kernel.org, john.g.garry@oracle.com,
	linux-ext4@vger.kernel.org
Subject: Re: [RFC 01/12] common/preamble: Fix fsx for ext4 with bigalloc
Message-ID: <20250620095916.j4vybkssyglixae7@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1749629233.git.ojaswin@linux.ibm.com>
 <2568ed1e9d1c47d0fdb357f0e10c5ed341a72379.1749629233.git.ojaswin@linux.ibm.com>
 <20250618191324.fpwyi6acobodmyit@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <aFT9soHgXs1Yb5Jw@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFT9soHgXs1Yb5Jw@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>

On Fri, Jun 20, 2025 at 11:51:07AM +0530, Ojaswin Mujoo wrote:
> On Thu, Jun 19, 2025 at 03:13:24AM +0800, Zorro Lang wrote:
> > On Wed, Jun 11, 2025 at 03:04:44PM +0530, Ojaswin Mujoo wrote:
> > > From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
> > > 
> > > Insert range and collapse range only works with bigalloc in case
> > > the range is cluster size aligned, which fsx doesnt take care. To
> > > work past this, disable insert range and collapse range on ext4, if
> > > bigalloc is enabled.
> > > 
> > > This is achieved by defining a new function _setup_fs_options
> > > which can serve as a mechanism to apply FS-wide options to
> > > the tests.
> > > 
> > > Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > > ---
> > >  common/preamble | 16 ++++++++++++++++
> > >  1 file changed, 16 insertions(+)
> > > 
> > > diff --git a/common/preamble b/common/preamble
> > > index ba029a34..2bccff74 100644
> > > --- a/common/preamble
> > > +++ b/common/preamble
> > > @@ -24,6 +24,20 @@ _register_cleanup()
> > >  	trap "${cleanup}exit \$status" EXIT HUP INT QUIT TERM $*
> > >  }
> > >  
> > > +# setup FS options only to be available for each test run
> > > +_setup_fs_options() {
> > 
> > If this's a function for fsx only, better to name it with "fsx", e.g.
> > _setup_default_fsx_avoid (or some other names).
> > 
> > > +	case "$FSTYP" in
> > > +	"ext4")
> > > +		if [[ "$MKFS_OPTIONS" =~ bigalloc ]]; then
> > > +			export FSX_AVOID="-I -C"
> > 
> > Hmm... I'm also wondering if this's an issue should be fixed in fstests. How about
> > let the testers who tests ext4 with MKFS_OPTIONS="-O bigalloc" write local.config
> > as below?
> > 
> > [ext4-bigalloc]
> > ...
> > MKFS_OPTIONS="-O bigalloc"
> > FSX_AVOID="-I -C"
> > 
> > Thanks,
> > Zorro
> 
> Hey Zorro, 
> 
> Basically the idea is that _setup_fs_options is a generic function that
> can be used to do any fs specific modifications to the global options.
> 
> This way we can set options to avoid known issues with different FSes,
> which can otherwise confuse the user if they are not aware of such
> issues. 
> 
> Does that sound okay?

I think we should give this choice to the user or the test case who wants
to test ext4 bigalloc feature. And MKFS_OPTIONS isn't the only way to
enable bigalloc, some test cases can do _scratch_mkfs "-O bigalloc".

**But, if *ext4 list* really hope to force set FSX_AVOID="-I -C" for
"$MKFS_OPTIONS" =~ bigalloc, then better to do this in _run_fsx* function at
first, I don't think it's worth having a global _setup_fs_options, and call
it at the beginning of each case running for now.

Thanks,
Zorro

> 
> Regards,
> ojaswin
> 
> > 
> > 
> > > +		fi
> > > +		;;
> > > +	# Add other filesystem types here as needed
> > > +	*)
> > > +		;;
> > > +	esac
> > > +}
> > > +
> > >  # Prepare to run a fstest by initializing the required global variables to
> > >  # their defaults, sourcing common functions, registering a cleanup function,
> > >  # and removing the $seqres.full file.
> > > @@ -55,4 +69,6 @@ _begin_fstest()
> > >  	# remove previous $seqres.full before test
> > >  	rm -f $seqres.full $seqres.hints
> > >  
> > > +	# setup filesystem options for a given test execution
> > > +	_setup_fs_options
> > >  }
> > > -- 
> > > 2.49.0
> > > 
> > > 
> > 
> 


