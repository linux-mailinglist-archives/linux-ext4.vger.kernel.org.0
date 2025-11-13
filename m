Return-Path: <linux-ext4+bounces-11854-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 09414C56F7C
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Nov 2025 11:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 45E18341C24
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Nov 2025 10:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B996C332EDE;
	Thu, 13 Nov 2025 10:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OnkRsypH"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6B533375E;
	Thu, 13 Nov 2025 10:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763030714; cv=none; b=gjh2lxPYdaocFEsXj9/b3yIjcu5Y3GY7LLLM6/ISBHPRnF22DyfOKCS+9RCG5dbW/Xmr879Djzbhiz9HW5Qp6PsrblWQ/Z0O3tsyOKBSrhB00sBZYMjFovmIUvba5CBuEw3tuVF/ugHi+19jriRB3M9u0t5++fUnOtkj+SEVbeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763030714; c=relaxed/simple;
	bh=0V4nmiVLu6WmrmPcgP+RB2wXKuhog7gPfyMDiYBhcPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQFianL3iin3aWw2dKwRQUEo3ZGuTrvgsrml8+WQH6Q4o5qYezD5LoI5R/75p/gAEUmue1lOyfxI71sJVQAA3tlKxtqm9vL7jVqgT6tHLmbT6JRCi/WpIDGXCSnJLnHLFKj2tem4gu8/ooxkB1+fcEN7vVnE9OoJDiU9O2teJ+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OnkRsypH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD8bvtR001049;
	Thu, 13 Nov 2025 10:45:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=G7wOTt0vc428XVIX+02emwrOH8y8Wb
	1IdbQw3SNwLEo=; b=OnkRsypHc/GOA+xA6RICIw39KIIhbMMC5pZvsJGwL/4VQ1
	mdHo7KcbRDiLDQlERmGVlSuEE+ebHCHFDv3rTbqDSMEPsMtsBUvNaa1j8FIIR5dq
	br/AvNdaJw270ZhnuQ76ifxcvlW5TjQRHDH6h5fNqqnvTzj16Hteg8ZPTRB9OJ9W
	oR7Kj4+MLPpLLsfbCxIz2xqgvXvaw8PeYMiNl5a5U+qJC1TEdTPUDEbILot3MpIG
	+OyhwgeHbaKb17cfaeNJbd30UrkaROpcJLAe0qUqGMFpZPbHX1jJNTS3721KkzBV
	PURzd6eKQEW5UItQLVlVy+N2pYjiUUCNNlJLT/oQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5tk4t63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 10:45:06 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD8lqSO008190;
	Thu, 13 Nov 2025 10:45:05 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aah6n5a7k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 10:45:05 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ADAj3JZ53477822
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 10:45:03 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B72B620040;
	Thu, 13 Nov 2025 10:45:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 86FBC2004E;
	Thu, 13 Nov 2025 10:45:00 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.211.50])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 13 Nov 2025 10:45:00 +0000 (GMT)
Date: Thu, 13 Nov 2025 16:14:33 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 6/7] generic/774: reduce file size
Message-ID: <aRW2kc-cILSIWeRF@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <176279908967.605950.2192923313361120314.stgit@frogsfrogsfrogs>
 <176279909116.605950.12144124358096086284.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176279909116.605950.12144124358096086284.stgit@frogsfrogsfrogs>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ksUJF7KvZ6IuQFr7ZMqtYS2qmNii1hLi
X-Proofpoint-ORIG-GUID: ksUJF7KvZ6IuQFr7ZMqtYS2qmNii1hLi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA5OSBTYWx0ZWRfX9F56dfQggZNs
 W4TV0oVC2LHOd0h72G3bM0Rz6/plkCnBIWoL6d0J78pR02H6tlz6SbjUyWeoptOPpkdqDCuRd/d
 nP82PmsKQUUNQ3NySB8tGBMUmzThiHNy0zcvLpfhE7vuj83B3eygG+4nXKvV53qNTbH5u/0f4Ne
 eifppE55ddujfTE93wpKnRh4iyovrW9xAJ7UnJyWc2H57sVVzjZNeiho8ksQrVTUkoD3JJkX+5Z
 Yb9f9fhR7QI79dfwIhzsZFsI++RePaMX1Euyd5DlRyjWhfQtrvX4CR9swNrP7FIcnX4VsCostt/
 RjTO72yVS6ZDBTRkQ+7VPM2N1oOmX5IiZVgIwfVBHrsT+EJCArgbeT6nOx+x4oZBqTVn1vNXG8X
 mKh0l15gzKzprMKNIUu7KnBmKr8QBg==
X-Authority-Analysis: v=2.4 cv=V6xwEOni c=1 sm=1 tr=0 ts=6915b6b2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=FzDxYMQOQF-4DHx3sykA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_01,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080099

On Mon, Nov 10, 2025 at 10:27:35AM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> We've gotten complaints about this test taking hours to run and
> producing stall warning on test VMs with a large number of cpu cores.  I
> think this is due to the maximum atomic write unit being very large on
> XFS where we can fall back to a software-based out of place write
> implementation.
> 
> On the victim machine, the atomic write max is 4MB and there are 24
> CPUs.  As a result, aw_bsize to be 1MB, so the file size is
> 1MB * 24 * 2 * 100 == 4.8GB.  I set up a test machine with fast storage
> and 24 CPUs, and the atomic writes poked along at 25MB/s and the total
> runtime was 300s.  On spinning rust those stats will be much worse.
> 
> Let's try backing the file size off by 10x and see if that eases the
> complaints.

Hi Darrick,

I agree with John's comments on limiting the awu_max to 1MB as well. But
regardless, this change looks good to me. 

Feel free to add:
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Thanks for fixing this up, I think I didn't test enough with slow
storage which made me miss these issues for g/774 and g/778

Regards,
ojaswin

> 
> Cc: <fstests@vger.kernel.org> # v2025.10.20
> Fixes: 9117fb93b41c38 ("generic: Add atomic write test using fio verify on file mixed mappings")
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  tests/generic/774 |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> 
> diff --git a/tests/generic/774 b/tests/generic/774
> index 7a4d70167f9959..28886ed5b09ff7 100755
> --- a/tests/generic/774
> +++ b/tests/generic/774
> @@ -29,7 +29,7 @@ aw_bsize=$(_max "$awu_min_write" "$((awu_max_write/4))")
>  fsbsize=$(_get_block_size $SCRATCH_MNT)
>  
>  threads=$(_min "$(($(nproc) * 2 * LOAD_FACTOR))" "100")
> -filesize=$((aw_bsize * threads * 100))
> +filesize=$((aw_bsize * threads * 10))
>  depth=$threads
>  aw_io_size=$((filesize / threads))
>  aw_io_inc=$aw_io_size
> 

