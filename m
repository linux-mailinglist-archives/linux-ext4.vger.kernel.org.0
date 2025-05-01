Return-Path: <linux-ext4+bounces-7596-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7449EAA5C82
	for <lists+linux-ext4@lfdr.de>; Thu,  1 May 2025 11:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1F823B948D
	for <lists+linux-ext4@lfdr.de>; Thu,  1 May 2025 09:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2122192F5;
	Thu,  1 May 2025 09:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C8oc5eLo"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE22213255
	for <linux-ext4@vger.kernel.org>; Thu,  1 May 2025 09:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746090667; cv=none; b=IiSdY8tG1nevhUivpR2xG4Cr/JsXPA3Ix63cIBk+mLx/FxtIWAxdTAtgkycBeY5NNzbOaWs7XmSv/y7yOsxr2GdFz2IMJEEjAiGrkknbiv4ff4NrLKFAzhs29UxMCF6MQ4o4g3/y1WOmXn+40oh35Kj9I6fOkRV0LsN7v72br4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746090667; c=relaxed/simple;
	bh=QEmXOiaRmXnU0Pvpj2r5Tc5dFQl/2TPO2eRzIxZTpSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8MwHviMCmG+0ig0n9eKAXmWUrNqnMcs1KSNJG0TKW38FWwsvVvy8VZeQYyqrvH9Q7QZnEjpJaJnk6WoH3GSLzC7WO2FVbsbR2j4qKhNpXN/n0ZYeaGOqV6Z1bMFSrpp0RE6f7KRVqgZVZam5xV0iAfed+abmhj/WLXrzAWHW0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C8oc5eLo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746090664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QxhIn1Sw5963uslvOW25nDRRIDUs0PbP3KlVBu7IStA=;
	b=C8oc5eLotFhcFt4pENeaCHFr+ZmEQCIShUieTO/IhSpKLVC5m20QQzLVrMX55pdhcT03Wh
	HNvAh1huCjVdAkzfZ561CVdLdcrDUwyFasKS3j2cNyvnndXdfYRq+eCYbEm9EdlS/HC1n6
	5NUsngG7mPVzrwsxFdADZ8FXPT+Sau4=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-0F5mH_ZPONOChQjOk6ci7Q-1; Thu, 01 May 2025 05:11:01 -0400
X-MC-Unique: 0F5mH_ZPONOChQjOk6ci7Q-1
X-Mimecast-MFC-AGG-ID: 0F5mH_ZPONOChQjOk6ci7Q_1746090660
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-736cd27d51fso698350b3a.2
        for <linux-ext4@vger.kernel.org>; Thu, 01 May 2025 02:11:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746090660; x=1746695460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QxhIn1Sw5963uslvOW25nDRRIDUs0PbP3KlVBu7IStA=;
        b=N9kxjy9apResZPZVZh8lQMGKS3V5wHN3tcSxSthuWapa8hgQtp59dWFcFzf5GRrg3A
         i+pzE/OKFxl/bB9ViKhraaRwfA5xXorVXmyqulHbHg1nVISkWrM/nC+DQ1rll5kIoq/Z
         +s3WGjOQgDofChzpsEi6e+OIoIf+H3O8n/JVMSKtWUJR7mxiss43x8c9qjyPatxI/F5Y
         QMeyrLa3DYbjJsHTHMy1Uef14eWL7RLXMONpkQqMNEibC0Peh7GKKNaepI5hsTRot7L6
         0XhUkZPfEcB2v2qwjS/T9VPadfhFLpypYO5A7sYy457sKGAwMQGErSubAVEhVpVWOlMh
         HGdg==
X-Forwarded-Encrypted: i=1; AJvYcCVSZ6Hqf7y0zuNkGkw2umX0Ak9f48n7tvctPbw5Mikn4FVdVCto9ZGtsQxNZWiNHxVJTKuJNWDGpSR4@vger.kernel.org
X-Gm-Message-State: AOJu0YyTqleEl0TIRJ6+H85BePlcSDUmlCrg7aWRZg0gBcRvDWgjyWSh
	KpuL3VtcWPvGbQ2VF8rU97myKK3sqKb0QwRa9YGviBZSyCa/HORaM7WGdXydoqXVDfdPMLf+Apb
	PA9yMh/XG0h0FzSRP1iJn/qQsQoMHulhhlVZc2k0KMJA6guIDvcHs+m/0h7A=
X-Gm-Gg: ASbGnct56SJKFZJrlyxT1IqB9INt28vYpzW2VNwWcE4aqtYDHUOpP7zO8SwYd1dIC9G
	ENE1eZf5WXJR2lR0Sap6GnyzfCJVFseGFy6UmM15kQeNxuiJPetdIomYLU020yayIaoYqHPHHb6
	LCIXNuVfTe26QgF2RAatbsfPCN0yC+NSpn3VDMOezopDU1tqFZkQ1Cfwap0mOfjw4TdTyJhEB/7
	ACI2hqEJsg0hyLyOYkpCbQUXohC3Gg++xmENKShdxnNsBYO7pX3b2EtdYvKe8wBS8Gg5+xYjDzV
	8S6hSUKBiAuF2cT7mAoXRnl/Jt9MA9+CSgznU+SGZTQHgBfJzH9D
X-Received: by 2002:a05:6a00:399f:b0:736:b9f5:47c6 with SMTP id d2e1a72fcca58-74049254c95mr2293521b3a.16.1746090659928;
        Thu, 01 May 2025 02:10:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFb5/7x8ZBKSA+i2VN4Rh2/jV2SOh0H2mngKBWWKI7BKImnX6gIaLln1uDeV0hnSozdCGsAzw==
X-Received: by 2002:a05:6a00:399f:b0:736:b9f5:47c6 with SMTP id d2e1a72fcca58-74049254c95mr2293497b3a.16.1746090659522;
        Thu, 01 May 2025 02:10:59 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7404fa42fb0sm353535b3a.166.2025.05.01.02.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 02:10:59 -0700 (PDT)
Date: Thu, 1 May 2025 17:10:53 +0800
From: Zorro Lang <zlang@redhat.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>,
	fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ojaswin@linux.ibm.com, djwong@kernel.org,
	zlang@kernel.org, david@fromorbit.com, hch@infradead.org
Subject: Re: [PATCH v3 1/2] common: Move exit related functions to a
 common/exit
Message-ID: <20250501091053.ghovsgjb52yvb7rj@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1746015588.git.nirjhar.roy.lists@gmail.com>
 <7363438118ab8730208ba9f35e81449b2549f331.1746015588.git.nirjhar.roy.lists@gmail.com>
 <87cyctqasl.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cyctqasl.fsf@gmail.com>

On Thu, May 01, 2025 at 08:47:46AM +0530, Ritesh Harjani wrote:
> "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com> writes:
> 
> > Introduce a new file common/exit that will contain all the exit
> > related functions. This will remove the dependencies these functions
> > have on other non-related helper files and they can be indepedently
> > sourced. This was suggested by Dave Chinner[1].
> > While moving the exit related functions, remove _die() and die_now()
> > and replace die_now with _fatal(). It is of no use to keep the
> > unnecessary wrappers.
> >
> > [1] https://lore.kernel.org/linux-xfs/Z_UJ7XcpmtkPRhTr@dread.disaster.area/
> > Suggested-by: Dave Chinner <david@fromorbit.com>
> > Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> > ---
> >  check           |  2 ++
> >  common/config   | 17 -----------------
> >  common/exit     | 39 +++++++++++++++++++++++++++++++++++++++
> >  common/preamble |  3 +++
> >  common/punch    | 39 +++++++++++++++++----------------------
> >  common/rc       | 28 ----------------------------
> >  6 files changed, 61 insertions(+), 67 deletions(-)
> >  create mode 100644 common/exit
> >
> > diff --git a/check b/check
> > index 9451c350..bd84f213 100755
> > --- a/check
> > +++ b/check
> > @@ -46,6 +46,8 @@ export DIFF_LENGTH=${DIFF_LENGTH:=10}
> >  
> >  # by default don't output timestamps
> >  timestamp=${TIMESTAMP:=false}
> > +. common/exit
> > +. common/test_names
> 
> So this gets sourced at the beginning of check script here.
> 
> >  
> >  rm -f $tmp.list $tmp.tmp $tmp.grep $here/$iam.out $tmp.report.* $tmp.arglist
> >  
> <...>
> > diff --git a/common/preamble b/common/preamble
> > index ba029a34..51d03396 100644
> > --- a/common/preamble
> > +++ b/common/preamble
> > @@ -33,6 +33,9 @@ _register_cleanup()
> >  # explicitly as a member of the 'all' group.
> >  _begin_fstest()
> >  {
> > +	. common/exit
> > +	. common/test_names
> > +
> 
> Why do we need to source these files here again? 
> Isn't check script already sourcing both of this in the beginning
> itself?

The _begin_fstest is called at the beginning of each test case (e.g. generic/001).
And "check" run each test cases likes:

  cmd="generic/001"
  ./$cmd

So the imported things (by "check") can't help sub-case running

Thanks,
Zorro

> 
> -ritesh
> 


