Return-Path: <linux-ext4+bounces-9160-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2593B0EAA9
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Jul 2025 08:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E58593B1B5C
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Jul 2025 06:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A4226C3B7;
	Wed, 23 Jul 2025 06:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="a9Od9cWb"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCEE248873;
	Wed, 23 Jul 2025 06:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753252266; cv=none; b=F6EekzSUyoyS55MwCsV7U9F9kgQiTEvMzHV8bTdnJuIfuY+ZW+ys6CdQRTWMVVKAYsioTu4/ySQ1do2fl+8GSkSX+hPSOVX7/AfrjGzC1AnZqkHCv8DRn9AL8q+gFv7BfSNrkffaYlyVZu7RlGxyFJQgthKyxA0hzhB4iTpwLLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753252266; c=relaxed/simple;
	bh=9nvMvBGs6JMLEfhugYRVg7nfMGizUadRYQsyGSOwFbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TGWqq3lKUSSIuEVWOckUgg4Tsm9JNtTrbGT62/obOTJn0MNtnNxxWoW/7M9W3rlIBNma4RuPNw+eaO7o95g01xO7PCTZ/t1Qmx9qfZWgLoSaMb1N/BIVOorQ9RtHvTbrfc0BR8vewwQO8MeermPyU4KvP088ehdtJ5Hg1hOVBUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=a9Od9cWb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N66vgV027701;
	Wed, 23 Jul 2025 06:30:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=UUEGT/sUYkFf4gih7YaF2crredDSL9
	YO30q2Z/pvqo8=; b=a9Od9cWbrb2SLn/u9nQtVJTN9qT3S70fCBMtqpvIheoacn
	9F1AEPHSTxJt0k4/zNDB6Ll9GwBwq/jsWY4q5HafywAmgdFYxbehKpd4a9oyiq4o
	xXu08uxkliLZyljzSoE18S7ByC1A6kVZQvvqEm7JKN1AY0migz83xZp60VTSFj0N
	cNX7Cl8Ku8MKfu7HuM3Vh02h0sXiZh77P6SFbCHkiX0g1VJ8JcYW7dKCiZPIBMQK
	LysLz8mDSS2JwucueNswqOZCEyBn5QKI2M/nvFjTMiybjcZLqmAr991I/USW5l/h
	ATjTV8pJO/+inOWNMfAC3y5dgaLexYe0LVGLddcg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482ff5k08r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 06:30:56 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56N6N8ht018047;
	Wed, 23 Jul 2025 06:30:56 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482ff5k08m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 06:30:56 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56N3M58L012823;
	Wed, 23 Jul 2025 06:30:55 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 480p306rbq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 06:30:55 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56N6UrSi57213290
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 06:30:53 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4037220040;
	Wed, 23 Jul 2025 06:30:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C486620043;
	Wed, 23 Jul 2025 06:30:50 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.209.114])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 23 Jul 2025 06:30:50 +0000 (GMT)
Date: Wed, 23 Jul 2025 12:00:48 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, john.g.garry@oracle.com,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 08/13] generic/1229: Stress fsx with atomic writes
 enabled
Message-ID: <aICBYrgdwZUcm2C7@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1752329098.git.ojaswin@linux.ibm.com>
 <1e1e7d552e91fab58037b7b35ffbf8b2e7070be5.1752329098.git.ojaswin@linux.ibm.com>
 <20250717162230.GH2672039@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717162230.GH2672039@frogsfrogsfrogs>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA1MCBTYWx0ZWRfXzRIi3k0Ck60u
 ROtC2tLWO4rDlDCbiJn1+oySVcRKYekYdhRU+49UKPUxFZuAEjv+8DwhqyzJT4j5sxn+7nBE99J
 A2Drrnd6c1qL525qTQvea2dmB5ciNu2Q6yGNV1icG5aW6DgrmflQzNXkkQKpBQtnjRWzTTCF3qm
 NDG4AKEXr1F4zoG0t01HBF1zGCeq36uNE6W7LQngiSJe5soJaBEr9E45mI15MxJ1OR5YfZn/7s0
 PX/xWZdag8AfNiCC3RRViJ+OUtrShYpgiAqheYcPeVQExLttBM9DDsKmFkvtHsv7Z8bgTVVe1EY
 MdOvbwOov2PZB6S0MRh+ofKcQwPrZVdfLoGAT9Ym2rkxGgQ6hfAoGNnUSXK4NrKH/aD8YZ7rUnh
 O6vQf4Y6jxAktUry1gBpJURcjWlr+mQumyDvQpTceOPsXWK3wQC/9YJGjjMtm+4ZFhmR+TAB
X-Authority-Analysis: v=2.4 cv=evLfzppX c=1 sm=1 tr=0 ts=688081a0 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=2tcgm7eZke0umGGLaFsA:9 a=CjuIK1q_8ugA:10 a=U1FKsahkfWQA:10
X-Proofpoint-GUID: ll9oNXlQFTwHByoXRp7lyJgKlcguFbKj
X-Proofpoint-ORIG-GUID: jqjavEVRMWN2MgiUEZvGwLUG6tXpxoqK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_01,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=542 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507230050

On Thu, Jul 17, 2025 at 09:22:30AM -0700, Darrick J. Wong wrote:
> On Sat, Jul 12, 2025 at 07:42:50PM +0530, Ojaswin Mujoo wrote:
> > Stress file with atomic writes to ensure we excercise codepaths
> > where we are mixing different FS operations with atomic writes
> > 
> > Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> 
> Hrm, doesn't generic/521 test this already if the fs happens to support
> atomic writes?
> 
> --D

Hi Darrick,

Yes but I wanted one with _require_scratch_write_atomic and writes going
to SCRATCH fs to explicitly test atomic writes as that can get missed in
g/521. 

Would you instead prefer to have those changes in g/521?

Regards,
Ojaswin

