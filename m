Return-Path: <linux-ext4+bounces-13089-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F2AD3C2CD
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Jan 2026 10:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 069744C9672
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Jan 2026 08:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7295F3A9D8E;
	Tue, 20 Jan 2026 08:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BYaHnmIO"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703203B5300
	for <linux-ext4@vger.kernel.org>; Tue, 20 Jan 2026 08:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768898747; cv=none; b=q2ZTXDQcRcqTYpv+L0fk1CGf7oep8f9lQqLm7k9ghw6v/e5ExtrF8emQgnl+PIiFa/AxUzgL2MuDTQwrKMgm9cXvMo1fcZusmW3MP/bZi8IIeuHlFIrMVw+s2FSFCXHlMEjgpEkh5JkrzbJeXDgyBfDpKLGL0pi+DLVFL0bcDyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768898747; c=relaxed/simple;
	bh=d+JTxiEMK+/Qv5YFRvhuqD1K4Z5FUqfVqXRbAoGvyNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QRwPfp7LTaXb0NaFcS/dBNV5R7mRvzMkAy0eCtxY+CFqaDIoq6t/i8O/TsO9cir0xiYq65ZZ1HXgYmqVzGLBCLmiWKh/T5MmsGw3hNbmxZU1+4wkEXjlZ1XtaDlLzdZKJlgaVSwiYg3Pccq5EexKQbltfvnQnCv4AU17wnRM+p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BYaHnmIO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60K8DTfh030379;
	Tue, 20 Jan 2026 08:45:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=8ibPNw+NZgUsyfut3lgEisQyraM+kw
	N4CAB0Z4hfrfw=; b=BYaHnmIOFfjyGNA9Fn+2o09EtV3PriwepSFVF+tpi1DiQj
	J2sbyUYBcz+pDZI1Vef4gs01jvcxjGfQBmkus4fYXTo+Yod0MJdKZ0Akgece7W3Y
	F7EQWnlMPlsaHOwjWjvVRyKkNZHJqCPuDtQ+ZUaAGzGBpy5RXnROwpNzlPdGDq8D
	lvDIV8fv5Uz7QxpgkEPoFFpJQgQrg1akifiBs6lYpWHD5C80bOhpZxybDpGon4aY
	T72gDsg6Gbdu4V/Iv8qfFhLS/brmIs2RmjDxGH9I/AaVyOF5/sjpW/p7yBHC9E7w
	NZPd5j9mMP2soj0xxzhaR69HH+PfCWuYDzF7TeRg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bt60eg509-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:45:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60K70ZtS024614;
	Tue, 20 Jan 2026 08:45:26 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4brxarj4yb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:45:26 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60K8jPMW50790784
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jan 2026 08:45:25 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 25C732004B;
	Tue, 20 Jan 2026 08:45:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1639F20040;
	Tue, 20 Jan 2026 08:45:24 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.158])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 20 Jan 2026 08:45:23 +0000 (GMT)
Date: Tue, 20 Jan 2026 14:15:21 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Ye Bin <yebin@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH] ext4: fix mballoc-test.c is not compiled when
 EXT4_KUNIT_TESTS=M
Message-ID: <aW9AofPgVKEL6bk1@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20260119131257.306564-1-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119131257.306564-1-yebin@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=WMdyn3sR c=1 sm=1 tr=0 ts=696f40a7 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=i0EeH86SAAAA:8 a=08Pl6IIc4GBuHI-mHw8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 64D5xVXiEc68dir5SWULo0RurYswol9Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDA2OCBTYWx0ZWRfX/0feg/IWsm1P
 JjNUxt+IOiMqATdupa0Qd/NE0K5B4E+SvhF+G6D966TOI7jBxD6r63Tz+Hq6kmpkulZNSbOWf4+
 sJTLnHuSl22yhW1LSRC/VkwFeWRUaKKJH9Y0rwqRfGO3U7lfnEq0GKaEYHET9GdoSCy4HSMn7Dz
 iVm3IuH1yaOI7iUQzZ1nHKpN8jppyrV9mL1uZXBSpK9CtpyJFhqz7luFOo8jIQ6cv+7UP0hsE7R
 o/1TE8ZoY1dpBd7YPsIJvidF7MoaMvKe0YC6mWel8nB17dU2zTLSk1J7VjrmQ1MOvgVHvR3Je7F
 0ebuuosoPDCAQmCI0aTZjRk2sEpg+hCPz+djc78Xp7zfIpsTNbqIqXD3w5ckUokUqH9TPtqTErH
 jOtp5eKNYJBAHikrG4erzi89J87UW9XQ6EUj+fkvSYnUdkl6L+2iqR47k82IRB5ylnHii+3S3Ja
 6mj4aWK1UU5zmBbgMyA==
X-Proofpoint-ORIG-GUID: 64D5xVXiEc68dir5SWULo0RurYswol9Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_02,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0
 impostorscore=0 spamscore=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601200068

On Mon, Jan 19, 2026 at 09:12:57PM +0800, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> Now, only EXT4_KUNIT_TESTS=Y testcase will be compiled in 'mballoc.c'.
> 
> EXT4_FS      KUNIT    EXT4_KUNIT_TESTS
> Y              Y         Y
> Y              Y         M
> Y              M         M // This case will lead to link error
> M              Y         M
> M              M         M
> 
> Fixes: 7c9fa399a369 ("ext4: add first unit test for ext4_mb_new_blocks_simple in mballoc")
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  fs/ext4/mballoc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index e817a758801d..0fbd2dfae497 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -7191,6 +7191,10 @@ ext4_mballoc_query_range(
>  	return error;
>  }
>  
> -#ifdef CONFIG_EXT4_KUNIT_TESTS
> +#if IS_ENABLED(CONFIG_EXT4_KUNIT_TESTS)
> +#if IS_BUILTIN(CONFIG_EXT4_FS) && IS_MODULE(CONFIG_KUNIT)
> +/* This case will lead to link error. */
> +#else
>  #include "mballoc-test.c"
>  #endif
> +#endif

Hi Ye Bin,

Thanks for pointing out this issue but your solution seems to be having
a side effect of making ext4.ko depend on kunit.ko.

  modinfo ext4.ko
  license:        GPL
  license:        GPL
  description:    Fourth Extended Filesystem
  author:         Remy Card, Stephen Tweedie, Andrew Morton, Andreas Dilger, Theodore Ts'o and others
  alias:          fs-ext4
  alias:          ext3
  alias:          fs-ext3
  depends:        kunit
  intree:         Y
  name:           ext4
  retpoline:      Y
  vermagic:       6.19.0-rc4-xfstests-g326263653b81-dirty SMP preempt mod_unload

That means we won't be able to insert ext4 module without having kunit.
This is not the behavior we want. I think a more simpler fix here could
be:

  #if IS_BUILTIN(CONFIG_KUNIT) && IS_ENABLED(CONFIG_EXT4_KUNIT_TESTS)
  #include "mballoc-test.c"
  #endif

So basically, as long as KUNIT=y and EXT4_KUNIT_TESTS=y/m we will run
these tests, otherwise we won't. This also removes the dependency issue.

What do you think?

Regards,
ojaswin

> -- 
> 2.34.1
> 

