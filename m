Return-Path: <linux-ext4+bounces-1059-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F713845A99
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Feb 2024 15:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74A471C28209
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Feb 2024 14:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753BF5D473;
	Thu,  1 Feb 2024 14:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IAavYhwJ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C74953360;
	Thu,  1 Feb 2024 14:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706798964; cv=none; b=ST6mm3AIJmzyNgJZ+jEQTur94jWCOpIeepDSRKquAl8KAw6ALLcfQltIr4uobrRXJH1hxDzIFFXM4Ql9oWYtt8NpregVdDTMngNabp9jfAzQRNFAQUMCIN8iMrVUO/8ywFow+CGx4AdjGqVBRDPPHdCqsydO2r4azgoKM6TqWPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706798964; c=relaxed/simple;
	bh=LcXQI8abkOri3PWixBLK/i23BRAp25Y0A37S14neU8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tuj2JbXsNOMkg9wdLgohoLAgbHcSCg91Ana6HVNIA/+tb6oiEqKoeZBRHa52WEUuPrMQVBW6YB5sogr0Da+PTezCjXHm1oRgccOUheP6WINm0kCp+ga3iQMEIdaXZAftWnbgaUwmKAx+cniZORUEY5WXo+kG6unUdzr9d9kpKMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IAavYhwJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 411EejNK025987;
	Thu, 1 Feb 2024 14:49:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=jfGySMiZGIQS7MTkzXaXUnV2Kv3JIO1qCvcUWAK2cTw=;
 b=IAavYhwJdFspr2Ed9q1j2iBs4cMaa0XJ145uGsDVXEHgCsCH4ZtoTCKz9p3/Izj2FULV
 9KAzP5vTYdtWYaME8nAAVl6/m5Icy5kdWJNCEGmywQ+ywojxafc93aWs0c/3eG37R2W/
 eGrmilVtdvJKwKkh8zAdaOOtnixT+r2F+4dZOMtdU+theKgj0r44q1YgQd1oMJaQejw0
 5hfXF821Nuy0KOkclNpovGtNJhJXJelS9vT3DbchjDqwG2SP2WppjTenRduvQudpFS6Y
 wQXrimqZfcZTFQmO6ji882Quon9gUF0KlDerqySFParOWXDXObrQAMeN85xJFWTHL1Xk dQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w0bqnjwqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 14:49:01 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 411EC9vn002290;
	Thu, 1 Feb 2024 14:49:01 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w0bqnjwq4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 14:49:01 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 411EWTPv007184;
	Thu, 1 Feb 2024 14:49:00 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vwev2mb6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 14:49:00 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 411EmwGu43450858
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Feb 2024 14:48:58 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 974C420040;
	Thu,  1 Feb 2024 14:48:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF07C20043;
	Thu,  1 Feb 2024 14:48:55 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.108.243])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  1 Feb 2024 14:48:55 +0000 (GMT)
Date: Thu, 1 Feb 2024 20:18:53 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, chengzhihao1@huawei.com,
        yukuai3@huawei.com, stable@kernel.org
Subject: Re: [PATCH v2] ext4: correct best extent lstart adjustment logic
Message-ID: <ZbuvVSI1GrAeK8hM@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20240201141845.1879253-1-libaokun1@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201141845.1879253-1-libaokun1@huawei.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6ocGdo9fYaIGs-dNLZMP46o-N_sGvdr6
X-Proofpoint-ORIG-GUID: P4ka9Ulo7s_HQ6UoKitvQxh4WTTE20DT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_02,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 phishscore=0
 clxscore=1011 impostorscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402010117

Hey Baokun, thanks for the v2.

On Thu, Feb 01, 2024 at 10:18:45PM +0800, Baokun Li wrote:
> When yangerkun review commit 93cdf49f6eca ("ext4: Fix best extent lstart
> adjustment logic in ext4_mb_new_inode_pa()"), it was found that the best
> extent did not completely cover the original request after adjusting the
> best extent lstart in ext4_mb_new_inode_pa() as follows:
> 
>   original request: 2/10(8)
>   normalized request: 0/64(64)
>   best extent: 0/9(9)
> 
> When we check if best ex can be kept at start of goal, ac_o_ex.fe_logical
> is 2 less than the adjusted best extent logical end 9, so we think the
> adjustment is done. But obviously 0/9(9) doesn't cover 2/10(8), so we
> should determine here if the original request logical end is less than or
> equal to the adjusted best extent logical end.
> 
> In addition, add a comment stating when adjusted best_ex will not cover
> the original request, and remove the duplicate assertion because adjusting
> lstart makes no change to b_ex.fe_len.
> 
> Link: https://lore.kernel.org/r/3630fa7f-b432-7afd-5f79-781bc3b2c5ea@huawei.com
> Fixes: 93cdf49f6eca ("ext4: Fix best extent lstart adjustment logic in ext4_mb_new_inode_pa()")
> Cc: stable@kernel.org

So I'm not sure if this is actually fixing a BUG and if we need to
backport this to stable but I guess Ted can take a call on that. 

Other than that, the patch looks good. Feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>


Regards,
ojaswin

> Signed-off-by: yangerkun <yangerkun@huawei.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

