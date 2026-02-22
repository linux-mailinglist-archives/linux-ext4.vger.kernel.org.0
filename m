Return-Path: <linux-ext4+bounces-13769-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DOBMauam2nU3AMAu9opvQ
	(envelope-from <linux-ext4+bounces-13769-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Feb 2026 01:09:15 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FD9170E53
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Feb 2026 01:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A99C5300C90C
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Feb 2026 00:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184F6F4F1;
	Mon, 23 Feb 2026 00:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rocketmail.com header.i=@rocketmail.com header.b="qmUuNlqD"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sonic316-21.consmr.mail.ne1.yahoo.com (sonic316-21.consmr.mail.ne1.yahoo.com [66.163.187.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AE5DF76
	for <linux-ext4@vger.kernel.org>; Mon, 23 Feb 2026 00:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771805352; cv=none; b=StR4yoCJMusuJpXn72iigoDknpBJpHaTNVIBLv5fP3yxZqfifty5CalEb56J2o/kp7GT0imBMRNfnY11RIAcfXP0qT1kJFwgIm2tq4MMeiqfjO5c8MEiTHavgR+3mVGVBpMjBL+4oFlnAcA43z83jc4L6NygeQg518wVC5oNrbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771805352; c=relaxed/simple;
	bh=MMlT3BEOkyACfyu/Zb9hs74cDUuueM2SXiCxwxBJwlk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vGSpa6X0/sXTVP2q6khpBaoiAoB0FQy/VEVuzw/WWTJbb1t59rOX6GnF303pJQyNgg5s5PjYyi2yj2IBKqeKSAwwgsHRdq/jxqmqARzelci6FDBeYer9+F7gqDzI9H4pIlDUKumkSnm9xOT90cRCYKX3cVB29gR5/pdOYymXpZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rocketmail.com; spf=pass smtp.mailfrom=rocketmail.com; dkim=pass (2048-bit key) header.d=rocketmail.com header.i=@rocketmail.com header.b=qmUuNlqD; arc=none smtp.client-ip=66.163.187.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rocketmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rocketmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1771805350; bh=sFLpp+jkHBFj41x3oL6S2+LjNIJH1IGhbSOv62gDP54=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=qmUuNlqDmJecFQijlYNwr+whGkXTjFtg4v2OXW61szJ8SzowqUP73INy1BiBcyV8QnWd1rONPLlQbWpnY7O2wrJ5fkDwOwXEfLFhZAHc5RVDrhWAPCK+65PiBIF5SK8Y71+7iGOAPRMYxUAAqiHS1g9IpZP/kb/bypiHAT4B/1BVSyITgAs+f6vVs4dQt8futhhigEShvmOHG21KpLP3kRQGEelNtE/tr291WySEQbAS1XTDTiNxTKIkZFRIKQeq5/poY3IKB2xe+J7JJIxCd+IYZCTbyRQaRn2WjjZR11gjB9lVqfcwrt2L1QNdx+tduSsusVyQRJUHA4Tg+3J/uQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1771805350; bh=S8iaoA3biWasLNi7TnxzOpFblNngSDd+fBQD6DkBS+s=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=jYobDZPAPZi1OBHKQlDi9dGOQCoKyLFtbJXxb+PTafbpHA82+xb1y5P7LSDRaVfhulFaENEjp0uFsl/f0Shr5S7xfWK10Ki4y7uA9Nafo/0RylC2WasAx5DxLeW2TfMtfUE/gMEZ96tyziTdUWOQm+tcFSREtr5BXyz0JZ8HMQwlONE0yMCIwMXKZQ6HqleuYpqlvR2nCF1mM1u7LF2j/6xOwLbyuAV0JWJuK9jnFigCtvptxQ4ntyxMbPkwZMxD37OyUKyCeBBpZzBE/zMAg9S8kP9MXnQnch+YXDUfGwQZYd6o+New8ALqBs7wwIe4AH0VZ9vxWkyF8aaHwa7xBw==
X-YMail-OSG: 56.txqMVM1kGx15GToT8LpFjjslK45ifZktaIC9OusDZi7n2VXoPIqPH6tNROCe
 s1VSEUoRfq1fDjGLWFtvt5tIdD_Y3DlDpu4qWmt37OBBOhHOFQZKbGKPwxEYy6WwgXMejyAF5N1s
 swkMzCdIi.JRpPOJJ7QVctg3jPDnokQYwSVpKfExY4TItekYTPRZI8MpmcmpE8V9qnyBdzbpIIv_
 Hgw1AN89ttR_ldHWrS3PsoyxrjzQ9R1bUUxkeItrFUVvoVgfwbuDLDr_9ek.d9cCXPX4uh16GVTm
 PTh24hz6ie1UVWs4Orvn6FiermyvO7BK8OwNvO6eMIyY8ED_4fcSvZpRRoU9Oh7R5VuGMIz1AWZO
 YssKQzSrE2P0muErR.21AptlwBL353YWav3tJxrHAqwJm8gws90.OjeziRTH7o3SpeNWKIuEU4Gb
 ugILASZXHL9hx6._skteRm7UtFETd8BSJUfLSA7vCw2T9s4EF9yNzFVTr_nvIqkXBCktEw3YyKE_
 UmvJC8GbIIG6Fn7.PwOzsb0dzPSXLakyqC8r9U2VaCvMs9Odmpvb56zNWbohrdSD7FVxWbLtHboX
 928kr6GVVQvr332akIFsFh.cHhx6865mBstUHJfEVecJJtso6Xvq.jLSPUipkzAJB7q7k1B3loMe
 K3I7HNE8OuYjdAQm9MdbRRUVvRzBZ5vh2VW6xdqQPqhPXMgvKQnKSEPgIkMzOm7j5Hln5VHEIc7a
 740MPEI.yLRpZ5iIGPHN9tiBS1KUHP0Nef5KS2jTMU6ZHOMq1eAQQO9SJr4pV5vIydFjjeFbXSAt
 k0E_kyJgLJiryky.D2Inzw41v5AZu_rQ2xzZsvfg8uNBXjUj_qTVG33te7SBBXELWtOUBA5Fj5hi
 LssTZ1ME2VqM0bBxUlVpu8cPTNHN664U2BfY8DBci_b9aXzwVATWOB4aQyl_Z8s4og62Lr3WITU2
 YfnVzBpPSqBKx7gdu2eB8FB10fM8vBDsHRn.gLgbqdR9hFJ14sDt.1v5.MEsku_s4uqjjq1Yhesu
 zw3TOgRho95qW02ML8UXFkOryWCFsSOeMQ4TCCitNwWb6YZ3vWjTBc8w01wZJSZfDvv2eQB2aGuq
 5IGxNctQfj5Io1.7X6WX3ApIyUbwNaH8GUzrFl1Q40DQ3EkPTfW8O_bnjql0IYhUErXAMgJYi6nh
 xZT6JZPxI8t7Z20RIdhQycMKn0z7Qg.AEkOlV3Yi3xm0TYtxwfLMMqQ6WnRtwksHgIOPauL9fSMR
 KP_njG5trFkx7Bb0lMiFuYwATkpa06QvQTliswaZAJ41DK6t7BGk9Rs6e6Qfi2211FQVaLJwjAcB
 oyO_M4YVd16DoN2B3Nluo.SAD9bP8OuOulH4AG6Ci.L67cMSx6_o_6BkpEUUQL3IrqBkVHaZbo.I
 .0JVHOmEo4lwbfo9EL9OXMnf8P2CZm0_UH9TmXZH6vDN1rTxkKX5Y3AiJ446hqp2wpEgcfcAR7nz
 Pv3dyAcJv_GqTAu.CfD3Sam4008NlmBku_qcLmBR57MUgOB0TOQte3v0FpVzAJhQ5wG7B.A1I1Xs
 bRYoGfVi_Ut6MLnK78Z9afg99HQi5ISf0ivu2lhEQe6ZBL3hyJUmuF_HAsQMYqEMPw_txvo5s_pp
 529CfpVasDBbhYDjuWALJrVvmVlmr6ZnHpSFdxX7eJJ.dAweGRABcfB7hlP_rUq0fRq8U2ViLZRk
 JkH89sQg0LfOiw1axj0rNqodnLNbsbA4mNFNAguKXS4PLBHw4RATUQHa6Zk2MrbJ8hRKGBKlSr8k
 TMXi0rlO96CSbJCetAYvVbecc4ZahI_KgGpU6x5ZCoOB2guyBaDRlEsOS5Gkf1X8cO8BFMXMdQ4l
 A5Rwe4l0EEWpZtZcmwEL7vmPaiEJQbbN3CAALVqn06803rUZLgFfalGXeHl8UHN1CtGXJGGKTE04
 Q3vV24BS9YKNxEEs6_KIWXj69E9j0cdQNKnDt__NyVyt9lGHTSqFAPUgGyRhwYtlC5UwVrx_XtLl
 72AN.C_B8ZdKa7ah1hBzb0GiXy33OltEIhO3dtTqjQ5r0a.LYLOjLRig31_QThaz0GKw3V1sGpgU
 3.puBYm6PBUxRhycX5jYAVZ3Bsjy1Gdk0EDq3KgUkaX_PTy0CMvRvIDl2NTGTGCS9vijufueUBvn
 cRlyOap9vZLWf3iHjrrCqDimsEuKAkdW6QIbT0Y.LKsjMWw2Bqqwrx8rMu1jehzC.Sg4IYc8RoHJ
 8Lif_w8wi5qtwZI5FgWYdu66uQB8sjtpAYSBW
X-Sonic-MF: <mario_lohajner@rocketmail.com>
X-Sonic-ID: 01330c34-d24c-4593-86a8-f70d1269996b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Mon, 23 Feb 2026 00:09:10 +0000
Received: by hermes--production-ir2-bbcfb4457-4sf65 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 377acfba9804a543d50c2cbd3fe052ad;
          Sun, 22 Feb 2026 23:08:27 +0000 (UTC)
Message-ID: <4b19e54a-57aa-4a32-adf8-2dbf07d3d9ed@rocketmail.com>
Date: Mon, 23 Feb 2026 00:08:24 +0100
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: add optional rotating block allocation policy
Content-Language: hr
To: Theodore Tso <tytso@mit.edu>
Cc: Baokun Li <libaokun1@huawei.com>, adilger.kernel@dilger.ca,
 linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yang Erkun <yangerkun@huawei.com>, libaokun9@gmail.com
References: <c6a3faa7-299a-4f10-981d-693cdf55b930@huawei.com>
 <069704a4-2417-470a-bf32-0ee3afd1be6a@rocketmail.com>
 <9fc3443b-0eea-4917-909b-709113f5e706@huawei.com>
 <606941c7-2a0d-44c7-a848-188212686a78@rocketmail.com>
 <20260206014249.GH31420@macsyma.lan>
 <26d60068-d149-4c53-a432-8b9db6b7e6a5@rocketmail.com>
 <20260207053106.GA87551@macsyma.lan>
 <16f17918-9186-4416-bbde-b93482933d8b@rocketmail.com>
 <20260207175522.GB87551@macsyma.lan>
 <9e520492-9b26-487f-9d60-7e0625c987c9@rocketmail.com>
 <20260208195849.GA74984@macsyma.lan>
From: Mario Lohajner <mario_lohajner@rocketmail.com>
In-Reply-To: <20260208195849.GA74984@macsyma.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.25198 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rocketmail.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[rocketmail.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[huawei.com,dilger.ca,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-13769-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[rocketmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[rocketmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mario_lohajner@rocketmail.com,linux-ext4@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rocketmail.com:mid,rocketmail.com:dkim]
X-Rspamd-Queue-Id: 27FD9170E53
X-Rspamd-Action: no action



On 2/8/26 20:58, Theodore Tso wrote:
> On Sun, Feb 08, 2026 at 12:47:12PM +0100, Mario Lohajner wrote:
>>
>> Someone comes forward with a fork, saying:
>> “Here is 'my fork'. I believe it may work well for 'some dishes'.”
> 
> Give me *proof* that it works on 'some dishes' in terms of actual
> perfomance, specifiying real-world workloads, and real-world devices,
> and we can talk.  "I believe" is not enough for code that upstream has
> to test and maintain indefinitely.  If it works for you, it's open
> source.  You can run with an out-of-tree on your systems.  But if you
> want us to accept it upstream, you need to provide something more than
> "I believe".
> 
> Cheers,
> 
> 					- Ted

Hi Ted,
sorry for late but lengthy answer.

Of course — no disagreement there. Getting code upstream is serious
business, and I fully agree that “I believe” is not sufficient.
If something is to be merged and maintained long-term, it must be
justified with measurable data on real workloads and real hardware.

Before going further, let me briefly say thank you:

Andreas — thank you for immediately recognizing the core idea and
potential usefulness of the round-robin policy.

Baokun — thank you for suggesting the per-CPU split cursors and
reinforcing the stream allocation direction.

Theodore — thank you for pushing me to rethink both the execution and
the structure of the patch itself.

That feedback directly shaped V2.

*** Whats changed in V2 ***

Stream allocation enforcement:
To promote sequentiality all files are treated as streams, but instead
of relying on a hash array of global goals (with unpredictable scaling),
each inode maintains its own atomic cursor.
This helps preserve intra-file locality and reduces fragmentation by
keeping allocations sequential per inode.

Per-CPU cursors:
It turns out the contention point isn’t the cursor itself, but rather
all CPUs racing for the same blocks.
Per-CPU cursors is the way tp a solution but with a small twist:

Allocation starting points are split per-CPU and evenly distributed
across the LBA space. In effect, this creates LBA zones advancing along
LBA as allocation progresses, it further helps avoiding allocation
hotspots while keeping race conditions and contention in check *without*
mutex or locks.

Preserved is allocator isolation:
Regular allocator is not modified or burdened in any way.
The rotating allocator is selected at mount time (-o rralloc) and
implemented as a separate allocation path.
This keeps the default behavior untouched and allows independent
evolution of "rralloc" policy.

The repository below summarizes the motive and result of the current
design:

https://github.com/mlohajner/RRALLOC

In summary, files are "floating" across the LBA and in-place overwriting
is greatly reduced. It may look counterintuitive, but that is the goal, 
tested with v6.18.9 stable.

Best regards,
manjo


P.S.
On performance evidence

Like V1, V2 is a policy, meaning:
It relies on established and well-tested ext4 heuristics, adjusted to
produce round-robin allocation behavior.

As proof of principle, it performs round-robin allocation across the LBA
space (and wraps around to the start, thus delivering on the promise).

By design - leveraging existing ext4 heuristics and keeping the rotating
allocator fully separated - performance should remain in line with
current allocator expectations.

Preliminary results confirm that round-robin allocation can be
implemented without compromising (regular) allocator efficiency.

