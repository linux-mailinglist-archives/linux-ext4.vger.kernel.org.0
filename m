Return-Path: <linux-ext4+bounces-14336-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNccNzjupWlLHwAAu9opvQ
	(envelope-from <linux-ext4+bounces-14336-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Mar 2026 21:08:24 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECB11DF20E
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Mar 2026 21:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95AFE30C9404
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Mar 2026 20:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422CD3FD139;
	Mon,  2 Mar 2026 20:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rocketmail.com header.i=@rocketmail.com header.b="Z6WIWsHs"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sonic317-32.consmr.mail.ne1.yahoo.com (sonic317-32.consmr.mail.ne1.yahoo.com [66.163.184.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38CE2BE057
	for <linux-ext4@vger.kernel.org>; Mon,  2 Mar 2026 20:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772481901; cv=none; b=fZX7n6Zcc44LC/Ucf+gPxwIldNADA2w5NLfLFrhw8ktf9fqztIOVSaq4VUD67/equLvpuI1bVinZbkeA2KS4XOmjPJppjG0UhbRzlUezWw2eGYXusqFpti/nPxAHwATC9XLrxmwLQISXL/ayxsuVocHv8Qh+95QHWY6rcWEecOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772481901; c=relaxed/simple;
	bh=IHM/xB9GbJumvoj0cIGAg9YSiC+S1r5Wnvf1bAmmRLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NU338MAY8d9X2y0WhQ4A4VeDwu/dt8PhIUEU39hbom0QLVYugFcguAkTOiAcw4BEp8ZgHAayoclKTL/dQpdiK5aLJvOEss1sppEfdGYY8azaSoSK3+B7YFXy+/llxP3YbUBAZ5ciS+9Luz7S6MRmMEUfyKfU380iigNaXYn6JMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rocketmail.com; spf=pass smtp.mailfrom=rocketmail.com; dkim=pass (2048-bit key) header.d=rocketmail.com header.i=@rocketmail.com header.b=Z6WIWsHs; arc=none smtp.client-ip=66.163.184.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rocketmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rocketmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1772481893; bh=JY9vq4TOx0MFjBIDpVrLgotdC3p1LfiftSDeX2K0jSA=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Z6WIWsHsejUt2v8z+0V29sb9TwveElcU1fnZ5eDnn9ErWZkxTvrFQqKXReesei+SxihWK9WfQFrcjjKc4iEH2FtTRm13S/zO7Ixp/ojo87BB46bsNgHlQR9iJvvfM4SOcQH/RZWJrF5iohZn8dTkGs6yq3SnjBYBSg4MFwejs78U+bA2qqE14n7H7/lQ3tpl49yP/bdaCk7F0nvtOVNdAZabPC5zOMdnOqWGdGEGqiGNpv1wZ2AZZx8saCP8OCwZqXUM0N5pQKOKih9agxvOagNhoihxEuJfOHV3jubirTiSt2/NEz1aFQPtvoYmAOZDAoIshLfNFxV4AuNgi69zBw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1772481893; bh=xNy+HXPUlyBejmGwq496GQ96MLGivbnqHQX8J1O2iVK=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=q8jtMwC7unXF+kQJiVpqf/6kiQW4AU31QLx8P+Q405TPCBngOP8AV8tz7pYUwj0XE9Fmzk/NxH6Va5CMDjwVShkYd+yslJnAAdAenLabJA2g5FihZwUOLx+/B310SLpJYfk4VSacODq5XZicd5gy+nn8ld/GW9bCc9wJI2L+di45dlr4IEfYgO53rd3c7KDZxYivTlR3pWw2K8BbeGi+RtKx9mRuQKpyLBeZ+sor0O6ukzRcXKmP2jewOgIhiTn/9+dq/AAv/ggynQ/TwoQmz7OtcAAAWQnTgP32wjPNPhXPUYxugbSZZvrDkS2GRa4/yaiA6FmoirV8+Qtu6abbbA==
X-YMail-OSG: onkwIh8VM1mq0_efLClU_qL9hGPXt2QrI4DDxpAFtGifqfjfl7LN57kZxcCPob4
 rRf8QeR.Pyjs_sa2t.0a01nqPZ5ukZsqvW_RXZasN4SFY2t8PoHMoruaOw7IGq1dXAD3cxjlSsxs
 sSI3LVvhuN7Oel44mMBdQE3I.VIs8uGiwIPb_aa7oos4jt_mE7bmxbLP.WK77UoeQxRZImE66jvj
 rvjAiCbVWK1nqflkQxJq5vETV7lCrw7_Spqa4mMQDcZ7oXaLGrKytqu7hMOOl8Yq5mHB5xVSb.pO
 S6m7_FERZm1mgoO0iC8QyuwBeiFtAsbcvq37EUF45K_D6y7eF6ahQ67pFjhHZjCaETCpMakUklnZ
 Tg2awFrDchEani.prhI3p7kV317OJwJkFJd7E8Xz_4OYfiX53J8T1lDrwd8MYZpbpMpuwQDjJiTj
 ZYKzGb1NQM1bSsJpPNc3tD69dO4kNl0pK2nwQpKnZHi1WuqRnVQyGc8SgXf4uhTomMxNSSE6bBxT
 TxiY56gs9UOQyzQZWo9w0FS_SQkyQLwTFOeV0r6SCT1vvzv0xi96T2PvjvCInN0p3_rjzqqrzIwf
 dX1sdy1w24If0u5JXPeKWoRGi_4PBF6U45qrE9fQq4CKv2OteARDdgXOhYRHcGseTS_C4sAStcl1
 OZUZe3izqTjt3Cq0NTjSTqEn9gzUhds6yJXeOUEeCwmkV1NN_EUHrmPik_zFZKYrdgmUJk4QKis7
 bQD2q2J.mhUwzWmHZIs2bdwfX.RLiVaOxiHeJ1uAKkqXPdwvdzb2qx7by3gVz2Rf3fsDoXPsfb0l
 tbtOEE10_XbCwWMs7PY_94QBHQKct2r7lm6wbdpe6svl0Qvrun8jT7Z7BtHZTFgef8KEwlDv_d0o
 740QLb93CAqXSspIuazm.ZUCTXxSCNWwl8IJj4HaFFqUhkWVx7DRZ0bzgWyQbKNdknGM2J5jK8na
 _wfs8gpWjmjIv9Vn9xL4JZvK_6cZkUaZhLgqKWs2JmY07O6dhiy18ODmIYi0f0OoLTd3TpuEuTkX
 5ZX57u01KEfRQ4.EdznWJlC8pJKlLhF8z8dj26ihzCarnMAiVy08fSBIbN9C883ps9gkxM6P3e.Y
 SedJSPRiou6vxLay8yP1ya8W44McD5zFcz4Rc2VuwtMWOaWP9y9ld.bNesrFhaHPA32Qfi0i8bSO
 uYweAey1OBxvPZAA47lwJFaM1jWNtZmEG6Vd.kJCDgzeY4kkbfn7HEMe339NZIWBTTAottshICEw
 OPSPW3ZlCt_jwkzeHKd0TJghbo5nB1I50kYIshvtU6TstZDxi.wEJfYd_hEgk1N6Asb0SR02Vqwo
 vIR3z0eOi30uK_BhATma0wIkI7TPjcXvqSvkMkxH5XkfUpg54BN6wHPmGTM06KJPzEPUrQXLCKmP
 svx.PiLid78WPCWhQIFZsx7Gm_UFt4q49Ward1NUO7qn.OjsjdK5Csuz_ExFay03zfIwMWcqdYJi
 rQfcTFxLmQ5.XVBP3SbaTZiVPBDEkY9d3kEb2813LGWiZGo.P9tCTrwL8Fevfq7mUrAAsZdHjCBo
 zGQyFrRfYGiRpapyJSQ1OxgBNnFwONY60yj6WJ347HO0BMtj1IaV7xT32b8wZKXGlHQbL9HpKUCp
 I3N89Q5OOXuT1QKToL64nl_b9lB06RB6b3AmqsxkfEh7WAUgJdFo5BrQqvp5VF39z.bGYT_urzlZ
 OsFfSJTA9tVptMU1dkIy6ZQ534reEo8tSzOf2UdRFb_ZKncqt3j.d.DQXuTuFV58MOKsZ8_kKecq
 JxNXH4pkW.HX80VUXncGB6LmKrerb0P7JblweFojwc9nVU1eBjmk7Yc2KZm_EJ0.bXfwnFEDVOyD
 6cyxFlNoCENNtlSHuHngHK_05VnecLsbFywTlirpe_KnA50bqsxHeBNjPrfglwlPUXBpPbM7Fwc2
 NtvOby4KN5QioXhHLc5b0LYfGR71eSeG.qj4GXCEDRU08A1fwHq80wPu1lwLJ4CF.fdr2WfyelBP
 7FMaNNXkX5ofo4A2ANFJfmXYBlDh4Rn8zqMveMgeoDa_nWRPF0h2.Q4NfTjHtQa1sl7ThmqMkZ.9
 J3Vo66uKbP8S0myWZwOe8wTUlw2EX4TYdiz3fmw.J_u0b1jRXCpkLO7bKRIbKCnltwovlnRtI6N2
 KzZfBcSwXmImGot9X3wuzeNcIH31h.JRQaYjkjnMB...t97mN.F_DUde7BXBPAHuO_fOaE3BFka3
 95.qZJZwSTRUtP_p0iSLe55k-
X-Sonic-MF: <mario_lohajner@rocketmail.com>
X-Sonic-ID: 1bab83a9-882b-4bd9-858d-576801106e94
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Mon, 2 Mar 2026 20:04:53 +0000
Received: by hermes--production-ir2-bbcfb4457-pgdzr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID fe1b15f879a7cba06976c78243764d51;
          Mon, 02 Mar 2026 20:04:47 +0000 (UTC)
Message-ID: <c156caec-e2c8-4b85-a135-0adecb56a859@rocketmail.com>
Date: Mon, 2 Mar 2026 21:04:44 +0100
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: rralloc - (former rotalloc) improved round-robin
 allocation policy
Content-Language: hr
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
 <2af6328d-5a72-476d-9768-9398a9417ea6@rocketmail.com>
 <20260227164319.GB93969@macsyma-wired.lan>
From: Mario Lohajner <mario_lohajner@rocketmail.com>
In-Reply-To: <20260227164319.GB93969@macsyma-wired.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.25198 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Rspamd-Queue-Id: 3ECB11DF20E
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
	FREEMAIL_CC(0.00)[dilger.ca,huawei.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-14336-lists,linux-ext4=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action



On 27. 02. 2026. 17:43, Theodore Tso wrote:
> On Fri, Feb 27, 2026 at 03:46:59PM +0100, Mario Lohajner wrote:
>>
>> Concentrated allocation can create contention, write amplification, and
>> uneven LBA utilization even on modern NVMe/SSD devices.
> 
> Uneven LBA utilization is the thing where I'm asking, "why should we care".
> 
> In terms of how this would cause contention and write amplification,
> <<citation needed>>.  What is your benchmarks where you can
> demonstrate this, and how common is this across NVMe/SSD devices?
> That is, if it's just one trashy product, maybe it should just be
> avoided --- especially if it has other problems.
> 
> 						- Ted

RRALLOC spreads allocation starting points across block groups to avoid
repeated concentration under parallel load.

This reduces short-term allocation concentration in the same regions
when multiple CPUs allocate concurrently.

In high-concurrency testing, performance is consistently comparable to
or occasionally better than the regular allocator. No regressions have
been observed across tested configurations.

Under sustained parallel allocation pressure, testing shows improved
tail-latency stability compared to the current allocator.

Additional high-concurrency test results are available at:
https://github.com/mlohajner/RRALLOC

Regards,
Mario Lohajner

