Return-Path: <linux-ext4+bounces-12121-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED21C99FCF
	for <lists+linux-ext4@lfdr.de>; Tue, 02 Dec 2025 05:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4593C3A2FB9
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Dec 2025 04:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A468A2F5461;
	Tue,  2 Dec 2025 04:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AyOZel7Y";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qV2aJjWt"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1092F5313
	for <linux-ext4@vger.kernel.org>; Tue,  2 Dec 2025 04:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764649034; cv=none; b=c4ERiPhPdg1g9+JsGo0xd5jHi7AWm1lhNDqLjRx5FjS64rOZhCr1gVhCv0x6KNYW/DaBcecbP7SDhazKrnxJ2lYWmfLfIabBY8Au80l0zC1dlBiPzOSl7yfbb5bEvXWtSW4+XQ0jzNzVENYHwygV0XC5iQ6tKP0vXKFom7X3glI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764649034; c=relaxed/simple;
	bh=ah5nYOP6c9lSuKDe49RQ5yuYYM+3psF1VX0FA8BUvSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CrrH8w45N8BL/Uet0rl935u0eJkstMUfZgGpDgLpez6CBNXDF4kJchdSg0uS/Hx6ggdPUNgHx0ojt2Mrdq6rctySxwWoP5Dfz8g1Esmf9s7MftIDC5UEI4goYSSsKFpp6pArWGXr26UXi0nLGQHl9UlXD1pKP5f5aaqpWvyb2fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AyOZel7Y; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qV2aJjWt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764649030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FOVhVPby26S7Sm2GODw1N28S+VVsoHvVcOsIsxdA41Q=;
	b=AyOZel7YFTie4yKCTtv4fc/qjoeR3gCiNI4YpLg6jdP7izcq52RoBwJ49V7VCYB826m5ph
	aM84ZtVM9gr0I56Yul7pjInsD6Liw2bOJiJfrl8KE6cuYms8ZaEHck0WibG3068A2Yubge
	s97R/GPP9ZpOfU/dOaVSYrOcXMD5KN4=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-OwnDaty1MQOYmjO305h9eg-1; Mon, 01 Dec 2025 23:17:08 -0500
X-MC-Unique: OwnDaty1MQOYmjO305h9eg-1
X-Mimecast-MFC-AGG-ID: OwnDaty1MQOYmjO305h9eg_1764649028
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-343fb64cea6so8963359a91.3
        for <linux-ext4@vger.kernel.org>; Mon, 01 Dec 2025 20:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764649028; x=1765253828; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FOVhVPby26S7Sm2GODw1N28S+VVsoHvVcOsIsxdA41Q=;
        b=qV2aJjWtikSKBZypQzcb74LxQjr6QE62pM+8xNFUEMYdMBQzHJuqLhnDRRB9QbQhxS
         VpudV2JQogUOCSvbVAg1vFOy8imSOLQfA56V/u9a5a5EhhnBzbO7RBIPmkHg/FzwG9wT
         dCZ/MXZzQpbwqUC5EKqrziG5ZSupj4trdf+4xrzEzdbjh0runA0Xlo7hz+gdWBDmPK+D
         S7PE7jjPnA19/wu4uOROaadDS7+pJEUEuSLTT3D6ZfVL+2+27fVUF2q3DulOPbmrg4Xn
         ilNWijINb3wh174Ie3F69w4Fgd65bPQ7M+B9LxuS/dfD0i9WMK8PN/ImgjWsOh+NH5cM
         LRVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764649028; x=1765253828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FOVhVPby26S7Sm2GODw1N28S+VVsoHvVcOsIsxdA41Q=;
        b=FTjBqczQFAq9UlkSTdzEiFhyJnvHtvqDQp7OZIckg4DDHUxMdbIv+Uy7qhngW/RZBo
         go0Z63xbX37nPZAmRXwIdadqjl+6is+0Qn8bXTBseogVpfZ+rCDPwsxrpTDQjYbyWnJy
         9lcp0r8JmVFommNeewWOUio8kzd0jyoAt7mWt4/hbSvdRnZrb0ylJjfKiLBj7BE2AHRO
         We3ANkLvKzDX/ndTPhp2QFBdhQ209jbABY4TCPOjky2qP66scSY/vRU8MhuyG4bw96hd
         9zstDtpoNytl9wQ1FY0RODK+nXKS3OJ4kc0sUMtMnJd5veNZ1G6zwNZ61DwQk/ydVDlD
         VrXA==
X-Forwarded-Encrypted: i=1; AJvYcCXIT/KGtsH9Io9mHHI2YggWP+xoREUuHkhm4VWG01bfl2QFcBk4qjAqXkVBa7l82OUkmkxH+W/6BcFy@vger.kernel.org
X-Gm-Message-State: AOJu0YxXISbdpbgD/UKR3mFOcS+g4EgF1keye68gjDqk0QLxjo4R1gyi
	lcl26SPh3l+JI/Kp0xEnNOvQFCQK54zKG525AS2UefsP4RESMy0WRjsu84rSaQy76OeYSWLpoo/
	PicM/Y2MtnLAgiOLsZZOIkXWY1H9Xtd4SqCGi8T7HaBNlXpDR9WtCz430NKqBhyk=
X-Gm-Gg: ASbGncvvs6DSGKIrd5C9dtHd2GfLEiPaiX6OR2kf6so5yJy8A+cq99LtCnXOzM1eylz
	jcMcyDxaYSJGi7Wzesi3uzAHgXnjFV/ZeetJH5owyCxE+ucGrg7oUFZlxLaArRcGGIVmogj/6By
	QxhOC7ASgaBA/FaZg8r5Pw+yg8T4899HeHNHh9jUBuwE9eYtJ9LwXoLY66bfWCognfeN9b/M5/A
	Z8hibdVJn3nLSqnhWAEeA1fNSS0YJ7R3+DyelO1B/GARd3fbXQhf197OlwTUtAxWD+bzf8Ma8S5
	WNgV9JtHENve41rZvzQhtc+it4Q03+1bxlsFYniqaYZ8czf0ymFupyIoaVgxtPJwO9SaHTTrGjm
	EL0c4cBvMF+DS6SKpilaQJMn+ay3GyCgtMWFkZwH+9nEkoAOPdQ==
X-Received: by 2002:a17:90b:1c91:b0:32b:df0e:9283 with SMTP id 98e67ed59e1d1-34733f3e84fmr36685147a91.34.1764649027560;
        Mon, 01 Dec 2025 20:17:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEar7S2w5DviYqZgaxduHjgAYE/sRtZ6cpfS/3FDaT23TH2FRg4PWLmyOMfqyTzuB9g1zt2ZQ==
X-Received: by 2002:a17:90b:1c91:b0:32b:df0e:9283 with SMTP id 98e67ed59e1d1-34733f3e84fmr36685112a91.34.1764649026925;
        Mon, 01 Dec 2025 20:17:06 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3477b1cbdc0sm14643857a91.2.2025.12.01.20.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 20:17:06 -0800 (PST)
Date: Tue, 2 Dec 2025 12:17:01 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Su Yue <glass.su@suse.com>, fstests@vger.kernel.org, l@damenly.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] generic: use _qmount_option and _qmount
Message-ID: <20251202041701.cb2yzns2ytddt7dh@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20251124132004.23965-1-glass.su@suse.com>
 <20251201225924.GA89454@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201225924.GA89454@frogsfrogsfrogs>

On Mon, Dec 01, 2025 at 02:59:24PM -0800, Darrick J. Wong wrote:
> On Mon, Nov 24, 2025 at 09:20:04PM +0800, Su Yue wrote:
> > Many generic tests call `_scratch_mount -o usrquota` then
> > chmod 777, quotacheck and quotaon.
> 
> What does the chmod 777 do, in relation to the quota{check,on} programs?
> Is it necessary for the root dir to be world writable (and executable!)
> for quota tools to work?

Hi Darrick,

The _qmount always does "chmod ugo+rwx $SCRATCH_MNT", I think it's for regular
users (e.g. fsgqa) can write into $SCRATCH_MNT. If a test case doesn't use
regular user, the "chmod 777" isn't necessary. The author of _qmount might
think "chmod 777 $SCRATCH_MN" doesn't hurt anything quota test, so always
does that no matter if it's needed. If you think it hurts something, we can
only do that for the cases who really need that :)

I think this patch trys to help quota test cases to use unified common helpers,
most of them don't need the "chmod 777" actually, right Su?

Thanks,
Zorro

> 
> > It can be simpilfied to _qmount_option and _qmount. The later
> > function already calls quotacheck, quota and chmod.
> > 
> > Convertaions can save a few lines. tests/generic/380 is an exception
> 
> "Conversions" ?
> 
> --D
> 
> > because it tests chown.
> > 
> > Signed-off-by: Su Yue <glass.su@suse.com>
> > ---
> >  tests/generic/082 |  9 ++-------
> >  tests/generic/219 | 11 ++++-------
> >  tests/generic/230 | 11 ++++++-----
> >  tests/generic/231 |  6 ++----
> >  tests/generic/232 |  6 ++----
> >  tests/generic/233 |  6 ++----
> >  tests/generic/234 |  5 ++---
> >  tests/generic/235 |  5 ++---
> >  tests/generic/244 |  1 -
> >  tests/generic/270 |  6 ++----
> >  tests/generic/280 |  5 ++---
> >  tests/generic/400 |  2 +-
> >  12 files changed, 27 insertions(+), 46 deletions(-)
> > 
> > diff --git a/tests/generic/082 b/tests/generic/082
> > index f078ef2ffff9..6bb9cf2a22ae 100755
> > --- a/tests/generic/082
> > +++ b/tests/generic/082
> > @@ -23,13 +23,8 @@ _require_scratch
> >  _require_quota
> >  
> >  _scratch_mkfs >>$seqres.full 2>&1
> > -_scratch_mount "-o usrquota,grpquota"
> > -
> > -# xfs doesn't need these setups and quotacheck even fails on xfs, so just
> > -# redirect the output to $seqres.full for debug purpose and ignore the results,
> > -# as we check the quota status later anyway.
> > -quotacheck -ug $SCRATCH_MNT >>$seqres.full 2>&1
> > -quotaon $SCRATCH_MNT >>$seqres.full 2>&1
> > +_qmount_option 'usrquota,grpquota'
> > +_qmount "usrquota,grpquota"
> >  
> >  # first remount ro with a bad option, a failed remount ro should not disable
> >  # quota, but currently xfs doesn't fail in this case, the unknown option is
> > diff --git a/tests/generic/219 b/tests/generic/219
> > index 642823859886..a2eb0b20f408 100755
> > --- a/tests/generic/219
> > +++ b/tests/generic/219
> > @@ -91,25 +91,22 @@ test_accounting()
> >  
> >  _scratch_unmount 2>/dev/null
> >  _scratch_mkfs >> $seqres.full 2>&1
> > -_scratch_mount "-o usrquota,grpquota"
> > +_qmount_option "usrquota,grpquota"
> > +_qmount
> >  _force_vfs_quota_testing $SCRATCH_MNT
> > -quotacheck -u -g $SCRATCH_MNT 2>/dev/null
> > -quotaon $SCRATCH_MNT 2>/dev/null
> >  _scratch_unmount
> >  
> >  echo; echo "### test user accounting"
> > -export MOUNT_OPTIONS="-o usrquota"
> > +_qmount_option "usrquota"
> >  _qmount
> > -quotaon $SCRATCH_MNT 2>/dev/null
> >  type=u
> >  test_files
> >  test_accounting
> >  _scratch_unmount 2>/dev/null
> >  
> >  echo; echo "### test group accounting"
> > -export MOUNT_OPTIONS="-o grpquota"
> > +_qmount_option "grpquota"
> >  _qmount
> > -quotaon $SCRATCH_MNT 2>/dev/null
> >  type=g
> >  test_files
> >  test_accounting
> > diff --git a/tests/generic/230 b/tests/generic/230
> > index a8caf5a808c3..0a680dbc874b 100755
> > --- a/tests/generic/230
> > +++ b/tests/generic/230
> > @@ -99,7 +99,8 @@ grace=2
> >  _qmount_option 'defaults'
> >  
> >  _scratch_mkfs >> $seqres.full 2>&1
> > -_scratch_mount "-o usrquota,grpquota"
> > +_qmount_option "usrquota,grpquota"
> > +_qmount
> >  _force_vfs_quota_testing $SCRATCH_MNT
> >  BLOCK_SIZE=$(_get_file_block_size $SCRATCH_MNT)
> >  quotacheck -u -g $SCRATCH_MNT 2>/dev/null
> > @@ -113,8 +114,8 @@ setquota -g -t $grace $grace $SCRATCH_MNT
> >  _scratch_unmount
> >  
> >  echo; echo "### test user limit enforcement"
> > -_scratch_mount "-o usrquota"
> > -quotaon $SCRATCH_MNT 2>/dev/null
> > +_qmount_option "usrquota"
> > +_qmount
> >  type=u
> >  test_files
> >  test_enforcement
> > @@ -122,8 +123,8 @@ cleanup_files
> >  _scratch_unmount 2>/dev/null
> >  
> >  echo; echo "### test group limit enforcement"
> > -_scratch_mount "-o grpquota"
> > -quotaon $SCRATCH_MNT 2>/dev/null
> > +_qmount_option "grpquota"
> > +_qmount
> >  type=g
> >  test_files
> >  test_enforcement
> > diff --git a/tests/generic/231 b/tests/generic/231
> > index ce7e62ea1886..02910523d0b5 100755
> > --- a/tests/generic/231
> > +++ b/tests/generic/231
> > @@ -47,10 +47,8 @@ _require_quota
> >  _require_user
> >  
> >  _scratch_mkfs >> $seqres.full 2>&1
> > -_scratch_mount "-o usrquota,grpquota"
> > -chmod 777 $SCRATCH_MNT
> > -quotacheck -u -g $SCRATCH_MNT 2>/dev/null
> > -quotaon -u -g $SCRATCH_MNT 2>/dev/null
> > +_qmount_option "usrquota,grpquota"
> > +_qmount
> >  
> >  if ! _fsx 1; then
> >  	_scratch_unmount 2>/dev/null
> > diff --git a/tests/generic/232 b/tests/generic/232
> > index c903a5619045..21375809d299 100755
> > --- a/tests/generic/232
> > +++ b/tests/generic/232
> > @@ -44,10 +44,8 @@ _require_scratch
> >  _require_quota
> >  
> >  _scratch_mkfs > $seqres.full 2>&1
> > -_scratch_mount "-o usrquota,grpquota"
> > -chmod 777 $SCRATCH_MNT
> > -quotacheck -u -g $SCRATCH_MNT 2>/dev/null
> > -quotaon -u -g $SCRATCH_MNT 2>/dev/null
> > +_qmount_option "usrquota,grpquota"
> > +_qmount
> >  
> >  _fsstress
> >  _check_quota_usage
> > diff --git a/tests/generic/233 b/tests/generic/233
> > index 3fc1b63abb24..4606f3bde2ab 100755
> > --- a/tests/generic/233
> > +++ b/tests/generic/233
> > @@ -59,10 +59,8 @@ _require_quota
> >  _require_user
> >  
> >  _scratch_mkfs > $seqres.full 2>&1
> > -_scratch_mount "-o usrquota,grpquota"
> > -chmod 777 $SCRATCH_MNT
> > -quotacheck -u -g $SCRATCH_MNT 2>/dev/null
> > -quotaon -u -g $SCRATCH_MNT 2>/dev/null
> > +_qmount_option "usrquota,grpquota"
> > +_qmount
> >  setquota -u $qa_user 32000 32000 1000 1000 $SCRATCH_MNT 2>/dev/null
> >  
> >  _fsstress
> > diff --git a/tests/generic/234 b/tests/generic/234
> > index 4b25fc6507cc..2c596492a3e0 100755
> > --- a/tests/generic/234
> > +++ b/tests/generic/234
> > @@ -66,9 +66,8 @@ _require_quota
> >  
> >  
> >  _scratch_mkfs >> $seqres.full 2>&1
> > -_scratch_mount "-o usrquota,grpquota"
> > -quotacheck -u -g $SCRATCH_MNT 2>/dev/null
> > -quotaon -u -g $SCRATCH_MNT 2>/dev/null
> > +_qmount_option "usrquota,grpquota"
> > +_qmount
> >  test_setting
> >  _scratch_unmount
> >  
> > diff --git a/tests/generic/235 b/tests/generic/235
> > index 037c29e806db..7a616650fc8f 100755
> > --- a/tests/generic/235
> > +++ b/tests/generic/235
> > @@ -25,9 +25,8 @@ do_repquota()
> >  
> >  
> >  _scratch_mkfs >> $seqres.full 2>&1
> > -_scratch_mount "-o usrquota,grpquota"
> > -quotacheck -u -g $SCRATCH_MNT 2>/dev/null
> > -quotaon $SCRATCH_MNT 2>/dev/null
> > +_qmount_option "usrquota,grpquota"
> > +_qmount
> >  
> >  touch $SCRATCH_MNT/testfile
> >  chown $qa_user:$qa_user $SCRATCH_MNT/testfile
> > diff --git a/tests/generic/244 b/tests/generic/244
> > index b68035129c82..989bb4f5385e 100755
> > --- a/tests/generic/244
> > +++ b/tests/generic/244
> > @@ -66,7 +66,6 @@ done
> >  # remount just for kicks, make sure we get it off disk
> >  _scratch_unmount
> >  _qmount
> > -quotaon $SCRATCH_MNT 2>/dev/null
> >  
> >  # Read them back by iterating based on quotas returned.
> >  # This should match what we set, even if we don't directly
> > diff --git a/tests/generic/270 b/tests/generic/270
> > index c3d5127a0b51..9ac829a7379f 100755
> > --- a/tests/generic/270
> > +++ b/tests/generic/270
> > @@ -62,10 +62,8 @@ _require_command "$SETCAP_PROG" setcap
> >  _require_attrs security
> >  
> >  _scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full 2>&1
> > -_scratch_mount "-o usrquota,grpquota"
> > -chmod 777 $SCRATCH_MNT
> > -quotacheck -u -g $SCRATCH_MNT 2>/dev/null
> > -quotaon -u -g $SCRATCH_MNT 2>/dev/null
> > +_qmount_option "usrquota,grpquota"
> > +_qmount
> >  
> >  if ! _workout; then
> >  	_scratch_unmount 2>/dev/null
> > diff --git a/tests/generic/280 b/tests/generic/280
> > index 3108fd23fb70..fae0a02145cf 100755
> > --- a/tests/generic/280
> > +++ b/tests/generic/280
> > @@ -34,9 +34,8 @@ _require_freeze
> >  
> >  _scratch_unmount 2>/dev/null
> >  _scratch_mkfs >> $seqres.full 2>&1
> > -_scratch_mount "-o usrquota,grpquota"
> > -quotacheck -u -g $SCRATCH_MNT 2>/dev/null
> > -quotaon $SCRATCH_MNT 2>/dev/null
> > +_qmount_option "usrquota,grpquota"
> > +_qmount
> >  xfs_freeze -f $SCRATCH_MNT
> >  setquota -u root 1 2 3 4 $SCRATCH_MNT &
> >  pid=$!
> > diff --git a/tests/generic/400 b/tests/generic/400
> > index 77970da69a41..ef27c254167c 100755
> > --- a/tests/generic/400
> > +++ b/tests/generic/400
> > @@ -22,7 +22,7 @@ _require_scratch
> >  
> >  _scratch_mkfs >> $seqres.full 2>&1
> >  
> > -MOUNT_OPTIONS="-o usrquota,grpquota"
> > +_qmount_option "usrquota,grpquota"
> >  _qmount
> >  _require_getnextquota
> >  
> > -- 
> > 2.48.1
> > 
> > 
> 


