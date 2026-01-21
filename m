Return-Path: <linux-ext4+bounces-13152-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Kh9JFGmcGlyYgAAu9opvQ
	(envelope-from <linux-ext4+bounces-13152-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Jan 2026 11:11:29 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E752354FD1
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Jan 2026 11:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 530868C8181
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Jan 2026 09:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9163AE6F3;
	Wed, 21 Jan 2026 09:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fSQKHvYH"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C643E8C6A
	for <linux-ext4@vger.kernel.org>; Wed, 21 Jan 2026 09:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768989125; cv=none; b=ts1AceFB9s4d5fJ3tkDrmiInzFMSREuy/pnxSo25v3TNNA1kTpJ+W7+E+YQv1/UC1cG6X8x8gUCYNmeLk7c87vhMlPnh7cVJRz9KF4LAK2bpRwQlh2Txf/bB/WTWLL/UQid0YKiVkvXd7AEuM6eqYF/1DMahXafutSzcDzTrqfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768989125; c=relaxed/simple;
	bh=sKAOOVzZtFw+7lBvebr+3tlTbk7f81FWxT14u2DhcK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HfG9+AsmFdzqC1vMHPEm4fRIyBATK8Gu+PZUYFjvUhLnIOLcPwoo8dQIsp/pjieBvaJBzq++EnDoDSWbOK9GuTS2KHH6VuRTIWzITyqQGGq9yLx+wYdkkBtwpKS0Nk5xfuMSrhUwJu8zArt8hjo6sP0wHBsqFDMz+yWMDYUDfuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fSQKHvYH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60KN0Y3P020992;
	Wed, 21 Jan 2026 09:51:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=mZeAr8m70rC+1egCLs2Yj7qodNEtxs
	M8x2BqK2ySLJk=; b=fSQKHvYHoj/uDdmLPAapmdv/yWp/y+zKO+2Ve9vhYjYOVA
	gX9J13zL8F243hKDHGmnKTsqKsDGLpx5FvenbzyPuZjCRzqiMoYq3/xUp98AY20G
	9Bmh69j1mQeIb1GcAacqBfagFJ6MW9gNfDIyzWVkN2xOZ9B/l7I+Y2kC+vB14VH8
	pe2n6oDuhd/0E7J/QOaB52OhBkY8maI6AJ+8Mu29iNsSs0dZJUXogh1lXnlzmSQJ
	WigBQVWexTEkCmtPt2fXRItY2gfOxALFVCPu0HHEjELWdUN0TS7CyVrm1sAKs673
	8l/Np2AQ5CQqh7uW5ilscTx9P5u1VHB5V7uHaqcA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br2563c05-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Jan 2026 09:51:47 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60L6WQLM016600;
	Wed, 21 Jan 2026 09:51:46 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4brn4y37yd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Jan 2026 09:51:46 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60L9pifn44433696
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Jan 2026 09:51:44 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 87EDE20043;
	Wed, 21 Jan 2026 09:51:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE91720040;
	Wed, 21 Jan 2026 09:51:42 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.23.21])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 21 Jan 2026 09:51:42 +0000 (GMT)
Date: Wed, 21 Jan 2026 15:21:38 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: yebin <yebin@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH] ext4: fix mballoc-test.c is not compiled when
 EXT4_KUNIT_TESTS=M
Message-ID: <aXChqhSUCgUFkWnH@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20260119131257.306564-1-yebin@huaweicloud.com>
 <aW9AofPgVKEL6bk1@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <6970968C.1050507@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6970968C.1050507@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDA4MSBTYWx0ZWRfX6sgCviF8ZXze
 ixCHmCROH1KabHzxNN9MwiNQf4j/HVbCgxkouHoAmB5EL25vER18/ROv8wTVesMjexUyjlp0eMm
 mmZDYHXbW3A0h3ZRByjMQGv+IQiAFO7+755g61kNmTNSqZTSLJxLOGcybbLnGVPRJOH72LLDvyT
 P6nwLzU8/QX6gorn1ujq0RTMy2cyKZwGCVYkTcwViqhpP/w+GgBVWcg6xwdv9GQao1uu7JpBZSu
 blz6MFsrcfyQmzCggEFrUZI8wIcouIWdZ0txfcSkjwybS3oTxvNc9DfYryz1yl9xYvSuyfluUHj
 G6z99GI7a0mXFpJadrj4mBsTV+OMtzL+URrRzNbnZyXyL8OAUE1mCZqTm7Q4DqX/9u4rtETmqBl
 +7i/cWGyQ3IHKtFLvRMOo8u4scWGVi7u3R4pWRjkMTfXvL1iVpOcjwW6p/jqsNaxmL8NsAvhTnL
 Yqis5WsgM770pqzXlEA==
X-Authority-Analysis: v=2.4 cv=BpSQAIX5 c=1 sm=1 tr=0 ts=6970a1b3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8 a=M87kKLqQOsZr0u_KcasA:9 a=CjuIK1q_8ugA:10
 a=p2IFJ_9x1UAA:10
X-Proofpoint-GUID: z0cNnVT2BH-OP5wvqgDVr7LYdXMs2B9n
X-Proofpoint-ORIG-GUID: z0cNnVT2BH-OP5wvqgDVr7LYdXMs2B9n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601210081
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[ibm.com,none];
	DKIM_TRACE(0.00)[ibm.com:+];
	TAGGED_FROM(0.00)[bounces-13152-lists,linux-ext4=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,huawei.com:email,li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FROM_NEQ_ENVFROM(0.00)[ojaswin@linux.ibm.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: E752354FD1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 05:04:12PM +0800, yebin wrote:
> 
> 
> On 2026/1/20 16:45, Ojaswin Mujoo wrote:
> > On Mon, Jan 19, 2026 at 09:12:57PM +0800, Ye Bin wrote:
> > > From: Ye Bin <yebin10@huawei.com>
> > > 
> > > Now, only EXT4_KUNIT_TESTS=Y testcase will be compiled in 'mballoc.c'.
> > > 
> > > EXT4_FS      KUNIT    EXT4_KUNIT_TESTS
> > > Y              Y         Y
> > > Y              Y         M
> > > Y              M         M // This case will lead to link error
> > > M              Y         M
> > > M              M         M
> > > 
> > > Fixes: 7c9fa399a369 ("ext4: add first unit test for ext4_mb_new_blocks_simple in mballoc")
> > > Signed-off-by: Ye Bin <yebin10@huawei.com>
> > > ---
> > >   fs/ext4/mballoc.c | 6 +++++-
> > >   1 file changed, 5 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> > > index e817a758801d..0fbd2dfae497 100644
> > > --- a/fs/ext4/mballoc.c
> > > +++ b/fs/ext4/mballoc.c
> > > @@ -7191,6 +7191,10 @@ ext4_mballoc_query_range(
> > >   	return error;
> > >   }
> > > 
> > > -#ifdef CONFIG_EXT4_KUNIT_TESTS
> > > +#if IS_ENABLED(CONFIG_EXT4_KUNIT_TESTS)
> > > +#if IS_BUILTIN(CONFIG_EXT4_FS) && IS_MODULE(CONFIG_KUNIT)
> > > +/* This case will lead to link error. */
> > > +#else
> > >   #include "mballoc-test.c"
> > >   #endif
> > > +#endif
> > 
> > Hi Ye Bin,
> > 
> > Thanks for pointing out this issue but your solution seems to be having
> > a side effect of making ext4.ko depend on kunit.ko.
> > 
> >    modinfo ext4.ko
> >    license:        GPL
> >    license:        GPL
> >    description:    Fourth Extended Filesystem
> >    author:         Remy Card, Stephen Tweedie, Andrew Morton, Andreas Dilger, Theodore Ts'o and others
> >    alias:          fs-ext4
> >    alias:          ext3
> >    alias:          fs-ext3
> >    depends:        kunit
> >    intree:         Y
> >    name:           ext4
> >    retpoline:      Y
> >    vermagic:       6.19.0-rc4-xfstests-g326263653b81-dirty SMP preempt mod_unload
> > 
> > That means we won't be able to insert ext4 module without having kunit.
> 
> Thank you for your reply.
> In my opinion, if the CONFIG_EXT4_KUNIT_TESTS configuration is enabled and
> ext4.ko uses symbols from kunit.ko, then it is normal for ext4.ko to depend
> on kunit.ko.

Hi Ye,

I just feel it adds a dependency that might catch people by surprise.
For example, I'm looking at some RHEL kernel configs, we have EXT4_KUNIT_TESTS=m, 
KUNIT=m, EXT4=m. So incase this patch reaches some distros in future, we
will can have kunit module inserted everytime someone wants to use ext4 in
production, which is infact not recommended by the Kunit docs itself.

I still feel we should avoid this dependency. Eventually we may need to
see if can just build the tests as a module [1] rather than #include
method to avoid these issues.

Regards,
ojaswin


[1] https://docs.kernel.org/dev-tools/kunit/usage.html#testing-static-functions

> 
> > This is not the behavior we want. I think a more simpler fix here could
> > be:
> > 
> >    #if IS_BUILTIN(CONFIG_KUNIT) && IS_ENABLED(CONFIG_EXT4_KUNIT_TESTS)
> >    #include "mballoc-test.c"
> >    #endif
> > 
> > So basically, as long as KUNIT=y and EXT4_KUNIT_TESTS=y/m we will run
> > these tests, otherwise we won't. This also removes the dependency issue.
> > 
> > What do you think?
> > 
> > Regards,
> > ojaswin
> > 
> > > --
> > > 2.34.1
> > > 
> > 
> 

