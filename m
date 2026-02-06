Return-Path: <linux-ext4+bounces-13590-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOWwDvUMhmkRJQQAu9opvQ
	(envelope-from <linux-ext4+bounces-13590-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 06 Feb 2026 16:47:01 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A75FFE00
	for <lists+linux-ext4@lfdr.de>; Fri, 06 Feb 2026 16:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B8B3301C6D6
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Feb 2026 15:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10B02D0602;
	Fri,  6 Feb 2026 15:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lhMMqAjm"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6682C1594;
	Fri,  6 Feb 2026 15:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770392667; cv=none; b=H2IBanhy63TbM+/kau72wuuWh3Z8GJqtgz7p/5kHR0Njt/Vqft0PXnzwNppq0YSj77xzAJxRJhL1s5+wCDfmfIuN2+X5v7pYwFj6e5RmSH4aVD1mIiAF0sA97xM1HPDNdmTBwHlL6x8Fe5oS8+O64PnihW4S88EjX6nXQTVqv38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770392667; c=relaxed/simple;
	bh=YkM4OT1WlVVW6vXW3Vu+jetAYDe7dPKKPlInpbj8y+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6ti/kxftytmU5qN1B6K4klRQl+EMew2LbqX1s6xr6f0or0nc2qFwgXPMQsznRf4VgOpjX1fa0eBywSWKy//qJOJvtIjsPZTpZW4PdPeDFRk1TffWlOaItgmGcn5iQthSu42tRH02GYcJPdU1T9lj331KrkrMb/wgGzh21uRy6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lhMMqAjm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6162lmqb003911;
	Fri, 6 Feb 2026 15:44:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=YsUJJd/emDsO89WiTkNZ38mnZpspyF
	IBeM4kFA/Jv3o=; b=lhMMqAjmuqUN00s2NUSWbjQBlX9nzgLYyU/cYoeVEzFcqv
	S7almL95pRxwUi9uDPzr8O2QzX5ImXQZpsYkLEoNdM/ljj1dwDWHZSPCVO/8N/Oa
	o/qo7l63UGVNw7aw3OYc9FPbHFNzlozEnzbHh8YR3MvAuIn1hkrl7++7Qv6n4Mjm
	TYRzfNIsNf/es/aL5gfnFEHMHLUDQYGO8/YoyyXV9dnfaUOJ1L4HbSx19RE7zDQU
	S+1sWsU2/0kJ69DLrXHy3AvajGZB3xo+Eh+aHCHj5/TM1+flCv6/oY4o+jXDY4hX
	pyNmMox32VILElHEB1qx1MjvpmKlOXkYjbFl7JBw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c175n96vc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Feb 2026 15:44:25 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 616C5tvX025743;
	Fri, 6 Feb 2026 15:44:24 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c1w2n6pmc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Feb 2026 15:44:24 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 616FiMlJ22938088
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Feb 2026 15:44:22 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 90E7F20040;
	Fri,  6 Feb 2026 15:44:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F2422004E;
	Fri,  6 Feb 2026 15:44:21 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.218.3])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  6 Feb 2026 15:44:21 +0000 (GMT)
Date: Fri, 6 Feb 2026 21:14:18 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-ext4@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [bug report] ext4: refactor zeroout path and handle all cases
Message-ID: <aYYMUgzc8qk3Gtb1@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <caa37f28-a2e8-4e0a-a9ce-a365ce805e4b@stanley.mountain>
 <aYXvVgPnKltX79KE@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYXvVgPnKltX79KE@stanley.mountain>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fkKdAmiPMI9YL6iCOptV2ItHkkXLolNo
X-Authority-Analysis: v=2.4 cv=VcX6/Vp9 c=1 sm=1 tr=0 ts=69860c59 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=b4PEHfateFPbnxi_mBIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: fkKdAmiPMI9YL6iCOptV2ItHkkXLolNo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDExMSBTYWx0ZWRfXz5mJ/6uJb/Nh
 iogJ+Kma4FSrO8BjRglo8BGRdo5zBrAeGqaRUShdUy9kUxIl1jc8/68M/GdirYD9r78O/AOiGqM
 t2gALth5Zwxj7NAOguitLT3lJgi2fo/epx0ZYm2VGL7LLQCwpv6AQT5IwyOMRaCjjgrKjmUwi7q
 dvscdR3+x90Ch5Nya3N9j6vlVEtwXttpd/5mBtEsz0q6C8i4INRAJw8LsMC+bvHOWJC8IL+4L6O
 f6xSQZ4eYCh0F4Dv2+jTFKRq6gmAZzriz1QQC4GVBNhX0ee3EfPea/Qb0X4LWBOdB+ZFYn9NYrg
 RHCE95DoWbZ8i1RF0kxT/TMSXn5EMSiMna6LhOk2HIG/LKemNX+4R9S26OOqaQOmCz0E8TqyLkk
 onVfyYVejRnb5+OcJ+yHTG2YoxHEIE5aWP8uLH0t1AKYcrm8ldraUhbhLcd2crskPu3jBJydFZc
 +Nlv+aDz2hIyUmJXTzA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_04,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2602060111
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com:mid];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-13590-lists,linux-ext4=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ojaswin@linux.ibm.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 66A75FFE00
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 04:40:38PM +0300, Dan Carpenter wrote:
> [ Smatch checking is paused while we raise funding.  #SadFace
>   https://lore.kernel.org/all/aTaiGSbWZ9DJaGo7@stanley.mountain/ -dan ]
> 
> Hello Ojaswin Mujoo,
> 
> Commit a985e07c2645 ("ext4: refactor zeroout path and handle all
> cases") from Jan 23, 2026 (linux-next), leads to the following Smatch
> static checker warning:
> 
> 	fs/ext4/extents.c:3369 ext4_split_extent_zeroout()
> 	warn: duplicate zero check 'err' (previous on line 3363)
> 
> fs/ext4/extents.c
>     3361 
>     3362         err = ext4_ext_get_access(handle, inode, path + depth);
>     3363         if (err)
>     3364                 return err;
>     3365 
>     3366         ext4_ext_mark_initialized(ex);
>     3367 
>     3368         ext4_ext_dirty(handle, inode, path + depth);
> 
> Presumably "err = ext4_ext_dirty()".
> 
> --> 3369         if (err)
>     3370                 return err;
>     3371 
>     3372         return 0;
>     3373 }
> 
> regards,
> dan carpenter

Hi dan,

Thanks for the report, I'll send a patch for this.

Many thanks for all the work you do and hope you are able to work out a 
way to carry the smatch project forward!

Regards,
ojaswin

