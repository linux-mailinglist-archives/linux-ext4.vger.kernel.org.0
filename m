Return-Path: <linux-ext4+bounces-13617-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIEoOvw6h2lKVQQAu9opvQ
	(envelope-from <linux-ext4+bounces-13617-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Sat, 07 Feb 2026 14:15:40 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59445105F2F
	for <lists+linux-ext4@lfdr.de>; Sat, 07 Feb 2026 14:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 385023014122
	for <lists+linux-ext4@lfdr.de>; Sat,  7 Feb 2026 13:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2586B311588;
	Sat,  7 Feb 2026 13:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rocketmail.com header.i=@rocketmail.com header.b="ucU9g7Oj"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sonic303-21.consmr.mail.ne1.yahoo.com (sonic303-21.consmr.mail.ne1.yahoo.com [66.163.188.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685A917C211
	for <linux-ext4@vger.kernel.org>; Sat,  7 Feb 2026 13:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770470134; cv=none; b=u5pUxUf9ulwYrviazeQSk0HW4u6AcaY3ZFNLhuDFKNg1ta9CUa18SB6nnx3l1u7BJLdVAF4gRqwOUrAGYXV1IsTGR+RmXlLoeVfFbJJXjTInJi4Jjq5KdLy0Huv0+09O004hri2+CtUD0CQofizbAFn4uEqf7xOJkYuE3COfT8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770470134; c=relaxed/simple;
	bh=pQLIBuVZ+iG71snm/xrgysAJPeFQGxacT1S9gMemRcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IPNSr8CBx7gZbfSa5gIRi6bWjUuxke0ky3Q8JBl6mh4QzzDaHtFiBN5HcBY+XF9g7PeQARMr6NpyBRI52MpG7lq/L/rzHcADu/Eo1Zlsh/jBWUHd/ToQIt0tFU06aZEp+JI2kaJ92z6ONzw+X3pe0sKaSO3OsWsbmzmQR/u2c+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rocketmail.com; spf=pass smtp.mailfrom=rocketmail.com; dkim=pass (2048-bit key) header.d=rocketmail.com header.i=@rocketmail.com header.b=ucU9g7Oj; arc=none smtp.client-ip=66.163.188.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rocketmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rocketmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1770470133; bh=Cz7XT21JVOfj/cPR5svb/eQqrUxwi6ckspalKshiXio=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=ucU9g7OjNvkqNyPWcli8YcPZTvYhRs2jzDF9VmovptjgX/sDAXHo5+msoMbcxS4bzOdJ7ZirCQNjjamhKaMiUkbo/3+iDf98SYFo47ChzXrFfqrkKINCKSkVWSZi9SjELBGrfUBzJrdXld9Szla6/GaIQW2tYDYDGmLxuhCdlGEalD6eBuht45/32Bdp/yMMPlM7vKmy/jovUZREMyICtIVjcIeRSgP12KV8F+AfkiAaavwH9RxWfkIfYRy4jVfZf7d/bkA+qYHHhBlAbyISH53LL3pvxvmsHiw9t/W0k/5Nl6NRp/gZnFTnDJD1b/qrlpHZ/NrQtqRdGVX/HQ+cTg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1770470133; bh=Xowv4+tEqx0x67TPI1TvwsQW2eBm6SxW/jSC1rJiKtN=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=KIEH0HGIYvKwgHCWSK46bEAVVf5ZBnaJFejZuhPO/l5ut5Q/607MNOD0ESGCULXcourfdEFf+0UbYT9VkYE3hItVBIxG7sfeYzw9LHDQSmNyKo4QL1/tdUDgqMWpqNsxyUkoAw0VFVsaZwXydsjpEkX3ui5wDfbEz6Uum1G5q9VxYcQVPOvtCrMWNrFQwVcFrKbWB/go6G0k/iI9RhYaC8TU+Fcentnb7V1Fcq++qL/fUJs4ok2cvU0EY7/1GC0Wr0x81htaOfl3sPI2KKzz6iRE13AL5dMUbsf7CPjZBO3kuZOUwYvlJuVVU+2TmDPwmMBppyo/BESpKixduFkXmA==
X-YMail-OSG: VLBg_VkVM1nlOuyI08rkOe8Iyn27992MZtCzZOsi0FQk7yG3wGniJKTjD7qsNqm
 qMqxshLY8MLElU_3sJrSB5Zlz706Ik9HCljKuQ_QTJlRWBXa0x6urgutUwJEEy5wk5A00iMWyI_X
 2pNdqFHxPexxaUj.ZwZKSH1fz9KIVFJJs.PRVST4uXchRdEQAHxqYPGTfYw7D1kPpb0zVoThHJsi
 2Qs2AFAUXTJEEqijPjtYgyAcYYUpCbIASj58hiIUYpjr9f1yqtqmWd5H2hVudhTDjFE7kyhwzPSo
 eCgWDVccg4UWB24dB6LOFFXZMAbE_YF92rD38Sg7ZJabtr8QxLC7ooDdSE_ff5OZnT9UG9PlNZpA
 EvYKASaFefeyjf_KMX5eZ6mxpi9AQNRXPwUwJQBPAeAG6v32kCPdnySV20.9CYgLaM6bBpDdygWc
 LDvtdNfbl_vL4geOpZ4OE5GPjoTzUOqGEtgQ.Je4JzotCtZNhb738i1Bsjc0itrSEjVmgJLLDIFY
 Xj2NmXbR6Bwp79RZzQfUaYdkiBBIdjhyaeY9dCNBOyUMycP4jRnQzeO5MDh2lbJAmdeoNLJeXYfB
 14T3.Z711u84Pq4HkGoamXfVW3koCfHsMNXE7Xj5ySF80pJv.KwcfpEAJktnliiFGDTo.rF43zjM
 R2dQdff19jbbA0xGEzkGEgAcV2u_e30yeivNE9Xxo_NHIP9RoF37kSsKSb5CEQMC9iz1rMqLvPMb
 nLqA70uDMq9.ldu2Hx4ewQGTjtRxCtn0CxKRt19rDxVpq8gLllm6P4WYexDjJvluE1jBMjUREjNk
 OrPw5ZF4q9Zgs7f8j_MMpPxWSK0KZ_dpjlN6HkhLc0vbos83Fwy4z47bNrATIP9Tvzc8gnTbJtvu
 5uQ4scCMxkee.TO7a1gBsHep_4BzfUwl5rBTKmIPqoJpacHs4HRHHzQM2K5jrbxta4JsaQWhxuaR
 8amsmwu_22R2E0P2BCKgaOy_33uXz0N.lcVQA5aZI85zAtnN2k9y9vK19DxaMVBt7M1XKJdd88K0
 Wl4uu.wg4CdUb9GbMbNZCOp5_K1byacT.w1YIYhbLtnT4WRgnmeYPtQIizBVWZgm_W7yoi2XAuQ0
 PHVrQKHbLs5UF01n4lRb6umVb.cphn88Bo0rw5GpAu1iq0cKW3LAJqgQuLrOItY0AzKbk9p4LAam
 Eg2Zfbu2oeic5MfYOaQXAay3ie9rL35myKl6AnCvAcbrLkiIwKIQe94UC1.08ZcoN4IwMnDF9UH_
 WvwHHeWvIJP7pflKzDALok0sgnrgdTuQJ_3s_Aw4HCNaRBzPxWy5lwO2siHR0c9O2Ax49WXVoUKr
 6lDcf0lTfbbDBtpIfYDU.69O25_cVF7rztYa.i9kzkQOdqcMyp0UYGXeXnTmtl8zTK81gI6wSIyi
 QHMUKfCLSIlQ.ABhfPWtpy5CbXjppRdajFf1cEoGTEyijBWsin6MaILJj98Ut3QD4y1VwTONoQWU
 AI1q_tvqv6RPcbAszWqUWWZHknsuu3z63IOtRkqI9acDyv69uQfkZMafNNJ4bDbTOQkXABvJNNlq
 ltim1VaPPx0RhoQqFPvx_jIc8a6ysiA49LATTCMUmVrWC4F686ngpgcgQQcLR6eViw90NpPGriYY
 cwcSHejMMND7a4CVW63U239YyNg9gcvyIy01jY22UxR5Ybd9U9R0Ky__PuWjLfR1uBD6M2Ju6yCk
 OnZFbsK.DNOhx.K01w3j_PNJA55EUo1VOscZfkPDLjO0KmHP4rDCS1slFQSt1aRKLC8Bazzpy20q
 WCRzfg7j4O6wWDuGgbBCcSCs4j9DpVD63vNmA4YRgnSFwQoC29MwJGP58i0uSuDIwWZEbBcREIoZ
 cB3o9fHz3E3VMB6d7mQArSwC9deHS_TsUETFT35jgj6BW2uYi42f7ZGA1Ge_YxARJXgtrDEDbGPJ
 HuVOoVwgpXDigARSjBL_gSqlbETrsE_fIh6WVT3WSHu8lWInEoesQJPk5F2nbMqZaazxZMnPY9Xs
 dousswY1F.V5q8rgcDmjy7dhJTkZLHF2zfSUOiNFdIDyv68_f7IpGmvbmsT8n3SBbTg6wVHxO3Ia
 H_kzKmxOpKZpRwporoxmbnncQDJ2BnlkMs.y9jGPzd0AhWmUYhGboNCCgrpSot77wOXwihR1dCMN
 L_LkL.aSkwNKZlr61d46wrxZplLP_yXXxi0prij3Q7C27_JdW_MbQakNkeLBngDZJSgU7KxI_1Uo
 zRqV0zIp_vQCWSKbRkt5GlenuLyPHpN7C
X-Sonic-MF: <mario_lohajner@rocketmail.com>
X-Sonic-ID: 7b43d9a4-2dba-42cd-864e-206bebaf0674
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Sat, 7 Feb 2026 13:15:33 +0000
Received: by hermes--production-ir2-6fcf857f6f-52lzv (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d3b96823537292a582d3d37d23741d66;
          Sat, 07 Feb 2026 12:45:09 +0000 (UTC)
Message-ID: <16f17918-9186-4416-bbde-b93482933d8b@rocketmail.com>
Date: Sat, 7 Feb 2026 13:45:06 +0100
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: add optional rotating block allocation policy
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
Content-Language: hr
From: Mario Lohajner <mario_lohajner@rocketmail.com>
In-Reply-To: <20260207053106.GA87551@macsyma.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.25178 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rocketmail.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[rocketmail.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[huawei.com,dilger.ca,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-13617-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[rocketmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[rocketmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mario_lohajner@rocketmail.com,linux-ext4@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rocketmail.com:mid,rocketmail.com:dkim,psu.edu:url,wikipedia.org:url,flashdba.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 59445105F2F
X-Rspamd-Action: no action

On 2/7/26 06:31, Theodore Tso wrote:
> On Fri, Feb 06, 2026 at 08:25:24PM +0100, Mario Lohajner wrote:
>> What is observable in practice, however, is persistent allocation locality
>> near the beginning of the LBA space under real workloads, and a
>> corresponding concentration of wear in that area, interestingly it seems to
>> be vendor-agnostic. = The force within is very strong :-)
> 
> This is simply not true.  Data blocks are *not* located to the
> low-numbered LBA's in kind of reasonble real-world situation.  Why do
> you think this is true, and what was your experiment that led you
> believe this?
> 
> Let me show you *my* experiment:
> 
> root@kvm-xfstests:~# /sbin/mkfs.ext4 -qF /dev/vdc 5g
> root@kvm-xfstests:~# mount /dev/vdc /vdc
> [  171.091299] EXT4-fs (vdc): mounted filesystem 06dd464f-1c3a-4a2b-b3dd-e937c1e7624f r/w with ordered data mode. Quota mode: none.
> root@kvm-xfstests:~# tar -C /vdc -xJf /vtmp/ext4-6.12.tar.xz
> root@kvm-xfstests:~# ls -li /vdc
> total 1080
>   31018 -rw-r--r--   1 15806 15806    496 Dec 12  2024 COPYING
>     347 -rw-r--r--   1 15806 15806 105095 Dec 12  2024 CREDITS
>   31240 drwxr-xr-x  75 15806 15806   4096 Dec 12  2024 Documentation
>   31034 -rw-r--r--   1 15806 15806   2573 Dec 12  2024 Kbuild
>   31017 -rw-r--r--   1 15806 15806    555 Dec 12  2024 Kconfig
>   30990 drwxr-xr-x   6 15806 15806   4096 Dec 12  2024 LICENSES
>     323 -rw-r--r--   1 15806 15806 781906 Dec  1 21:34 MAINTAINERS
>   19735 -rw-r--r--   1 15806 15806  68977 Dec  1 21:34 Makefile
>      14 -rw-r--r--   1 15806 15806    726 Dec 12  2024 README
>    1392 drwxr-xr-x  23 15806 15806   4096 Dec 12  2024 arch
>     669 drwxr-xr-x   3 15806 15806   4096 Dec  1 21:34 block
> 131073 drwxr-xr-x   2 15806 15806   4096 Dec 12  2024 certs
>   31050 drwxr-xr-x   4 15806 15806   4096 Dec  1 21:34 crypto
> 143839 drwxr-xr-x 143 15806 15806   4096 Dec 12  2024 drivers
> 140662 drwxr-xr-x  81 15806 15806   4096 Dec  1 21:34 fs
> 134043 drwxr-xr-x  32 15806 15806   4096 Dec 12  2024 include
>   31035 drwxr-xr-x   2 15806 15806   4096 Dec  1 21:34 init
> 140577 drwxr-xr-x   2 15806 15806   4096 Dec  1 21:34 io_uring
> 140648 drwxr-xr-x   2 15806 15806   4096 Dec  1 21:34 ipc
>     771 drwxr-xr-x  22 15806 15806   4096 Dec  1 21:34 kernel
> 143244 drwxr-xr-x  20 15806 15806  12288 Dec  1 21:34 lib
>      11 drwx------   2 root  root   16384 Feb  6 16:34 lost+found
>   22149 drwxr-xr-x   6 15806 15806   4096 Dec  1 21:34 mm
>   19736 drwxr-xr-x  72 15806 15806   4096 Dec 12  2024 net
>   42649 drwxr-xr-x   7 15806 15806   4096 Dec  1 21:34 rust
>     349 drwxr-xr-x  42 15806 15806   4096 Dec 12  2024 samples
>   42062 drwxr-xr-x  19 15806 15806  12288 Dec  1 21:34 scripts
>      15 drwxr-xr-x  15 15806 15806   4096 Dec  1 21:34 security
> 131086 drwxr-xr-x  27 15806 15806   4096 Dec 12  2024 sound
>   22351 drwxr-xr-x  45 15806 15806   4096 Dec 12  2024 tools
>   31019 drwxr-xr-x   4 15806 15806   4096 Dec 12  2024 usr
>     324 drwxr-xr-x   4 15806 15806   4096 Dec 12  2024 virt
> 
> Note how different directories have different inode numbers, which are
> in different block groups.  This is how we naturally spread block
> allocations across different block groups.  This is *specifically* to
> spread block allocations across the entire storage device.  So for example:
> 
> root@kvm-xfstests:~# filefrag -v /vdc/arch/Kconfig
> Filesystem type is: ef53
> File size of /vdc/arch/Kconfig is 51709 (13 blocks of 4096 bytes)
>   ext:     logical_offset:        physical_offset: length:   expected: flags:
>     0:        0..      12:      67551..     67563:     13:             last,eof
> /vdc/arch/Kconfig: 1 extent found
> 
> root@kvm-xfstests:~# filefrag -v /vdc/sound/Makefile
> Filesystem type is: ef53
> File size of /vdc/sound/Makefile is 562 (1 block of 4096 bytes)
>   ext:     logical_offset:        physical_offset: length:   expected: flags:
>     0:        0..       0:     574197..    574197:      1:             last,eof
> /vdc/sound/Makefile: 1 extent found
> 
> See?  The are not spread across LBA's.  Quod Erat Demonstratum.
> 
> By the way, spreading block allocations across LBA's was not done
> because of a concern about flash storage.  The ext2, ext3, and ewxt4
> filesysetm has had this support going over a quarter of a century,
> because spreading the blocks across file system avoids file
> fragmentation.  It's a technique that we took from BSD's Fast File
> System, called the Orlov algorithm.  For more inforamtion, see [1], or
> in the ext4 sources[2].
> 
> [1] https://en.wikipedia.org/wiki/Orlov_block_allocator
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git/tree/fs/ext4/ialloc.c#n398
> 
>> My concern is a potential policy interaction: filesystem locality
>> policies tend to concentrate hot metadata and early allocations. During
>> deallocation, we naturally discard/trim those blocks ASAP to make them
>> ready for write, thus optimizing for speed, while at the same time signaling
>> them as free. Meanwhile, an underlying WL policy (if present) tries to
>> consume free blocks opportunistically.
>> If these two interact poorly, the result can be a sustained bias toward
>> low-LBA hot regions (as observable in practice).
>> The elephant is in the room and is called “wear” / hotspots at the LBA
>> start.
> 
> First of all, most of the "sustained bias towards low-LBA regions" is
> not because where data blocks are located, but because of the location
> of static metadata blocks in particular, the superblock, block group
> descriptors, and the allocation bitmaps.  Having static metadata is
> not unique to ext2/ext3/ext4.  The FAT file system has the File
> Allocation Table in low numbered LBA's, which are constantly updated
> whenever blocks are allocated.  Even log structured file systems, such
> as btrfs, f2fs, and ZFS have a superblock at a static location which
> gets rewriten at every file system commit.
> 
> Secondly, *because* all file systems rewrite certain LBA's, and how
> flash erase blocks work, pretty much all flash translation layers for
> the past two decades are *designed* to be able to deal with it.
> Because of Digital Cameras and the FAT file systems, pretty much all
> flash storage do *not* have a static mapping between a particular LBA
> and a specific set of flash cells.  The fact that you keep asserting
> that "hotspots at the LBA start" is a problem indicates to me that you
> don't understand how SSD's work in real life.
> 
> So I commend to you these two articles:
> 
> https://flashdba.com/2014/06/20/understanding-flash-blocks-pages-and-program-erases/
> https://flashdba.com/2014/09/17/understanding-flash-the-flash-translation-layer/
> 
> These web pages date from 12 years ago, because SSD technology is in
> 2026, very old technology in an industry where two years == infinity.
> 
> For a more academic perspective, there's the paper from the
> conference: 2009 First International Conference on Advances in System
> Simulation, published by researchers from Pennsylvania State
> University:
> 
>      https://www.cse.psu.edu/~buu1/papers/ps/flashsim.pdf
> 
> The FlashSim is available as open source, and has since been used by
> many other researchers to explore improvements in Flash Translation
> Layer.  And even the most basic FTL algorithms mean that your proposed
> RotAlloc is ***pointless***.  If you think otherwise, you're going to
> need to provide convincing evidence.

Hi Ted,

Let me try to clarify this in a way that avoids talking past each other.

I fully agree with the allocator theory, the Orlov algorithm, and with
your demonstration.
I am not disputing *anything*, nor have I ever intended to.

The pattern I keep referring to as “observable in practice” is about
repeated free -> reallocate cycles, allocator restart points, and reuse
bias - i.e., which regions of the address space are revisited most
frequently over time.

> 
>> Again, we’re not focusing solely on wear leveling here, but since we
>> can’t influence the WL implementation itself, the only lever we have is
>> our own allocation policy.
> 
> You claim that you're not focusing on wear leveling, but every single
> justification for your changes reference "wear / hotspotting".  I'm
> trying to tell you that it's not an issue.  If you think it *could* be
> an issue, *ever*, you need to provide *proof* --- at the very least,
> proof that you understand things like how flash erase blocks work, how
> flash translation layers work, and how the orlov block allocation
> algorithm works.  Because with all due respect, it appears that you
> are profoundly ignorant, and it's not clear why we should be
> respecting your opinion and your arguments.  If you think we should,
> you really need to up your game.
> 
> Regards,
> 
> 					- Ted

Although I admitted being WL-inspired right from the start, I maintain 
that *this is not* wear leveling - WL deals with reallocations, 
translations, amplification history... This simply *is not* that.
Calling it "wear leveling" would be like an election promise - it might, 
but probably won’t, come true.

The question I’m raising is much narrower: whether allocator
policy choices can unintentionally reinforce reuse patterns under
certain workloads - and whether offering an *alternative policy* is
reasonable (I dare to say; in some cases more optimal).

I was consciously avoiding turning this into a “your stats vs. my stats”
&| “your methods vs. my methods” discussion.
However, to avoid arguing from theory alone, I will follow up with a
small set of real-world examples.

https://github.com/mlohajner/elephant-in-the-room

These are snapshots from different systems, illustrating the point I’m 
presenting here. Provided as-is, without annotations; while they do not 
show the allocation bitmap explicitly, they are statistically correlated 
with the most frequently used blocks/groups across the LBA space.

Given that another maintainer has already expressed support for making
this an *optional policy; disabled by default* I believe this discussion
is less about allocator theory correctness and more about whether
accommodating real-world workload diversity is desirable.

Regards,
Mario

P.S.
I'm so altruistic I dare say this out loud:
At this point, my other concern is this: if we reach common ground and 
make it optional, and it truly helps more than it hurts, who will 
actually ever use it? :-)
(Assuming end users even know it exists, to adopt it in a way that feels 
like a natural progression/improvement.)

