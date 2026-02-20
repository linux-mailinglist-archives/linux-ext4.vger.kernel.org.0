Return-Path: <linux-ext4+bounces-13754-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Jt5D18HmGmh/QIAu9opvQ
	(envelope-from <linux-ext4+bounces-13754-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Feb 2026 08:03:59 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FDA165153
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Feb 2026 08:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 192DF3020A61
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Feb 2026 07:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9218A285C8B;
	Fri, 20 Feb 2026 07:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YYd5k6DN"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1875A1C8634
	for <linux-ext4@vger.kernel.org>; Fri, 20 Feb 2026 07:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771571036; cv=none; b=n3rQZvXtYN8COt1G25L1I79A7OkGqyR6R17v/JEYTvNkmJE2KP60OJ5uYx47uQ3wwCorE3GqgAvk8Nt06LTd6bbFuIMVniOqQWdAeymlF9FyFUh43HFsjtqWZLl/T/IzyUn86lWmayFunU3lMdFPC+gzOHIPmi0dBzj6x3QuS8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771571036; c=relaxed/simple;
	bh=Kx7sPLdu5UCFIeduLb4eZ4wjcEotdKgZe9nd7N72nHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2ws70WLtw/LtF398RCh7nl8req6GJuniyNEYerDtd8ubHxd4x3fOKY2sMquZjwzjApqGqY31uIFiqm09+88IF0SyIJgpf0hfjgsEFVWs5ktw0izQP7OR47pI0njKmMHA4wgP4aSZGhC+HqROe1JT5YmPrlGKYCIUVQX12XcGX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YYd5k6DN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61JKOQhD1368483;
	Fri, 20 Feb 2026 07:03:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=/j5SSJU7Aoosi7qT6UzTHF/ULwy882
	WSWaZyFIX8zdY=; b=YYd5k6DNnIvyJGqfqWETjQiEF0mexILh0qJJO+aYfcIuGX
	Fc1np86ShjHP3V5VTLr4t56icaHdwtdtl0Xu+SVhcqe1R9ykxtf81Rxbfa/qy+3j
	C9d6eSly+2Vo0EtoJQ43SKJQdKEt1EIXLI6fm/5fef0ZJx5f3OKE6Gp5s6kqxFCk
	IIylq/KPMhScIE98/IymS4Zk5AdKlAD3AZiyXeoXJ2RK0cGilP1ZGq/2eXOu3Hzs
	WZDDahmZ7q1wjSmJR4uMIefZwb2poquHKXYyTMihc85qC1p3mTtVUZuTuylH02rN
	oHn94F35xKPzS8M4m6BgpYXN4itIwfHP0xVCXjIg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cajcjresp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 07:03:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61K3mCXx017834;
	Fri, 20 Feb 2026 07:03:52 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ccb28qe3d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 07:03:52 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61K73o4I26018132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Feb 2026 07:03:50 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3FA252004F;
	Fri, 20 Feb 2026 07:03:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 501CE20040;
	Fri, 20 Feb 2026 07:03:49 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.24.78])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 20 Feb 2026 07:03:49 +0000 (GMT)
Date: Fri, 20 Feb 2026 12:33:45 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH RFC] Update MAINTAINERS file to add reviewers for ext4
Message-ID: <aZgHUY7L4DgWmsa6@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20260219152450.66769-1-tytso@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219152450.66769-1-tytso@mit.edu>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mj35-EtRoFcC0WbgOupq8mjoCj2dLTks
X-Authority-Analysis: v=2.4 cv=Md9hep/f c=1 sm=1 tr=0 ts=69980758 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=RPJ6JBhKAAAA:8 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=DxPsj7DoMBh85DXIDEcA:9 a=CjuIK1q_8ugA:10 a=fa_un-3J20JGBB2Tu-mn:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDA1NyBTYWx0ZWRfX/va65HGi1MCL
 /QucMB/mtYBr9kXgft00HnGjiB4eu8x4XKBuZwmmEPBlmg1yCKXLI4GvWVLYD0Jamv7p7GDg6bo
 28xIwqDAG+pFfLS7AxZcVQLEELGj6RJ8kEk7KmlZLbzoE5cFdCRw3K6NfUEfpOT1WggllCL3AeH
 9jTYBmblsyN41MeNHJj3Xa0xh+Je14h/WGvxYFv+P1Oivs9izcqevqGP83Pfb4lHgQ5M12l8YfF
 vpAozuKVdQxTG2lrRfCbv8hn988hNuXTBehjqj3IDGy+I2qA/ZKyYA9LsFfTytwfIGyCP00Lxgd
 KXuuIgtT6SVURClPm17z9nuvCN8cgekPQU86d8QloPa3F2xG2mEgIPJwxKCN3SWw5U0qOu0fpV3
 0x7WE77xqD+uMURowNQ7NT/t670p/CO+IuHsc2mx19TdB1ckCe9wb8wlksfUJKIta4a6Bfl5v6x
 hO4iJPakCirvvZtm0og==
X-Proofpoint-GUID: mj35-EtRoFcC0WbgOupq8mjoCj2dLTks
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_06,2026-02-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602200057
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email];
	TAGGED_FROM(0.00)[bounces-13754-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ojaswin@linux.ibm.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 87FDA165153
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 10:24:50AM -0500, Theodore Ts'o wrote:
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  MAINTAINERS | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index eaf55e463bb4..481dceb6c122 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9581,7 +9581,12 @@ F:	include/linux/ext2*
>  
>  EXT4 FILE SYSTEM
>  M:	"Theodore Ts'o" <tytso@mit.edu>
> -M:	Andreas Dilger <adilger.kernel@dilger.ca>
> +R:	Andreas Dilger <adilger.kernel@dilger.ca>
> +R:	Baokun Li <libaokun1@huawei.com>
> +R:	Jan Kara <jack@suse.cz>
> +R:	Ojaswin Mujoo <ojaswin@linux.ibm.com>

Hi Ted,

Thanks for adding me as a reviewer :) 

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
ojaswin

> +R:	Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> +R:	Zhang Yi <yi.zhang@huawei.com>
>  L:	linux-ext4@vger.kernel.org
>  S:	Maintained
>  W:	http://ext4.wiki.kernel.org
> -- 
> 2.51.0
> 

