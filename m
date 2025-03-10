Return-Path: <linux-ext4+bounces-6742-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C938A58DA7
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Mar 2025 09:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC9A81636D7
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Mar 2025 08:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607AC222593;
	Mon, 10 Mar 2025 08:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fJy0hO++"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBA92222A5
	for <linux-ext4@vger.kernel.org>; Mon, 10 Mar 2025 08:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741594002; cv=none; b=ROxDXoqKcgwT+QSHpI9/aemHdSLAIxpk1ey61qfUXq882dSHyDyOKaH60bQWP+c3rbFbLP5hjH45bmqlDxRw2LHpK2hLEcRwVB6rFzK03Zd18OPVH9L/c6I1kebZngqkGgplfDFStgQ8EMo3Gpio4tU+isVJp9nxJhiSXHBYSC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741594002; c=relaxed/simple;
	bh=93W6ybCwcYA7AqE4AGQacqgIe8KHvftkYc5f4XtCDwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h3bT3d9pgdRid84FgYst2pIgCFBOr/lYPo0Z9T6I5sgVo2wBtaGqte7INLkPa41D+jJ8c0a9bNQrRvkalWR+IFMRvVgRbxnHRm4hQxePRTcaRZuGADzjgYNHw3zBbicC55fiK/XHaZK3GTdvZVmoQrBNdxnW1mgcC4UELHhL/tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fJy0hO++; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741593999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RCOLOU56jiLb/4wdgy3TIcrzpp/26Wu5xoarM9qeWc0=;
	b=fJy0hO++RT0JWEWjjt08Eks6V8UTUNYbkY4+LBvdaEuJU03PYpxFnlY13iHpV9OkxI3kFH
	U2hZAFVu64fl/4m5z3MpWSVbDAsmwYywXyxjm0cz9dAmg7e7T7C4+Gg62PGdOdlepngPqZ
	+Pmp9p+cSI8dGWKJtYh0YF+FlSW8zkI=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-rJ-57va-NCOoslQ52dKn2A-1; Mon, 10 Mar 2025 04:06:37 -0400
X-MC-Unique: rJ-57va-NCOoslQ52dKn2A-1
X-Mimecast-MFC-AGG-ID: rJ-57va-NCOoslQ52dKn2A_1741593996
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-223d86b4df0so114673945ad.3
        for <linux-ext4@vger.kernel.org>; Mon, 10 Mar 2025 01:06:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741593996; x=1742198796;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCOLOU56jiLb/4wdgy3TIcrzpp/26Wu5xoarM9qeWc0=;
        b=Nb3kK9oY0qy3m4tMOMElOTVbb578GztscvNBeRJfKx9bzn1fcXfrcx6bDBomMYkGze
         Qg3maYgYTzPfoz32Yx0PN4sABdwQyEyVbQzTM2sGqNe4MbC9lC0RdwbyOpWqnEpKetMW
         aOv9mVrO4ijvAGXpW49x4QXuc9CX7EIY4xANQ9FmpDXuVT6Ir2gfIFm5IMpkeoh2ljUs
         +0wv7smV7tpjhn2XN20fDOnFd8MtTZkXDwsHwa4V9hYGUlxYUq5rZlyIuevmW1YAMX1Z
         zRHLkj8URDHCpVZasppnrItXWie27XTDllkOvkvWabs5oieVDPgiiAcPh7w/eCFjqzLf
         A/NQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgNXlh2rqrLmlzxjRhskBSnQvOTsPEgwkUhjq3CZ4GZY9kuxmftdvEe9yct1zBnnSMILqjT1YO2K5u@vger.kernel.org
X-Gm-Message-State: AOJu0YwougasaLcJJ/1yNa+YGyUtMYX/jsChE09RgSuV9du3mrDMOUHa
	cwBl9SVj7gNm59dJzD7SPhr3vTvmyT325hpJ4OA5xbgtDURauYYUOdUVaVoXjRknJOvok2pFAC5
	NgyWYJZ1ybR/CrScqU4moEKgZQXnuyhERSDcAHuoUDec5B2yC4Y9XkPeclfE=
X-Gm-Gg: ASbGncuvHhbV8usOs7Etgb4nnr8qL2Z8c9C0OA9XHewfppeQOuO65NLobmvbHGAkx9i
	1RIbombemZXh+W415iRYCt4sC/OOmMzAIMKI7n7aSzRAbCHNpYmnb8by9/yu/h+dusikEaWImT4
	mo7l5x9xRhszGJ/NcJtGvuePBhLhtgyxVWEP3KpN0AnOQ2rJuxLSg2/v5oiL8S7yViBixMtnSEJ
	gjyZOB0ER+J+brGB0ocVuxv0NWAvJZ4w2BLM6kaUTYynCICmvotgZatMesh8jzt1ZFrcv9I3CDS
	mRdg68dgusehgPwqFvSW56s5+YJZcq+gJ9jvr+D7QLOY+Pu5P8u5KIwe
X-Received: by 2002:a05:6a00:3d55:b0:736:52d7:daca with SMTP id d2e1a72fcca58-736aaadf019mr20663418b3a.18.1741593996265;
        Mon, 10 Mar 2025 01:06:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3zepBp9E0MRImticocc6MTl8Bx7wo5uHRMcLdiudFO4r9G/SfjZxODbq9kG76X31x/uUrMQ==
X-Received: by 2002:a05:6a00:3d55:b0:736:52d7:daca with SMTP id d2e1a72fcca58-736aaadf019mr20663391b3a.18.1741593995950;
        Mon, 10 Mar 2025 01:06:35 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736cd220c5fsm2495334b3a.55.2025.03.10.01.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 01:06:35 -0700 (PDT)
Date: Mon, 10 Mar 2025 16:06:30 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	ritesh.list@gmail.com, ojaswin@linux.ibm.com, djwong@kernel.org,
	zlang@kernel.org
Subject: Re: [PATCH v1 2/2] check,common/{preamble,rc},soak: Decoupling
 init_rc() call from sourcing common/rc
Message-ID: <20250310080630.4lnscrcbaputlocv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1741248214.git.nirjhar.roy.lists@gmail.com>
 <1d07e5657c2817c74e939894bb554424199fd290.1741248214.git.nirjhar.roy.lists@gmail.com>
 <Z8oT_tBYG-a79CjA@dread.disaster.area>
 <5c38f84d-cc60-49e7-951e-6a7ef488f9df@gmail.com>
 <20250308072034.t7y2d3u4wgxvrhgd@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250308072034.t7y2d3u4wgxvrhgd@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Sat, Mar 08, 2025 at 03:20:34PM +0800, Zorro Lang wrote:
> On Fri, Mar 07, 2025 at 01:35:02PM +0530, Nirjhar Roy (IBM) wrote:
> > 
> > On 3/7/25 03:00, Dave Chinner wrote:
> > > On Thu, Mar 06, 2025 at 08:17:41AM +0000, Nirjhar Roy (IBM) wrote:
> > > > Silently executing scripts during sourcing common/rc doesn't look good
> > > > and also causes unnecessary script execution. Decouple init_rc() call
> > > > and call init_rc() explicitly where required.
> > > > 
> > > > Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> > > FWIW, I've just done somethign similar for check-parallel. I need to
> > > decouple common/config from common/rc and not run any code from
> > > either common/config or common/rc.
> > > 
> > > I've included the patch below (it won't apply because there's all
> > > sorts of refactoring for test list and config-section parsing in the
> > > series before it), but it should give you an idea of how I think we
> > > should be separating one-off initialisation environment varaibles,
> > > common code inclusion and the repeated initialisation of section
> > > specific parameters....
> > Thank you so much. I can a look at this.
> > > 
> > > .....
> > > > diff --git a/soak b/soak
> > > > index d5c4229a..5734d854 100755
> > > > --- a/soak
> > > > +++ b/soak
> > > > @@ -5,6 +5,7 @@
> > > >   # get standard environment, filters and checks
> > > >   . ./common/rc
> > > > +# ToDo: Do we need an init_rc() here? How is soak used?
> > > >   . ./common/filter
> > > I've also go a patch series that removes all these old 2000-era SGI
> > > QE scripts that have not been used by anyone for the last 15
> > > years. I did that to get rid of the technical debt that these
> > > scripts have gathered over years of neglect. They aren't used, we
> > > shouldn't even attempt to maintain them anymore.
> > 
> > Okay. What do you mean by SGI QE script (sorry, not familiar with this)? Do
> > you mean some kind of CI/automation-test script?
> 
> SGI is Silicon Graphics International Corp. :
> https://en.wikipedia.org/wiki/Silicon_Graphics_International
> 
> xfstests was created to test xfs on IRIX (https://en.wikipedia.org/wiki/IRIX)
> of SGI. Dave Chinner worked in SGI company long time ago, so he's the expert
> of all these things, and knows lots of past details :)

Hi Nirjhar,

I've merged Dave's "[PATCH 0/5] fstests: remove old SGI QE scripts" into
patches-in-queue branch. You can base on that to write your V2, to avoid
dealing with the "soak" file.

Thanks,
Zorro

> 
> Thanks,
> Zorro
> 
> > 
> > --NR
> > 
> > > 
> > > -Dave.
> > > 
> > -- 
> > Nirjhar Roy
> > Linux Kernel Developer
> > IBM, Bangalore
> > 
> > 


