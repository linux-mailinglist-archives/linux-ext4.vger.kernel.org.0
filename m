Return-Path: <linux-ext4+bounces-5424-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A65359DA162
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Nov 2024 05:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67C6E284486
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Nov 2024 04:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4FB13AD32;
	Wed, 27 Nov 2024 04:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qFmAqLu2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E88A28EB;
	Wed, 27 Nov 2024 04:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732680666; cv=none; b=owJPRsKaqzHTfXv1Wi6rWsk3KHUKWYpbhGh5MHoY7HIDkDS/uobxWAY5f+D9f8mGEZ5rfmrO9GfX8chBux5uLV+pL9V1AzQKv7SiqQHg16At9GXv34b5X8W2KicUebVvOPpYXTAtGTrj0bplzGzxfySo++uW06q7Fl+eodk8Ryk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732680666; c=relaxed/simple;
	bh=TYTDcjsqNKeaTPwfZYzMQyvFJJHi+MtHNhnX1Jbhr8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hfVhR+qw6rZby0j10XI8jFlPVMT93/CXiiFf+JkXccPpgO063eS/WgxBz02xRyWF3j9Pzy9NWCZFxUhFdLc9XpBoMBbEgxu/tdhACXgtZj5vcMKN45vgsNtB3qvEFrEU7EIg9QNcZYew477jdVykOJRN8nE3hEofeNifg9QG3nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qFmAqLu2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AR1hFKb029064;
	Wed, 27 Nov 2024 04:11:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=AcANvL
	BRj0URF3S+mm9MgzkLiCa5FPcE7wfCsyDaFZI=; b=qFmAqLu27pGWUNS7cAz312
	DK2NrjHsxZaYUaLO5aSBNtq2WHWbC9+apaNfvUD0HO9RkgM+Txo6onx8h8jpgIpr
	QwF8zltQIRT9c3UcoLeJdTS8lYz64GB0lsYkA6zxi4pLbQCUY0c0pBLT1HFzP5sZ
	dWsSXphV+8jHQBv70Ptuv1LW6HrDBJ6XqXRua51994QrrwKNMVQ6pMGpvyK11eId
	nWWDwL1BJK7xDqNSMOH3neTVB1AJe//8O3KnkTCqxYKey1a5NDu/qlOk0seUtSFw
	Y0iheG+Loe4T+RMD0QkNX4PG7fQMXTATxsYyljWPf2yPjYtq23hj5gHYA9lLVRHA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43386nhrah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 04:11:01 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AR3vx1w025979;
	Wed, 27 Nov 2024 04:11:01 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43386nhraf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 04:11:01 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AR3m15s000843;
	Wed, 27 Nov 2024 04:11:00 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 433sryje50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 04:10:59 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AR4Aw8656492332
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Nov 2024 04:10:58 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 106F620043;
	Wed, 27 Nov 2024 04:10:58 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9AAFD20040;
	Wed, 27 Nov 2024 04:10:56 +0000 (GMT)
Received: from [9.39.20.219] (unknown [9.39.20.219])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 27 Nov 2024 04:10:56 +0000 (GMT)
Message-ID: <98fc9c14-b1ff-4782-b33f-dcbb8ac143ea@linux.ibm.com>
Date: Wed, 27 Nov 2024 09:40:55 +0530
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] generic: Addition of new tests for extsize hints
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
        ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org
References: <cover.1732599868.git.nirjhar@linux.ibm.com>
 <4b3bc104222cba372115d6e249da555f7fbe528b.1732599868.git.nirjhar@linux.ibm.com>
 <Z0VqeLeYbLX-uCeK@infradead.org>
From: Nirjhar Roy <nirjhar@linux.ibm.com>
In-Reply-To: <Z0VqeLeYbLX-uCeK@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: REP1evpLufzBhPRBPiEwJjHYF225dWGj
X-Proofpoint-ORIG-GUID: xys0g0p3JzD9Qcm4-IWDsqMWgO6UHZiM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=367 suspectscore=0 impostorscore=0 malwarescore=0 spamscore=0
 clxscore=1011 adultscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411270030


On 11/26/24 11:58, Christoph Hellwig wrote:
> Looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>
Thank you.

--NR

-- 
---
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


