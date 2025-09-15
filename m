Return-Path: <linux-ext4+bounces-10029-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE98B577EF
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Sep 2025 13:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DA7D16D606
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Sep 2025 11:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3A12FD7A3;
	Mon, 15 Sep 2025 11:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="d48efdLi"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8BB2309B2;
	Mon, 15 Sep 2025 11:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935196; cv=none; b=pIba6taMNIRS3MbqlqAabLwVOEkj6lLvaluQcVs1Qcihq05Fn/u+jjKWyHQrxxVdGLiQly81aL/jEWYqkn43jQKKdX6PhkiVvGlz7QB7Ynjoj7cBw7+68HXmlecVJL8VxA8kxCMDKrBjjX2OXHU+x66QT206+TR0aWgq04DaBWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935196; c=relaxed/simple;
	bh=uYTGOhsbXa0ucAORTyXGNU1yOdgccqwDw4jKSydkw4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uW8GIgjwAeYXh/9pYGI1ilT2k5QiQOEDxzabPMaqR9sJIU7c6nfv2fUGZ6tqy99Q4/MXKRAKUxBLeNPnLgFbyVWMvTDVdwUxx2TkSiQS2EHENNPfKyd7e79lykjgySk1YSK6OmiVxprbIx2ft53UXvIgH7wxOr7rsed5igyPvTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=d48efdLi; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58F0aHfK021403;
	Mon, 15 Sep 2025 11:19:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=RzaO4b3jqUKV+R1jZy05KPKafZ2dFe
	rEnB2JNj90Jws=; b=d48efdLivBSU1F1HWhPeikxxDsHywuTXUJsDSfi3FoLKl3
	s09S3Mwxlo4kCAYwJi8Zq+bIJOOZiIYd9EUM8AIrHSe9A61aWRqMXBC+yIIhUWtO
	bTpWPE9U/od52slWEH2Mju7zh1OIyNljzQJFAm1dY02R464SORTo8hKD2EmQXvW0
	5afF81w7y2GPOQkRP7Z84yNI2EBR1O69CMDNJzYa4mLHJMbTJuYdz4OVwraEPqy9
	9Y5HQC3h4R5/iB17uf/oeFc0T83LDPAh7NC7xUUG3X0OtjX33rNbSosb9oPMCSjs
	s57FUZSSVHRbxlyUD2FCwWEmrNJGGpMjLimmH3iA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 494y1x1pas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Sep 2025 11:19:46 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58FBJjYr000418;
	Mon, 15 Sep 2025 11:19:45 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 494y1x1paq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Sep 2025 11:19:45 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58FBFTXY022384;
	Mon, 15 Sep 2025 11:19:45 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 495kxpe3v0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Sep 2025 11:19:45 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58FBJh8O55837166
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 11:19:43 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 33EAB20040;
	Mon, 15 Sep 2025 11:19:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7EB382004B;
	Mon, 15 Sep 2025 11:19:40 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.158])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 15 Sep 2025 11:19:40 +0000 (GMT)
Date: Mon, 15 Sep 2025 16:49:37 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v6 01/12] common/rc: Add _min() and _max() helpers
Message-ID: <aMf2SUh0gLeQO7rw@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1757610403.git.ojaswin@linux.ibm.com>
 <9475f8da726b894dd152b54b1416823181052c2a.1757610403.git.ojaswin@linux.ibm.com>
 <5a22a799-a6b9-43d3-9226-d1d554d170e4@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a22a799-a6b9-43d3-9226-d1d554d170e4@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxMCBTYWx0ZWRfX4PEjCcHcDazi
 ChJnYqEgF0f7QzeDdSRFGeGGKahaA1HZZmyIglhD0XOKju3ma5fiI9fiGJXwiEIH9NSIAwXMjMx
 5z+5NzBv7xoCRdewcAOmyI4J9K+k2TDYcM7wGWnkVj9MucYc2w6qOS7q6r6b0buy6DQoFFlnUGO
 NyqVKcN4j2TKGue06hlMsorE+qRmqUMZI1IVZABVomqE4I83stG9UnHM2S2mKuOFNxGOq3tJDFV
 dU1VM1yhtk5X5XC8BnM54JMGSG/sRyO6AgzmWyrfFX28EeCrdgYcK7xHFafp4EAMjFF2UDX2TpB
 Rs41/s2S2sa2E2NW4/q2cTWLRnKlivdUQWbIl/8Suw7ETUqFMv2d64Eqrl4HofRr0JD7apsb/5y
 Wpv1NrpG
X-Proofpoint-ORIG-GUID: _ARQOro69MyPk80WuckITckUz4zPTBcj
X-Authority-Analysis: v=2.4 cv=euPfzppX c=1 sm=1 tr=0 ts=68c7f652 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=yPCof4ZbAAAA:8 a=8tsh_XVOevaKpRn8MqUA:9 a=CjuIK1q_8ugA:10 a=zgiPjhLxNE0A:10
X-Proofpoint-GUID: A2FXZeoIDjSsugnX2y3qRDJhBVmKB57_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_04,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130010

On Fri, Sep 12, 2025 at 05:53:47PM +0100, John Garry wrote:
> On 11/09/2025 18:13, Ojaswin Mujoo wrote:
> > Many programs open code these functionalities so add it as a generic helper
> > in common/rc
> > 
> > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> 
> Reviewed-by: John Garry <john.g.gary@oracle.com>
> 
> I just sent a patch for something similar for blktests to linux-block. I
> wonder how much commonality there is for such helpers...
> 
> BTW, let me know if I should attribute some credit there. cheers

Thanks for the review John!

I think the helpers are simple enough so credit is not needed :) 

Thanks,
Ojaswin

