Return-Path: <linux-ext4+bounces-5244-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 996B59D17E3
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Nov 2024 19:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22E011F20C23
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Nov 2024 18:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1641991B4;
	Mon, 18 Nov 2024 18:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6PWBeva"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E4115250F;
	Mon, 18 Nov 2024 18:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731953715; cv=none; b=WVwm3LIlFafRvXEsSsxYiVxZlh4uDO20JLLjTn3GlFycZFAUQ+v1bWk9l+MHs07q3y+IdvTfITZZrDrvSQlJrXVfIqLOgkrjuWnBfQOeHTjow9KhSlCIcMovJVTIYfLokKfT+nwThjz++X0R4V3MXO0Juw+JiT8hMM3ybUHMjRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731953715; c=relaxed/simple;
	bh=GVa0muk2OxSEBjOw6/Cel5SFXNb8/AmMkCcu5po60qM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=MuEWoykvKT0DONfWEZTYP1zQ3oyzRXdN1NjSXiZYO9NfJ5thJnXLPrIsGNgcJN608giINuyDpKXyEMghNPajP2oj2UV5XgSZwUKTU6D/RI/YNMxqlul6kQlux6CTmcet/PM1YJQOHPuUAgPtOQ0bb6xM2R5yhPf7t4Lm5oA3Nxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6PWBeva; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7e6cbf6cd1dso3022090a12.3;
        Mon, 18 Nov 2024 10:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731953713; x=1732558513; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OUhWO9CPMEXpChc3ijwqCPg/MwDl1YT2SSyS5ons8QQ=;
        b=Q6PWBevaOKpiWCnSLvWNeL/em/l41qC1k8y3V18szfCm1tqlZ651Z0FthnZ+/V06uO
         0IT0OeSrzxc6A94aFoWriteQBsOkX4sHrcQtMFFbS4PlW1f/t3DVFOFqIbnBl2MeuQQO
         Z+M4SMmPLC3m2L1NrgOcjY/YXsHK/gDq6hOqMBiG6PBKoyqM0IWhDuL6w9edU+gqrNLe
         6waKwyABlMXtGPyQfu9Dl3oINNbtnhcSIYsCdnQ2CrSV9WhMzniGpd96plyJ+fffYPZs
         8MIew30/3NxRqiolwDuQ25tEJNgpSRBAG6sZ+9QpvqGj+vPAKDePNXmbPrTVuZnXx+E+
         dybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731953713; x=1732558513;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OUhWO9CPMEXpChc3ijwqCPg/MwDl1YT2SSyS5ons8QQ=;
        b=dlvwicxLxOrHmIkgVv4/uyjEP9Dz6b/S1qL5YRs/2gKt2nHCS+xYmC83NKnNtfDtlQ
         4zWScMabsJmYKrJmBCi43KTm8UKke0s6VdUdtodU4tHM1IEpBhhuDJ4b1gNBKrciZK7R
         9WsebQqY17rVCecW9R0MqYwW1uVPB5JXBWse7AqVp43Hrt6LEaWkaV5p6UsZAN8A55aB
         sao0NM0PRam2E+96dmvBNDcsalwd8V+o7kErQRFnODwhLyp1mFgoJMcsaNuoTDoLWJ5B
         oz56+IN/oPWmA9D92jJYAy+vcsUL/5bLtTAI85XeSP+r2T/jc5PgEI2r2UbUSmLw3klF
         cIiw==
X-Forwarded-Encrypted: i=1; AJvYcCWGXvDgxK6M8m4KZfmCBw413mASk5MoDBydvyErT2nfJ48VCLJZTlvyEFncas0UV5kqm2IlofdA6RRQ@vger.kernel.org, AJvYcCWz8+f7woyrM7E54WVU4y2E7UYHVvSjwRjmQg9KyMhiIuAve7OQancwW6M7fFvo24CbRZP8TFpW@vger.kernel.org, AJvYcCXcrZJ+IFpdCxtTu0rtN8P8U94HzRtxGs8jwoIas+v2nOZEVxSyz0sri3l0RCX0NEpkcU1X0lNm4+DuXg==@vger.kernel.org
X-Gm-Message-State: AOJu0YznVuMFr8UnYXh2bFMLVZhnJHMTg5+3wd5uZYR562O2ODeTBsER
	iv4/z5qJ/c4fIjoUX3zLWz2cVQiKrOmfH6dnJwCu2L53e30AWuH6EJytqA==
X-Google-Smtp-Source: AGHT+IGAGMz6lKVHh34hu1dsWO0qEfwNQ2zZUDFXacHvycxzenbl3hhllP1tAcoj9TTRc3NJcHEU/A==
X-Received: by 2002:a17:902:e886:b0:20c:b606:d014 with SMTP id d9443c01a7336-211d0ebcc2emr178875495ad.44.1731953712655;
        Mon, 18 Nov 2024 10:15:12 -0800 (PST)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0dc305dsm59872525ad.44.2024.11.18.10.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 10:15:12 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Nirjhar Roy <nirjhar@linux.ibm.com>, fstests@vger.kernel.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, ojaswin@linux.ibm.com, zlang@kernel.org
Subject: Re: [PATCH v2 1/2] common/rc,xfs/207: Adding a common helper function to check xflag bits on a given file
In-Reply-To: <20241118162810.GI9425@frogsfrogsfrogs>
Date: Mon, 18 Nov 2024 23:36:12 +0530
Message-ID: <87r0788lij.fsf@gmail.com>
References: <cover.1731597226.git.nirjhar@linux.ibm.com> <9a955f34cab443d3ed0fc07c17886d5e8a11ad80.1731597226.git.nirjhar@linux.ibm.com> <20241115164548.GE9425@frogsfrogsfrogs> <87r07cco5p.fsf@gmail.com> <20241118162810.GI9425@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

"Darrick J. Wong" <djwong@kernel.org> writes:

> On Sat, Nov 16, 2024 at 12:36:26AM +0530, Ritesh Harjani wrote:
>> "Darrick J. Wong" <djwong@kernel.org> writes:
>> 
>> > On Fri, Nov 15, 2024 at 09:45:58AM +0530, Nirjhar Roy wrote:
>> >> This patch defines a common helper function to test whether any of
>> >> fsxattr xflags field is set or not. We will use this helper in the next
>> >> patch for checking extsize (e) flag.
>> >> 
>> >> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> >> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>> >> Signed-off-by: Nirjhar Roy <nirjhar@linux.ibm.com>
>> >> ---
>> >>  common/rc     |  7 +++++++
>> >>  tests/xfs/207 | 13 ++-----------
>> >>  2 files changed, 9 insertions(+), 11 deletions(-)
>> >> 
>> >> diff --git a/common/rc b/common/rc
>> >> index 2af26f23..fc18fc94 100644
>> >> --- a/common/rc
>> >> +++ b/common/rc
>> >> @@ -41,6 +41,13 @@ _md5_checksum()
>> >>  	md5sum $1 | cut -d ' ' -f1
>> >>  }
>> >>  
>> >> +# Check whether a fsxattr xflags character ($2) field is set on a given file ($1).
>> >> +# e.g, fsxattr.xflags =  0x80000800 [----------e-----X]
>> >> +_test_fsx_xflags_field()
>> >
>> > How about we call this "_test_fsxattr_xflag" instead?
>> >
>> > fsx is already something else in fstests.
>> >
>> >> +{
>> >> +    grep -q "fsxattr.xflags.*\[.*$2.*\]" <($XFS_IO_PROG -c "stat" "$1")
>> >> +}
>> >
>> > Not sure why this lost the xfs_io | grep -q structure.  The return value
>> > of the whole expression will always be the return value of the last
>> > command in the pipeline.
>> >
>> 
>> I guess it was suggested here [1]
>> 
>> [1]: https://lore.kernel.org/all/20241025025651.okneano7d324nl4e@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/
>
> Ah.
>
>> root-> grep -q "hello" <(echo "hello world"); echo $?
>> 0
>> 
>> The cmd is not using the unnamed pipes ("|") any more. It's spawning the
>> process () which does echo "hello world" and creating a named pipe or
>> say temporary FD <() which is being read by grep now. So we still will
>> have the correct return value. Slightly inefficitent compared to unnamed
>> pipes though I agree. 
>
> Well... it's subtle, being bash, right? :)
>
> bash creates a pipe and a subprocess for the "echo hello world", then
> hooks its stdout to the pipe, just like a regular "|" pipe.
>
> But for "grep -q hello" things are different -- for the grep process,
> the pipe is added as a new fd (e.g. /dev/fd/63), and then that path is
> provided on the command line.  So what bash is doing is:
>
> 	grep -q "hello" /dev/fd/63
>
> AFAICT for grep this makes no difference unless you want it to tell you
> filenames:
>
> $ grep -l hello <(echo hello world)
> /dev/fd/63

aah yes, I see (from strace)

pipe2([3, 4], 0)                        = 0
fcntl(63, F_GETFD)                      = 0
fcntl(62, F_GETFD)                      = -1 EBADF (Bad file descriptor)
dup2(3, 62)                             = 62
close(3)                                = 0

Thanks!

-ritesh

> $ echo hello world | grep -l hello
> (standard input)
>
> and I'm sure there's other weird implications that I'm not remembering.
>
>> > (Correct?  I hate bash...)
>> >
>> 
>> root-> ls -la <(echo "hello world");
>> lr-x------ 1 root root 64 Nov 16 00:42 /dev/fd/63 -> 'pipe:[74211850]'
>> 
>> Did I make you hate it more? ;) 
>
> Yep!
>
> --D
>
>> 
>> -ritesh
>> 
>> > --D
>> >
>> >> +
>> >>  # Write a byte into a range of a file
>> >>  _pwrite_byte() {
>> >>  	local pattern="$1"
>> >> diff --git a/tests/xfs/207 b/tests/xfs/207
>> >> index bbe21307..4f6826f3 100755
>> >> --- a/tests/xfs/207
>> >> +++ b/tests/xfs/207
>> >> @@ -21,15 +21,6 @@ _require_cp_reflink
>> >>  _require_xfs_io_command "fiemap"
>> >>  _require_xfs_io_command "cowextsize"
>> >>  
>> >> -# Takes the fsxattr.xflags line,
>> >> -# i.e. fsxattr.xflags = 0x0 [--------------C-]
>> >> -# and tests whether a flag character is set
>> >> -test_xflag()
>> >> -{
>> >> -    local flg=$1
>> >> -    grep -q "\[.*${flg}.*\]" && echo "$flg flag set" || echo "$flg flag unset"
>> >> -}
>> >> -
>> >>  echo "Format and mount"
>> >>  _scratch_mkfs > $seqres.full 2>&1
>> >>  _scratch_mount >> $seqres.full 2>&1
>> >> @@ -65,14 +56,14 @@ echo "Set cowextsize and check flag"
>> >>  $XFS_IO_PROG -c "cowextsize 1048576" $testdir/file3 | _filter_scratch
>> >>  _scratch_cycle_mount
>> >>  
>> >> -$XFS_IO_PROG -c "stat" $testdir/file3 | grep 'fsxattr.xflags' | test_xflag "C"
>> >> +_test_fsx_xflags_field "$testdir/file3" "C" && echo "C flag set" || echo "C flag unset"
>> >>  $XFS_IO_PROG -c "cowextsize" $testdir/file3 | _filter_scratch
>> >>  
>> >>  echo "Unset cowextsize and check flag"
>> >>  $XFS_IO_PROG -c "cowextsize 0" $testdir/file3 | _filter_scratch
>> >>  _scratch_cycle_mount
>> >>  
>> >> -$XFS_IO_PROG -c "stat" $testdir/file3 | grep 'fsxattr.xflags' | test_xflag "C"
>> >> +_test_fsx_xflags_field "$testdir/file3" "C" && echo "C flag set" || echo "C flag unset"
>> >>  $XFS_IO_PROG -c "cowextsize" $testdir/file3 | _filter_scratch
>> >>  
>> >>  status=0
>> >> -- 
>> >> 2.43.5
>> >> 
>> >> 
>> 

