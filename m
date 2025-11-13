Return-Path: <linux-ext4+bounces-11853-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EC2C56E3E
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Nov 2025 11:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 299DB347200
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Nov 2025 10:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0602F2E0412;
	Thu, 13 Nov 2025 10:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jFqmUOqZ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327F317555;
	Thu, 13 Nov 2025 10:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763030097; cv=none; b=oG1viypJ9Dj0OP6zjYadvArQ2lDpJHKdZfjArOzyr1Li9Q0Z7emExqwg7wgKH+9YCTcSII44POcdJAChhhDrYmGp42Kgkn8ddapSRgtKmwTsdzqfeBEN55hnbVzrmTeLPTmmJUJRvY2pgW5/rT+xyFH/4xcCIhEhRh8aO817NZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763030097; c=relaxed/simple;
	bh=vlpD+Vg71L45G94DxX0FXrvlYViQW70XX2aNyOHfrtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLSbvUV3NVlHn4vnS7IhxBEHCLZvM7g0lxxvnEQh+sLVtbGRAlvqpgl1pXEc03jhsB4fJBZTtCqyGmlOw9Io/JHVOAUmbaOQF+Q6F7CgtrZzoZeDMwxkiAGNhQ9AWCSckJ8PxzrrCgObOu6xcK6UKdBB38F8hv70+ayfqyH3hWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jFqmUOqZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD84h97017468;
	Thu, 13 Nov 2025 10:34:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=TVBmMREZGV7X0mkQ1J+JKyx2LOzD3k
	a7MM67oRzvvs8=; b=jFqmUOqZ16/prOaulVYNYMDv6nkl3fCEfQKVbAM/2jD2vB
	LsgyQmVRZO2mNSiCI+gDBNfG9FDolyBTqUhOyxaZXsFktiL0+cIfxLJ1VYf+V/J3
	Qx+GOpdnYsBYHx8rv0LWHhUy/o0oA94Jg92FEZhkzxI74NFvO8qa+QRY+ZRPavYZ
	mcNHtgABGUW8bWup0cX+5BBGmRISxbv/bek+CQvyTFIGpleKwJ+mTm1HtYeE7W02
	NJH5PX2Kh3mn6F0BZ9qHA9H3UAE0UBQisIH4joF9vSegb7fPbZynHCzYcVPkfIpc
	vHZy2+A7bzl+O7Z1mAfjJgrX5yK0jnfTOG++oQPg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wk8fdfr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 10:34:51 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD90t4H011428;
	Thu, 13 Nov 2025 10:34:50 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aajw1mydb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 10:34:50 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ADAYmaQ56689146
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 10:34:48 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6E7C2004E;
	Thu, 13 Nov 2025 10:34:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 454C420043;
	Thu, 13 Nov 2025 10:34:47 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.211.50])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 13 Nov 2025 10:34:47 +0000 (GMT)
Date: Thu, 13 Nov 2025 16:04:33 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 7/7] generic/774: turn off lfsr
Message-ID: <aRW0BmIMpo5Hz_-O@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <176279908967.605950.2192923313361120314.stgit@frogsfrogsfrogs>
 <176279909135.605950.17114455316765178991.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176279909135.605950.17114455316765178991.stgit@frogsfrogsfrogs>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAyMiBTYWx0ZWRfXzCk4Uvz3hMO3
 rO7u31xpyq5259KfQGBuQFds6zpe/kYvZUG7nJApMpVUGwQtBhIRtrSABe1mJTgKpz2vxnXnCrv
 kkoeqzGDajM/9qtCGV+tbFLqFxYCKkKKw6+m1t6Ci/dVVx3LUqv42KEmPDMnBFY+hcNLaz11rQM
 S/48+YPPyuOISNIzEZ3BtEaDfHQLmcWQ8c6D8ZZirWtjSxybEP9VImOijRGBm/J0NZuwAm2TLPV
 loIDB9V6yWtyi1gGT3KyIll3nRYd6UbKMXw8XCCVUX/5choVK7VFnHq2k1w2TE+Y5WM49ERG4m8
 mujgC7Rl9LxXlgoC29UUDMyL16DpKBBahFAyFGgDBVET+CcMOZ2VNzRWdEzrRoA1EvAKwLcETq2
 GTEtGucAKbmFugOTWhEWaFZiv1IHlQ==
X-Authority-Analysis: v=2.4 cv=ZK3aWH7b c=1 sm=1 tr=0 ts=6915b44b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=bxu2D024HnIU00ImzO0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: nBI-AhOk8O3_Ur7OIFH32eumRtDxPzU9
X-Proofpoint-GUID: nBI-AhOk8O3_Ur7OIFH32eumRtDxPzU9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_01,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511080022

On Mon, Nov 10, 2025 at 10:27:51AM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> This test fails mostly-predictably across my testing fleet with:
> 
>  --- /run/fstests/bin/tests/generic/774.out	2025-10-20 10:03:43.432910446 -0700
>  +++ /var/tmp/fstests/generic/774.out.bad	2025-11-10 01:14:58.941775866 -0800
>  @@ -1,2 +1,11 @@
>  QA output created by 774
>  +fio: failed initializing LFSR
>  +verify: bad magic header 0, wanted acca at file /opt/test-file offset 0, length 33554432 (requested block: offset=0, length=33554432)
>  +verify: bad magic header 0, wanted acca at file /opt/test-file offset 33554432, length 33554432 (requested block: offset=33554432, length=33554432)
>  +verify: bad magic header 0, wanted acca at file /opt/test-file offset 67108864, length 33554432 (requested block: offset=67108864, length=33554432)
>  +verify: bad magic header 0, wanted acca at file /opt/test-file offset 100663296, length 33554432 (requested block: offset=100663296, length=33554432)
>  +verify: bad magic header 0, wanted acca at file /opt/test-file offset 134217728, length 33554432 (requested block: offset=134217728, length=33554432)
>  +verify: bad magic header 0, wanted acca at file /opt/test-file offset 167772160, length 33554432 (requested block: offset=167772160, length=33554432)
>  +verify: bad magic header 0, wanted acca at file /opt/test-file offset 201326592, length 33554432 (requested block: offset=201326592, length=33554432)
>  +verify: bad magic header 0, wanted acca at file /opt/test-file offset 234881024, length 33554432 (requested block: offset=234881024, length=33554432)
>  Silence is golden
> 
> I'm not sure why the linear feedback shift register algorithm is
> specifically needed for this test.

Hi Darrick thanks for the fix. Strange that I never observed this but
yes it is not needed.

Feel free to add:
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
ojaswin

> 
> Cc: <fstests@vger.kernel.org> # v2025.10.20
> Fixes: 9117fb93b41c38 ("generic: Add atomic write test using fio verify on file mixed mappings")
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  tests/generic/774 |    4 ----
>  1 file changed, 4 deletions(-)
> 
> 
> diff --git a/tests/generic/774 b/tests/generic/774
> index 28886ed5b09ff7..86ab01fbd35874 100755
> --- a/tests/generic/774
> +++ b/tests/generic/774
> @@ -56,14 +56,12 @@ group_reporting=1
>  ioengine=libaio
>  rw=randwrite
>  io_size=$((filesize/3))
> -random_generator=lfsr
>  
>  # Create unwritten extents
>  [prep_unwritten_blocks]
>  ioengine=falloc
>  rw=randwrite
>  io_size=$((filesize/3))
> -random_generator=lfsr
>  EOF
>  
>  cat >$fio_aw_config <<EOF
> @@ -73,7 +71,6 @@ ioengine=libaio
>  rw=randwrite
>  direct=1
>  atomic=1
> -random_generator=lfsr
>  group_reporting=1
>  
>  filename=$testfile
> @@ -93,7 +90,6 @@ cat >$fio_verify_config <<EOF
>  [verify_job]
>  ioengine=libaio
>  rw=read
> -random_generator=lfsr
>  group_reporting=1
>  
>  filename=$testfile
> 

