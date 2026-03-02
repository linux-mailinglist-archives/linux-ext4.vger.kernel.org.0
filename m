Return-Path: <linux-ext4+bounces-14330-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MatInbHpWnEFgAAu9opvQ
	(envelope-from <linux-ext4+bounces-14330-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Mar 2026 18:23:02 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CF51DDBE9
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Mar 2026 18:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4E8CC30058E1
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Mar 2026 17:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BD0425CC9;
	Mon,  2 Mar 2026 17:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P/IKWw2H"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8845F36C9CD
	for <linux-ext4@vger.kernel.org>; Mon,  2 Mar 2026 17:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772472177; cv=none; b=ldbEbk2h9T9y+DgVPCzDwi4KiLQM89T72Za+tz0070CBNYDvTFXx4KOD4SQKvTBuZOnNhZxzYSA7XHsIRN7r7Pu0LAHye8ovxmkhmS66aPU4nQXQpojC/YEJaSd3R+L2ER3XyFezV4aBgOHV7kT3KqfzyPc0BhyVcvEyFsy45xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772472177; c=relaxed/simple;
	bh=WgTPk+qNRmkzPvNca6f3hirLn+iueYtIakZvXzzvVkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDdK6mq6xNUr0SfvQMvSKfB9HdqZ8eMfr5aT9AhPfqnqSOBFTJuqoN5z5wr4lxQIk5DgetxsQUccSZNZsqwnp8i4tMA0Z+Smqf8SYa9yCPTd4wOVptz2QyDe35Iyc2Zu5bgB2w2J9LAWM0wqejV/0torbDIjUhpOLoDf0nRnCzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P/IKWw2H; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622E3U1E2080896
	for <linux-ext4@vger.kernel.org>; Mon, 2 Mar 2026 17:22:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=XginLNNRNhYShrDJ4oisk+E2Akf33Q
	hBtqzbqpL7BB0=; b=P/IKWw2Hqz4YVQVNUdLcIBJn6vz8TZibtbXGpY6LchOT6c
	WuzIbeKHIsdWdWrs7sWN4Ctfggsaks8peCHqc9VZRGrDjj3gY9AEjNLncOdO6DCp
	0Nzcdvkvk5qtu9c2D/mRhsh4K6btiZvLRqwBMYE+pJkZsZpocCAjTo+kjk39x6O1
	3jkEUS6meKRDItLIHbw/IQRVWhtvKTcF/CXiyki8wnCeoXah/I8WxNb+qA8jp+c4
	V9n2wYY7S/lxDYc1/n7oNF94XLpXUQDbi5uDZVAAZSBQQZC2YtyyP0J0WVeoOqgK
	Wk4S4FtWBcsnXUdFXE1eCtX+4phgGHvhev8UKERA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckssmfj2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 17:22:55 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 622E2iQG027662;
	Mon, 2 Mar 2026 17:22:54 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmcwj6twp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 17:22:54 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 622HMq4635914232
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Mar 2026 17:22:52 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E20320043;
	Mon,  2 Mar 2026 17:22:52 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C2C8E20040;
	Mon,  2 Mar 2026 17:22:51 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.211.209])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  2 Mar 2026 17:22:51 +0000 (GMT)
Date: Mon, 2 Mar 2026 22:52:49 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: kunit: extents-test: Fix percpu_counters list
 corruption
Message-ID: <aaXHaeYhtbKScEO1@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <5bb9041471dab8ce870c191c19cbe4df57473be8.1772381213.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bb9041471dab8ce870c191c19cbe4df57473be8.1772381213.git.ritesh.list@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDE0MCBTYWx0ZWRfX9b9cePNYc7j9
 VeuVxhmwTFOmO4PGWrPX4mUeEkyzrxBhgs3M89JIYi2wtqAKeIewiOfhQx/f+Az2W1m5hK5TCv3
 723bO9r+2l2EYjzbhkr8wHF6bS49KWEWnYePFf6onRw30Nir5scIAuqRX//o+7TNVJHSG0kE2JE
 A+2mnq9hkEWRDhsoXAYx/qtOBKwup0XE0Pm23nnSBWl2o01W7pUxjWW0KB7mnaw6Iwioi19dyfT
 3eY5vZAmPcTrOBUPtHt9zQnUWmG4mayNNoX0Nty4kFgrIywPYPKKbW23w7cfm2jIP5MzGgwEvP8
 eLqLwa/LXZKyMxeAmze66I17A/FO/SodKU8RSqm88lRvWGs2PRZfrGNqZ+lhye+rP6yCSXBlzsb
 DRSeo5EH86wMf9/qLSiH1vJoiQb9Wt+fwfVVu7zRvLiuOFJoVJnQs8ARnJVXjVxh02+n4GBa9l+
 23HgvqVzZ5ol2P+KKOg==
X-Proofpoint-ORIG-GUID: xxqSVT51Iu0Pl8LePNoWo8ddLVPkH4D_
X-Proofpoint-GUID: xhDN-t_NUyGUiO6zOmvHtzKqfrnPrHuK
X-Authority-Analysis: v=2.4 cv=AobjHe9P c=1 sm=1 tr=0 ts=69a5c76f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=RYFEQTbYq_cBbKwKQy4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_04,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 spamscore=0 clxscore=1015 suspectscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020140
X-Rspamd-Queue-Id: 17CF51DDBE9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	TAGGED_FROM(0.00)[bounces-14330-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ojaswin@linux.ibm.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[linux-ext4];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action

On Sun, Mar 01, 2026 at 09:44:26PM +0530, Ritesh Harjani (IBM) wrote:
> commit 82f80e2e3b23 ("ext4: add extent status cache support to kunit tests"),
> added ext4_es_register_shrinker() in extents_kunit_init() function but
> failed to add the unregister shrinker routine in extents_kunit_exit().
> 
> This could cause the following percpu_counters list corruption bug.
> 
>          ok 1 split unwrit extent to 2 extents and convert 1st half writ
>   slab kmalloc-4k start c0000002007ff000 pointer offset 1448 size 4096
>  list_add corruption. next->prev should be prev (c000000004bc9e60), but was 0000000000000000. (next=c0000002007ff5a8).
>  ------------[ cut here ]------------
>  kernel BUG at lib/list_debug.c:29!
> cpu 0x2: Vector: 700 (Program Check) at [c000000241927a30]
>     pc: c000000000f26ed0: __list_add_valid_or_report+0x120/0x164
>     lr: c000000000f26ecc: __list_add_valid_or_report+0x11c/0x164
>     sp: c000000241927cd0
>    msr: 800000000282b033
>   current = 0xc000000241215200
>   paca    = 0xc0000003fffff300   irqmask: 0x03   irq_happened: 0x09
>     pid   = 258, comm = kunit_try_catch
> kernel BUG at lib/list_debug.c:29!
> enter ? for help
>  __percpu_counter_init_many+0x148/0x184
>  ext4_es_register_shrinker+0x74/0x23c
>  extents_kunit_init+0x100/0x308
>  kunit_try_run_case+0x78/0x1f8
>  kunit_generic_run_threadfn_adapter+0x40/0x70
>  kthread+0x190/0x1a0
>  start_kernel_thread+0x14/0x18
> 2:mon>
> 
> This happens because:
> 
> extents_kunit_init(test N):
>   ext4_es_register_shrinker(sbi)
>     percpu_counters_init() x 4; // this adds 4 list nodes to global percpu_counters list
>       list_add(&fbc->list, &percpu_counters);
>     shrinker_register();
> 
> extents_kunit_exit(test N):
>   kfree(sbi);			// frees sbi w/o removing those 4 list nodes.
>   				// So, those list node now becomes dangling pointers
> 
> extents_kunit_init(test N+1):
>   kzalloc_obj(ext4_sb_info)	// allocator returns same page, but zeroed.
>   ext4_es_register_shrinker(sbi)
>     percpu_counters_init()
>       list_add(&fbc->list, &percpu_counters);
>         __list_add_valid(new, prev, next);
> 	next->prev != prev 		// list corruption bug detected, since next->prev = NULL
> 
> Fixes: 82f80e2e3b23 ("ext4: add extent status cache support to kunit tests")
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---

Hey Ritesh,

I can confirm that the patch fixes the issue. Thanks for looking into
this. Feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
ojaswin

>  fs/ext4/extents-test.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/extents-test.c b/fs/ext4/extents-test.c
> index 7c4690eb7dad..a6b3e6b592a5 100644
> --- a/fs/ext4/extents-test.c
> +++ b/fs/ext4/extents-test.c
> @@ -142,8 +142,10 @@ static struct file_system_type ext_fs_type = {
> 
>  static void extents_kunit_exit(struct kunit *test)
>  {
> -	struct ext4_sb_info *sbi = k_ctx.k_ei->vfs_inode.i_sb->s_fs_info;
> +	struct super_block *sb = k_ctx.k_ei->vfs_inode.i_sb;
> +	struct ext4_sb_info *sbi = sb->s_fs_info;
> 
> +	ext4_es_unregister_shrinker(sbi);
>  	kfree(sbi);
>  	kfree(k_ctx.k_ei);
>  	kfree(k_ctx.k_data);
> --
> 2.53.0
> 

