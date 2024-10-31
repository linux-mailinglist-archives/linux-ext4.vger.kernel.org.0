Return-Path: <linux-ext4+bounces-4877-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E699B872A
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Nov 2024 00:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE27C1F222D6
	for <lists+linux-ext4@lfdr.de>; Thu, 31 Oct 2024 23:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCEF1E3775;
	Thu, 31 Oct 2024 23:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="WuQnTROm"
X-Original-To: linux-ext4@vger.kernel.org
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBD419CD1D
	for <linux-ext4@vger.kernel.org>; Thu, 31 Oct 2024 23:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730417507; cv=none; b=i1mYXJlIfM4K6IYvuqELDjDR7TcmWdbmZige3I+p3TxALcMALhjN+2CnNb9r5x/bapF83fkBsk/5TiC3eagIRJnFCWXA+G1pWSrWtXZZr9gRgD65ufhD1ahmtZzYtjJQI4KYIsZ7k3LiZ1rLzgl+QpSOS0R/uwTgKwtcYzOixr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730417507; c=relaxed/simple;
	bh=IVJLAb8y0oM8o/EKypnDgVIQwAzhFWgQyO0aaKjb1o4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fV5DmTdPH1TVS1NARYuY2DFIcXLyhhQYz2q00lcxFItj5oK6ENMlw4dxbolom12tiGCTD05p9Frb0s3X6pxCGutV3QDSNMnJ9hyFEPK0mqguBOJ9HI3Uk9wGAZOk+oIjubK8T/mhMVBTwgEnaGCF0XUSSWOSkSe/qp4rUErHKlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=WuQnTROm; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6008a.ext.cloudfilter.net ([10.0.30.227])
	by cmsmtp with ESMTPS
	id 6YJntFD0rnNFG6edet5xNw; Thu, 31 Oct 2024 23:31:38 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 6eddt5Ns3zWaB6edetRBjB; Thu, 31 Oct 2024 23:31:38 +0000
X-Authority-Analysis: v=2.4 cv=dfaG32Xe c=1 sm=1 tr=0 ts=6724135a
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=GtNDhlRIH4u8wNL3EA3KcA==:17
 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=K0Ap-pyKWWmxKUwgzmsA:9 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jCG9Z1bZRYqbrYLvyKfqUnIB12xsUdtxtavULjifs9c=; b=WuQnTROm7pWPymN5HZgz3UKChH
	HGoAc/i2oW0qaEChDgX1l7agfO9/EmhnnYVzH0iA9a8C53/F7EUTMXp651tyCu3ku+GdL0N5oCR/i
	bcVJSkxkGM5raRHZl2cXth1NFUgb+0WhYopcVTwVQlBhUNVmyhLNTOEZUSTucUEFX1hJBVPvslg5l
	s1lrlu3RXWI01ZlL8j9wwM06cXCg5uJcx8BVr1Taq9e/Myz/0yl6B3P6GLJmBjVr3wn9H9M9rkRc4
	rRgsLd21IbtF77QECf2dvcqTpld+31tOXSDS6ydMqroi8dQtXRCawHCFk8r/39GeMXku5HB/WD5g/
	SKD4vJpw==;
Received: from [177.238.21.80] (port=63018 helo=[192.168.0.27])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1t6edd-000M8L-0a;
	Thu, 31 Oct 2024 18:31:37 -0500
Message-ID: <ca7be9f4-3f33-48ba-b61a-0a40ea1f17a6@embeddedor.com>
Date: Thu, 31 Oct 2024 17:31:34 -0600
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] jbd2: Avoid dozens of
 -Wflex-array-member-not-at-end warnings
To: Jan Kara <jack@suse.cz>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>,
 linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <ZxvyavDjXDaV9cNg@kspp> <20241031123313.dfcuttwzzs5f5i7a@quack3>
 <fe0e9c86-fa44-425e-a955-aa9e401b6334@embeddedor.com>
 <20241031213208.gzr5jv2kg5eobjuo@quack3>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20241031213208.gzr5jv2kg5eobjuo@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.21.80
X-Source-L: No
X-Exim-ID: 1t6edd-000M8L-0a
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.27]) [177.238.21.80]:63018
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGQTwdq1/FWAVTw/y8NaxLARSBmnsPsCLheOc3/eOtdsEetyq4DsJGrq8D2foWqM4yDnO+ZgBc68fCqK/BIwPNYKSQ6qXMN0864fAmpfKlSyKf0twyGr
 CjBLEOBnmSqqhJMLr1u6MzZ5AivihtBy9LH2SOr/qhmqmEsRPc0YLBGmKOLOU1OVujSaMoiQqYfzBT9BhY5zvqkJRI7AFpgw4MW5tAYqiphUahOiAZiS/DaG



On 31/10/24 15:32, Jan Kara wrote:
> On Thu 31-10-24 09:54:36, Gustavo A. R. Silva wrote:
>> On 31/10/24 06:33, Jan Kara wrote:
>>> On Fri 25-10-24 13:32:58, Gustavo A. R. Silva wrote:
>>>> -Wflex-array-member-not-at-end was introduced in GCC-14, and we
>>>> are getting ready to enable it, globally.
>>>>
>>>> Use the `DEFINE_RAW_FLEX()` helper for an on-stack definition of
>>>> a flexible structure (`struct shash_desc`) where the size of the
>>>> flexible-array member (`__ctx`) is known at compile-time, and
>>>> refactor the rest of the code, accordingly.
>>>>
>>>> So, with this, fix 77 of the following warnings:
>>>>
>>>> include/linux/jbd2.h:1800:35: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>>>>
>>>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>>>> ---
>>>>    include/linux/jbd2.h | 13 +++++--------
>>>>    1 file changed, 5 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
>>>> index 8aef9bb6ad57..ce4560e62d3b 100644
>>>> --- a/include/linux/jbd2.h
>>>> +++ b/include/linux/jbd2.h
>>>> @@ -1796,22 +1796,19 @@ static inline unsigned long jbd2_log_space_left(journal_t *journal)
>>>>    static inline u32 jbd2_chksum(journal_t *journal, u32 crc,
>>>>    			      const void *address, unsigned int length)
>>>>    {
>>>> -	struct {
>>>> -		struct shash_desc shash;
>>>> -		char ctx[JBD_MAX_CHECKSUM_SIZE];
>>>> -	} desc;
>>>> +	DEFINE_RAW_FLEX(struct shash_desc, desc, __ctx, 1);
>>>
>>> Am I missing some magic here or the 1 above should be
>>> JBD_MAX_CHECKSUM_SIZE?
>>
>> This seems to be 32-bit code, and the element type of the flex-array
>> member `__ctx` is `void *`. Therefore, we have:
> 
> Why do you think the code is 32-bit? It is used regardless of the
> architecture...

Right, sorry, I got a bit confused...

> 
>> `sizeof(ctx) == 4` when `char ctx[JBD_MAX_CHECKSUM_SIZE];`
>>
>> To maintain the same size, we tell `DEFINE_RAW_FLEX()` to allocate `1`
>> element for the flex array, as in 32-bit `sizeof(void *) == 4`.
> 
> So I agree we end up allocating enough space on stack but it is pretty
> subtle and if JBD_MAX_CHECKSUM_SIZE definition changes, we have a problem.
> I think we need something like (JBD_MAX_CHECKSUM_SIZE + sizeof(*desc->__ctx)
> - 1) / sizeof(*desc->__ctx))?

I see. Well, in that case it'd be something more like:

-       struct {
-               struct shash_desc shash;
-               char ctx[JBD_MAX_CHECKSUM_SIZE];
-       } desc;
+       DEFINE_RAW_FLEX(struct shash_desc, desc, __ctx,
+                       (JBD_MAX_CHECKSUM_SIZE +
+                        sizeof(*((struct shash_desc *)0)->__ctx)) /
+                        sizeof(*((struct shash_desc *)0)->__ctx));

Notice that `desc` is created inside `DEFINE_RAW_FLEX()`

Thanks
--
Gustavo








