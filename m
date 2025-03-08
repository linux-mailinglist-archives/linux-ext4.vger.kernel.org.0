Return-Path: <linux-ext4+bounces-6721-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD56A578E1
	for <lists+linux-ext4@lfdr.de>; Sat,  8 Mar 2025 08:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 627727A8C37
	for <lists+linux-ext4@lfdr.de>; Sat,  8 Mar 2025 07:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54EE8190692;
	Sat,  8 Mar 2025 07:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B4rIW9kx"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2271815B54C
	for <linux-ext4@vger.kernel.org>; Sat,  8 Mar 2025 07:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741418446; cv=none; b=EwO5JUXxpp0CpIEHOMOtMOm/h5M/hpbsIsupDFasPs05MQp6Wt6NOnGWdZWUrxdtmAD6ybLvZguP7HK09N7vfE5OeIaIxwKEOf+3OU7Ln6WIWtiT1cSHo9YVzfpRX9qyReJMj/YFgk8a1EpnWF1ksiOkDIv8S/QhFK7cnlE8MRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741418446; c=relaxed/simple;
	bh=8sxuAERpEbGvHkeeugpgqaFjFk1RBwouM05IenGdnOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YqXpkyp8LOVCaGzh2Q7FahL9i0us/w+uoXjHukKGdQBMro2eDeEKo/Xcox8F8QpKrDmuYK/pyYeo/A2ur1eHgjN2b0vh9/6KnfKO22k6XX8uW6Uo88g5nUBLTZvtmL1jnaJ0VQmy7aNgvFVFXrea/r9Fs0MOvvTb6KoDw/2uv8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B4rIW9kx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741418443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SCmKkV1CZokZ249gYYS9oMcIg8uihOkUdFQfQeNSRaw=;
	b=B4rIW9kxcCaBHT+QLfYzj7GJNt+RDqtXYn2BJwaN4VtEdFNVVQSVUljG28osGP3gZ6jyN3
	yXfpt7DKYCONBujmMvQCe8ZHXP1bWBzeg61LM22kECmmyx0zVD+jFLSXPzbjKH7C6ws5U/
	d3rhYGgRnH7zxlQyzdhmk94Xfn+crC4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-OnZFe7fqO5Sa7-HOrLYFCw-1; Sat, 08 Mar 2025 02:20:41 -0500
X-MC-Unique: OnZFe7fqO5Sa7-HOrLYFCw-1
X-Mimecast-MFC-AGG-ID: OnZFe7fqO5Sa7-HOrLYFCw_1741418440
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ff581215a0so7353825a91.0
        for <linux-ext4@vger.kernel.org>; Fri, 07 Mar 2025 23:20:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741418440; x=1742023240;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCmKkV1CZokZ249gYYS9oMcIg8uihOkUdFQfQeNSRaw=;
        b=pogbJ2LiaR99DyX7qNoauuj9NYhn5QkWh7TA8GGPwAh+yeDaWEy8DrGcxASNLU5UuA
         nAOsQtGkaIL4dCbIXxpjBgThjWrIxJNMDFBdowEQ6N3lesv3NvcFyKsUJu6xLQ8fhyiP
         aM4N2SNU+4v8hwwUo3ZrXp1sXZMzt7G0NA2DcDaytcrYOKnYQfXvllsWPnZucdBYhlgQ
         d6FbLWKx2L8jFJ9qK5/Z6uekf/lO5L/XYr9+cPgBe3p/I/mEGjoWryh7zbd5iPHezihQ
         oqnusNdL5yJ378Ha6FY+PXM9JmJeDz4kJ9+Wn9A0Q60XmNxINMaykBi0s6LHeino8tF1
         JBEg==
X-Forwarded-Encrypted: i=1; AJvYcCUkbaE8R4nkzJLNeUQntM33ZShxP41wQxSb4r7FwoDRzEsejFfxPgn1tvy3SbIkb1EaQdKmvw1KWZ0C@vger.kernel.org
X-Gm-Message-State: AOJu0YyH9qgrdoNxs4jghN3fYJLiI+cX7287aCqCav/vjQX+v7hdNbzI
	Ta4Pzxpi27TgZWlg1HWTlZY/2ECZVPmKjeSCy6ERAO+ksTbcvx/CPCx+0ottYt1Ujg+6UPqoJtJ
	HCknsQhY2wd0g8CQ6yrh0Fj/ecmQyBnaZNf1oOW3dWJ9ii1CCvlDpvHAhyDoi56v+7juXag==
X-Gm-Gg: ASbGncuuxHouNCSEmIc8S2c+W3qUn9BahgXI1sKDuZd4Iq4lPTo6nBPGkfzSpURu+i+
	ArHrCIngCpT78KggiKNGbOJZ7yRnQfAr3ta6EJC6rOFGMOcLdLLwIAZS+D6C5ZOC0dFMhBZrm8h
	sokX8ofzBcvy6sm6jS+rhJqiEeobzjeNJCjMm7zqrMh44KBNxCoycexgUPrdsjZRAccXbHHnGqS
	TMpYSOx1w60OS+dzMJNT8YMzLRPtcEsMde2p4c09rvAg/mlYuzesAxbDwNWdjKY+KeA0Y8KUVJ1
	7GaHhyTW07LcyuozymZvaeANPU4Je8GSa2/YG30ikD5mHB+aCqEqU7Ao
X-Received: by 2002:a05:6a21:103:b0:1ee:e641:ca8 with SMTP id adf61e73a8af0-1f544b16c66mr11008017637.20.1741418440311;
        Fri, 07 Mar 2025 23:20:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHd8WnneJ5eOgn0QHqj+cjsbRu2WaQD2CgClh7WJVs9v/NrrONTtCOd5IaZ87Dmd1CYw1zzMg==
X-Received: by 2002:a05:6a21:103:b0:1ee:e641:ca8 with SMTP id adf61e73a8af0-1f544b16c66mr11007995637.20.1741418440041;
        Fri, 07 Mar 2025 23:20:40 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af368398b1dsm2707688a12.8.2025.03.07.23.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 23:20:39 -0800 (PST)
Date: Sat, 8 Mar 2025 15:20:34 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	ritesh.list@gmail.com, ojaswin@linux.ibm.com, djwong@kernel.org,
	zlang@kernel.org
Subject: Re: [PATCH v1 2/2] check,common/{preamble,rc},soak: Decoupling
 init_rc() call from sourcing common/rc
Message-ID: <20250308072034.t7y2d3u4wgxvrhgd@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1741248214.git.nirjhar.roy.lists@gmail.com>
 <1d07e5657c2817c74e939894bb554424199fd290.1741248214.git.nirjhar.roy.lists@gmail.com>
 <Z8oT_tBYG-a79CjA@dread.disaster.area>
 <5c38f84d-cc60-49e7-951e-6a7ef488f9df@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c38f84d-cc60-49e7-951e-6a7ef488f9df@gmail.com>

On Fri, Mar 07, 2025 at 01:35:02PM +0530, Nirjhar Roy (IBM) wrote:
> 
> On 3/7/25 03:00, Dave Chinner wrote:
> > On Thu, Mar 06, 2025 at 08:17:41AM +0000, Nirjhar Roy (IBM) wrote:
> > > Silently executing scripts during sourcing common/rc doesn't look good
> > > and also causes unnecessary script execution. Decouple init_rc() call
> > > and call init_rc() explicitly where required.
> > > 
> > > Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> > FWIW, I've just done somethign similar for check-parallel. I need to
> > decouple common/config from common/rc and not run any code from
> > either common/config or common/rc.
> > 
> > I've included the patch below (it won't apply because there's all
> > sorts of refactoring for test list and config-section parsing in the
> > series before it), but it should give you an idea of how I think we
> > should be separating one-off initialisation environment varaibles,
> > common code inclusion and the repeated initialisation of section
> > specific parameters....
> Thank you so much. I can a look at this.
> > 
> > .....
> > > diff --git a/soak b/soak
> > > index d5c4229a..5734d854 100755
> > > --- a/soak
> > > +++ b/soak
> > > @@ -5,6 +5,7 @@
> > >   # get standard environment, filters and checks
> > >   . ./common/rc
> > > +# ToDo: Do we need an init_rc() here? How is soak used?
> > >   . ./common/filter
> > I've also go a patch series that removes all these old 2000-era SGI
> > QE scripts that have not been used by anyone for the last 15
> > years. I did that to get rid of the technical debt that these
> > scripts have gathered over years of neglect. They aren't used, we
> > shouldn't even attempt to maintain them anymore.
> 
> Okay. What do you mean by SGI QE script (sorry, not familiar with this)? Do
> you mean some kind of CI/automation-test script?

SGI is Silicon Graphics International Corp. :
https://en.wikipedia.org/wiki/Silicon_Graphics_International

xfstests was created to test xfs on IRIX (https://en.wikipedia.org/wiki/IRIX)
of SGI. Dave Chinner worked in SGI company long time ago, so he's the expert
of all these things, and knows lots of past details :)

Thanks,
Zorro

> 
> --NR
> 
> > 
> > -Dave.
> > 
> -- 
> Nirjhar Roy
> Linux Kernel Developer
> IBM, Bangalore
> 
> 


