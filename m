Return-Path: <linux-ext4+bounces-9837-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F8DB4792B
	for <lists+linux-ext4@lfdr.de>; Sun,  7 Sep 2025 07:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 281621B225A6
	for <lists+linux-ext4@lfdr.de>; Sun,  7 Sep 2025 05:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CE41DC075;
	Sun,  7 Sep 2025 05:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T+ak4fXz"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B72B18EAB
	for <linux-ext4@vger.kernel.org>; Sun,  7 Sep 2025 05:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757222294; cv=none; b=PfY8UriARQ8Vwgkfz4evvxzseBwuFHeJutD/VQtdJoOljTphCqssaeoJmZfXPuE0JXbPk+qP80FwQ7zkc/3Hlm+I/CS5JEoGuV03Mb7T6L5/viW2SLObEIleBujATQOt3ZF1vmkwayB4gTi85v3cjVvVen1WtV7YRQ9j6/ZPMbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757222294; c=relaxed/simple;
	bh=qwccVuzbUesgD3QoZMWodzkcU8xN7J0ykW7Ze0ZXgK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2o9o/tHCUHtL9QU/bDSos3WfYZfQ4cQJMmpEc9eatmj6kInN0Liz6alWjYQ7sF3qYDruOCIiSmC2WUt0MfLcgfYXu28bPEkokRUjkueCSZkdldICMAPlHxO/bnsSxQWTNsSXjlAQ0EDRIrRipZn7bjDFcp5RSiMymRXGjAXde4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T+ak4fXz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757222291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OblASZcrr7kB2yJKEylAwifpAWWyy4KUP/8RCxYnVGo=;
	b=T+ak4fXzwMnGbGfZcOyCWWH17x8dfYw0u+JTbZ/rWvlD6k51mAQ24i8pivRZzQ88uJKFz+
	brJuaziumt3PeH9HqShuw1HV1nB5zUxFXhhHZXODf2ykmvE5cFn9X51HY9FOgiEMGdKKRd
	qd3HXgDVMfUzh9IzZXa3wh9yJb6TlJw=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-OD_ZUfYhOJWlzIfXgxQGFQ-1; Sun, 07 Sep 2025 01:18:10 -0400
X-MC-Unique: OD_ZUfYhOJWlzIfXgxQGFQ-1
X-Mimecast-MFC-AGG-ID: OD_ZUfYhOJWlzIfXgxQGFQ_1757222289
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24b2336e513so52181285ad.0
        for <linux-ext4@vger.kernel.org>; Sat, 06 Sep 2025 22:18:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757222289; x=1757827089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OblASZcrr7kB2yJKEylAwifpAWWyy4KUP/8RCxYnVGo=;
        b=kxW7j2r9JVlGI36QISn4HStEqX4RK307z4d7g2kwKd2JFaZ1IQEgM1R7xfaj96ziKg
         YRF9/8zjqFGaiZDSWen0Qebqeb7Yv0/q7sGegAZbk/K5j3ybxsdsBr9s0cfPVGoT7gjL
         RNfBIdYziZ4FxLmCL4SipjDGipyQrWMnxTOq5hrmwp/qbfGX0+ITRGq1c02eVwUjzh2f
         20QvYRIQ5VTTO220lVKsVZsLTeup4WUpF7a2m3OmXArDTbWyG+1BE2aN8audFcupEIN5
         lyvs7XCDfDO2b94UJTD/w9Myy9Ck0hu6qBjmoJ2c9H2Kvmusvvm48HBzsEKrC9DRr5U3
         PpXQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2s2BXbNcGppPVwUfU8XqcPk0S94rMyZgSJy371z7b8jcxkPY2vRETnavPCwCmGIKOZadUIfKRjmtJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwZJd0aEQLk6fU4T8BnNKdzXMJlrtwklKWBAARx+5jeQyQoaOwm
	EzAKIwuWBKjg0G0sdkfnB/HmM9vfPtSt6391Co9EHh1l/r6E+nBlQobvr5RV2I2NHeucc9hddYf
	izqpO84hbLuYr835be8TrFiotTEfgDhKEjIRSBMVjivnRQWLTY91T/jCrMq4qVyE=
X-Gm-Gg: ASbGncsY6MvJx6aRPQBOULYzVvZ/W9in+YZJqYhP2qkQ4CWWdEcQ9d1gDEBuVHxOCBM
	D/fk3Ps7gA79+0NX8mzMJ32kZqPFW6zBI9LLPzmSNv/b47P+763WOowCk2tx2qRL4zvz0Y4jTOM
	d2VmweFjTuGJoyWnnjtT4HEP1YHZLAgxmm5nAaZ1s9UgZM6d2fEOAYq4P/ZrKE7Qd4XFAZXSvAA
	6ICkwGqXFAfSRNpGPTHnDV6tAHn9XtFZjfNe9/UpFNqNMQ1ackOouPSWtV5hHcKWHw7Ar9hmvLQ
	Z/xXDCJ6F0llS0j1onPIFSFb5Yqw/p6iTmj4d8RZIAu7A7MC3AtdPsozTxWe2CgLxLA+8b7ui7K
	4y+p6
X-Received: by 2002:a17:902:7c98:b0:249:33db:34b with SMTP id d9443c01a7336-25174374976mr39073175ad.42.1757222289312;
        Sat, 06 Sep 2025 22:18:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErgKrN3nawKeRdKJYtoByqaDG+aENeILCXOZaM7UN1gFx5Yj70HtS39XlJA3mnEHXugO/6/A==
X-Received: by 2002:a17:902:7c98:b0:249:33db:34b with SMTP id d9443c01a7336-25174374976mr39072895ad.42.1757222288607;
        Sat, 06 Sep 2025 22:18:08 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b020a7cb5sm146860015ad.115.2025.09.06.22.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 22:18:08 -0700 (PDT)
Date: Sun, 7 Sep 2025 13:18:03 +0800
From: Zorro Lang <zlang@redhat.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>, fstests@vger.kernel.org,
	Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
	tytso@mit.edu, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v5 02/12] common/rc: Add _require_fio_version helper
Message-ID: <20250907051803.t4av26vmf7zodzjl@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1755849134.git.ojaswin@linux.ibm.com>
 <955d47b2534d9236adbd2bbd13598bbd1da8fc04.1755849134.git.ojaswin@linux.ibm.com>
 <1b12c0d9-b564-4e57-b1a5-359e2e538e9c@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b12c0d9-b564-4e57-b1a5-359e2e538e9c@oracle.com>

On Tue, Sep 02, 2025 at 03:50:10PM +0100, John Garry wrote:
> On 22/08/2025 09:02, Ojaswin Mujoo wrote:
> > The main motivation of adding this function on top of _require_fio is
> > that there has been a case in fio where atomic= option was added but
> > later it was changed to noop since kernel didn't yet have support for
> > atomic writes. It was then again utilized to do atomic writes in a later
> > version, once kernel got the support. Due to this there is a point in
> > fio where _require_fio w/ atomic=1 will succeed even though it would
> > not be doing atomic writes.
> > 
> > Hence, add an explicit helper to ensure tests to require specific
> > versions of fio to work past such issues.
> > 
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > ---
> >   common/rc | 32 ++++++++++++++++++++++++++++++++
> >   1 file changed, 32 insertions(+)
> > 
> > diff --git a/common/rc b/common/rc
> > index 35a1c835..f45b9a38 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -5997,6 +5997,38 @@ _max() {
> >   	echo $ret
> >   }
> > +# Check the required fio version. Examples:
> > +#   _require_fio_version 3.38 (matches 3.38 only)
> > +#   _require_fio_version 3.38+ (matches 3.38 and above)
> > +#   _require_fio_version 3.38- (matches 3.38 and below)
> 
> This requires the user to know the version which corresponds to the feature.
> Is that how things are done for other such utilities and their versions vs
> features?

I don't like to use "version" to be the _require_ condition either. fstests always
recommend "checking if the feature/behavior is really supported" at first, not a
hard version limitation. Some old downstream software might backport new upstream
commits, the version is useless for them.

Thanks,
Zorro

> 
> I was going to suggest exporting something like
> _require_fio_atomic_writes(), and _require_fio_atomic_writes() calls
> _require_fio_version() to check the version.
> 
> Thanks,
> John
> 
> 


