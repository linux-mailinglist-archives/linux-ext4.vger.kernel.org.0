Return-Path: <linux-ext4+bounces-14210-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qN25OGi8oWmswAQAu9opvQ
	(envelope-from <linux-ext4+bounces-14210-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Feb 2026 16:46:48 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C3D1BA36C
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Feb 2026 16:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C43C30E50BA
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Feb 2026 15:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641F143CEFF;
	Fri, 27 Feb 2026 15:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rocketmail.com header.i=@rocketmail.com header.b="Dzq2gap1"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sonic304-21.consmr.mail.ne1.yahoo.com (sonic304-21.consmr.mail.ne1.yahoo.com [66.163.191.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EEF3D3006
	for <linux-ext4@vger.kernel.org>; Fri, 27 Feb 2026 15:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772206662; cv=none; b=fXE9Q15A1lqyDM+UwPzyf45Is2dkBbfBUEndWvy9Z7cd/9vFzDpSK899HXNo+AOFNwX9Bipuo7jS07I1NKSu0By1nuwI5N9SZcEpFtDIZtcYvAhwr/LTxLvlzu4xw/XVzjtwZYhuqyCZnbUEpOQJIJiaz0qbC4hFO24eRFQ+jpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772206662; c=relaxed/simple;
	bh=RapVb7BH+XK2subqtHq2u+14TIv+lNVtbIvsVoDVLEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aV71AhNfSUNi5Kg6FMThbls1HJdkgUFglzwfCqZw7TamoA7OQGdwytRWbb3jU+BSYWhFYtFcKJ6FJB2OsGE1JsbtkNs2ZgkPzlsBVYoevl88BMpXl+Rk6OC1osu9AZ+kgUusoEIFRlffHpZV7fIeUTTmugpGHb/iUSrNc40rsjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rocketmail.com; spf=pass smtp.mailfrom=rocketmail.com; dkim=pass (2048-bit key) header.d=rocketmail.com header.i=@rocketmail.com header.b=Dzq2gap1; arc=none smtp.client-ip=66.163.191.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rocketmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rocketmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1772206660; bh=XoZFibiMoK98Hdn2fiBFquvQMiQpEw8kJwSX6qSl8sY=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Dzq2gap1bSrzjiTv1gNwciK8XIY0uqBZey0jzsCnf56NeCI0/CegOv5yBZLIdyWXucJ/IO8NPglrRS1QRLkxKomBzrvc8z6TLbMBIz1mqNw42ayYaFij0MpP1g50wgT/+gFqOq20PXC4VpCc2w2fsrdy8gUQ4ofSSVqqHSt5j5esDvt918bwXEB6kjq+xg5m5lti5sFxy3tiebZ/VG91nFTdNqZAOTfMyWyhh/fwiv2Htf2cDo2yhsSvlZ3VRws9YH2MJSQy9r736csM4rAf/2v1enpc/qOkGIKxmugusQmNNwePYJC+uBKBv3RjurAOMnaW2eSTeffzuLHm38Ao7g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1772206660; bh=ZBaS6fRQP3gsEX/yWmgWt6Sm0KJb6uv7oj/9C8KkkwQ=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=UjEioDyMt6SroG/heqJC3ysjqqfSVbu0bY8Yl/YR9Q970msIIY3fhP7lZR5uGj51FdMZm0MXHOvlv9U02k3oELPcA+AwooCv6ZgG0JJ92RDEu/sykVy7htwomZ+kjUIadMbj7oat/1d4f4h5fgXz2JcrcliohEs+FOwr172Cos2lAagZGpm1ZRP7zBL1Q65r/O5v9QQLWvzQmXk0AaxbXsZFoXylYVffWW9LeboJ0TamXCGjvitXEc/tRyZgUClzKV/BM21rp0dZx0iALHdMCc+nsP6oM6bx7JUxw1m0LHaAM0ZJq8s55lJE7oX2PbN4CmYhdt8mZG+hxLPGG/r2Cg==
X-YMail-OSG: gWEZVU8VM1leEryLpFUuj_5y23J90XoEuIIcEd3jswva5uCxblPeS3gizBaKDOD
 53KZgIPUCFuQLtoW48TMIIyT3_1N8nWJEI60PrUOMm.e0P3R8SbIMrUL99g9skMrrFBQhg_xgdCO
 ggBH8T4eOjvgPvTZWLDqUxNUQvYvfWETlqmZg_8.w3dvjQqngPt.KsvUHRH_pDds8wB9qVYz4Hmz
 CkvqDCYMTgPk6HA9EzBYhB2ueS.mJb.BrjVh1f3JG5vMAm61a3aI9kIxX43kmGxXzmOtZNT3kprw
 sX2Qeui8IoiKaQCpxBWWmp5SoPf44FmGvzcB7iqajwOeUiMtm1j2yWeOANl9DaUZrLmgk_Fwfv_N
 ukwobtd_R0nYF8P08H5usPhhsAiH50P.XfiDS8mwLPcT.sIMpp1OQF6b1hXAxL43EN0.6lbCDMbR
 p8eFRfDDYZ78N8JfWALkwBjG5UKIp0GPkbSHBrGEBAlnFaJ4p0DcCoPTWW8Oc6uHe2LZ6LajdMNY
 ndpzKwUmdfJXMf3sEiYIQWpEhOboBgVKwD._jkF2pmKzMUMoX0DnukvU0f.ZEMKUA6MjMO8szpey
 2HHZcfIUXhoon435j2Px2SXrWiirB6dYfluZDFP0tWpJAQCxH36b3QGIFcN8n9CtcsPGAmS_OeQ.
 r6YxrbEkqTKr_jzSFbOH4ua_yfnE74NkuPHH6eANECoKA72d7vMoy7tm2_ep7gm0.oZTLCcwuT78
 AN713iW56GR123qabTzNpnK5pCzDbArnKumBUu4xkJgdqkhz9QhBHWEblwuZ7Wte1MZBhWut9NkT
 H_cckAcJmIznluDSM3Eu5CJsodDUjTWmSHLdf.Ou6JPeI9MjDO5Hc5B3cLlypeDX6d8zg8FzccxJ
 .I7Vql7KjgJWl0gOMV351MkK.kRpxl_NDro8NmWTp_s9LmIJtekvcRgEFU7jspDntYZVvfkbTvJ_
 mnGjzvPx0LX0oRk2qPS4KbbGCB4OGEpjj1S3tR812lA_AAAiPjjWNH8vWh1DI.z0gImmjT2jJKyc
 Vt8wa98J7TEYodBIEOyOTegDIwpzJIsgkn8m6g4MbAAi6u4TcOtMfSlQCnNmhZCa35TbzeZHH_HP
 .9p49FPIP2txbYme2lBAySqY6tjampx73Ml8gWW.A66p1h87C.aw86N6jsf44I7jZN7QH_EMyF3X
 Q89we6UYN37BHm9_pzhFg_1XogIfN.csavVPObZI6TOZHbBMAfvaGiokJv5gB32xZqJxBK5KiLVB
 M12Po8RrWV4MqGcYRQK9JXe3sZNX1R9VAH_D7gk2Pj.SS8asVA_u09Zek1LwKgnQI5QNrjPcj2JC
 ETIUeH5nEH3xpkodeqjgHSKH_A4HIBgP4YGK6PJOsFE0cqUo8fuI7ujojC1H.7q9OS.b9._RVyEm
 L_lG0AxCon5unhKOGAGVjnRXRA8aC20oGx.CPxxi.AEvfszNjMONZ0FSdXe915npW6.zpDgOs.x2
 X6.7vQO3dfh2iEuCWnn4nQZngKtwUiiVjDs4DQYOywNDWOjbSjb3jNCVLBXTGjY5mQBVSw7AKhho
 ir64fC3bbMUg1zvijrRnohPLPJw3JOMK6luMG1H7b1U4yAkq.lrlXyaL_BCGa4eODlEph3FK2bui
 8abEgS_mboN2RERZIp2TCPEbW3sxZo7lq2jC5Srvv2A2q0ybwiGt20grZ41Bv2e2cwlkR8T8WxlE
 BKsV7M1Psb5ln4Hl7OwGnXQ8nyB6HD5uiUaayRxffSuKoe82xW4_Oqp9Pw2DRvTMN4LEre3Sc2y6
 3jYeH9zuwj_ROSv.Qyb6wd.8pc6d_klBi3AkRKsu99yAlPGYrl4znVGL02713x29z89aHMmU3BKD
 6WVe5FBek01WPPgJF4bQ0QEzs6Jh9R7VwvRfI62lDMKS9G7ucCJhA9LPdGDa_Vkbx6Py9eBmaiP_
 OAyQRloyS_G9ESyeFknWenG.Qz4qKtFYFHKX_B7_z3yfEaCOwvU7dsDdrvMmbO.lAhQHE8AznC34
 1vpBQLlEjgKV2u0ZKtWTrD61XaivIjUrIcB0.HZ3GwhPHlNlwXZ39xN_4nR6Ipniz5plTNCxHbgG
 zTS3ammJBS.BAeOlN8tEl5VwAX_.SW_09WBvMf2YstbXdfgN80U5XW.XqsQiZLpxFMDXZ1jouZ.x
 1As1mQP7hW9wDPbdPGtLl4d49LyK.XqdKgT67kPo2FMjFthHPkp_xvHZ.xgsSxrO8xhjH_p_p3DG
 gqtintjeMWnhHdZdhqsa_OGbZ_IB5R2tAbqJaOOSoZqVq
X-Sonic-MF: <mario_lohajner@rocketmail.com>
X-Sonic-ID: c4899a92-95ad-4936-a571-bd6653b366a3
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Fri, 27 Feb 2026 15:37:40 +0000
Received: by hermes--production-ir2-bbcfb4457-w955t (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f278db9c2cba741c058b044e6ad65a2d;
          Fri, 27 Feb 2026 14:47:01 +0000 (UTC)
Message-ID: <2af6328d-5a72-476d-9768-9398a9417ea6@rocketmail.com>
Date: Fri, 27 Feb 2026 15:46:59 +0100
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: rralloc - (former rotalloc) improved round-robin
 allocation policy
To: Theodore Tso <tytso@mit.edu>
Cc: Andreas Dilger <adilger@dilger.ca>, libaokun1@huawei.com,
 adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org, yangerkun@huawei.com, libaokun9@gmail.com
References: <20260225201520.220071-1-mario_lohajner.ref@rocketmail.com>
 <20260225201520.220071-1-mario_lohajner@rocketmail.com>
 <D135BB30-388D-4B4F-9E09-211F6DA74FCA@dilger.ca>
 <20260226024819.GA39209@macsyma-wired.lan>
 <04dfeda0-8c13-4233-b631-d8912d4fe6f0@rocketmail.com>
 <20260227011200.GA68551@macsyma-wired.lan>
Content-Language: hr
From: Mario Lohajner <mario_lohajner@rocketmail.com>
In-Reply-To: <20260227011200.GA68551@macsyma-wired.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.25198 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
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
	FREEMAIL_CC(0.00)[dilger.ca,huawei.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-14210-lists,linux-ext4=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,rocketmail.com:mid,rocketmail.com:dkim]
X-Rspamd-Queue-Id: 63C3D1BA36C
X-Rspamd-Action: no action



On 27. 02. 2026. 02:12, Theodore Tso wrote:
> On Thu, Feb 26, 2026 at 10:50:29PM +0100, Mario Lohajner wrote:
>> The primary purpose of rralloc is to improve allocation distribution
>> and avoid hotspotting.   Performance improvements are not the goal here...
> 
> You haven't explained *why* allocation distribution and avoiding
> hotspotting is something we should care about.
> 
> If it's not performance, then why?  How does reducing hotspotting
> improve things for the user?  Why should we care about this goal that
> apparently is so important to you?
> 
> 					- Ted

Hello Ted,

The motivation behind rralloc is to promote even allocation across the
available LBA under overwrite-heavy workloads.

With the regular allocator, repeated allocations can concentrate the
pressure in specific regions (e.g., in-place overwrites or LBA start).

rralloc spreads allocations across the LBA, reducing localized
contention while:
	* promoting existing stream allocation behavior
	* distributing LBA space per CPU
	* preserving intra-file locality and heuristics
	* using the entire LBA in a round-robin manner
	* minimizing contention and races
	* keeping the regular allocator isolated and intact

Block group usage analysis confirms that rralloc distributes
allocations evenly without degrading baseline throughput:
	* small/medium/large file fragmentation experiments
	* synthetic tests
	* real-world tests (kernel source tree copies)

https://github.com/mlohajner/RRALLOC

Why it matters:
Concentrated allocation can create contention, write amplification, and
uneven LBA utilization even on modern NVMe/SSD devices.
rralloc promotes round-robin allocation across the entire LBA,
with per-CPU zones, ensuring more even allocation distribution while
leaving throughput and existing heuristics unchanged.

Workloads include (but not limited to):
	* media files processing and rendering
	* builds/compilations
	* database workloads

End user impact:
Users can enable rralloc at mount to take advantage of this alternative
allocation policy.
Regular allocator behavior remains unchanged for those who prefer linear
or traditional allocation.

This approach is backward-compatible, non-intrusive, and preserves
on-disk format and existing heuristics.

Preliminary observations under heavy multi-threaded workloads suggest
reduced contention effects, but this has not yet been fully characterized.

Regards,
Mario Lohajner (manjo)


