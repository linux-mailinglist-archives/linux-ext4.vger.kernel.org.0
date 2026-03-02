Return-Path: <linux-ext4+bounces-14322-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJd5IhqfpWnACAAAu9opvQ
	(envelope-from <linux-ext4+bounces-14322-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Mar 2026 15:30:50 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F2E1DAD3C
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Mar 2026 15:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0607B30255DB
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Mar 2026 14:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565563FFABB;
	Mon,  2 Mar 2026 14:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="X0un3yuU"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7763FD146
	for <linux-ext4@vger.kernel.org>; Mon,  2 Mar 2026 14:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772461823; cv=none; b=eZhEwDnvrjQg2YWIYRWtN1ttDk7sz5Bp3/o9sMdHA7ODmIREd62v7FSpsHa7Qe0tsAPcjLTSijFbRjVOZGdF3CHTtWqIfdumAasRvbuvvzhBTWbO2aOU8E+VtjfXwCi5nNkGn4HkG3r4KbTECqeIvd3VnbtGskwkUjLUat+0H8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772461823; c=relaxed/simple;
	bh=Rm/FqExQEYRQdoVv0OUzEAYk4kdNDeRtAp6kamqHICo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pf2fru01Ii23IRVdoegJmXWqZJZlJFa94Xs+jLiuiep6LZpDIX5b7wpYbuZ8L7ExiJ3HIxhfviJXGE2lelQxVqfOcKYukDldfIw/rEgHhqydajUywL86onBtj0bJGBFlpXy9k+N9Ssjin7iAfFDvFes7yRILZBJ7Q2Mx6wOuS9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=X0un3yuU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622EJueC2166769;
	Mon, 2 Mar 2026 14:30:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=J7YTp7ZpQ2hpgj+JpXbJb2tJAo836/
	aQ2UMUo05AHRk=; b=X0un3yuUkAcmKJJd1tSy1yVb6uByBWht1NkoSRBhuCg6Dz
	oH1Z4gDYbxJ1q/lLMs6SUpAd1HkFfh1XQYddtzcM6w8Hq6ezvZSiTB4hgh8xBaI2
	WcKANjQ56M6Uj+ONxMoLljXPtCd5aH/uPc4PYIzhgv7qs+wsc+7cbuQyURTEiaDw
	3azJ3FMZJk5gfQkJDExdZH69cDXtaGf6l9FckqBqGleO9sEZBbzMvqMUT8sX+dOX
	bogGO3zWnOVFPsANmBLL7/3RnUNRzrW2110RoH6OKGmGLxjrjeZqwiWmdx+C5iML
	MS2Hgjp6c1YMziyJ4D3nUZR4jBkw5DF3cWazhfHw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckskbpt7b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 14:30:16 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 622DNM5V010309;
	Mon, 2 Mar 2026 14:30:16 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmc6jxdpu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 14:30:16 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 622EUEf545023692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Mar 2026 14:30:14 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45B0B2004E;
	Mon,  2 Mar 2026 14:30:14 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 402ED20043;
	Mon,  2 Mar 2026 14:30:13 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.211.209])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  2 Mar 2026 14:30:13 +0000 (GMT)
Date: Mon, 2 Mar 2026 20:00:10 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] ext4: Minor fix for ext4_split_extent_zeroout()
Message-ID: <aaWe8v-CSFjsxHZE@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20260206155821.2869356-1-ojaswin@linux.ibm.com>
 <87tsvg7x32.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tsvg7x32.ritesh.list@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: juLvtj0-kcrV2ltCccdPh8y5HIu65lbj
X-Authority-Analysis: v=2.4 cv=b66/I9Gx c=1 sm=1 tr=0 ts=69a59ef9 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8 a=FfleP43KWFRlo7d4BCkA:9
 a=CjuIK1q_8ugA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDExOSBTYWx0ZWRfX/qpgaI8TtFnB
 cTHiAyulG38G8QffLFc8xWn3atD/QpKGfHm77DYGZIhNOWBUDrq2iS786S7rMWlpKMhXEDAI1hC
 h4+0p3+tQf2117P1k/DQKdX0bNk5rz/uiY8vONKC6LaM/mrDHjfa8Ay8RY9Qpg16KkN86SQvi9X
 zg0dB8BNnmQfCekvWE1O40V4SsbYNoo6V4ZARy+FbsowblxUEtHfc1cQ6RB/4xNs8EiMPXsvnap
 SeB5YsUbLdtMrMTX1Aj5i4BRAKRfXeJR3eC0onaUeU4brl43th5FReMpkBSBPhF2EXI01BqMv6o
 6VGdoYrcAopYvyZ0VmIx/PlecYbiMCj4Pf1Sn60se/Wz6GAsv/XagsLhSjzVH3QU8DzI9gpbieF
 LbdvKjzuFoo0rrmLJZeL/6nbO0zY1h581Cy3XL9HpzJYL2siBQ5M23SyefMecsqZ8eH1NR+Md/J
 H+5TOhEWtFeNTsaxE3w==
X-Proofpoint-GUID: iL0CVeTY3PZB7oQOKRAgiJHl1Mj54sSw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020119
X-Rspamd-Queue-Id: 31F2E1DAD3C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14322-lists,linux-ext4=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ojaswin@linux.ibm.com,linux-ext4@vger.kernel.org];
	DKIM_TRACE(0.00)[ibm.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-ext4];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 11:03:53AM +0530, Ritesh Harjani wrote:
> Ojaswin Mujoo <ojaswin@linux.ibm.com> writes:
> 
> > We missed storing the error which triggerd smatch warning:
> >
> > 	fs/ext4/extents.c:3369 ext4_split_extent_zeroout()
> > 	warn: duplicate zero check 'err' (previous on line 3363)
> >
> > fs/ext4/extents.c
> >     3361
> >     3362         err = ext4_ext_get_access(handle, inode, path + depth);
> >     3363         if (err)
> >     3364                 return err;
> >     3365
> >     3366         ext4_ext_mark_initialized(ex);
> >     3367
> >     3368         ext4_ext_dirty(handle, inode, path + depth);
> > --> 3369         if (err)
> >     3370                 return err;
> >     3371
> >     3372         return 0;
> >     3373 }
> >
> > Fix it by correctly storing the err value from ext4_ext_dirty().
> >
> 
> 
> Looks straight forward.
> 
> 
> > Link: https://lore.kernel.org/all/aYXvVgPnKltX79KE@stanley.mountain/
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> 
> Fixes: a985e07c26455 ("ext4: refactor zeroout path and handle all cases")
> 
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Thanks Ritesh, I'll add the fixes tag and resend.

Regards,
ojaswin

> 
> 
> > ---
> >  fs/ext4/extents.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> > index 3630b27e4fd7..5579e0e68c0f 100644
> > --- a/fs/ext4/extents.c
> > +++ b/fs/ext4/extents.c
> > @@ -3365,7 +3365,7 @@ static int ext4_split_extent_zeroout(handle_t *handle, struct inode *inode,
> >  
> >  	ext4_ext_mark_initialized(ex);
> >  
> > -	ext4_ext_dirty(handle, inode, path + depth);
> > +	err = ext4_ext_dirty(handle, inode, path + depth);
> >  	if (err)
> >  		return err;
> >  
> > -- 
> > 2.52.0

