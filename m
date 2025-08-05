Return-Path: <linux-ext4+bounces-9267-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9538DB1B18B
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Aug 2025 11:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36807189EE76
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Aug 2025 09:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE59C26A1A3;
	Tue,  5 Aug 2025 09:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tNDsBG0W"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF801AA782;
	Tue,  5 Aug 2025 09:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754387761; cv=none; b=nuB6GDzM2uNvD2LyDKOTtlEDbRE5vNqfMYvG/dZczV+c8rP8pQRdVUntaEnWOQK4VxPVZCrAbSliP+oFE03ccJpJWvVt5vVE4B8LLjKdj8aHt4PBualkfxjk6OlAjKLRfn1Es2KDS96iZ2ottzUH6GkxfmAatTPesK+Q87pr0v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754387761; c=relaxed/simple;
	bh=UZfMeOmyRoNQ/3CJiujXHLuhnpjbmcZ0G5d2eo3WdO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EyQafq4reMGPrnpu7GWJ9/OY6A3XJJKW3d4/zxv1cku6NLoiqCkyMN61WaNrxczT+Zrh6fDpRptEoNGlC4Fi9aKz2kg8dU4iAfOaf0QMJEUasuzAETPlZN9gMHm2il5Mz6Ih5OZw0NOXftVRdCK5KSro/pZH77s4majj/9nuF3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tNDsBG0W; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 574NUqeQ030923;
	Tue, 5 Aug 2025 09:55:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=EAfCxla08hBWldIS+xRflEEtx0zM5b
	Meki2a/2qT674=; b=tNDsBG0Wgyv7DxNoq9vgbJt/6S3j/BUhm4v0bu9DB3j9w4
	eyU5xHkdPWLJ0xUOReq22Y49y2uSkIE/mclIcAghbIY8OXdIgVRigbvW7uXYIVDU
	YfeWo7Xu8oULnFyXuy9KA0kuqe+Fi8yjKVuvarU/FzcmvWZzKiKMljvdC7LboI2f
	k11poEAg0I98trWTXQ+OZ+gem2lcwlTWgUdqFqLSXDsjJOlo/sXd1YLo9EG73Qqz
	qmUpNCNZJyCGcR9Sv1ptoq53iCv9V/f4OZBBWhNiE2aK4+C12vKTfI0YhrcVj9Da
	zTTfBsEiKj4WQOUFRem31WWa2aqlYinua9uflpow==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48b6kea68a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 09:55:52 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5755YHYX004495;
	Tue, 5 Aug 2025 09:55:52 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 489yq2hkwe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 09:55:51 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5759tnBX33292708
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 Aug 2025 09:55:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9613820040;
	Tue,  5 Aug 2025 09:55:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D4B1B2004E;
	Tue,  5 Aug 2025 09:55:47 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.158])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  5 Aug 2025 09:55:47 +0000 (GMT)
Date: Tue, 5 Aug 2025 15:25:45 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: zlang@redhat.com, djwong@kernel.org, fstests@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        catherine.hoang@oracle.com
Subject: Re: [PATCH] generic/765: modify some steps to fix test
Message-ID: <aJHVIRNCQ70Vmbtl@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20250731091813.2462058-1-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731091813.2462058-1-john.g.garry@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KLxhiYJgRLKRaAN73s0Ct5C8OyeOeUTU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDA3MSBTYWx0ZWRfX7MEARXgZMFhK
 LRMD1go6REGBpDNHQkKF/3y3nu7lDOUmJcpWTimNav5cNQMRrjyTLiBoagItUnAXZ3YStFpGQ5T
 n6BUADYExeSjY7zO66uP/xND1vUI9ZeuXGULwKRQwvtFcaj3G/dezHwcomY7ei5poDPi0eU81QU
 ss4ZhmMplPGFKLylEJVKs2OriW5zzv9AvftQNMypNxowkooidKfe09RAUwF2YiKHO5Kqckg+NsP
 fWsiaQGd0mZ2kteXsxSg+NS6ekYHPZE5PUdcWlqwirxcjD7qOjAiN+GmV2KQ0Rqwck9VTMvbiAr
 ERheYC5+1n7KXD1c9uBNYJkMrfHXDNbcC1FE3WWzLUPaXGiyJ+30DVDhkF8GN1K9zX5iZAVamGr
 5kDd2+PKVxa0nie/8Dgv9WuIHEGLtfZFLh17RXZLkACr8JFUbIP4hYfjWBUVoqtXhHd9yKl8
X-Authority-Analysis: v=2.4 cv=eLATjGp1 c=1 sm=1 tr=0 ts=6891d529 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=yPCof4ZbAAAA:8
 a=AcUWm9OTnHkBfutmEAYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: KLxhiYJgRLKRaAN73s0Ct5C8OyeOeUTU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_02,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508050071

On Thu, Jul 31, 2025 at 09:18:13AM +0000, John Garry wrote:
> Now that multi-block atomics writes are supported, some of the test steps
> are failing. Those steps relied on supporting single-block atomic writes
> only.
> 
> The current test steps are as follows:
> a. Ensure statx for bdev returns same awu_min/max as from sysfs
> b. test mkfs for each size of bdev atomic writes capabilities and supported
>    FS block size
> c. Ensure atomic limits for file match block size for each in b.
> d. Ensure that we can atomic write block size for each in b.
> e. Ensure that we cannot write file for 2* bdev awu_max or bdev awu_max /2
> 
> Make test pass again by:
> 1. Modify c. to ensure file awu_max >= block size
> 2. dropping e. We already have tests to ensure that we can only write a
>    size >= awu_min and <= awu_max in generic/767
> 
Hi John,

Changes look good, feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
ojaswin

> Signed-off-by: John Garry <john.g.garry@oracle.com>
> 
> diff --git a/tests/generic/765 b/tests/generic/765
> index 71604e5e..8c4e0bd0 100755
> --- a/tests/generic/765
> +++ b/tests/generic/765
> @@ -84,8 +84,8 @@ test_atomic_writes()
>      # Check that atomic min/max = FS block size
>      test $file_min_write -eq $bsize || \
>          echo "atomic write min $file_min_write, should be fs block size $bsize"
> -    test $file_max_write -eq $bsize || \
> -        echo "atomic write max $file_max_write, should be fs block size $bsize"
> +    test $file_max_write -ge $bsize || \
> +        echo "atomic write max $file_max_write, should be at least fs block size $bsize"
>      test $file_max_segments -eq 1 || \
>          echo "atomic write max segments $file_max_segments, should be 1"
>  
> @@ -94,34 +94,6 @@ test_atomic_writes()
>      _scratch_unmount
>  }
>  
> -test_atomic_write_bounds()
> -{
> -    local bsize=$1
> -
> -    get_mkfs_opts $bsize
> -    _scratch_mkfs $mkfs_opts >> $seqres.full
> -    _scratch_mount
> -
> -    test "$FSTYP" = "xfs" && _xfs_force_bdev data $SCRATCH_MNT
> -
> -    testfile=$SCRATCH_MNT/testfile
> -    touch $testfile
> -
> -    file_min_write=$(_get_atomic_write_unit_min $testfile)
> -    file_max_write=$(_get_atomic_write_unit_max $testfile)
> -    file_max_segments=$(_get_atomic_write_segments_max $testfile)
> -
> -    echo "test awb $bsize --------------" >> $seqres.full
> -    echo "file awu_min $file_min_write" >> $seqres.full
> -    echo "file awu_max $file_max_write" >> $seqres.full
> -    echo "file awu_segments $file_max_segments" >> $seqres.full
> -
> -    $XFS_IO_PROG -dc "pwrite -A -D -V1 -b $bsize 0 $bsize" $testfile 2>> $seqres.full && \
> -        echo "atomic write should fail when bsize is out of bounds"
> -
> -    _scratch_unmount
> -}
> -
>  sys_min_write=$(cat "/sys/block/$(_short_dev $SCRATCH_DEV)/queue/atomic_write_unit_min_bytes")
>  sys_max_write=$(cat "/sys/block/$(_short_dev $SCRATCH_DEV)/queue/atomic_write_unit_max_bytes")
>  
> @@ -150,14 +122,6 @@ for ((bsize=$bdev_min_write; bsize<=bdev_max_write; bsize*=2)); do
>      fi
>  done;
>  
> -# Check that atomic write fails if bsize < bdev min or bsize > bdev max
> -if [ $((bdev_min_write / 2)) -ge "$min_bsize" ]; then
> -    test_atomic_write_bounds $((bdev_min_write / 2))
> -fi
> -if [ $((bdev_max_write * 2)) -le "$max_bsize" ]; then
> -    test_atomic_write_bounds $((bdev_max_write * 2))
> -fi
> -
>  # success, all done
>  echo Silence is golden
>  status=0
> -- 
> 2.43.5
> 

