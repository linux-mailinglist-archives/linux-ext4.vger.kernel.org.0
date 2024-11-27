Return-Path: <linux-ext4+bounces-5421-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 903BB9DA15C
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Nov 2024 05:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C81F168CCD
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Nov 2024 04:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A276613AD2F;
	Wed, 27 Nov 2024 04:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A3eR2y/i"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD638367;
	Wed, 27 Nov 2024 04:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732680607; cv=none; b=iN3mnoIR2gzX/wzNrckTqcDzJ22rjKvvY1/J4l9QkiCkcz3HoBqN+WtMJdOdpHbXlpmPRq2j+CZXJmLh2tJRkXwtDF2xPX8bGWstIa1SxPcaH42o//jNXRaUo6T3W0dfsuG/aVOzLxB1M1/T06hvGaJiTawnqlbz/VffYZHY52Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732680607; c=relaxed/simple;
	bh=fNhVKh1W9sZ0ZVAL0RPkDdpUL9UNteVSPSeXLMw1mbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jjQ80Vdq2x+r/EPqRhk5gX2Yw+CdMWfcvCSRD2OoQpDFE/HI2jAelbMHmBWIa74H6q98pIUEiTQFjZDzN/Byog5IuuQza5UpWy0PA5ViFHemS/EOOmWb/W16+BCtEVu8yXWHESYfeDfokP7vsJa0PmM47zPjDAFqftzZJMQUiOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=A3eR2y/i; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AR1h8fs010531;
	Wed, 27 Nov 2024 04:09:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=PyIZBO
	LXI5tGmm1llUa+7U1f4gW8MRhlHaGOrylYuPc=; b=A3eR2y/iu0f5mvJCeQeRr7
	QO+KXF0cacvGkSbk5AsQaIYTXe5F2cOaB9RDCgjnUvGMJztdirQa361STRfmhPbj
	02hIq0czPt8h9vt8G00RIxyVXOT1Iz+wuw4w008JIvgN/2HiG+MPjWF5W2h/Fule
	ZfzggZRMGbCHhW4DkYeyInmhmRCnReM+LkL/hV2+IXMwY1JuvaEAsOSV9lfLe2go
	+qfAcCYZpPpyYHBLib2KQ7ggd8BF3yeIBIoYojz9CKOnwXKl1Wpsj7vfsTBzjpuX
	j6SX478X+coOLnkstrE7MXWZihGugfTi+3lZUhuDZdmc51+Rud+o4MRjUJadmLrQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43386k1a0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 04:09:58 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AR40D52011053;
	Wed, 27 Nov 2024 04:09:57 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43386k1a0w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 04:09:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AR15eWi026351;
	Wed, 27 Nov 2024 04:09:56 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 433v30wkqh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 04:09:56 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AR49trp48300374
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Nov 2024 04:09:55 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1AC2820043;
	Wed, 27 Nov 2024 04:09:55 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A3F2220040;
	Wed, 27 Nov 2024 04:09:53 +0000 (GMT)
Received: from [9.39.20.219] (unknown [9.39.20.219])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 27 Nov 2024 04:09:53 +0000 (GMT)
Message-ID: <44851aa9-0804-492d-a0fb-982ff7479a5a@linux.ibm.com>
Date: Wed, 27 Nov 2024 09:39:52 +0530
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] common/rc,xfs/207: Add a common helper function to
 check xflag bits
To: Christoph Hellwig <hch@infradead.org>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
        ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org
References: <cover.1732599868.git.nirjhar@linux.ibm.com>
 <31b0c72649ec4308aa4e8981ac416addae4e1fdb.1732599868.git.nirjhar@linux.ibm.com>
 <Z0VqUcxr0O30RgWU@infradead.org>
Content-Language: en-US
From: Nirjhar Roy <nirjhar@linux.ibm.com>
In-Reply-To: <Z0VqUcxr0O30RgWU@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DMj43RsVs_HIarYlyB2dRDIcirSgCKvC
X-Proofpoint-GUID: jAKpNNo8jJh4B7yYx6VVt7wORY5X6AFW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 mlxlogscore=480 spamscore=0 suspectscore=0 phishscore=0 clxscore=1011
 mlxscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411270030


On 11/26/24 11:57, Christoph Hellwig wrote:
> Looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
Thank you.
>
-- 
---
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


