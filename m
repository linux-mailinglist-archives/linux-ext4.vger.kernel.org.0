Return-Path: <linux-ext4+bounces-6058-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 964C3A0B7CD
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Jan 2025 14:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D064F3A5E43
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Jan 2025 13:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1ABE23499F;
	Mon, 13 Jan 2025 13:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dsec2V4Q"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50FB234962
	for <linux-ext4@vger.kernel.org>; Mon, 13 Jan 2025 13:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736773876; cv=none; b=n5k2s0cLGNTHLkyeJw/isC+DdN3kUS707MFrZDkVD3ieWRg2YgkIoH/v6JIkxy2uhC22x5FrujraQr6ORxgUk1WG0dwT/Y7/0DER0A/fryUFqb4slyBQZAsLwAUKLEB5ScYj0/rv82ninA0S1lLjkWmehmYCVQyFopmXIK/bsbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736773876; c=relaxed/simple;
	bh=ohJF4MOn0aRK7flWN/MCpqehYbVM3qklDIp9OG7mMc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIB1U3SQ/uXZ56iFSmZjbpW3TJ6QnV54P3bLWxUtCf2kUx8kHT5uH45bXsnjWpJ5EZeC/JiXyzah26uqLznJKnakw5upqez1GNc8+K2tgiFfPoZeo6bJscfY9GtCliXpPlFj0+y3aGx/ltjau/UeFRdn8pQq2/mVxPNvOb1oSO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dsec2V4Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736773873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FadNKLb2hmiuT2xe3JqSrPIXf7EYR5ffKD3vg2tvAY0=;
	b=Dsec2V4QSRD5z2FJQYb8SAC/cL8dByQTbmiHC2NZQRot+WMk+tMknSg14PQey/+8zTUJCY
	v/v568T5Rv5SMZt44eTxBazKdF632hn+bAfYvS/EMmAO6eTfo2y0SnKD/nOKf0Y3zmeoXN
	UItSlunxY0npd4Sl3CwI67uXSBh3ihc=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-rExzyuCDO1uygveLNj2Yvg-1; Mon, 13 Jan 2025 08:11:11 -0500
X-MC-Unique: rExzyuCDO1uygveLNj2Yvg-1
X-Mimecast-MFC-AGG-ID: rExzyuCDO1uygveLNj2Yvg
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ef6ef9ba3fso7526042a91.2
        for <linux-ext4@vger.kernel.org>; Mon, 13 Jan 2025 05:11:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736773868; x=1737378668;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FadNKLb2hmiuT2xe3JqSrPIXf7EYR5ffKD3vg2tvAY0=;
        b=pqi+c5b/gO5ABwPbU4YZO7zoz7D3AxHuced8LhyShWOPhREzggERpYa6CxiV+M+zeY
         gZUatsEfjIYVmskfzSiPYxNAKIzL6zX++UxCh8iFlWmaMyTs+7IEGfqdIAJDs9cgFKIc
         feJwsjcmsxLdXwAuCkUwU5on9U5P3cAuDCI6V9gnkKX0iaIdWS1fNkhSwHfUX9F8GzEy
         VtugldqTeA2JOaKETCTAecPSWKIDFwU8xD72m2YAqWLhN7iieHNO9gxs5JNOqjnAH+WD
         fkPnqKMJlaThYeZQ694O341zXZfnXDjTcJ7CF+NLFF4Cgl8bpovDKKd7spYThy5BTtNo
         rYAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXydPjwMGE+iclek1pXRfa/QD1p6sOCu0Zpu4q7cHO5QTgDX3XloccYP5IZerWF4V+8QdQGlJ7iJexz@vger.kernel.org
X-Gm-Message-State: AOJu0YzI/vzphX49z5BmOj58vgsN5l/Xc3+sl3uIsKCaY6QWj8g/nq9H
	TN7kWlnxNPi2XEulpzr1o4RtKp/F3oABAqZf7cQxZLK+qEHnwyD+89deJGzz2rmggtknk26m57Q
	ciX5bhwGbAlCt/iQ6xzs6RuLiodYhNRZPF8opesisDKFnEhMskh8KQrdsNe8=
X-Gm-Gg: ASbGncusdz+LuVzIlb0hIbG06wCRBsOoAdd9lVXzZ8ziK9vvNqN2yFSsR+e17wZxm5x
	Tov4xWVzxeTC/+NH4Lf7zEm7mjdT7m+PInOWu8+L5adF96fTVqiuiD6aEEgiHI0Xe0alFiE8Ze2
	3rSaA7Z6EgSQEQciNEazYOMp6yaWLRxctE6/XOMP9fs5sNJcfjBxes97Wi6e/hmYS3GSM34CLqw
	nQIwEYl1j4A9zqQPHSMIsQQ7FfrinkSpNW3XEMX9tkv38ILffFbyfLdNVxozbWv8sDn+SKO9MqM
	RYR1mFU7SDEcUtQsY3wNpQ==
X-Received: by 2002:a05:6a00:4ac6:b0:727:3cd0:1167 with SMTP id d2e1a72fcca58-72d21fea50emr29848202b3a.21.1736773868493;
        Mon, 13 Jan 2025 05:11:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEj0/2mbkwh5VkIBnE0+6ZYp96/BRcW6F6brwGkZMp1FqGOz+ypA2ZQPuOcXrqxY7jE6rIXig==
X-Received: by 2002:a05:6a00:4ac6:b0:727:3cd0:1167 with SMTP id d2e1a72fcca58-72d21fea50emr29848171b3a.21.1736773868036;
        Mon, 13 Jan 2025 05:11:08 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d40549322sm5777910b3a.8.2025.01.13.05.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 05:11:07 -0800 (PST)
Date: Mon, 13 Jan 2025 21:11:03 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
	ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org
Subject: Re: [PATCH] check: Fix fs specfic imports when $FSTYPE!=$OLD_FSTYPE
Message-ID: <20250113131103.tb25jtgkepw4xreo@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <f49a72d9ee4cfb621c7f3516dc388b4c80457115.1736695253.git.nirjhar.roy.lists@gmail.com>
 <20250113055901.u5e5ghzi3t45hdha@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <4afe80a4-ac6b-4796-b466-c42a95f7225a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4afe80a4-ac6b-4796-b466-c42a95f7225a@gmail.com>

On Mon, Jan 13, 2025 at 02:22:20PM +0530, Nirjhar Roy (IBM) wrote:
> 
> On 1/13/25 11:29, Zorro Lang wrote:
> > On Sun, Jan 12, 2025 at 03:21:51PM +0000, Nirjhar Roy (IBM) wrote:
> > > Bug Description:
> > > 
> > > _test_mount function is failing with the following error:
> > > ./common/rc: line 4716: _xfs_prepare_for_eio_shutdown: command not found
> > > check: failed to mount /dev/loop0 on /mnt1/test
> > > 
> > > when the second section in local.config file is xfs and the first section
> > > is non-xfs.
> > > 
> > > It can be easily reproduced with the following local.config file
> > > 
> > > [s2]
> > > export FSTYP=ext4
> > > export TEST_DEV=/dev/loop0
> > > export TEST_DIR=/mnt1/test
> > > export SCRATCH_DEV=/dev/loop1
> > > export SCRATCH_MNT=/mnt1/scratch
> > > 
> > > [s1]
> > > export FSTYP=xfs
> > > export TEST_DEV=/dev/loop0
> > > export TEST_DIR=/mnt1/test
> > > export SCRATCH_DEV=/dev/loop1
> > > export SCRATCH_MNT=/mnt1/scratch
> > > 
> > > ./check selftest/001
> > > 
> > > Root cause:
> > > When _test_mount() is executed for the second section, the FSTYPE has
> > > already changed but the new fs specific common/$FSTYP has not yet
> > > been done. Hence _xfs_prepare_for_eio_shutdown() is not found and
> > > the test run fails.
> > > 
> > > Fix:
> > > call _source_specific_fs $FSTYP at the correct call site of  _test_mount()
> > > 
> > > Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> > > ---
> > >   check | 1 +
> > >   1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/check b/check
> > > index 607d2456..8cdbb68f 100755
> > > --- a/check
> > > +++ b/check
> > > @@ -776,6 +776,7 @@ function run_section()
> > >   	if $RECREATE_TEST_DEV || [ "$OLD_FSTYP" != "$FSTYP" ]; then
> > >   		echo "RECREATING    -- $FSTYP on $TEST_DEV"
> > >   		_test_unmount 2> /dev/null
> > > +		[[ "$OLD_FSTYP" != "$FSTYP" ]] && _source_specific_fs $FSTYP
> > The _source_specific_fs is called when importing common/rc file:
> > 
> >    # check for correct setup and source the $FSTYP specific functions now
> >    _source_specific_fs $FSTYP
> > 
> >  From the code logic of check script:
> > 
> >          if $RECREATE_TEST_DEV || [ "$OLD_FSTYP" != "$FSTYP" ]; then
> >                  echo "RECREATING    -- $FSTYP on $TEST_DEV"
> >                  _test_unmount 2> /dev/null
> >                  if ! _test_mkfs >$tmp.err 2>&1
> >                  then
> >                          echo "our local _test_mkfs routine ..."
> >                          cat $tmp.err
> >                          echo "check: failed to mkfs \$TEST_DEV using specified options"
> >                          status=1
> >                          exit
> >                  fi
> >                  if ! _test_mount
> >                  then
> >                          echo "check: failed to mount $TEST_DEV on $TEST_DIR"
> >                          status=1
> >                          exit
> >                  fi
> >                  # TEST_DEV has been recreated, previous FSTYP derived from
> >                  # TEST_DEV could be changed, source common/rc again with
> >                  # correct FSTYP to get FSTYP specific configs, e.g. common/xfs
> >                  . common/rc
> >                  ^^^^^^^^^^^
> > we import common/rc at here.
> > 
> > So I'm wondering if we can move this line upward, to fix the problem you
> > hit (and don't bring in regression :) Does that help?
> > 
> > Thanks,
> > Zorro
> 
> Okay so we can move ". common/rc" upward and then remove the following from
> "check" file:
> 
>         if ! _test_mount
>         then
>             echo "check: failed to mount $TEST_DEV on $TEST_DIR"
>             status=1
>             exit
>         fi
> 
> since . common/rc will call init_rc() in the end, which does a
> _test_mount(). Do you agree with this (Zorro and Ritesh)?
> 
> I can make the changes and send a v2?

Hmm... the _init_rc doesn't do _test_mkfs, so you might need to do
". common/rc" after "_test_mkfs", rather than "_test_unmount".

By checking the _init_rc, I think it can replace the _test_mount you metioned
above. Some details might need more testing, to make sure we didn't miss
anything wrong:)

Any review points from others?

Thanks,
Zorro

> 
> --NR
> 
> > 
> > 
> > >   		if ! _test_mkfs >$tmp.err 2>&1
> > >   		then
> > >   			echo "our local _test_mkfs routine ..."
> > > -- 
> > > 2.34.1
> > > 
> > > 
> -- 
> Nirjhar Roy
> Linux Kernel Developer
> IBM, Bangalore
> 


