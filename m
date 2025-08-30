Return-Path: <linux-ext4+bounces-9765-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBF1B3CDD1
	for <lists+linux-ext4@lfdr.de>; Sat, 30 Aug 2025 19:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5A583BAFB5
	for <lists+linux-ext4@lfdr.de>; Sat, 30 Aug 2025 17:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5F12853E2;
	Sat, 30 Aug 2025 17:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I6oOpXxv"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA378271A7B
	for <linux-ext4@vger.kernel.org>; Sat, 30 Aug 2025 17:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756573759; cv=none; b=dgMn1uJMKA08Y5OFEPujw1V2iJRoxjo31G2FipvofNTSOUTjDKwO8WhInvvkqwdVygb9/AW2AYQf4jraciFLz4CEomAGlnfbMxaLPiHWdQM/T6N8iCSluddlp6x8UUMXve+6GwF1ajpWNmoM47S/cfV/r6Edq47Si6Lx7d7DI9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756573759; c=relaxed/simple;
	bh=JcLfCr1fNOZJnTTEBFUzA+5oLmKS60tKVwGIhQXW+GI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HO2x/TUeybXhQeWMX1AxC9yVLZA5hwIXPwAO4HNW+COYJG/szVjOco+lnkmmdPsqRfWfa68oCGBfCRvkCE+NGmQamBPmiucHUv0auH8WhQQjggE/eW9Ezj4bWPUCCvqWnci2gAtOKi0yCTd4qkyMWVn9KNgj3zYEqQ3r9gKgkBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I6oOpXxv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756573756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+sQOUl1w6wrKYsvuJH5QyydsTUnK4b9iWYOLl0ehlfc=;
	b=I6oOpXxv6bWbFKf5QtBf96xPNY97p3Ncd6xqrlUW4nk15T/wZh90ansDonpOovTcqb46t/
	q+EwYUekiGYMwBcx+x7hqfC+v6zLEv7hCWvMaXViJFO2x3Qpc3s+2UiV49ILlRyeEHYUwn
	Gla/N1B9bkEHgsJETBepASDU8enzlIM=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-NDLtSNqQNLq-i6KHtdKpRQ-1; Sat, 30 Aug 2025 13:09:14 -0400
X-MC-Unique: NDLtSNqQNLq-i6KHtdKpRQ-1
X-Mimecast-MFC-AGG-ID: NDLtSNqQNLq-i6KHtdKpRQ_1756573753
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-248eec89618so26639035ad.1
        for <linux-ext4@vger.kernel.org>; Sat, 30 Aug 2025 10:09:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756573753; x=1757178553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+sQOUl1w6wrKYsvuJH5QyydsTUnK4b9iWYOLl0ehlfc=;
        b=NsdX4PpVBR/QvHdT+9KByGUhvlS/uWX33VPQMMgcHNSJmAUXHayTqESE+ve7gkL1tn
         oc/89P01obn2sBfKL9ZkWiSp84RaUJem8S76FioaCi1k7sbqGA9d9suNXwpEA8w8r+kS
         65S9Z4GzsnLZ3hHMAeeAG9v23n/G7ymLBqaoqtTq7+GltoFNBp16maCkFSP3X+RoD2YH
         NKvLwQ/xQ51eOhldUKC1szUek50oyQ5x4kzNKEx2+tJ0GfeTneM4RfpnB3DeZOr78cLa
         XmGG0L5iRj1ynHqc0K9JUFjseg8wDMEAnYz3I31+/DwxX0Z1WW78gI3MJxjSOv3PmRkL
         tatg==
X-Forwarded-Encrypted: i=1; AJvYcCXwu8Wp4q3LpP7sQKzXVXFRDvxbX1mqtgnITSINXRDJhKwYs0MyIGGjGeaAexll9UEgXKMchpGq8FhL@vger.kernel.org
X-Gm-Message-State: AOJu0YysNT9iEAaGNufstcu/GpCQCdN8Yqkm29ICN0m52VKzJjymudGO
	MVosxfROvjpUvJrfUgb6SuzcEbNSinfvcat535pad/bMenTjohC7Rz0TQG2zLlxIHGkTonGV2zE
	AhcJMTuFpB80OxIIBvuksrqQl4qbogyWq2zF5W2fXDgulxB2IpxNbfI7HND+Spic=
X-Gm-Gg: ASbGncv9MLKLV68rdzFVYuMChN3B2dKZZnnnx36XOuad7sD1hRaieh1KiETRVVO1OMC
	5ZK34AjKbjSX6EpLCGdkfD8cEtUYP3K0+IHAAn3Y5b8oXilmX+bbeLJW2mIH1TLJlkRKrbNoj+8
	5lqTzh2yRsH7K5LjRLQksXMBu6zPU5PHzP1Jrc0reRWUpTLAY/CkazXI5U7O4yQxaVqboU66cXc
	tfzf1iiR3EAjVE670Lu+3GOfOoiYFnt+1bGr/aXjAACbkH7ZUqvy0OYzJwVlfRy/Y5zkF3TMs5j
	3LYbV+69fKFpMtt2mcP7efOl4B2JAORZ/Nn/KPMSC2GiCS9kJrFqbpXB9qZIoEjZexl6W6v2ldu
	57vy5
X-Received: by 2002:a17:903:190:b0:246:e8cc:8cef with SMTP id d9443c01a7336-24944870a4emr42656245ad.3.1756573753170;
        Sat, 30 Aug 2025 10:09:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFufkm14+kWgLeyAtnWDENYX2tBc3g+OtzDJJ2/KfgKYaBdKqAHSLkaQW2S2IFh13FYgWrI7Q==
X-Received: by 2002:a17:903:190:b0:246:e8cc:8cef with SMTP id d9443c01a7336-24944870a4emr42656025ad.3.1756573752783;
        Sat, 30 Aug 2025 10:09:12 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24a92f89763sm16457905ad.48.2025.08.30.10.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 10:09:12 -0700 (PDT)
Date: Sun, 31 Aug 2025 01:09:07 +0800
From: Zorro Lang <zlang@redhat.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org,
	Ritesh Harjani <ritesh.list@gmail.com>, john.g.garry@oracle.com,
	tytso@mit.edu, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v5 02/12] common/rc: Add _require_fio_version helper
Message-ID: <20250830170907.htlqcmafntjwkjf4@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1755849134.git.ojaswin@linux.ibm.com>
 <955d47b2534d9236adbd2bbd13598bbd1da8fc04.1755849134.git.ojaswin@linux.ibm.com>
 <20250825160801.ffktqauw2o6l5ql3@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <aK8hUqdee-JFcFHn@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <20250828150905.GB8092@frogsfrogsfrogs>
 <aLHcgyWtwqMTX-Mz@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLHcgyWtwqMTX-Mz@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>

On Fri, Aug 29, 2025 at 10:29:47PM +0530, Ojaswin Mujoo wrote:
> On Thu, Aug 28, 2025 at 08:09:05AM -0700, Darrick J. Wong wrote:
> > On Wed, Aug 27, 2025 at 08:46:34PM +0530, Ojaswin Mujoo wrote:
> > > On Tue, Aug 26, 2025 at 12:08:01AM +0800, Zorro Lang wrote:
> > > > On Fri, Aug 22, 2025 at 01:32:01PM +0530, Ojaswin Mujoo wrote:
> > > > > The main motivation of adding this function on top of _require_fio is
> > > > > that there has been a case in fio where atomic= option was added but
> > > > > later it was changed to noop since kernel didn't yet have support for
> > > > > atomic writes. It was then again utilized to do atomic writes in a later
> > > > > version, once kernel got the support. Due to this there is a point in
> > > > > fio where _require_fio w/ atomic=1 will succeed even though it would
> > > > > not be doing atomic writes.
> > > > > 
> > > > > Hence, add an explicit helper to ensure tests to require specific
> > > > > versions of fio to work past such issues.
> > > > 
> > > > Actually I'm wondering if fstests really needs to care about this. This's
> > > > just a temporary issue of fio, not kernel or any fs usespace program. Do
> > > > we need to add a seperated helper only for a temporary fio issue? If fio
> > > > doesn't break fstests running, let it run. Just the testers install proper
> > > > fio (maybe latest) they need. What do you and others think?
> > 
> > Are there obvious failures if you try to run these new atomic write
> > tests on a system with the weird versions of fio that have the no-op
> > atomic= functionality?  I'm concerned that some QA person is going to do
> > that unwittingly and report that everything is ok when in reality they
> > didn't actually test anything.
> 
> I think John has a bit more background but afaict, RWF_ATOMIC support
> was added (fio commit: d01612f3ae25) but then removed (commit:
> a25ba6c64fe1) since the feature didn't make it to kernel in time.
> However the option seemed to be kept in place. Later, commit 40f1fc11d
> added the support back in a later version of fio. 
> 
> So yes, I think there are some version where fio will accept atomic=1
> but not act upon it and the tests may start failing with no apparent
> reason.

The concern from Darrick might be a problem. May I ask which fio commit
brought in this issue, and which fio commit fixed it? If this issue be
brought in and fixed within a fio release, it might be better. But if it
crosses fio release, that might be bad, then we might be better to have
this helper.

Thanks,
Zorro

> 
> Regards,
> ojaswin
> > 
> > --D
> > 
> > > > Thanks,
> > > > Zorro
> > > 
> > > Hey Zorro,
> > > 
> > > Sure I'm okay with not keeping the helper and letting the user make sure
> > > the fio version is correct.
> > > 
> > > @John, does that sound okay?
> > > 
> > > Regards,
> > > ojaswin
> > > > 
> > > > > 
> > > > > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > > > > ---
> > > > >  common/rc | 32 ++++++++++++++++++++++++++++++++
> > > > >  1 file changed, 32 insertions(+)
> > > > > 
> > > > > diff --git a/common/rc b/common/rc
> > > > > index 35a1c835..f45b9a38 100644
> > > > > --- a/common/rc
> > > > > +++ b/common/rc
> > > > > @@ -5997,6 +5997,38 @@ _max() {
> > > > >  	echo $ret
> > > > >  }
> > > > >  
> > > > > +# Check the required fio version. Examples:
> > > > > +#   _require_fio_version 3.38 (matches 3.38 only)
> > > > > +#   _require_fio_version 3.38+ (matches 3.38 and above)
> > > > > +#   _require_fio_version 3.38- (matches 3.38 and below)
> > > > > +_require_fio_version() {
> > > > > +	local req_ver="$1"
> > > > > +	local fio_ver
> > > > > +
> > > > > +	_require_fio
> > > > > +	_require_math
> > > > > +
> > > > > +	fio_ver=$(fio -v | cut -d"-" -f2)
> > > > > +
> > > > > +	case "$req_ver" in
> > > > > +	*+)
> > > > > +		req_ver=${req_ver%+}
> > > > > +		test $(_math "$fio_ver >= $req_ver") -eq 1 || \
> > > > > +			_notrun "need fio >= $req_ver (found $fio_ver)"
> > > > > +		;;
> > > > > +	*-)
> > > > > +		req_ver=${req_ver%-}
> > > > > +		test $(_math "$fio_ver <= $req_ver") -eq 1 || \
> > > > > +			_notrun "need fio <= $req_ver (found $fio_ver)"
> > > > > +		;;
> > > > > +	*)
> > > > > +		req_ver=${req_ver%-}
> > > > > +		test $(_math "$fio_ver == $req_ver") -eq 1 || \
> > > > > +			_notrun "need fio = $req_ver (found $fio_ver)"
> > > > > +		;;
> > > > > +	esac
> > > > > +}
> > > > > +
> > > > >  ################################################################################
> > > > >  # make sure this script returns success
> > > > >  /bin/true
> > > > > -- 
> > > > > 2.49.0
> > > > > 
> > > > 
> > > 
> 


