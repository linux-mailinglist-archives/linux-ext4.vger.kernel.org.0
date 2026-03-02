Return-Path: <linux-ext4+bounces-14326-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OwfFoOrpWmpDgAAu9opvQ
	(envelope-from <linux-ext4+bounces-14326-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Mar 2026 16:23:47 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A021DBC08
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Mar 2026 16:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C79F3008528
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Mar 2026 15:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E36C40149D;
	Mon,  2 Mar 2026 15:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QP8sDo14"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F10239E88;
	Mon,  2 Mar 2026 15:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772464958; cv=none; b=oGgACbVTsr4eoL4qcz+7T4iV03NheXACxlO+PxjzYHJSLKgXJKBs86a7WwDKHj/dhvDSgke39Xh4cS922vxnWxmeZNYzDxFJxDlHojp95RGfqaleUqOwi5inOLCW90vPoRhGGZg8uhzb40bU3+UmXmLXvpw5V2hDmXMDlthCPA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772464958; c=relaxed/simple;
	bh=hV+hh85Kjdb6SEJrRo+kBNDYISyJ0v76F4fbJIjeR+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWMHHdewFJQuVmHGkPR5CE8hVE2fb/SgQzsdVX7J9xtNkIO0H+GTR8oWlVblR1Mq59/MZkF3GRyj5cKjZDpoCWlMBtyo2J9srf4X8g0d1k/mMkhJ8SHMv3Zca0JjObSt1HyBo7mWSqWEV6S55kuvJ+SQmNRzc/ZMcyml+FV9Ezc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QP8sDo14; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622EmXFa2072380;
	Mon, 2 Mar 2026 15:22:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=hoddnXC8wbKUfGyjXM5ItWCCS71HKf
	NyWeuU2f5XY8Q=; b=QP8sDo14bf8NspE2aFKPVTWo8WwJIOLyiPY09z/3JwI2Pu
	bqedMTdOycDdKtl8zcqf6NQeJCg0KJyOy/+u4tYQA6p37BnIWsSY1Qt37XBfBXPj
	rw2dOn1+4bXvDGGILO45FisBXUj0elMPVNXqIpiKn5X/TN/yrZXvpLnYRq2RmmsC
	TpKWDuPelNEu7nHmCs8gs2V+SouMdMgw1wPo8F7LXd/4aBDRikqzfomnpb2Nvbot
	q50UjMGMQZh46eIedWm8F6Q2Jr1Qrm4p3A1gyxdDbziMoR5qoDPOFliKYgCRE+ac
	pQocftms2Ccl0+LkAImJQtWlake8SHbGyhQ2bGUg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckskbq0us-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 15:22:35 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 622CQ0Zj028922;
	Mon, 2 Mar 2026 15:22:34 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmaprxtue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 15:22:34 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 622FMXdY56688910
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Mar 2026 15:22:33 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0393520043;
	Mon,  2 Mar 2026 15:22:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B78B20040;
	Mon,  2 Mar 2026 15:22:30 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.211.209])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  2 Mar 2026 15:22:29 +0000 (GMT)
Date: Mon, 2 Mar 2026 20:52:26 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Weixie Cui <523516579@qq.com>
Cc: dilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, Weixie Cui <cuiweixie@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>
Subject: Re: [PATCH v4] ext4: simplify mballoc preallocation size rounding
 for small files
Message-ID: <aaWrMizWrTssgsjn@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <tencent_E9C5F1B2E9939B3037501FD04A7E9CF0C407@qq.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_E9C5F1B2E9939B3037501FD04A7E9CF0C407@qq.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: HTOdoPvYm2HNTss9tTigfaG8599Ltorp
X-Authority-Analysis: v=2.4 cv=b66/I9Gx c=1 sm=1 tr=0 ts=69a5ab3b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=pGLkceISAAAA:8
 a=RPJ6JBhKAAAA:8 a=gZmg2J5fzIsqYHw35MAA:9 a=CjuIK1q_8ugA:10
 a=fa_un-3J20JGBB2Tu-mn:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDEyNyBTYWx0ZWRfXwpuWiWICKx60
 BDUHzOUmBVA3ppf1Ta1XExHIsoDxGwsHn6HdtOZb/3u1VrBJ6b1jH7K5VW7DOZ4MkOlRel4IHdf
 nJdL0DEc1HJ7f/z8UJUJsTqpoOp2iQj9sFzeCoU0h3sCfn4vo7Y9O511xEzaGp/Dbj9uGKl94gx
 xobXwpMoh0+c9gSF7V3qht1JjoiRPAl69ek8c1+BKtem+/nctwKtw+svsYCnk0DBMZ/yx84IoVy
 LL+eNf6R1K8CB1Xx01JvXSM9SbL7qW2p4GHrPUqtP7ORvlZzfaY2arUGm9j4pOddlQji7dYoNb1
 LqxXcXWxVDLYxhJ8ZBjGWiZEhfyQY+tQQsvEKIQMdfcDXQeqVK3XrKirikbaTBQbtiTn6NqJj3H
 ypLGPsOxGhVyt6PWLtQr+RdpApX1v57Cwb8ZSC4i+/wKD+o4/NKmwRRCEOHpX8GM+DvKBlqcitj
 MG057wf1MImmK08JvvQ==
X-Proofpoint-GUID: 9oO0tQ2I9kKsC3QiOlcUi2m33T7HpGq2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1011 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020127
X-Rspamd-Queue-Id: B5A021DBC08
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[dilger.ca,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-14326-lists,linux-ext4=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,dilger.ca:email,li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com:mid];
	FREEMAIL_TO(0.00)[qq.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ibm.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ojaswin@linux.ibm.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.970];
	TAGGED_RCPT(0.00)[linux-ext4];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 01:02:31PM +0800, Weixie Cui wrote:
> From: Weixie Cui <cuiweixie@gmail.com>
> 
> The if-else ladder in ext4_mb_normalize_request() manually rounds up
> the preallocation size to the next power of two for files up to 1MB,
> enumerating each step from 16KB to 1MB individually. Replace this with
> a single roundup_pow_of_two() call clamped to a 16KB minimum, which
> is functionally equivalent but much more concise.
> 
> Also replace raw byte constants with SZ_1M and SZ_16K from
> <linux/sizes.h> for clarity, and remove the stale "XXX: should this
> table be tunable?" comment that has been there since the original
> mballoc code.
> 
> No functional change.
> 
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>
> Signed-off-by: Weixie Cui <cuiweixie@gmail.com>
> 
> ---
> v4:
>  - Drop unnecessary braces around single-line if/else as suggested
>    by Andreas Dilger
> 
> v3:
>  - Replace raw constants with SZ_1M/SZ_16K
>  - Remove stale XXX comment
> ---
>  fs/ext4/mballoc.c | 24 +++++++++---------------
>  1 file changed, 9 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 20e9fdaf4301..1d6efba97835 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -4561,22 +4561,16 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
>  		(req <= (size) || max <= (chunk_size))
>  
>  	/* first, try to predict filesize */
> -	/* XXX: should this table be tunable? */
>  	start_off = 0;
> -	if (size <= 16 * 1024) {
> -		size = 16 * 1024;
> -	} else if (size <= 32 * 1024) {
> -		size = 32 * 1024;
> -	} else if (size <= 64 * 1024) {
> -		size = 64 * 1024;
> -	} else if (size <= 128 * 1024) {
> -		size = 128 * 1024;
> -	} else if (size <= 256 * 1024) {
> -		size = 256 * 1024;
> -	} else if (size <= 512 * 1024) {
> -		size = 512 * 1024;
> -	} else if (size <= 1024 * 1024) {
> -		size = 1024 * 1024;
> +	if (size <= SZ_1M) {
> +		/*
> +		 * For files up to 1MB, round up the preallocation size to
> +		 * the next power of two, with a minimum of 16KB.
> +		 */
> +		if (size <= (unsigned long)SZ_16K)
> +			size = SZ_16K;
> +		else
> +			size = roundup_pow_of_two(size);

Hi Weixie,

This if else ladder was long due a cleanup so thanks for taking this up.
I have one suggestion since you are already looking into this, do you
mind also cleaning up the NRL_CHECK_SIZE() logic because its pretty
messy

Essentially, the max contiguous blocks the buddy allocator can allocate
in one go is (bs * 2) no. of blocks so 4k bs can support 8192 blocks (ie
32MB) and 1024 bs can support 2048 blocks (ie 2MB) in one go. The
NRL_CHECK_SIZE() macro logic just makes sure that we dont set size as,
for example, 8MB for a 1kb bs ext4 which can only support upro 2MB
continuous allocations via buddy.

We should be able to refactor the above logic in much simpler way and
get rid of NRL_CHECK_SIZE.

Regards,
Ojaswin

>  	} else if (NRL_CHECK_SIZE(size, 4 * 1024 * 1024, max, 2 * 1024)) {
>  		start_off = ((loff_t)ac->ac_o_ex.fe_logical >>
>  						(21 - bsbits)) << 21;
> -- 
> 2.39.5 (Apple Git-154)
> 

