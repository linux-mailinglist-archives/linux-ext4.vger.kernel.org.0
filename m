Return-Path: <linux-ext4+bounces-8037-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 327CAABD783
	for <lists+linux-ext4@lfdr.de>; Tue, 20 May 2025 13:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 134337AD70B
	for <lists+linux-ext4@lfdr.de>; Tue, 20 May 2025 11:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E9E27BF85;
	Tue, 20 May 2025 11:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PDgk5NpW"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F051E2853;
	Tue, 20 May 2025 11:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747742225; cv=none; b=HYVPSnpbq2KTfNjUdejo9fYsflMdxQ3PEm+8D8t/yX3DaphE3szWYYSOEbaskOKbg5Qr13TmYXtZmq4RASp4TeUFrAeaihi07zNU5a2o7KQrno3/rbH2o/Cdu/Dg88T80KGl9kWIyWHj59YO0JPtZcRoxqAvZuzzvBmaV2DCONM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747742225; c=relaxed/simple;
	bh=qb4Uil2Py57WrJKbeDAYU6Y5108CdaFOWckAGO0EBNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TU4CtY9V8SVV8llfyB04FZCmcBb4BgaXltGSelu16shsSo6DFO8Zadixnu1nUuVDmWBkDig6gWUwbOlIJ+8zopwLIi2HcxZnoBYUy568uXGricYXR6tJOirCavGU+kbsSfmie6hV7aoF+GpZkY5l80bIm+GEeA2MW68aaCQkoj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PDgk5NpW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K9FCwE008573;
	Tue, 20 May 2025 11:57:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=0ynAJgnPnxYP7tXvcGzmX4wnNv8Ep5
	GpU/u7NKez97I=; b=PDgk5NpWZmFkMSTi2/hLbq5CmDU/qMvWOM68bGygNjJG5D
	CQP5yESIXh2jvwgrXNaC3rjo4Dz2bef0ELexG8LqR/OBe+k9cE6VNBjqW0LyO8cM
	RxhyqBf0TjddP+5vVYjZzW9IxlJ/ejW+XyEDQabgxmMGzjn4k/gUAfEz/fKYVPiS
	X/MeAb7EgftL2Jr/Nc7MyJ3LvD/tdyrHODFEl6EMe5YZQKK1L2PuUp1XJRzz8iIV
	WurbGl45eCo3UpVamxLoMjbQs+J+pFmWIaL437wT8/+YQUoIV+5/SryJX3R1gmcx
	DeqYbv0TJ/zmk5S+wIqwDTJii5dIxDzPdXgZV8Zg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46rpxkrsrr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 11:57:00 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54KBv0W3014297;
	Tue, 20 May 2025 11:57:00 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46rpxkrsrm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 11:57:00 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54KBUOrX008244;
	Tue, 20 May 2025 11:56:59 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 46q70kbhpf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 11:56:59 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54KBuwn957344432
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 11:56:58 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E61DD20040;
	Tue, 20 May 2025 11:56:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C18E2004F;
	Tue, 20 May 2025 11:56:56 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.28.45])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 20 May 2025 11:56:56 +0000 (GMT)
Date: Tue, 20 May 2025 17:26:53 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Guoyu Yin <y04609127@gmail.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] WARNING in mb_avg_fragment_size_order
Message-ID: <aCxuBdzvhK8lfmAQ@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <CAJNGr6v57z_RR5fNV+tLuGXEVKLRfXdo+hNS81HzztaC7pgchA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJNGr6v57z_RR5fNV+tLuGXEVKLRfXdo+hNS81HzztaC7pgchA@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EM8G00ZC c=1 sm=1 tr=0 ts=682c6e0c cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=fGO4tVQLAAAA:8 a=D_i6x2QXH9yj9_nRLjAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: LTZWqiE52FgyVSrndm91Vjf8vmXjg3R0
X-Proofpoint-ORIG-GUID: taZPLA5zxgFPvJUei0kZD1AVk4Gx2KYi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDA5NSBTYWx0ZWRfX8VCxxpfGcHwZ RVufoh6WrcvnrfeIzbGPLEcVFtFNPm/nXxVNf5EZ2YiWBCAUsO/f/gn+d8WNDK6nrbjGJbgRa3A 0WDFuNAmoaU2S1SNfC2qNDAiN6nVrlvEFJLDwjDOgnNxlwZ/Q+aaDwycAS1/gItOEErRScvM6HJ
 c/ix0yDzeMIZ4nFM0llw33a2V6fGBBR1b3/rIvx2Vg6GR00v4F1qlgG2wUMxogVIhJ9lxAeZ1j5 VAHlHPIBOozDiZSBTe19RkJHQX5gWljGmEo2BGReZpYwyGLzGuVHnN4FOa7pRhTN+EI44SHPZoS ILZgrL5Mu57t/oACT9QqckHHAPyD60vHma93rYeVuKM96drlvfXlK4mmTezpDHoOMSnfxQTf6N3
 ST+Q8nyY6pb+PR6agQF4o2ELmKtuzwFqigIPqPH1mDS/7i5aXOYrCIqA1b/EA54NQ++jAAhg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_04,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=907 spamscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0 clxscore=1015
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505200095

On Tue, May 20, 2025 at 01:12:11PM +0800, Guoyu Yin wrote:
> Hi,
> 
> This crash can be triggered by repeatedly performing specific file
> operations, causing a kernel warning in the Ext4 multi-block allocator
> (mballoc) module. The issue arises in mb_avg_fragment_size_order due
> to an invalid len parameter leading to an out-of-bound order, thus
> triggering the WARNING.
> 
> Root Cause:
> 1. Code Path: In ext4_mb_choose_next_group_best_avail(),
> ac_g_ex.fe_len might be incorrectly calculated as an excessively large
> value (e.g., via roundup).
> 2. Invalid Parameter: When ac_g_ex.fe_len is too large, order =
> fls(len) - 2 in mb_avg_fragment_size_order() exceeds
> MB_NUM_ORDERS(sb), triggering WARN_ON_ONCE(order > MB_NUM_ORDERS(sb)).
> 
> Code Locations:
> fs/ext4/mballoc.c:834.
> 
> Proposed Fix:
> 1. Add validity checks for ac_g_ex.fe_len in
> ext4_mb_choose_next_group_best_avail() to ensure it does not exceed 1
> << (MB_NUM_ORDERS(sb) + 2).
> 2. Enforce strict input validation for len in
> mb_avg_fragment_size_order() to reject invalid values.
> 
> This can be reproduced on:
> HEAD commit:
> 
> fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
> 
> report: https://pastebin.com/raw/W5ejqsNx
> 
> console output : https://pastebin.com/raw/U9qUGBhY
> 
> kernel config: https://pastebin.com/raw/zrj9jd1V
> 
> C reproducer : https://pastebin.com/raw/TCwWzfaH

Hi Guoyu,

A quick run of the reproducer is not able to hit this issue for me. I'll
try once with the config you privided. 

Also, it's strange that we hit this since the ext4_mb_normalize_request
takes care of making sure the goal doesn't cross the maximum blocks
buddy can allocate in one shot (ie 1 << blkbits + 1), which should
in-turn ensure that the goal length order is never greater than
MB_NUM_ORDER.

I'll try to see if I can hit it. In the meantime, if you are easily able
to replicate it, can you provide the following information:

1. I see you are testing on kernel v6.13-rc2 which is slightly old now.
Can you check if you are able to hit it on latest mainline kenrel
(v6.15-rc*)

2. Also, if possible can you please share the output after adding the following
tracing, example:

  sudo trace-cmd record -e "ext4:ext4_mballoc_alloc" ./reproducer

and then

  sudo trace-cmd report -i trace.dat 

to view the output in text format. (You can also use perf probe -e "ext4:ext4_mballoc_alloc")
to collect this.

Regards,
ojaswin

> 
> Best regards,
> Guoyu

