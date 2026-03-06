Return-Path: <linux-ext4+bounces-14684-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CM0AB72kqml6UwEAu9opvQ
	(envelope-from <linux-ext4+bounces-14684-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 06 Mar 2026 10:56:13 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8D321E45F
	for <lists+linux-ext4@lfdr.de>; Fri, 06 Mar 2026 10:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 13D253034B2E
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Mar 2026 09:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1A134DB44;
	Fri,  6 Mar 2026 09:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NRkd6xoU"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1074134D926
	for <linux-ext4@vger.kernel.org>; Fri,  6 Mar 2026 09:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772790963; cv=none; b=AVt7BrRy6FywxGAf1YpJJ2RU5uZfcPhZonvaREz/2aVqw5dt46jFzgFYtebiwb4z50BssnbVRvlTIw+jNSmB/ZSJkZtAHQ1k+87qDxptLx1OWjalUIT7G0+FcTHn5H1gkbEU/f4HZuFNR/bKtErhtURDXu/jnj8NLg/M7LgkkCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772790963; c=relaxed/simple;
	bh=hvsOI9MpD8D1nRZJkU1J8ZrE9PjnymxegJDXAlHkBZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/AY5OPSUi1yPN7k6Rrb0poVoXr09nLUeJl4MB6ri4XtroerBBMko3Ulv08o6BFhpviQzOmQpJ3b3TudfJplSB8onYiyxdXtlO0NYMiVklVWyRaurVyJix/EK/h8u1SSoxWXgMLbMMzmv93rMTTaKglLjn9VN4p4h7rrZZukYrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NRkd6xoU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625IGt1w2120236;
	Fri, 6 Mar 2026 09:55:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=bamniJGUkOXwAQVk8hLjMSZ538keH+
	T6eMKk0q4VKzQ=; b=NRkd6xoU1OETLZCnPY7vv1auts1nt7xobcrLgeKij10on+
	77jW/o+OLbRq4DOzdCFuxNqGRX2OGq+4J0GQMh0jMO7FM1TW+pCrGzeWr4rm5SaP
	f7njDKi0u3fKEDxbgEwM3kURa6KWVvBjb9ohv57Ga4BRtwWIkZkL3DmO6otvoWwR
	LPTnTJUVtQULQ9U1z009C+2ME4BymTYnsOJaUmLuBdO/59m7RnZECOjD01+mGpIS
	E6LkwIjLLIj7KAjXiKHKaCeWC5hEJ8k9qO543WnjVzdvI5hqTdDPFKizM5UQ6bgH
	FVdPrkaijthwVjBDNSAO3f3nHc73S1iJmp8EYqfw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksjdqv1d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Mar 2026 09:55:52 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6268R93T003284;
	Fri, 6 Mar 2026 09:55:50 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmb2yfe06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Mar 2026 09:55:50 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6269tmn531326490
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Mar 2026 09:55:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE6EF2004B;
	Fri,  6 Mar 2026 09:55:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF35B2004E;
	Fri,  6 Mar 2026 09:55:47 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.158])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  6 Mar 2026 09:55:47 +0000 (GMT)
Date: Fri, 6 Mar 2026 15:25:45 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Ye Bin <yebin@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH v3] ext4: fix mballoc-test.c is not compiled when
 EXT4_KUNIT_TESTS=M
Message-ID: <aaqkoSTFyYzxxYRI@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20260227065514.2365063-1-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227065514.2365063-1-yebin@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M9BA6iws c=1 sm=1 tr=0 ts=69aaa4a8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8 a=QLrFEjKb_T-t5Ved9GsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: DPCwBCK4Gu7-XoYPu2nGuNQuL-3JI86B
X-Proofpoint-GUID: DPCwBCK4Gu7-XoYPu2nGuNQuL-3JI86B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA5MSBTYWx0ZWRfX02tqXDpCh3JQ
 E0WjAsh3JYTyMxca6/exNDWxX3mNuW1WByzBHlh0rFp6jNwoafAWuzROyO+cWASeVp2EIoDFk0I
 2SVH2U7JqP45ypaBa9F7vO2eXUrXH3Q+UuliRzqau75xPr8tDLyFlXnX0iYttOEWae9rkogONM6
 efzUbE2cUPn5StQEBZMXFvmyXNOfiU0DemxE0efa6mk471mTQWrXxNdmgT7iP5cJQxo+xuv/6n/
 jtr2YzHFnCj98lZnVzc/3JYJdx0kuTSBLOkI7QdLwh3lWHxevaenXTqiRPz8RcFKZCLZ9V1KEJD
 JfGKUDqM6hKaicu6NIhBpCZbystpAMX5pLTAuUON7LuL+Hsp+awScr42zbuVQBbh37mYcNGDoik
 3q9Dtj5VFDylEyzeM8omKmhlGNibZQ/Mu/J6Bk4EYKg1WzWGt01YU/mLaCfpKmn5dlelHE+9s4b
 pckR/aXtTPW9NPNYIcg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_03,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060091
X-Rspamd-Queue-Id: AD8D321E45F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14684-lists,linux-ext4=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ojaswin@linux.ibm.com,linux-ext4@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-ext4];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 02:55:14PM +0800, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> Now, only EXT4_KUNIT_TESTS=Y testcase will be compiled in 'mballoc.c'.
> To solve this issue, the ext4 test code needs to be decoupled. The ext4
> test module is compiled into a separate module.
> 
> Reported-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
> Closes: https://patchwork.kernel.org/project/cifs-client/patch/20260118091313.1988168-2-chenxiaosong.chenxiaosong@linux.dev/
> Fixes: 7c9fa399a369 ("ext4: add first unit test for ext4_mb_new_blocks_simple in mballoc")
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Hi Ye,

From my testing I can see that EXPORT_SYMBOL_FOR_MODULE() doesn't
resepect the namespace restriction if EXT4_KUNIT_TESTS=y but I think
that should be okay.

The patch otherwise looks good. Feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

One thing, recently added extents-test.c is also having the same issue where
it doesn't work when compiled as module. Would you be willing to fix it
as well?

Regards,
ojaswin


