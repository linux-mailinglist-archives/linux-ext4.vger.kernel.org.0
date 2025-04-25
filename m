Return-Path: <linux-ext4+bounces-7492-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E1FA9C7A2
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Apr 2025 13:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67F489A5235
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Apr 2025 11:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E022459D9;
	Fri, 25 Apr 2025 11:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fc3XbYEq"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EB82459D1
	for <linux-ext4@vger.kernel.org>; Fri, 25 Apr 2025 11:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745580476; cv=none; b=UZMkkYZMuD6ck+DVsySksddY2IGrvHGwj0QHYRelqM5hScIEb3TMMP7mBV7jqlv2k+nQqFCuwf8XZJO2OZ7Eu3Ioret7nF9UWzKgRKUCQip87CAXrsgYpw0ebnfcnTYvncJRf4UnegNiRO+VmIm8aTj78cG4IVMoAve1TnJUlkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745580476; c=relaxed/simple;
	bh=i5Z+Lgt1EtCl9VHgJ6j1ptib2pceIv4cpi1Hcvb9NwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZquQet2VLGbxvbg65UNY9DDmqbkbdTrelcT+VJu31C63n5O51JJCAw3s6E3BfmhbiMxslpFusppzJYVFpsUaVpGVVpgkEZII7j0qn/8wUCcyM/CnJtZTOCMnRC8MjTTKm/NbIIzPWHhnf53OJ+Nsg96661/WBaGEBiD2mYbcTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fc3XbYEq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745580473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XPQIDfg7C6O1v8/d8MzIb298k2Hd1bakTq6r3C3OXZk=;
	b=Fc3XbYEqj14eHuCJ8Sb5wNWmdCTOC1r0NG6xqlhnQGDS67yAroE3ZBgRFqV1fhUP5AYO0a
	pL4qXwRZ+ncA6PDwMWhfSEK84/Uo0x784shtxVyj8hrd24Y6q2Nm4vot2DUK86MZffcyWB
	8FoVtxtmDI36fvXYEy4rN8P35zhBi2g=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-bstoMRTLPS6o5kfC-agT8w-1; Fri, 25 Apr 2025 07:27:52 -0400
X-MC-Unique: bstoMRTLPS6o5kfC-agT8w-1
X-Mimecast-MFC-AGG-ID: bstoMRTLPS6o5kfC-agT8w_1745580471
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-227ea16b03dso33373615ad.3
        for <linux-ext4@vger.kernel.org>; Fri, 25 Apr 2025 04:27:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745580471; x=1746185271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XPQIDfg7C6O1v8/d8MzIb298k2Hd1bakTq6r3C3OXZk=;
        b=w+9+j026Dp2lUkviktHg7gBv6Jat/vEzjOMpb4Pxc8IVGWB2DCF2fvvp5lsvWeq2u2
         RE0bt6idZ4V7qWoOHE0M3eXZkUhAOzIrf9floqLeafMD2/FaNa3nlA8OtIP9mNXNDl+w
         pzSn6KIzPKzVkij6kisao+CtQWQtOKnXTtYDOX7TYCEJ2TAUAI0xASUeI79PQZE7vaEQ
         wNxk8I5bR1gaw8ZoYZjepu9BriFcKJ1uEJmVCB+xQS+7Dbk8tkx48iPGf2sOcoGMeh0+
         fHUQlOt00OiunRxTrP8XqHM/uA7R+NzhcEnvIRIDXUKtR0DplrYb7rkbYSTN1ZMUWJIz
         VVNw==
X-Forwarded-Encrypted: i=1; AJvYcCWW+YHlncEPwHdD6TDYGVkpKV3CkCOoWgol+SiHJWk/oAEsIaoAwz8cUXukaPwj3skAuKsbxqjHhGd1@vger.kernel.org
X-Gm-Message-State: AOJu0YxUzuuwQC4YvDlGuRDOg9AUWGb7m4TKnsrG0eYZz8r8iNd65Lpa
	JOgCaIb7/+CN96+/DmA4oY5CAYR1s+DGCq1M1zjyPELGk8dRSSNFKlFn44b/TQb4pwGb2cXNriX
	j76bSyX1p4Rmf6yIpJvaJWw5/Pwx9vuj8Q0+KH/8VK3d05YW3iqmHvPP57Ho=
X-Gm-Gg: ASbGncvLnAvm4xDbzCXp8ebnNX0EjjBTkbUAldPSrTw7cqYROo8uTElzNfZ2LmhZ29w
	51ts3g7olBeyWVTSFE970oOr9x+cBQ22NivPaNu+BnVXOIJaqCLlqg7yXNoWW5Xh3DhmPhi/ppo
	GFTAUF8p/eC57IYyCYmhiDgsec3BvHZH1XA4kaVdUu5k1hNIMEOSVPEGjQP25MU4GXOLQjaSjCW
	nUmNeET9IdhQartYjTyqoe0udLBHxgAGlj7KuzNu56UwMo6iK3nrIJzc05y/AwWdgrYaYwO1WOd
	stATxmSlrIOPcUVh5qFsmtJfa7klzyWNmfsJ7xIdlSCCdlsm8JjD
X-Received: by 2002:a17:903:3bcb:b0:22c:36d1:7a49 with SMTP id d9443c01a7336-22dbf742db5mr35128235ad.53.1745580471236;
        Fri, 25 Apr 2025 04:27:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwa8yD8eyCINBxOeRT1//BwZSAK6zkP857DMUhERB9O9vU028ZHcG+2dFDnEfzrJ3ix00EIA==
X-Received: by 2002:a17:903:3bcb:b0:22c:36d1:7a49 with SMTP id d9443c01a7336-22dbf742db5mr35127795ad.53.1745580470793;
        Fri, 25 Apr 2025 04:27:50 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db50e7a1dsm29777615ad.140.2025.04.25.04.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 04:27:50 -0700 (PDT)
Date: Fri, 25 Apr 2025 19:27:45 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
	ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org,
	david@fromorbit.com
Subject: Re: [PATCH v1 1/2] common: Move exit related functions to a
 common/exit
Message-ID: <20250425112745.aaamjdvhqtlx7vpd@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1745390030.git.nirjhar.roy.lists@gmail.com>
 <d0b7939a277e8a16566f04e449e9a1f97da28b9d.1745390030.git.nirjhar.roy.lists@gmail.com>
 <20250423141808.2qdmacsyxu3rtrwh@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <054fa772-360e-4f90-bc4d-ea7ef954d5a2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <054fa772-360e-4f90-bc4d-ea7ef954d5a2@gmail.com>

On Thu, Apr 24, 2025 at 02:39:39PM +0530, Nirjhar Roy (IBM) wrote:
> 
> On 4/23/25 19:48, Zorro Lang wrote:
> > On Wed, Apr 23, 2025 at 06:41:34AM +0000, Nirjhar Roy (IBM) wrote:
> > > Introduce a new file common/exit that will contain all the exit
> > > related functions. This will remove the dependencies these functions
> > > have on other non-related helper files and they can be indepedently
> > > sourced. This was suggested by Dave Chinner[1].
> > > 
> > > [1] https://lore.kernel.org/linux-xfs/Z_UJ7XcpmtkPRhTr@dread.disaster.area/
> > > Suggested-by: Dave Chinner <david@fromorbit.com>
> > > Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> > > ---
> > >   check           |  1 +
> > >   common/btrfs    |  2 +-
> > >   common/ceph     |  2 ++
> > >   common/config   | 17 +----------------
> > >   common/dump     |  1 +
> > >   common/exit     | 50 +++++++++++++++++++++++++++++++++++++++++++++++++
> > >   common/ext4     |  2 +-
> > >   common/populate |  2 +-
> > >   common/preamble |  1 +
> > >   common/punch    |  6 +-----
> > >   common/rc       | 29 +---------------------------
> > >   common/repair   |  1 +
> > >   common/xfs      |  1 +
> > I think if you define exit helpers in common/exit, and import common/exit
> > in common/config, then you don't need to source it(common/exit) in other
> > common files (.e.g common/xfs, common/rc, etc). Due to when we call the
> > helpers in these common files, the process should already imported
> > common/rc -> common/config -> common/exit. right?
> 
> Oh, right. I can remove the redundant imports from
> common/{btrfs,ceph,dump,ext4,populate,preamble,punch,rc,repair,xfs} in v2. I
> will keep ". common/exit" only in common/config and check. The reason for me
> to keep it in check is that before common/rc is sourced in check, we might
> need _exit() (which is present is common/exit). Do you agree?

I thought "check" might not need that either. I didn't give it a test, but I found
before importing common/rc, there're only command arguments initialization, and
"check" calls "exit" directly if the initialization fails (except you want to call
_exit, but I didn't see you change that).

Thanks,
Zorro

> 
> --NR
> 
> > 
> > Thanks,
> > Zorro
> > 
> > >   13 files changed, 63 insertions(+), 52 deletions(-)
> > >   create mode 100644 common/exit
> > > 
> > > diff --git a/check b/check
> > > index 9451c350..67355c52 100755
> > > --- a/check
> > > +++ b/check
> > > @@ -51,6 +51,7 @@ rm -f $tmp.list $tmp.tmp $tmp.grep $here/$iam.out $tmp.report.* $tmp.arglist
> > >   SRC_GROUPS="generic"
> > >   export SRC_DIR="tests"
> > > +. common/exit
> > >   usage()
> > >   {
> > > diff --git a/common/btrfs b/common/btrfs
> > > index 3725632c..9e91ee71 100644
> > > --- a/common/btrfs
> > > +++ b/common/btrfs
> > > @@ -1,7 +1,7 @@
> > >   #
> > >   # Common btrfs specific functions
> > >   #
> > > -
> > > +. common/exit
> > >   . common/module
> > >   # The recommended way to execute simple "btrfs" command.
> > > diff --git a/common/ceph b/common/ceph
> > > index df7a6814..89e36403 100644
> > > --- a/common/ceph
> > > +++ b/common/ceph
> > > @@ -2,6 +2,8 @@
> > >   # CephFS specific common functions.
> > >   #
> > > +. common/exit
> > > +
> > >   # _ceph_create_file_layout <filename> <stripe unit> <stripe count> <object size>
> > >   # This function creates a new empty file and sets the file layout according to
> > >   # parameters.  It will exit if the file already exists.
> > > diff --git a/common/config b/common/config
> > > index eada3971..6a60d144 100644
> > > --- a/common/config
> > > +++ b/common/config
> > > @@ -38,7 +38,7 @@
> > >   # - this script shouldn't make any assertions about filesystem
> > >   #   validity or mountedness.
> > >   #
> > > -
> > > +. common/exit
> > >   . common/test_names
> > >   # all tests should use a common language setting to prevent golden
> > > @@ -96,15 +96,6 @@ export LOCAL_CONFIGURE_OPTIONS=${LOCAL_CONFIGURE_OPTIONS:=--enable-readline=yes}
> > >   export RECREATE_TEST_DEV=${RECREATE_TEST_DEV:=false}
> > > -# This functions sets the exit code to status and then exits. Don't use
> > > -# exit directly, as it might not set the value of "$status" correctly, which is
> > > -# used as an exit code in the trap handler routine set up by the check script.
> > > -_exit()
> > > -{
> > > -	test -n "$1" && status="$1"
> > > -	exit "$status"
> > > -}
> > > -
> > >   # Handle mkfs.$fstyp which does (or does not) require -f to overwrite
> > >   set_mkfs_prog_path_with_opts()
> > >   {
> > > @@ -121,12 +112,6 @@ set_mkfs_prog_path_with_opts()
> > >   	fi
> > >   }
> > > -_fatal()
> > > -{
> > > -    echo "$*"
> > > -    _exit 1
> > > -}
> > > -
> > >   export MKFS_PROG="$(type -P mkfs)"
> > >   [ "$MKFS_PROG" = "" ] && _fatal "mkfs not found"
> > > diff --git a/common/dump b/common/dump
> > > index 09859006..4701a956 100644
> > > --- a/common/dump
> > > +++ b/common/dump
> > > @@ -3,6 +3,7 @@
> > >   # Copyright (c) 2000-2002,2005 Silicon Graphics, Inc.  All Rights Reserved.
> > >   #
> > >   # Functions useful for xfsdump/xfsrestore tests
> > > +. common/exit
> > >   # --- initializations ---
> > >   rm -f $seqres.full
> > > diff --git a/common/exit b/common/exit
> > > new file mode 100644
> > > index 00000000..ad7e7498
> > > --- /dev/null
> > > +++ b/common/exit
> > > @@ -0,0 +1,50 @@
> > > +##/bin/bash
> > > +
> > > +# This functions sets the exit code to status and then exits. Don't use
> > > +# exit directly, as it might not set the value of "$status" correctly, which is
> > > +# used as an exit code in the trap handler routine set up by the check script.
> > > +_exit()
> > > +{
> > > +	test -n "$1" && status="$1"
> > > +	exit "$status"
> > > +}
> > > +
> > > +_fatal()
> > > +{
> > > +    echo "$*"
> > > +    _exit 1
> > > +}
> > > +
> > > +_die()
> > > +{
> > > +        echo $@
> > > +        _exit 1
> > > +}
> > > +
> > > +die_now()
> > > +{
> > > +	_exit 1
> > > +}
> > > +
> > > +# just plain bail out
> > > +#
> > > +_fail()
> > > +{
> > > +    echo "$*" | tee -a $seqres.full
> > > +    echo "(see $seqres.full for details)"
> > > +    _exit 1
> > > +}
> > > +
> > > +# bail out, setting up .notrun file. Need to kill the filesystem check files
> > > +# here, otherwise they are set incorrectly for the next test.
> > > +#
> > > +_notrun()
> > > +{
> > > +    echo "$*" > $seqres.notrun
> > > +    echo "$seq not run: $*"
> > > +    rm -f ${RESULT_DIR}/require_test*
> > > +    rm -f ${RESULT_DIR}/require_scratch*
> > > +
> > > +    _exit 0
> > > +}
> > > +
> > > diff --git a/common/ext4 b/common/ext4
> > > index f88fa532..ab566c41 100644
> > > --- a/common/ext4
> > > +++ b/common/ext4
> > > @@ -1,7 +1,7 @@
> > >   #
> > >   # ext4 specific common functions
> > >   #
> > > -
> > > +. common/exit
> > >   __generate_ext4_report_vars() {
> > >   	__generate_blockdev_report_vars TEST_LOGDEV
> > >   	__generate_blockdev_report_vars SCRATCH_LOGDEV
> > > diff --git a/common/populate b/common/populate
> > > index 50dc75d3..a17acc9e 100644
> > > --- a/common/populate
> > > +++ b/common/populate
> > > @@ -4,7 +4,7 @@
> > >   #
> > >   # Routines for populating a scratch fs, and helpers to exercise an FS
> > >   # once it's been fuzzed.
> > > -
> > > +. common/exit
> > >   . ./common/quota
> > >   _require_populate_commands() {
> > > diff --git a/common/preamble b/common/preamble
> > > index ba029a34..0f306412 100644
> > > --- a/common/preamble
> > > +++ b/common/preamble
> > > @@ -3,6 +3,7 @@
> > >   # Copyright (c) 2021 Oracle.  All Rights Reserved.
> > >   # Boilerplate fstests functionality
> > > +. common/exit
> > >   # Standard cleanup function.  Individual tests can override this.
> > >   _cleanup()
> > > diff --git a/common/punch b/common/punch
> > > index 64d665d8..637f463f 100644
> > > --- a/common/punch
> > > +++ b/common/punch
> > > @@ -3,6 +3,7 @@
> > >   # Copyright (c) 2007 Silicon Graphics, Inc.  All Rights Reserved.
> > >   #
> > >   # common functions for excersizing hole punches with extent size hints etc.
> > > +. common/exit
> > >   _spawn_test_file() {
> > >   	echo "# spawning test file with $*"
> > > @@ -222,11 +223,6 @@ _filter_bmap()
> > >   	_coalesce_extents
> > >   }
> > > -die_now()
> > > -{
> > > -	_exit 1
> > > -}
> > > -
> > >   # test the different corner cases for zeroing a range:
> > >   #
> > >   #	1. into a hole
> > > diff --git a/common/rc b/common/rc
> > > index 9bed6dad..945f5134 100644
> > > --- a/common/rc
> > > +++ b/common/rc
> > > @@ -2,6 +2,7 @@
> > >   # SPDX-License-Identifier: GPL-2.0+
> > >   # Copyright (c) 2000-2006 Silicon Graphics, Inc.  All Rights Reserved.
> > > +. common/exit
> > >   . common/config
> > >   BC="$(type -P bc)" || BC=
> > > @@ -1798,28 +1799,6 @@ _do()
> > >       return $ret
> > >   }
> > > -# bail out, setting up .notrun file. Need to kill the filesystem check files
> > > -# here, otherwise they are set incorrectly for the next test.
> > > -#
> > > -_notrun()
> > > -{
> > > -    echo "$*" > $seqres.notrun
> > > -    echo "$seq not run: $*"
> > > -    rm -f ${RESULT_DIR}/require_test*
> > > -    rm -f ${RESULT_DIR}/require_scratch*
> > > -
> > > -    _exit 0
> > > -}
> > > -
> > > -# just plain bail out
> > > -#
> > > -_fail()
> > > -{
> > > -    echo "$*" | tee -a $seqres.full
> > > -    echo "(see $seqres.full for details)"
> > > -    _exit 1
> > > -}
> > > -
> > >   #
> > >   # Tests whether $FSTYP should be exclude from this test.
> > >   #
> > > @@ -3835,12 +3814,6 @@ _link_out_file()
> > >   	_link_out_file_named $seqfull.out "$features"
> > >   }
> > > -_die()
> > > -{
> > > -        echo $@
> > > -        _exit 1
> > > -}
> > > -
> > >   # convert urandom incompressible data to compressible text data
> > >   _ddt()
> > >   {
> > > diff --git a/common/repair b/common/repair
> > > index fd206f8e..db6a1b5c 100644
> > > --- a/common/repair
> > > +++ b/common/repair
> > > @@ -3,6 +3,7 @@
> > >   # Copyright (c) 2000-2002 Silicon Graphics, Inc.  All Rights Reserved.
> > >   #
> > >   # Functions useful for xfs_repair tests
> > > +. common/exit
> > >   _zero_position()
> > >   {
> > > diff --git a/common/xfs b/common/xfs
> > > index 96c15f3c..c236146c 100644
> > > --- a/common/xfs
> > > +++ b/common/xfs
> > > @@ -1,6 +1,7 @@
> > >   #
> > >   # XFS specific common functions.
> > >   #
> > > +. common/exit
> > >   __generate_xfs_report_vars() {
> > >   	__generate_blockdev_report_vars TEST_RTDEV
> > > -- 
> > > 2.34.1
> > > 
> -- 
> Nirjhar Roy
> Linux Kernel Developer
> IBM, Bangalore
> 


