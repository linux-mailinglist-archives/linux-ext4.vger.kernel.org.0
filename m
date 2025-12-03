Return-Path: <linux-ext4+bounces-12131-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3B7C9DA60
	for <lists+linux-ext4@lfdr.de>; Wed, 03 Dec 2025 04:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 167FA347C00
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Dec 2025 03:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06870246783;
	Wed,  3 Dec 2025 03:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=damenly.org header.i=@damenly.org header.b="ezocLxgi"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-108-mta1.mxroute.com (mail-108-mta1.mxroute.com [136.175.108.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC517081F
	for <linux-ext4@vger.kernel.org>; Wed,  3 Dec 2025 03:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764732710; cv=none; b=u/JuzdGqkJI/GMRaS3SycL64NDpqsYvAg62OHDUiw30rWrwob6LiOUZRdTTRSdj5RH6CnQBq6wHO4O56cM8+bVmyB6vrakzX0m9LWEomX/P088konbM/9WAUuarqjmuWmgOrXtLW4Xy79G+Pb/d8eQW9poFoHR3wgtfL9O4ms50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764732710; c=relaxed/simple;
	bh=HL6y0HW6ppNWmWdM2TleC2h/mEI4CLRlqyWjfVA0auc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aJVkvFFx2q91S2iIRrIOnEJerY+DTtAK1NSowMFqeM8TYDq/YrxHs62N/mv5yAyheVI38ZT5Vewk6MIeiwcP35THdWiXR188MU2bECpnqHUCsYtgURwjSsH0LuD4mZPEt5lxYNe5kHBPLDZFIEnbuyDxWTLCRcLHm17i9xrpi3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=damenly.org; spf=pass smtp.mailfrom=damenly.org; dkim=pass (2048-bit key) header.d=damenly.org header.i=@damenly.org header.b=ezocLxgi; arc=none smtp.client-ip=136.175.108.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=damenly.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=damenly.org
Received: from filter006.mxroute.com ([140.82.40.27] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta1.mxroute.com (ZoneMTA) with ESMTPSA id 19ae23f56950004eea.004
 for <linux-ext4@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 03 Dec 2025 03:26:33 +0000
X-Zone-Loop: 0f8ba5deed0556ed28e4529cbfec3343a706b5cc2122
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=damenly.org
	; s=x; h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:
	Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=DBSJG38ktnT2q1HRu9FZWZPNIQH7YkG3Qv+57BXe230=; b=ezocLxgiRETtNDJFSksWljMy4V
	fcrDGabrOXaoA8pifQBLI6hN0IuT6bUPJ7gmdqKZ1Fh/mckkTjWIu0G8ffcpaJrVo0siH7zk0+9DY
	1znVy77EeUSQ73vzFwYPoR/z5bLxSO2gOkwTYFnid+WIvZQqV5l2Wsr+tMQeqqdRcY3Uv4McUA7rY
	DcClKCy5jB3oDT8xf2vVTT1E0MB49WGsuAFIyTQx2UZI5n91iTSk4UOZgQp87recWScZ3j977imO3
	Y+cfT8LB47Af8xHuYgcDfwvjH2qVj2quXnoMHZd4Z28o0/VX7rrZtip/IXv0Gmv/Pp3KWWosLEVj5
	ImQ6jLVw==;
From: Su Yue <l@damenly.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Su Yue <glass.su@suse.com>,  fstests@vger.kernel.org,
  linux-ext4@vger.kernel.org,  linux-xfs@vger.kernel.org
Subject: Re: [PATCH] generic: use _qmount_option and _qmount
In-Reply-To: <20251201225924.GA89454@frogsfrogsfrogs> (Darrick J. Wong's
	message of "Mon, 1 Dec 2025 14:59:24 -0800")
References: <20251124132004.23965-1-glass.su@suse.com>
	<20251201225924.GA89454@frogsfrogsfrogs>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Wed, 03 Dec 2025 11:26:22 +0800
Message-ID: <cy4wfdpd.fsf@damenly.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Authenticated-Id: l@damenly.org

On Mon 01 Dec 2025 at 14:59, "Darrick J. Wong" <djwong@kernel.org> 
wrote:

> On Mon, Nov 24, 2025 at 09:20:04PM +0800, Su Yue wrote:
>> Many generic tests call `_scratch_mount -o usrquota` then
>> chmod 777, quotacheck and quotaon.
>
> What does the chmod 777 do, in relation to the quota{check,on} 
> programs?
> Is it necessary for the root dir to be world writable (and 
> executable!)
> for quota tools to work?
>
It's unnecessary. Only tests calling `_su $qa_user` or 
`_file_as_id` need
the permisson.

>> It can be simpilfied to _qmount_option and _qmount. The later
>> function already calls quotacheck, quota and chmod.
>>
>> Convertaions can save a few lines. tests/generic/380 is an 
>> exception
>
> "Conversions" ?
>
Yeah...

--
Su
> --D
>
>> because it tests chown.
>>
>> Signed-off-by: Su Yue <glass.su@suse.com>
>> ---
>>  tests/generic/082 |  9 ++-------
>>  tests/generic/219 | 11 ++++-------
>>  tests/generic/230 | 11 ++++++-----
>>  tests/generic/231 |  6 ++----
>>  tests/generic/232 |  6 ++----
>>  tests/generic/233 |  6 ++----
>>  tests/generic/234 |  5 ++---
>>  tests/generic/235 |  5 ++---
>>  tests/generic/244 |  1 -
>>  tests/generic/270 |  6 ++----
>>  tests/generic/280 |  5 ++---
>>  tests/generic/400 |  2 +-
>>  12 files changed, 27 insertions(+), 46 deletions(-)
>>
>> diff --git a/tests/generic/082 b/tests/generic/082
>> index f078ef2ffff9..6bb9cf2a22ae 100755
>> --- a/tests/generic/082
>> +++ b/tests/generic/082
>> @@ -23,13 +23,8 @@ _require_scratch
>>  _require_quota
>>
>>  _scratch_mkfs >>$seqres.full 2>&1
>> -_scratch_mount "-o usrquota,grpquota"
>> -
>> -# xfs doesn't need these setups and quotacheck even fails on 
>> xfs, so just
>> -# redirect the output to $seqres.full for debug purpose and 
>> ignore the results,
>> -# as we check the quota status later anyway.
>> -quotacheck -ug $SCRATCH_MNT >>$seqres.full 2>&1
>> -quotaon $SCRATCH_MNT >>$seqres.full 2>&1
>> +_qmount_option 'usrquota,grpquota'
>> +_qmount "usrquota,grpquota"
>>
>>  # first remount ro with a bad option, a failed remount ro 
>>  should not disable
>>  # quota, but currently xfs doesn't fail in this case, the 
>>  unknown option is
>> diff --git a/tests/generic/219 b/tests/generic/219
>> index 642823859886..a2eb0b20f408 100755
>> --- a/tests/generic/219
>> +++ b/tests/generic/219
>> @@ -91,25 +91,22 @@ test_accounting()
>>
>>  _scratch_unmount 2>/dev/null
>>  _scratch_mkfs >> $seqres.full 2>&1
>> -_scratch_mount "-o usrquota,grpquota"
>> +_qmount_option "usrquota,grpquota"
>> +_qmount
>>  _force_vfs_quota_testing $SCRATCH_MNT
>> -quotacheck -u -g $SCRATCH_MNT 2>/dev/null
>> -quotaon $SCRATCH_MNT 2>/dev/null
>>  _scratch_unmount
>>
>>  echo; echo "### test user accounting"
>> -export MOUNT_OPTIONS="-o usrquota"
>> +_qmount_option "usrquota"
>>  _qmount
>> -quotaon $SCRATCH_MNT 2>/dev/null
>>  type=u
>>  test_files
>>  test_accounting
>>  _scratch_unmount 2>/dev/null
>>
>>  echo; echo "### test group accounting"
>> -export MOUNT_OPTIONS="-o grpquota"
>> +_qmount_option "grpquota"
>>  _qmount
>> -quotaon $SCRATCH_MNT 2>/dev/null
>>  type=g
>>  test_files
>>  test_accounting
>> diff --git a/tests/generic/230 b/tests/generic/230
>> index a8caf5a808c3..0a680dbc874b 100755
>> --- a/tests/generic/230
>> +++ b/tests/generic/230
>> @@ -99,7 +99,8 @@ grace=2
>>  _qmount_option 'defaults'
>>
>>  _scratch_mkfs >> $seqres.full 2>&1
>> -_scratch_mount "-o usrquota,grpquota"
>> +_qmount_option "usrquota,grpquota"
>> +_qmount
>>  _force_vfs_quota_testing $SCRATCH_MNT
>>  BLOCK_SIZE=$(_get_file_block_size $SCRATCH_MNT)
>>  quotacheck -u -g $SCRATCH_MNT 2>/dev/null
>> @@ -113,8 +114,8 @@ setquota -g -t $grace $grace $SCRATCH_MNT
>>  _scratch_unmount
>>
>>  echo; echo "### test user limit enforcement"
>> -_scratch_mount "-o usrquota"
>> -quotaon $SCRATCH_MNT 2>/dev/null
>> +_qmount_option "usrquota"
>> +_qmount
>>  type=u
>>  test_files
>>  test_enforcement
>> @@ -122,8 +123,8 @@ cleanup_files
>>  _scratch_unmount 2>/dev/null
>>
>>  echo; echo "### test group limit enforcement"
>> -_scratch_mount "-o grpquota"
>> -quotaon $SCRATCH_MNT 2>/dev/null
>> +_qmount_option "grpquota"
>> +_qmount
>>  type=g
>>  test_files
>>  test_enforcement
>> diff --git a/tests/generic/231 b/tests/generic/231
>> index ce7e62ea1886..02910523d0b5 100755
>> --- a/tests/generic/231
>> +++ b/tests/generic/231
>> @@ -47,10 +47,8 @@ _require_quota
>>  _require_user
>>
>>  _scratch_mkfs >> $seqres.full 2>&1
>> -_scratch_mount "-o usrquota,grpquota"
>> -chmod 777 $SCRATCH_MNT
>> -quotacheck -u -g $SCRATCH_MNT 2>/dev/null
>> -quotaon -u -g $SCRATCH_MNT 2>/dev/null
>> +_qmount_option "usrquota,grpquota"
>> +_qmount
>>
>>  if ! _fsx 1; then
>>  	_scratch_unmount 2>/dev/null
>> diff --git a/tests/generic/232 b/tests/generic/232
>> index c903a5619045..21375809d299 100755
>> --- a/tests/generic/232
>> +++ b/tests/generic/232
>> @@ -44,10 +44,8 @@ _require_scratch
>>  _require_quota
>>
>>  _scratch_mkfs > $seqres.full 2>&1
>> -_scratch_mount "-o usrquota,grpquota"
>> -chmod 777 $SCRATCH_MNT
>> -quotacheck -u -g $SCRATCH_MNT 2>/dev/null
>> -quotaon -u -g $SCRATCH_MNT 2>/dev/null
>> +_qmount_option "usrquota,grpquota"
>> +_qmount
>>
>>  _fsstress
>>  _check_quota_usage
>> diff --git a/tests/generic/233 b/tests/generic/233
>> index 3fc1b63abb24..4606f3bde2ab 100755
>> --- a/tests/generic/233
>> +++ b/tests/generic/233
>> @@ -59,10 +59,8 @@ _require_quota
>>  _require_user
>>
>>  _scratch_mkfs > $seqres.full 2>&1
>> -_scratch_mount "-o usrquota,grpquota"
>> -chmod 777 $SCRATCH_MNT
>> -quotacheck -u -g $SCRATCH_MNT 2>/dev/null
>> -quotaon -u -g $SCRATCH_MNT 2>/dev/null
>> +_qmount_option "usrquota,grpquota"
>> +_qmount
>>  setquota -u $qa_user 32000 32000 1000 1000 $SCRATCH_MNT 
>>  2>/dev/null
>>
>>  _fsstress
>> diff --git a/tests/generic/234 b/tests/generic/234
>> index 4b25fc6507cc..2c596492a3e0 100755
>> --- a/tests/generic/234
>> +++ b/tests/generic/234
>> @@ -66,9 +66,8 @@ _require_quota
>>
>>
>>  _scratch_mkfs >> $seqres.full 2>&1
>> -_scratch_mount "-o usrquota,grpquota"
>> -quotacheck -u -g $SCRATCH_MNT 2>/dev/null
>> -quotaon -u -g $SCRATCH_MNT 2>/dev/null
>> +_qmount_option "usrquota,grpquota"
>> +_qmount
>>  test_setting
>>  _scratch_unmount
>>
>> diff --git a/tests/generic/235 b/tests/generic/235
>> index 037c29e806db..7a616650fc8f 100755
>> --- a/tests/generic/235
>> +++ b/tests/generic/235
>> @@ -25,9 +25,8 @@ do_repquota()
>>
>>
>>  _scratch_mkfs >> $seqres.full 2>&1
>> -_scratch_mount "-o usrquota,grpquota"
>> -quotacheck -u -g $SCRATCH_MNT 2>/dev/null
>> -quotaon $SCRATCH_MNT 2>/dev/null
>> +_qmount_option "usrquota,grpquota"
>> +_qmount
>>
>>  touch $SCRATCH_MNT/testfile
>>  chown $qa_user:$qa_user $SCRATCH_MNT/testfile
>> diff --git a/tests/generic/244 b/tests/generic/244
>> index b68035129c82..989bb4f5385e 100755
>> --- a/tests/generic/244
>> +++ b/tests/generic/244
>> @@ -66,7 +66,6 @@ done
>>  # remount just for kicks, make sure we get it off disk
>>  _scratch_unmount
>>  _qmount
>> -quotaon $SCRATCH_MNT 2>/dev/null
>>
>>  # Read them back by iterating based on quotas returned.
>>  # This should match what we set, even if we don't directly
>> diff --git a/tests/generic/270 b/tests/generic/270
>> index c3d5127a0b51..9ac829a7379f 100755
>> --- a/tests/generic/270
>> +++ b/tests/generic/270
>> @@ -62,10 +62,8 @@ _require_command "$SETCAP_PROG" setcap
>>  _require_attrs security
>>
>>  _scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full 
>>  2>&1
>> -_scratch_mount "-o usrquota,grpquota"
>> -chmod 777 $SCRATCH_MNT
>> -quotacheck -u -g $SCRATCH_MNT 2>/dev/null
>> -quotaon -u -g $SCRATCH_MNT 2>/dev/null
>> +_qmount_option "usrquota,grpquota"
>> +_qmount
>>
>>  if ! _workout; then
>>  	_scratch_unmount 2>/dev/null
>> diff --git a/tests/generic/280 b/tests/generic/280
>> index 3108fd23fb70..fae0a02145cf 100755
>> --- a/tests/generic/280
>> +++ b/tests/generic/280
>> @@ -34,9 +34,8 @@ _require_freeze
>>
>>  _scratch_unmount 2>/dev/null
>>  _scratch_mkfs >> $seqres.full 2>&1
>> -_scratch_mount "-o usrquota,grpquota"
>> -quotacheck -u -g $SCRATCH_MNT 2>/dev/null
>> -quotaon $SCRATCH_MNT 2>/dev/null
>> +_qmount_option "usrquota,grpquota"
>> +_qmount
>>  xfs_freeze -f $SCRATCH_MNT
>>  setquota -u root 1 2 3 4 $SCRATCH_MNT &
>>  pid=$!
>> diff --git a/tests/generic/400 b/tests/generic/400
>> index 77970da69a41..ef27c254167c 100755
>> --- a/tests/generic/400
>> +++ b/tests/generic/400
>> @@ -22,7 +22,7 @@ _require_scratch
>>
>>  _scratch_mkfs >> $seqres.full 2>&1
>>
>> -MOUNT_OPTIONS="-o usrquota,grpquota"
>> +_qmount_option "usrquota,grpquota"
>>  _qmount
>>  _require_getnextquota
>>
>> --
>> 2.48.1
>>
>>

