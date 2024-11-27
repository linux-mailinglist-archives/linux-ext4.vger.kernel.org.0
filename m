Return-Path: <linux-ext4+bounces-5431-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0BB9DA1A5
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Nov 2024 06:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06C471654B6
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Nov 2024 05:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1122A13CFAD;
	Wed, 27 Nov 2024 05:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Qw6H4OIz"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EAD481CD;
	Wed, 27 Nov 2024 05:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732684299; cv=none; b=kCiIavRPg1YpHgd3h868cMlU0jbyphNEQPN1ZHCOATAwPd+YY/dLS6xl3DzZ5i3S25FQkLjdgnrIdvZ0TEsjvpJdj7KBngbQuP9f+yPTxiK+uHLbRMtUPgqGUc4i+7FUQVYN5HXkmLJcmrm6+oFinO6LADWiAAXranwWwc5qFN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732684299; c=relaxed/simple;
	bh=qrkOGM6Gbh9TLjWT+u6nRVQT6FDAjux/1T3+M1VnVQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oZEW3f913YpgG29cI3Kkfcs/xw3x2MCQtrlNvGJYJLqC05/zU7jyZnq2+FOGVHl3ioQ0wxadyJaHXGcqw3tvOHcZDYM0pepRIjSAe07YGgkmTcsaVtyY3BvMkojLUltyY/HaxbFi+xx2tA1ci2XPsf3hg+a8Z9m67HMrh7+4+jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Qw6H4OIz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AR1hAE4021843;
	Wed, 27 Nov 2024 05:11:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=20te9S
	TD66VlO9s+dcaD8xcDf8C5gZ+SkWqFR2Fyj0U=; b=Qw6H4OIzQp2LY1kxH1zPA1
	L+QNFdIpoo2B88lk4fcXAjhxUhxNXFk69VBH9rrHEoBXaPafGvBqQ/rOJjPQ4eZL
	NfCY2GnzkrFETl8kStYf4Q7sePaKaZkvcnj+XSNmH1banhJdcYNpssqnfEtu8Nrz
	cfTMM4luXe3x88VgeZsVbX/aTihs65bRbE+5CIsshDeKHTDsOq7gxR1GxmMEs5rs
	WUIf5TPfMlnwQ2l81wt2PouXKKVTKizN1HDx3XY4SaB2pm7Cp4Bs4EVt44AJrEer
	b0hRxS3vlaeUSKYCm01+S8ZA10ZmvKVfMpAIy7Lr0p+o5Ti+DAghGYIGI6GLjeBQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43389chyag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 05:11:35 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AR53cSS021514;
	Wed, 27 Nov 2024 05:11:35 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43389chyae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 05:11:35 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AR506m7024893;
	Wed, 27 Nov 2024 05:11:34 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 433tvkjde8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 05:11:33 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AR5BWxv29688484
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Nov 2024 05:11:32 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E72352004B;
	Wed, 27 Nov 2024 05:11:31 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A403820040;
	Wed, 27 Nov 2024 05:11:30 +0000 (GMT)
Received: from [9.39.20.219] (unknown [9.39.20.219])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 27 Nov 2024 05:11:30 +0000 (GMT)
Message-ID: <53139dfe-2c2d-4488-8eba-dd30cfc1af93@linux.ibm.com>
Date: Wed, 27 Nov 2024 10:41:29 +0530
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] common/rc: Add a new _require_scratch_extsize
 helper function
Content-Language: en-US
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org
References: <cover.1732681064.git.nirjhar@linux.ibm.com>
 <fbc317332fb3d76680f65eb0c697f8c16b958bc4.1732681064.git.nirjhar@linux.ibm.com>
 <87mshlgt93.fsf@gmail.com>
From: Nirjhar Roy <nirjhar@linux.ibm.com>
In-Reply-To: <87mshlgt93.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: F5aniYUEEf4XSovvkywpt94PyaTWVNQW
X-Proofpoint-ORIG-GUID: Vd1gbArkoCvXFD6hudnQrl_pj5JWD3FC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=639
 adultscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411270040


On 11/27/24 10:36, Ritesh Harjani (IBM) wrote:
> Nirjhar Roy <nirjhar@linux.ibm.com> writes:
>
>> _require_scratch_extsize helper function will be used in the
>> the next patch to make the test run only on filesystems with
>> extsize support.
>>
> Sure. Thanks for addressing the review comments.
> The patch looks good to me. Please feel free to add -
>
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Thank you.

-- 
---
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


