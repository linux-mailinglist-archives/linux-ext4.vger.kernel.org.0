Return-Path: <linux-ext4+bounces-5422-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5E29DA15E
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Nov 2024 05:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4442D283EA6
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Nov 2024 04:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D612D13AD2F;
	Wed, 27 Nov 2024 04:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RyT56qJN"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C67E367;
	Wed, 27 Nov 2024 04:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732680626; cv=none; b=L3E29YWGRky+hTv+RNGu3ZwHF/t/CI2Z43gZtPhpiCRObJorKVLNDoBjH9mlBDek21hRHA8GDO9Ok9N/4bb+cXZF8cOURVYceV6wzyFrm6dMS3Z6pSZ91f8MiS4fyIbYSvGWZHwN3Z/iq75moo24RfQ0aX/Xo+wLiwaEEzPVcA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732680626; c=relaxed/simple;
	bh=RDCfDL5zHP8wZOrnSwImmaS1HJCU3ZLuscRrgGfPEGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ffxBLtuT1TE5ThEi4PwEtd/72Z1PICwb/PB+2pt6mbTjfy4TcvJtuRVcC3tsbkKSUDpHj1yzQW/N+g8rReqLeEGQVXVSr8qKhC31xr6X4mG84yXz/FTotGq4OsdbLwLGqyr5Zx4q9bExsnC0lw5gHXdPMO7UP0+NmLx0IFMxhz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RyT56qJN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AR1ifRc032407;
	Wed, 27 Nov 2024 04:10:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=uvLvwK
	jQcheNpdb1b+6MG4l3nFu4kDuvTiG6PzOZBGE=; b=RyT56qJNnpeIdUBYk9Pp53
	rp8OGLHB/jWCwhRNPERJPT9CBJvMcCrsDtgxw089poTwCfsGcpNPpzvoe51JdbV7
	SpHb4OzhwpCsDz1K1Y8HNJZ7OXYfrHrWa9GSrIYZ6OKGrNUs7HZZYze08Jbyiu/G
	5RalW7jYi0V9gNcdIAuLvZBas7dej0AtJiLa9/tYRf0fOrcQMg5HawtVCNfKu1iP
	7xzL9zFHGYdYEtJDcbbmwDVeOBE/Fr/U4RW4ikbiCV5URXLpxBCb8zw53f7wQlK+
	zuRKnuD94XNuVvGL2AgFHteIZF0p/BiV4s2DYj4YjAW7cJl6IqBAm+ZXvzuEByHA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43386nhr8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 04:10:15 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AR3xItY030486;
	Wed, 27 Nov 2024 04:10:15 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43386nhr8a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 04:10:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AR0oJ7f026384;
	Wed, 27 Nov 2024 04:10:14 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 433v30wkr0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 04:10:14 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AR4ACWr20840858
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Nov 2024 04:10:12 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 826C220043;
	Wed, 27 Nov 2024 04:10:12 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1814C20040;
	Wed, 27 Nov 2024 04:10:11 +0000 (GMT)
Received: from [9.39.20.219] (unknown [9.39.20.219])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 27 Nov 2024 04:10:10 +0000 (GMT)
Message-ID: <c8cb3b2c-7977-48d1-8655-e30f8ff4c9df@linux.ibm.com>
Date: Wed, 27 Nov 2024 09:40:10 +0530
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] common/rc: Add a new _require_scratch_extsize
 helper function
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
        ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org
References: <cover.1732599868.git.nirjhar@linux.ibm.com>
 <3e0f7be0799a990e2f6856f884e527a92585bf56.1732599868.git.nirjhar@linux.ibm.com>
 <Z0VqZP7dIVVbBPNc@infradead.org>
From: Nirjhar Roy <nirjhar@linux.ibm.com>
In-Reply-To: <Z0VqZP7dIVVbBPNc@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 87QlRgxuuK7p8zmtxemPftX_BnjCfBAH
X-Proofpoint-ORIG-GUID: ltcKDCpizO9IgVlJRSIU_eW8aJYA1Gfh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=367 suspectscore=0 impostorscore=0 malwarescore=0 spamscore=0
 clxscore=1011 adultscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411270030


On 11/26/24 11:57, Christoph Hellwig wrote:
> Looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
Thank you.

-- 
---
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


