Return-Path: <linux-ext4+bounces-14700-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNRUMQPFq2mRggEAu9opvQ
	(envelope-from <linux-ext4+bounces-14700-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Sat, 07 Mar 2026 07:26:11 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C4422A5FB
	for <lists+linux-ext4@lfdr.de>; Sat, 07 Mar 2026 07:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 774E1303181D
	for <lists+linux-ext4@lfdr.de>; Sat,  7 Mar 2026 06:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F473081D6;
	Sat,  7 Mar 2026 06:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GDBPWwDF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36572336896
	for <linux-ext4@vger.kernel.org>; Sat,  7 Mar 2026 06:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772864758; cv=none; b=iYCh+NxV9aQO50NhKII7MB4CZVp2MklmnxcbX4yAKki+Ch6byDwivkZyEgCR7H20jf9ukx8qrDLZtwvX/uOBDWA4+EETxz4Q0Sv5ZxkCoJ9iwBySVsdrEJT9JlGdUzVsyFu/hyJJn1426bQx3M0oLEcXOOU33Zi+/hCn9FNlcJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772864758; c=relaxed/simple;
	bh=Hd+D1BzH6eKszJms7NRKKcG6GaOpJmHRg1KF3IQH5eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sc8tsLgINTf7Z0CE6eKMiET/52wNQgxmLun0QPQ/MDv1w/lOHYJVQAlWSBDDZ5Kuol0XgijRNEP9HCADn14J/nWiZsnj62Y1TQ9K5zSY37fmccUn5ZkShhXQRtXNWKnZmatBmE7B2UBuaj9tWz5y2TYcCbYW7gzSOz59kJrIna0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GDBPWwDF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6275t2UC1031984;
	Sat, 7 Mar 2026 06:25:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=9vcOF4z5/z3Zx0Ui6x22AuHLTCUugt
	XiRm+euARI5Hk=; b=GDBPWwDFR8d4FuSHpGnI9pm2gdUXXOUITHtun4VZmoCgAN
	X9CzYkwfAJt7jH6Wox2FTD+iz1RtWbmuxbdt1lqMpH3CZlCOkLfi2JgdGR3epU/q
	1bvwZyo3HaM4NIvXf0fUSLlO+WRWy1rpOF8JjEfE/47QJ88aWrgByRVqOeucfHOZ
	+gS5QPaFdX0i5W+WZQEuEdfN9iKmc52aREpAmx351r4/jq5WpcYZZ/Q0NLvP1XZH
	LMYwXM/2czrXQO1iCsNtq9tW4IiZpwH6iXP8v2StzDWksqvLfazmEqLQNSwjN0e6
	mOYhkFQjbwzbR/lEv3dzo/2i7txYfAZ2bzk8e07Q==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crd1m872y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 07 Mar 2026 06:25:27 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6274pdZq003201;
	Sat, 7 Mar 2026 06:25:27 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmb2yjxuy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 07 Mar 2026 06:25:27 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6276PPQB45613428
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 7 Mar 2026 06:25:25 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6324520043;
	Sat,  7 Mar 2026 06:25:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D89A920040;
	Sat,  7 Mar 2026 06:25:23 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.213.148])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat,  7 Mar 2026 06:25:23 +0000 (GMT)
Date: Sat, 7 Mar 2026 11:55:19 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "yebin (H)" <yebin10@huawei.com>
Cc: Ye Bin <yebin@huaweicloud.com>, tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, jack@suse.cz
Subject: Re: [PATCH v3] ext4: fix mballoc-test.c is not compiled when
 EXT4_KUNIT_TESTS=M
Message-ID: <aavEz51L9NmAAttT@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20260227065514.2365063-1-yebin@huaweicloud.com>
 <aaqkoSTFyYzxxYRI@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <69AB6B2D.6070006@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69AB6B2D.6070006@huawei.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ds3Wylg4 c=1 sm=1 tr=0 ts=69abc4d8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8 a=rXPuZVaDHc5X2p8U9qAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDA1MyBTYWx0ZWRfX8TxSD2zABRmK
 vxKzz9DOo1HEQxJABazepbtVX0w5fod0Vgc+M/pcTobjE3mb/Wl7K/EFroYkGKNt6zT6k46kf0+
 qbVDmjxpi3fTzEuDRTTOx93hBoS3Ls7Uqc2APy0XAEMsjpPy37sePgMe/OOSQuEZlBnYul7Y7S9
 326OJuygJaFY22nCpyT+xWoLTT8OX3602W7Z+dhYU8l+UNaANJQFCIuoRJC7GJnb+u48YxJBWoi
 atHMdycP28k98ybFhkXp5eaNL2ihd9Jqu5b/NBG3b641uNDBrZunQta1ViMjJ66OK3zh7Ehiy73
 agGC+q2wH0rYLpNmXj1J7B66ahfgE4Dm8JGq+WUUHXC6WcSMrv3plS1XVPeUkFPVuY4kU6JV5jg
 Zf742X37ULOlvVsL3UYgndqNm+PAmsumaUIrUyfy03Tj9zNj+LhpOd935yNVpfd2eIRmh8y0UX7
 HqEqIEEAA99nqVV4IUw==
X-Proofpoint-GUID: lnbMLm3fMCH8vVkfWunPcDnwca_00bJT
X-Proofpoint-ORIG-GUID: lnbMLm3fMCH8vVkfWunPcDnwca_00bJT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_02,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1011 impostorscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603070053
X-Rspamd-Queue-Id: 12C4422A5FB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14700-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[ojaswin@linux.ibm.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-0.964];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action

On Sat, Mar 07, 2026 at 08:02:53AM +0800, yebin (H) wrote:
> 
> 
> On 2026/3/6 17:55, Ojaswin Mujoo wrote:
> > On Fri, Feb 27, 2026 at 02:55:14PM +0800, Ye Bin wrote:
> > > From: Ye Bin <yebin10@huawei.com>
> > > 
> > > Now, only EXT4_KUNIT_TESTS=Y testcase will be compiled in 'mballoc.c'.
> > > To solve this issue, the ext4 test code needs to be decoupled. The ext4
> > > test module is compiled into a separate module.
> > > 
> > > Reported-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
> > > Closes: https://patchwork.kernel.org/project/cifs-client/patch/20260118091313.1988168-2-chenxiaosong.chenxiaosong@linux.dev/
> > > Fixes: 7c9fa399a369 ("ext4: add first unit test for ext4_mb_new_blocks_simple in mballoc")
> > > Signed-off-by: Ye Bin <yebin10@huawei.com>
> > 
> > Hi Ye,
> > 
> > > From my testing I can see that EXPORT_SYMBOL_FOR_MODULE() doesn't
> > resepect the namespace restriction if EXT4_KUNIT_TESTS=y but I think
> > that should be okay.
> > 
> > The patch otherwise looks good. Feel free to add:
> > 
> > Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > 
> > One thing, recently added extents-test.c is also having the same issue where
> > it doesn't work when compiled as module. Would you be willing to fix it
> > as well?
> > 
> No problem, I will fix this issue.

Awesome, thanks :)

Regards,
ojaswin

> > Regards,
> > ojaswin
> > 
> > 
> > 
> > .
> > 

