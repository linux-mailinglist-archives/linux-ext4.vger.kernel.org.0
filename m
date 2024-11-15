Return-Path: <linux-ext4+bounces-5221-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B71EB9CF4BB
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Nov 2024 20:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1231E1F21B69
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Nov 2024 19:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98C21D8E12;
	Fri, 15 Nov 2024 19:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyzmC4z5"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12887136338;
	Fri, 15 Nov 2024 19:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731698541; cv=none; b=N22bTra76/qHLIXkQHCYW8DCT6AIjaiZYda4WlLqvSjaMKCZoPVCqiqFF52AyG8kBoQhGd+EGY2XyNOzcxt63tB3DFq2kQUqPhe48zeR6ViMHUatixjyVyk8NGLrILL0UE/UDypwp0qEQujqkvgGjQtj6bokhDqqBoL3k6nsoIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731698541; c=relaxed/simple;
	bh=6G/b9hH9hi6Fz4dpX+tA6gPVNzXiRv5ymi0Gbz/TQV8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=q+IBvtT49jsFeLzTymOZNKRI5YZBU39gKaEBE0zadiFdNNdckvnGbxYmG6ID7aiTEPiqZy2+FIbEdXrDoc0TIampQShcLiMskWdYDM/hic9QQ7clFtddIiHhEOudL4GZiiRQ5f1T4B3AQ+gMmUZKwkEU3HGeXNNPgXJB0qFxV/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lyzmC4z5; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71e681bc315so1609932b3a.0;
        Fri, 15 Nov 2024 11:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731698538; x=1732303338; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PWCWCSqM5EiVesBVWTWxOKB4YwhvqjcwiSWzB2JNFOA=;
        b=lyzmC4z5WJifvCwsQzLrfypXjqA7UE8Ea1gTAzpcGl4JpKPOEGDBzuBP4bkh7LalD2
         Y6uFbg9qDyrFkqH5XnQnLAgjDV/xq6/ypvrnifXp9N9TdlguqG4rwKQ86i2nmlGMM+6r
         SINkjyLY0CadGMmPo0COMpd2HyeC/5eLgMKp33X5R728ETAemyv4ahUCp4Bij2dvEPVu
         1BjGiEsTON+TAmrSjDOSrptViRUsBxAjKfcD3+PG7YAyc4bLlYNanbef/RxMJ8U/GiJz
         ZeSDiOo5LzSGQz3lmOW/7Ur8tjJMXY8iOcndqGkui4rA3oeU3AmDoI0KFKY+pR8+XbiM
         J3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731698538; x=1732303338;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PWCWCSqM5EiVesBVWTWxOKB4YwhvqjcwiSWzB2JNFOA=;
        b=dFrDiM8CTpIQsKVe2aqcShTyFTV9s5HaITe6rd+5r5O1jy0uVK2b2qk5kjtgiT1ydA
         RMcZsVWieLjME8cH6yUOta+2rgxKXa9osW4IDly3tuF6q/OdHhm5fX/BnlvJklX77yF7
         tMwqQC5H2f+kX9XgsSb2MdNhX9q6TqQAfvGPoKlX3ZY9IhV/EehwwW0B2cdVIXZ5ynSJ
         dc/IrjSDZy7Q2VgvjwHwHY4fRVJGDjG6hh7FZ0VFG4APm0RFVyrFSOURElLp6vjCy7KX
         ZkMgS84mqqsn3nOCI1fYIFpd2u68s6H2DnJGEpGJUntfeg0ncpfMyds1q9DtOWf+aWRX
         qZow==
X-Forwarded-Encrypted: i=1; AJvYcCUD1Cr9t/LLe7EC3siZxZbqGf1zJzYskI8fctxljsR1efucxHo0KZGzBHCjF08A81meJEsZ8lyDAwP2@vger.kernel.org, AJvYcCXKX3JjZWwt4Mz+sYJDZgSFzo2442aJsw8wx+OX4db/XhGebjQoeQ1yZPMTwtcxOQ6BWIe4vc+XT/+M@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy3m1NU8uJes90LcjEktzSKVWhALK1rlrtbS7jmjseYASlzXKV
	eB3tzCkyiaWl5pEJ49qaPt1D7vAGSuEG9qts/kOfi4JyxtA9LOuT
X-Google-Smtp-Source: AGHT+IHnYbp70vCjXAE1/wnpw+SRyg6rXoRi90BrRWmaSGz9zPISzMXiE28u63WSEsug06GyD4LFVg==
X-Received: by 2002:a05:6a00:179e:b0:724:6c21:f0c with SMTP id d2e1a72fcca58-72475fbc463mr7267823b3a.4.1731698538247;
        Fri, 15 Nov 2024 11:22:18 -0800 (PST)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724771c0ba2sm1775081b3a.128.2024.11.15.11.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 11:22:17 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Darrick J. Wong" <djwong@kernel.org>, Nirjhar Roy <nirjhar@linux.ibm.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, ojaswin@linux.ibm.com, zlang@kernel.org
Subject: Re: [PATCH v2 1/2] common/rc,xfs/207: Adding a common helper function to check xflag bits on a given file
In-Reply-To: <20241115164548.GE9425@frogsfrogsfrogs>
Date: Sat, 16 Nov 2024 00:36:26 +0530
Message-ID: <87r07cco5p.fsf@gmail.com>
References: <cover.1731597226.git.nirjhar@linux.ibm.com> <9a955f34cab443d3ed0fc07c17886d5e8a11ad80.1731597226.git.nirjhar@linux.ibm.com> <20241115164548.GE9425@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

"Darrick J. Wong" <djwong@kernel.org> writes:

> On Fri, Nov 15, 2024 at 09:45:58AM +0530, Nirjhar Roy wrote:
>> This patch defines a common helper function to test whether any of
>> fsxattr xflags field is set or not. We will use this helper in the next
>> patch for checking extsize (e) flag.
>> 
>> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>> Signed-off-by: Nirjhar Roy <nirjhar@linux.ibm.com>
>> ---
>>  common/rc     |  7 +++++++
>>  tests/xfs/207 | 13 ++-----------
>>  2 files changed, 9 insertions(+), 11 deletions(-)
>> 
>> diff --git a/common/rc b/common/rc
>> index 2af26f23..fc18fc94 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -41,6 +41,13 @@ _md5_checksum()
>>  	md5sum $1 | cut -d ' ' -f1
>>  }
>>  
>> +# Check whether a fsxattr xflags character ($2) field is set on a given file ($1).
>> +# e.g, fsxattr.xflags =  0x80000800 [----------e-----X]
>> +_test_fsx_xflags_field()
>
> How about we call this "_test_fsxattr_xflag" instead?
>
> fsx is already something else in fstests.
>
>> +{
>> +    grep -q "fsxattr.xflags.*\[.*$2.*\]" <($XFS_IO_PROG -c "stat" "$1")
>> +}
>
> Not sure why this lost the xfs_io | grep -q structure.  The return value
> of the whole expression will always be the return value of the last
> command in the pipeline.
>

I guess it was suggested here [1]

[1]: https://lore.kernel.org/all/20241025025651.okneano7d324nl4e@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/

root-> grep -q "hello" <(echo "hello world"); echo $?
0

The cmd is not using the unnamed pipes ("|") any more. It's spawning the
process () which does echo "hello world" and creating a named pipe or
say temporary FD <() which is being read by grep now. So we still will
have the correct return value. Slightly inefficitent compared to unnamed
pipes though I agree. 

> (Correct?  I hate bash...)
>

root-> ls -la <(echo "hello world");
lr-x------ 1 root root 64 Nov 16 00:42 /dev/fd/63 -> 'pipe:[74211850]'

Did I make you hate it more? ;) 


-ritesh

> --D
>
>> +
>>  # Write a byte into a range of a file
>>  _pwrite_byte() {
>>  	local pattern="$1"
>> diff --git a/tests/xfs/207 b/tests/xfs/207
>> index bbe21307..4f6826f3 100755
>> --- a/tests/xfs/207
>> +++ b/tests/xfs/207
>> @@ -21,15 +21,6 @@ _require_cp_reflink
>>  _require_xfs_io_command "fiemap"
>>  _require_xfs_io_command "cowextsize"
>>  
>> -# Takes the fsxattr.xflags line,
>> -# i.e. fsxattr.xflags = 0x0 [--------------C-]
>> -# and tests whether a flag character is set
>> -test_xflag()
>> -{
>> -    local flg=$1
>> -    grep -q "\[.*${flg}.*\]" && echo "$flg flag set" || echo "$flg flag unset"
>> -}
>> -
>>  echo "Format and mount"
>>  _scratch_mkfs > $seqres.full 2>&1
>>  _scratch_mount >> $seqres.full 2>&1
>> @@ -65,14 +56,14 @@ echo "Set cowextsize and check flag"
>>  $XFS_IO_PROG -c "cowextsize 1048576" $testdir/file3 | _filter_scratch
>>  _scratch_cycle_mount
>>  
>> -$XFS_IO_PROG -c "stat" $testdir/file3 | grep 'fsxattr.xflags' | test_xflag "C"
>> +_test_fsx_xflags_field "$testdir/file3" "C" && echo "C flag set" || echo "C flag unset"
>>  $XFS_IO_PROG -c "cowextsize" $testdir/file3 | _filter_scratch
>>  
>>  echo "Unset cowextsize and check flag"
>>  $XFS_IO_PROG -c "cowextsize 0" $testdir/file3 | _filter_scratch
>>  _scratch_cycle_mount
>>  
>> -$XFS_IO_PROG -c "stat" $testdir/file3 | grep 'fsxattr.xflags' | test_xflag "C"
>> +_test_fsx_xflags_field "$testdir/file3" "C" && echo "C flag set" || echo "C flag unset"
>>  $XFS_IO_PROG -c "cowextsize" $testdir/file3 | _filter_scratch
>>  
>>  status=0
>> -- 
>> 2.43.5
>> 
>> 

