Return-Path: <linux-ext4+bounces-8209-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8610BAC6CA0
	for <lists+linux-ext4@lfdr.de>; Wed, 28 May 2025 17:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF02B173097
	for <lists+linux-ext4@lfdr.de>; Wed, 28 May 2025 15:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4894C28C00D;
	Wed, 28 May 2025 15:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aDaL1CWn"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0676A28C01C;
	Wed, 28 May 2025 15:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748445048; cv=none; b=Snsm5vdqvvK7zAYNbde+eyhxMQzl4EynnxP44aFGCie1gGCUIMma9PB03eq/At07H5oahjaWQtTMuVs5XVkY2RlP8GMvphb7bdxrH6YOQmAnoZ9pR9qbludAkwQccIfxylfjqUryEB+ohuIyCZZk00OGcTRZNN2IipJeU1unixw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748445048; c=relaxed/simple;
	bh=VoneiAYFe68XxjFSpgm16dS0jALbbMgSV8pvbxVlj3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQzBUwa3CJpBs2YWKq7m9VGdQv+oBtEHReiqclkZd1Dr1ukjDGa7pbE6JVmuek08Cj3IidAIX3tlZqtQlrr04VztHe0eh68tC3lseuJfBlMtwciEazs0zocMJNFGvqoElrlVu0vNnQhgE/HVKNpHUPMFGgW0DtZxbu1UhfA6lM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aDaL1CWn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SE9mEf022816;
	Wed, 28 May 2025 15:10:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=V3i3Tsthb6Ljxbs39P+VC5rZ1AQFt7
	AlQ+UDegLoUvk=; b=aDaL1CWnZqv4JE4qnpbuhdn8Coo7lOhVH4jY2YCfrEhItt
	xi1nptzXndG6Uefw+CZ+TQmYOV4gBMVWV5FriPOk2gjEZfXl0XlnCdbWdsnAeJUK
	9/2dr1UpKNtICFweLWLTuOE5rQOQnMJe0fSI7c6IDlNrAjDAGA5WfFtoz9GaJPFj
	5XjO2WLaUwkaQP40e8HKMTckUYguxrapJWa3+Pp2BJx1oNgIom2Sy4WdTvMxs5m2
	SQZ3KtJeHMyNeMTlw/MNDLu8FdeQno74Z+GnhN8kTnPPNhKpWm6C+zCXcIZWOUcv
	l8Ho6mH3DrtjdAm4tDtw/RcRz1vMZMIVWQrJWlQw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46x40h0ceu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 15:10:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54SEpgrn021333;
	Wed, 28 May 2025 15:10:29 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 46utnmqu4q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 15:10:28 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54SFAR5227132332
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 May 2025 15:10:27 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F3C820040;
	Wed, 28 May 2025 15:10:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4800D20043;
	Wed, 28 May 2025 15:10:23 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.18.84])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 28 May 2025 15:10:21 +0000 (GMT)
Date: Wed, 28 May 2025 20:40:15 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, libaokun1@huawei.com
Subject: Re: [PATCH 3/4] ext4: get rid of some obsolete EXT4_MB_HINT flags
Message-ID: <aDcnV0LHAXGBJOEv@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20250523085821.1329392-1-libaokun@huaweicloud.com>
 <20250523085821.1329392-4-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523085821.1329392-4-libaokun@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8u1fMgIIcPi9DJU2JDz_2YtrciT_Y0Kg
X-Proofpoint-ORIG-GUID: 8u1fMgIIcPi9DJU2JDz_2YtrciT_Y0Kg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDEzMCBTYWx0ZWRfX4CIPuIELoWl7 kuYtLboGBzaGde7dFKP04KOsKFSf0eV8TDKk/IabS5J1wZRkgxhUWzlQbBagTnGS0Oj4Y3vPs1V 9qwSS1P0lAAtlTFr0GAvs+1aiWO1f8AVxbVIv0EKQSw/yPoxv29fjbzV1lpz/oKNkeN4wT1aDlT
 1o77i7Q1ConnhPqAM7zEWV4AVBzRbsY0wL9u+Q3qZ6O2inXJB1mf+RbuB++4sFypjj23xS6VnXU 8VksRzxQQ3Vihv+d8Tx2xR+mBl09fHi+9ul0RoqRO2eu73ngB7EmSJFsa5oLBBLG+6xXSom8/BM CZ6IF5YwQ0ZY8SHzWFGrRwp3cnHciNL4a9n3huDrcAVKct7YKuLaumO+sk1u1J5/AxkH/zQEFrB
 auytSD6j2AQN7WtA2UOEnl2SDmd4tL93GPh5Ymu5Zfr6ix9rP/K+Hfa6yxU9thW3dXGOdAUa
X-Authority-Analysis: v=2.4 cv=L8MdQ/T8 c=1 sm=1 tr=0 ts=68372765 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=AiHppB-aAAAA:8 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8 a=twkGVns3odX8MIeO9usA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_07,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 adultscore=0 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=319 suspectscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505280130

On Fri, May 23, 2025 at 04:58:20PM +0800, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Since nobody has used these EXT4_MB_HINT flags for ages,
> let's remove them.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
ojaswin

