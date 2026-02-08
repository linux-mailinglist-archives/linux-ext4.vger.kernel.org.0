Return-Path: <linux-ext4+bounces-13619-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFRwHfoMiGmyhgQAu9opvQ
	(envelope-from <linux-ext4+bounces-13619-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Sun, 08 Feb 2026 05:11:38 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F33107DAA
	for <lists+linux-ext4@lfdr.de>; Sun, 08 Feb 2026 05:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0B9763003727
	for <lists+linux-ext4@lfdr.de>; Sun,  8 Feb 2026 04:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C4C2C11F9;
	Sun,  8 Feb 2026 04:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rocketmail.com header.i=@rocketmail.com header.b="KJc28idF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sonic302-20.consmr.mail.ne1.yahoo.com (sonic302-20.consmr.mail.ne1.yahoo.com [66.163.186.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FCF29BDB1
	for <linux-ext4@vger.kernel.org>; Sun,  8 Feb 2026 04:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770523889; cv=none; b=P5dvJU19yJ2EH1TcfZWXhpG4dVRXFqI/h7lLQA4iM+DY2aGwma/qbePTFj3lDZdhNQ6AcHn1SSCUkRiQEiy833Bid91ZQNZpBuXqv5Q5Kpxby4YAFgz1gA10+tcw9Q3q+Mq5olCB1u6/uNys7R6IB6l9AY5zVHpoOmQIWyP2L5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770523889; c=relaxed/simple;
	bh=MjnaEh9WwKDfwE8BInUDTm4fHKHXy+JK/rKV7H1l4Pk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IraH4PCePUaT9I2DjxkJINOcq0sj8eF/H4tahxPXvZkBF6Lho5DCRHU74HD9stcY5Mlf5cdSnhJ3Tqpvd4CbF1x8d6EpDskWBdyKFYDYXOHk3Qw/oaWKirUch1uNGMWuXM3tEebr33HJjMH0BjytzUDEMLbrAhtevMNZomKYrJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rocketmail.com; spf=pass smtp.mailfrom=rocketmail.com; dkim=pass (2048-bit key) header.d=rocketmail.com header.i=@rocketmail.com header.b=KJc28idF; arc=none smtp.client-ip=66.163.186.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rocketmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rocketmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1770523883; bh=h43xZnnNt9QmBfDnktsfg/b6RzX9IT0yQZgTatKX/8I=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=KJc28idFmT2qECs4hQC0Gz0VrPDXQdp0znJdGxH70Vv4i5AwXQqZIj71/qMhQfLh9/kH/6rJMHHVmlBwO3Kt1RlGFsYIAUTeze52oy6j6/R/Y38Gc+c3MPkCuy5WrL1Ee0KcoxS168l/KrPrA+v2+Tj/xF75uKksyrCsZHi19DNQ1Hxsc6lNCHv3Rl4vMhar+gOm2qabhN142WGzIS+nkongbubdQbPBqNacLmIO6PubL0zgelMLpDeMkZvB2ogXu85fKqoZ7TnoXu+Z41yUusNM7i6y7G+2su7xiH35hgesx+hRSZUmXAW1HgievCPyqDYq3kq4KyaoYHDF2TLpsQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1770523883; bh=5bblukTg7fT7RyAn5pSwCWsM8e4Ey/s11c4QGHSagEi=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Wxbh+EXs1t244itZJg+Q8NEy9WmJI1VfTkXz1w8ISwS5xPcgklyiEArNAeTJFp3uU/+ygOmRnwCx93rSNJMKYdHUCikHk4L51ebhCm8yBz32rj1Jqq9fblDNor9Pd6BGehs770EabkH4OrhYdv9RmGB0H29cZJbsqEG88kzXGd5DpT6ZQ43zHOfWhEi3FGWO0SA9ehU9njMK8vcsed8mX/okF5yMEyC3Itnq4MRGAGHromILbznPF6RCxP6jI60FUXNmCy+jR2dGvWsw8YhjTFTAYjWiCmJEu0eIQba9LAqYeLHcOqnuEdskLo/WjjRsa8ra60G7rbhKqS9WbvcLjA==
X-YMail-OSG: rJkxGa0VM1mVo3h6C67wN3cKbHlpWRYBy7zAZa5BKpNzZwhmBfIV4y1xbhDey_b
 WiEa2nFlRrVOSw6j9g.LormjGExijsNLh7rrjaQ3sR8zGaOOnVuLbQd3iWIgPWaNQN.FF5sJiGr.
 eq0ZGp6ddVSZ90WcM9bGNt4vTyrKgkTX3GX7pqQ_qI_hobE2DjhiTXk2Jci50qZKIB6T5dEwCD2i
 tPuAzNWloLXFGopLJMV8wDK4heak2jp3epBG1GpYoWGIfYBObG9ECJA8tDAeD8I9sVIqCFG3Z7NV
 YDwrlCuQBijQt0A27nnUoaJujIS1pOFXG.LMxPJJ3BWgjOCtkbKn2UENTVySsAFsDtXmFYzAvcg6
 Z7lUJ4oBQ0Fhay8fhGZp038wCmKy.gb5OCBVoDWr4BUH29KcY8DIt3vbzIljk5pOMT58Lue8YlE.
 Qb9ruSiYkvKF2eWCdeB0AS4t7qb7S1RDBA5jXyIwYWnH5Ej0FX.Xy5MyQEZ4iVufe14k_bRenegT
 OvktREaNScjnuNut_05I50JXJZ8j8_KxuGhwwFOATGsH_PfPhUFmOhdIWij4ov4XqymGtL0prsCZ
 iSDtb_.CgWKjasgx83Qq7Ta7u36EJmTSoTZFBEy3MseDF4qoc5KovU1QK8_Fk8K5T5Uj0UBG8viJ
 Vfzj7Mbui8bJAcXRQgP._6AW5nSs0nKbWN9LphTjOEg5eJoDX6YRZ8I0oGuwncgbo4F_juN4JCBC
 lO9bzEG.eCyPV184r5SXmx__usWRXf_sVmLJ4GE.BHIwW3enAfowbA48TAQm54AeqC_7I8SsRqfB
 1M3oBW6Ig4HuH0bB6fvexagjWxNRrplB8fjvcl5_WYMfDXKYCDh.eXTJy2bba.e8jEGGyEUEH.WU
 LBrQzVoAqcRBFyaIHNdXdyk6AspF3fQTKJUnwiduG3mzsi6UJL9wi5YVCUHXdDmMvIkaPbKDY6XM
 MIs3jcqgxtrbhXFMOa.9LKJTgeQcc7uo9QS7KkT85PVw8wVf3iaRzG.6yRO6aUZQf_TOScPiI8B9
 SnH4lU3DVEUhjdMnrnaHwRKGm7WUBxm0KPUGjxQk0MOs1Xhv.BqRWv7oNURoYUc67PS8OHLr2pwS
 w7PG71taPyIuWmGKVzRrjFoeiwvBe_VpeRbE6qBXmiYFkcfXxVnUtK67sI8yEcDqbM77qgrcGrdh
 G.XS_73cVGDRO7Ds0Pn7wbPRwF2_MyQebDvNRJawnJ_7_k8qO1HP1WNim8dtKJ8Zd3pBKba6yJ5b
 5.zYdIaz7YNOHLNrkJW819TvUSIf2ChHSR8y2uiI5l5zd9D2qp9Dt.Z3ngmrD.CLffGkFGxkN_SL
 0cGFPeSw3TYJO7iit71O7CII2OEbacqULH98zg2jNfL92rbpTEAviCZg8l1X55BGA21D4rHQu_vY
 B3aTM4.4b0ZMp7lZXbIB1nOaiDD8LWIQyz3DMBrvgh2PJjbQBpeaset9r9hCa7YpbD0tPXjgTLmN
 sq2FjZVND036sYw8LuPxEko1T7TuJYVmv_A_5B2L4WTXMaelIKxj2rYhClD0yZU4GviKzNGZO4n4
 DiGNp73.yLbH450M03my1WdpIQlk0J120DeGq6TL10h2wB10SuaeV5AzH5o2SbziQIH2R8oj3jwg
 qAxoxh_LhmXcGA88FSn_g4rWXuV6eX4Sz_5hCw9rYvYPJLc4R6vY1Z8hkZ9OxM307aT4Whgg2f7f
 FZ.b9uhsNhC7uJ718F2HEDivLfeulr1mGWmaZpD.JReug.Lni_FibJSiwCCgW6tHwMQhdc6beENn
 54OGcgnmp59.92Dbx7qTRbwAmux8o9pqngsBW_VCkBKf8.pWk3Npaojzrs5k0k3H09Gob_3fbBIj
 wiBKLM2IDoCWvvTng5yDa.1lBfcWp1MbWDJAqniMH9EnaDltQPdL6aiiPgXbWalS91vbKvFj6we0
 2YhtPbFEVnvq9ibsJhq5hZ5vMK0bhZQlg1LbHCfXCS.WguNxx3rD6Sg9X7EFBtmoL0ZjtF2Z3EtF
 I1luKiblEQPWQZ_XAtdsKKsoRIhdpUuJhfj00aJT5hkmh2lYPkHggBKrLsaKrGyUwlmwIrvCIkTL
 Hbel_PpveRq46oBQC4Q1TEqesrYcyKWnKcY31g6KNSCCk0WYmmqpn4PNnVYjgYWF5QJ5PYSrN0MS
 4VuQwqMQTLANiFnhl3GhN7ZQLS59Ei1l2zebuHZzpqx_e0ExOeAMmGEi7afdCLq4pGzSeeW2TREO
 lucHocjrteTx6NPlFFoNRfVjbcmj6fw6a4ABrYSX5k0H4koFh2Q--
X-Sonic-MF: <mario_lohajner@rocketmail.com>
X-Sonic-ID: a78c2b0a-f31e-42a4-9a02-4cfb4144d10d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Sun, 8 Feb 2026 04:11:23 +0000
Received: by hermes--production-ir2-6fcf857f6f-68cr8 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 285b038b58ae8d65c69582d0c1d1e301;
          Sun, 08 Feb 2026 04:11:17 +0000 (UTC)
Message-ID: <f4451542-1804-4417-84a8-6e3630da9da7@rocketmail.com>
Date: Sun, 8 Feb 2026 05:11:14 +0100
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
References: <20260204033112.406079-1-mario_lohajner.ref@rocketmail.com>
 <20260204033112.406079-1-mario_lohajner@rocketmail.com>
 <c6a3faa7-299a-4f10-981d-693cdf55b930@huawei.com>
 <069704a4-2417-470a-bf32-0ee3afd1be6a@rocketmail.com>
 <9fc3443b-0eea-4917-909b-709113f5e706@huawei.com>
 <606941c7-2a0d-44c7-a848-188212686a78@rocketmail.com>
 <20260206014249.GH31420@macsyma.lan>
 <26d60068-d149-4c53-a432-8b9db6b7e6a5@rocketmail.com>
 <20260207053106.GA87551@macsyma.lan>
 <16f17918-9186-4416-bbde-b93482933d8b@rocketmail.com>
 <20260207175522.GB87551@macsyma.lan>
From: Mario Lohajner <mario_lohajner@rocketmail.com>
In-Reply-To: <20260207175522.GB87551@macsyma.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.25178 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rocketmail.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[rocketmail.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[huawei.com,dilger.ca,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-13619-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[rocketmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[rocketmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mario_lohajner@rocketmail.com,linux-ext4@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,usenix.org:url]
X-Rspamd-Queue-Id: A4F33107DAA
X-Rspamd-Action: no action

On 07. 02. 2026. 18:55, Theodore Tso wrote:
> On Sat, Feb 07, 2026 at 01:45:06PM +0100, Mario Lohajner wrote:
>> The pattern I keep referring to as “observable in practice” is about
>> repeated free -> reallocate cycles, allocator restart points, and reuse
>> bias - i.e., which regions of the address space are revisited most
>> frequently over time.
> 
> But you haven't proved that this *matters*.  You need to justify
> **why** we should care about portions of the address space are
> revisted more frequently.  Why is it worth code complexity and
> mainteance overhead?
> 
> "Because" is not an sufficient answer.
> 
>> The question I’m raising is much narrower: whether allocator
>> policy choices can unintentionally reinforce reuse patterns under
>> certain workloads - and whether offering an *alternative policy* is
>> reasonable (I dare to say; in some cases more optimal).
> 
> Optimal WHY?  You have yet to show anything other than wear leveling
> why reusing portions of the LBA space is problematic, and why avoiding
> said reuse might be worthwhile.
> 
> In fact, there is an argument to be made that an SSD-specific
> allocation algorithm which aggressively tries to reuse recently
> deleted blocks would result in better performance.  Why?  Because it
> is an implicit discard --- overwriting the LBA tells the Flash
> Translation Layer that the previous contents of the flash associated
> with the LBA is no longer needed, without the overhead of sending an
> explicit discard request.  Discards are expensive for the FTL, and so
> when they have a lot of I/O pressure, some FTL implementations will
> just ignore the discard request in favor of serving immediate I/O
> requests, even if this results in more garbage collection overhead
> later.
> 
> However, we've never done this because it wasn't clear the complexity
> was worth it --- and whenever you make changes to the block allocation
> algorithm, it's important to make sure performance and file
> fragmentation works well across a large number of workloads and a wide
> variety of different flash storage devices --- and both when the file
> system is freshly formatted, but also after the equivalent of years of
> file system aging (that is, after long-term use).  For more
> information, see [1][2][3].
> 
> [1] https://www.cs.williams.edu/~jannen/teaching/s21/cs333/meetings/aging.html
> [2] https://www.usenix.org/conference/hotstorage19/presentation/conway
> [3] https://dl.acm.org/doi/10.1145/258612.258689
> 
> So an SSD-specific allocation policy which encourages and embraces
> reuse of LBA's (and NOT avoiding reuse) has a lot more theoretical and
> principled support.  But despite that, the questions of "is this
> really worth the extra complexity", and "can we make sure that it
> works well across a wide variety of workloads and with both new and
> aged file systems" haven't been answered satisfactorily yet.
> 
> The way to answer these questions would require running benchmarks and
> file system aging tools, such as those described in [3], while
> creating prototype changes.  Hand-waving is enough for the creation of
> prototypes and proof-of-concept patches.  But it's not enough for
> something that we would merge into the upstream kernel.
> 
> Cheers,
> 
> 							- Ted

It seems your mind is set :-(
-do allow me to briefly reiterate the relevant points.

*
The original allocator remains *intact and unchanged*.
The proposed allocator employes a *simple tweak*
(as recognised by a maintainer)

*
Clear allocator separation *guarantees* that nothing in the regular
allocator is disturbed or influenced by the proposal.

*
The goal of proposed allocator/policy is prioritizing sequential
distribution (round-robin) over strict locality.
(acknowledged by another maintainer)

*
Patch is implemented as optional mount option "-o rotalloc"
(disabled by default)

This patch consists of:
1) trivial group counter “cursor”,
2) trivial vectored allocator,
3) trivial simple proposed allocator "simply enforcing the cursor”


*** To reset the semantics clearly:

This is an *optional* alternative allocator that trades locality
for distribution.

The intent is deterministic sequential distribution (aka round-robin)
across the full LBA space, *agnostic* of the underlying device behavior.

It operates at the block/group allocation level!

Best regards,
Mario Lohajner manjo

