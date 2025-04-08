Return-Path: <linux-ext4+bounces-7136-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B0AA80E3B
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Apr 2025 16:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CBA442150C
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Apr 2025 14:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098911EFF91;
	Tue,  8 Apr 2025 14:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NzQm6nsP"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C1322A81C
	for <linux-ext4@vger.kernel.org>; Tue,  8 Apr 2025 14:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744122478; cv=none; b=aza7Azl75/2TE42erPTYZ/wPniTJGNO/dKbP+45QXhg/x83jhCgkkU+ItmR3qwENSK8kO+Rc3QKmSQKmH7wNZJW/V/Uv47fwx+8oHe8bPhOnFbLDubkwhUApiwEpjY6H6MKTbtqDHMXKzJsVm9EShKdUz+/BJziSnZYhX5YyvnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744122478; c=relaxed/simple;
	bh=8sVTW6TceJNB34RYjY9n6ubg4DVVdtoWsa7Sh4zjrSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YSAnWEAELkbHJ/ppS5VULsP5ZI/0w878AUdHP1xHB9W4ewYt/0xodwmu6KEnc/mztxYxvOzm7wMS1mM5gY+uiIl6d3LC6nXYluhiLrrB75/2VdWI33wxowtHTtyDoFD5wv9AL+ectb4aZcIQdedMibsnjAUabE0RXNKS7WQBfhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NzQm6nsP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744122475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8RFZ7s3rxzl+Ts3s9RalLsIVjWLHrI7+8FF2waxdV8s=;
	b=NzQm6nsPLH14O8UfUR4o/LvF+syKcYThzbGO7jMQnkvA8EE5D1gWtIQ6PCSjJ984QDR57g
	KwE/OMZO6f7eZ+rV0ZZXRH0PnW1+Vj2LNm9tMqRfY4j6tF+O7ej0FM45tM4oL2Gb1/9IcD
	Z5HDzDYajLWa93xLI9SO2tdpAXzsVxU=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-hQru-z11OrKZQHic9BpI1w-1; Tue, 08 Apr 2025 10:27:54 -0400
X-MC-Unique: hQru-z11OrKZQHic9BpI1w-1
X-Mimecast-MFC-AGG-ID: hQru-z11OrKZQHic9BpI1w_1744122473
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-224192ff68bso51836255ad.1
        for <linux-ext4@vger.kernel.org>; Tue, 08 Apr 2025 07:27:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744122473; x=1744727273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8RFZ7s3rxzl+Ts3s9RalLsIVjWLHrI7+8FF2waxdV8s=;
        b=w72TCocB6jaXn/VCGhp1cDq3mnaLyUet80Gj0PCwpvuxPKudIUa+c33bMJ4d2proIe
         mFpKWb8+XAszCqcN+9o4gzgRERVLzWTsqFnzq734ezFwgjnydB4FmwxYcRZZPQcM6Spp
         Mj9UGjpIDNj+QwE3PgrSMN0qdsDOPKBdjA26R9T3VJiZCY8URNOgXXRXU4N/vAjSklXw
         j6+00MEDkqwN7jdXi/UgXE+gn35T0YUSD2dQjKFL3nfX6kGs4Krm3tRFURghoCopmNpc
         sUTJD1MyQDh67uAjL6Dq0raDyuNwzoxp9tlbjiXPV7o9tJI5PXhvZG96Lubgz/HGctBB
         1B5w==
X-Forwarded-Encrypted: i=1; AJvYcCVrBUreqSMUdPrcuALOSc8A16ocLVSX8mMcxAyr1Mg2uPpyLLGyyd0dq1vxczVA2Pbua2dN8qHC3Sza@vger.kernel.org
X-Gm-Message-State: AOJu0YzwZx23DlvNRbCHv9pRh8pArDcPpgEPkgMGewA25ZssM73x7YkE
	bz3pdRu3jGmY1rtqal5cmkNdYJsW55jwKjd2iLUZx1axVVkAYP7x8kkj5r28Kydtcft4CHIo9Ti
	Ykdbyxr/96pl4LwkeDtuweIqinXP5rLW39fwaomV/278HL3OcLFfhRdHg+rg=
X-Gm-Gg: ASbGnctZCAeqmljEmRsSfmAIGiTK5q03JcwY8PtzN5jUk+3/ksnws/UVbcbSewQxzgI
	MYmKThuIAGAAu9G5CZ+O/7uPLXq3DiP/6/2eOXbqvTcIDWSZZLkSQEBD1FHhuOt0Oy/c8exdEET
	Iz1W9XBFuGqwpLZaZ3RDi/vYsqr+M/U/p2agQiSiSZh1oWHjvI6o2jm6KjC2RXEqsHILgsC8D5o
	DMtFso8jnzylnwFdnp7Usy6vAH2UwleNO+nLdZJ6E5S0ttfQSZ31o23gYl+hzoLQzq/c9ZziPV/
	/54cZ0VfbFhexFXzR315T57ZSRlEiEGomDKiUuhYlCMLsy0ST6wudqoU
X-Received: by 2002:a17:902:d4ca:b0:223:5e76:637a with SMTP id d9443c01a7336-22a95539beamr160554635ad.23.1744122473109;
        Tue, 08 Apr 2025 07:27:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgjgb0MlkszrbH2eNw4gben2vOMbEpUncigfF9I1M6mhJaVYcdLSb8ZfEimongz+/9tzu4Rg==
X-Received: by 2002:a17:902:d4ca:b0:223:5e76:637a with SMTP id d9443c01a7336-22a95539beamr160554245ad.23.1744122472750;
        Tue, 08 Apr 2025 07:27:52 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d9ea0801sm10573244b3a.119.2025.04.08.07.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 07:27:52 -0700 (PDT)
Date: Tue, 8 Apr 2025 22:27:48 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org,
	david@fromorbit.com
Subject: Re: [PATCH v2 5/5] common: exit --> _exit
Message-ID: <20250408142747.tojq7dhv3ad2mzaq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1743487913.git.nirjhar.roy.lists@gmail.com>
 <f6c7e5647d5839ff3a5c7d34418ec56aba22bbc1.1743487913.git.nirjhar.roy.lists@gmail.com>
 <87mscwv7o0.fsf@gmail.com>
 <20250407161914.mfnqef2vqghgy3c2@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <877c3vzu5p.fsf@gmail.com>
 <3c1d608d-4ea0-4e24-9abc-95eb226101c2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c1d608d-4ea0-4e24-9abc-95eb226101c2@gmail.com>

On Tue, Apr 08, 2025 at 12:43:32AM +0530, Nirjhar Roy (IBM) wrote:
> 
> On 4/8/25 00:16, Ritesh Harjani (IBM) wrote:
> > Zorro Lang <zlang@redhat.com> writes:
> > 
> > > On Fri, Apr 04, 2025 at 10:34:47AM +0530, Ritesh Harjani wrote:
> > > > "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com> writes:
> > > > 
> > > > > Replace exit <return-val> with _exit <return-val> which
> > > > > is introduced in the previous patch.
> > > > > 
> > > > > Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> > <...>
> > > > > ---
> > > > > @@ -225,7 +225,7 @@ _filter_bmap()
> > > > >   die_now()
> > > > >   {
> > > > >   	status=1
> > > > > -	exit
> > > > > +	_exit
> > > > Why not remove status=1 too and just do _exit 1 here too?
> > > > Like how we have done at other places?
> > > Yeah, nice catch! As the defination of _exit:
> > > 
> > >    _exit()
> > >    {
> > >         status="$1"
> > >         exit "$status"
> > >    }
> > > 
> > > The
> > >    "
> > >    status=1
> > >    exit
> > >    "
> > > should be equal to:
> > >    "
> > >    _exit 1
> > >    "
> > > 
> > > And "_exit" looks not make sense, due to it gives null to status.
> > > 
> > > Same problem likes below:
> > > 
> > > 
> > > @@ -3776,7 +3773,7 @@ _get_os_name()
> > >                  echo 'linux'
> > >          else
> > >                  echo Unknown operating system: `uname`
> > > -               exit
> > > +               _exit
> > > 
> > > 
> > > The "_exit" without argument looks not make sense.
> > > 
> > That's right. _exit called with no argument could make status as null.
> Yes, that is correct.
> > To prevent such misuse in future, should we add a warning/echo message
> 
> Yeah, the other thing that we can do is 'status=${1:-0}'. In that case, for
                                           ^^^^^^^^^^^^^^
That's good to me, I'm just wondering if the default value should be "1", to
tell us "hey, there's an unknown exit status" :)

Thanks,
Zorro

> cases where the return value is a success, we simply use "_exit". Which one
> do you think adds more value and flexibility to the usage?
> 
> --NR
> 
> > if the no. of arguments passed to _exit() is not 1?
> > 
> > -ritesh
> 
> -- 
> Nirjhar Roy
> Linux Kernel Developer
> IBM, Bangalore
> 


