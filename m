Return-Path: <linux-ext4+bounces-2908-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF342910B36
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Jun 2024 18:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 352F0287B0A
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Jun 2024 16:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770221B143D;
	Thu, 20 Jun 2024 16:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZPvpPqKs"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A281AF68A;
	Thu, 20 Jun 2024 16:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718899617; cv=none; b=XbSdTJcoRNSg4ajV3CH90y9gwnamyQrtDCISMYYBUWTRIbuuD81C0hw5iM3lSa9ZYi82VpvWHaO80BPpBBDQgkK2c7j+hFb2IvR79v3nZIMQHvwDgOoTPzify863KfXoQWiYAoEgmqNKNj/1iUMEjsindfnJd2WtrBZy27gufd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718899617; c=relaxed/simple;
	bh=zXbdU1oLq+AqkMmyeelEkii4gp4zKH4SF9MBqk8l1aQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UykP50NTydc68TizzyBdNOSglWRZStahMMu0pmAzsO6wBmilTNzAZodFqZdGQ2uQ8fUSPEn5sDhygg8T+h++AsyBJBzLAoqqpK7PeQ0y0bxRD9RSo+ThW7TJLS4XdJjvPIei/mw2nBuHcFqA7jbKb1s7FxwDanLv6manHDOeM/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZPvpPqKs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45K9v8Dd029254;
	Thu, 20 Jun 2024 16:06:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EPYPyP+Di0PB2m1ljCIq9SqCdLBOpOwq7ZjrKC+Akfs=; b=ZPvpPqKs2KHCPu5i
	QREhhYMtDXaie3wT27IVyu3YdkmgoV4ZZZR1g/SyzPggLSKlj2XbpBeRMnrJ3/Wq
	d1z/KsXxaESPT4p3gd2qm5RbMVtWwbSwfAPFPSjaA35EqRKSANZr9KbZMDLSaRek
	TYlJPW8xBJW6SeoBNz/Sh7PsduY9usVA5i6O/DAB4RiqObx2QcAZCo1u6Z47Jj/+
	KnNhR5ie6Jsm/3lL2p3DLz+uCr/uKN6cHQlFnfgVWAE+SNU6Mhl4p3FqGoSle+PT
	rxbWFfcUzgVUXUb1zNojYR1X9sZpkaP8YqLVuniocSkPSU3HyEYvfX8WRA5bTWUT
	fl52Zg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yvabp1wf0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 16:06:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45KG6i9v031711
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 16:06:44 GMT
Received: from [10.81.24.74] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 20 Jun
 2024 09:06:43 -0700
Message-ID: <bbff5b14-75ae-4dc3-9aac-17afd4e92693@quicinc.com>
Date: Thu, 20 Jun 2024 09:06:42 -0700
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: ext4: add missing MODULE_DESCRIPTION()
To: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro
	<viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
CC: <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20240527-md-fs-ext4-v1-1-07aad5936bb1@quicinc.com>
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240527-md-fs-ext4-v1-1-07aad5936bb1@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: iEhmeQnKT_kDzTdiXLG0NGm9C5dm5tlb
X-Proofpoint-ORIG-GUID: iEhmeQnKT_kDzTdiXLG0NGm9C5dm5tlb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_07,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 phishscore=0 mlxscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406200116

On 5/27/24 11:02, Jeff Johnson wrote:
> Fix the 'make W=1' warning:
> WARNING: modpost: missing MODULE_DESCRIPTION() in fs/ext4/ext4-inode-test.o
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>   fs/ext4/inode-test.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/fs/ext4/inode-test.c b/fs/ext4/inode-test.c
> index f0c0fd507fbc..749af7ad4e09 100644
> --- a/fs/ext4/inode-test.c
> +++ b/fs/ext4/inode-test.c
> @@ -279,4 +279,5 @@ static struct kunit_suite ext4_inode_test_suite = {
>   
>   kunit_test_suites(&ext4_inode_test_suite);
>   
> +MODULE_DESCRIPTION("KUnit test of ext4 inode timestamp decoding");
>   MODULE_LICENSE("GPL v2");
> 
> ---
> base-commit: 2bfcfd584ff5ccc8bb7acde19b42570414bf880b
> change-id: 20240527-md-fs-ext4-9d52d6959fb6
> 

Adding core fs maintainers.
Following up to see if anything else is needed to get this merged.


