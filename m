Return-Path: <linux-ext4+bounces-4866-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 892899B7F66
	for <lists+linux-ext4@lfdr.de>; Thu, 31 Oct 2024 16:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 547FD1C22922
	for <lists+linux-ext4@lfdr.de>; Thu, 31 Oct 2024 15:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE32B1BC9FF;
	Thu, 31 Oct 2024 15:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="GaUBPjV0"
X-Original-To: linux-ext4@vger.kernel.org
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2906D1A265B
	for <linux-ext4@vger.kernel.org>; Thu, 31 Oct 2024 15:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730390090; cv=none; b=t8E2B4JKqFS7d4+3MoR//aPLIqesTYFDvHaOIYJH4Sv9j2YBm6E1bREi1s+ZsIE3uNrKg3LzFUzmi3t53TjqxAvBIaSxFRdDHumM0lsuKFe85DouIdrsASV/Vfd3g8U56x0tjq3On1cfhN4NQadLWDONqEhc+D7skR77wEzdCCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730390090; c=relaxed/simple;
	bh=Gxzfn2SF0QBAoVHOxro2ClMb4X/IGqeuFDTOdU7DiYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=loWQwleXzxttUHPL1r01UbWd0wm+AsHv43Kx5PeG1hG2rf17PKUdzqn4wM4iivJnJlxQaM8ofTCpcEItNV9Mid5w6Q9f5NTdKNIPU7GXbtJVQ2H/WKny6LDHki5q6XSdtAx1FIxAgD+CDi23m/xjxPYnI6GjKNUJ8/BteymvTJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=GaUBPjV0; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5004a.ext.cloudfilter.net ([10.0.29.221])
	by cmsmtp with ESMTPS
	id 6Bo0t6pO0qvuo6XVWtT38p; Thu, 31 Oct 2024 15:54:46 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 6XVVttvjQWvXp6XVVtWXwy; Thu, 31 Oct 2024 15:54:46 +0000
X-Authority-Analysis: v=2.4 cv=LtdZyWdc c=1 sm=1 tr=0 ts=6723a846
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=GtNDhlRIH4u8wNL3EA3KcA==:17
 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=tQWGEp-pK8p0ZP6gKTUA:9 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KtvSriqj3Ua8SrbSVO6pQjRywNkkQJtFu2RPK0z3hdE=; b=GaUBPjV0nqaZ3rB8d1IqJKU9me
	aZgmNVZ19chDRGDuqtqqyoo8fm0iCfj500Un3A1ABcVueJ2jbZLgHMAjPzUPeyV4rta356TpnsVrl
	e850RsZPuDs+lR3HlemOZ+RUeBtTM1/xpGAja3fEl1m9Uak6Yp/UGDvkJZvwBTNKjEy4PQtvJlSOV
	rI7C88Lr9ohYWcEY3PnkUXdgIVtfsM9wKv+/4/uyKCoLtl2m/u6iRwL4wByB6DXYwsGjQof+SjL6r
	f5nDCRIwHPPirsxiHLPSFe59wBRcLZGA5pVSEEgRH+rpZdB67wIL19rd6Z19HcPt34/fVeAzXLl1q
	QzmLZnQw==;
Received: from [177.238.21.80] (port=39586 helo=[192.168.0.27])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1t6XVU-001e2z-2v;
	Thu, 31 Oct 2024 10:54:45 -0500
Message-ID: <fe0e9c86-fa44-425e-a955-aa9e401b6334@embeddedor.com>
Date: Thu, 31 Oct 2024 09:54:36 -0600
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] jbd2: Avoid dozens of
 -Wflex-array-member-not-at-end warnings
To: Jan Kara <jack@suse.cz>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>,
 linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <ZxvyavDjXDaV9cNg@kspp> <20241031123313.dfcuttwzzs5f5i7a@quack3>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20241031123313.dfcuttwzzs5f5i7a@quack3>
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
X-Exim-ID: 1t6XVU-001e2z-2v
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.27]) [177.238.21.80]:39586
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBS3u27LbFYJXn8tgS8uFnvA/Y4iSSx71wGZHrgtnWjxnaQ0tzhUXVmpH6goi7pqeB+zwTzonjKWbyYyYcrn9efhikjPE5u7+9/55hiEsVcAPlSWIWqB
 rvhjrUx1YCS8bDO0b7nZU0BO/HfZGd8eIYaTYI13iijC0+s4J9wBBB2vre+hDPCxLFKFrD0NJZXCi/PEMkhIoYjkiHds+4Ud25YgYYCXh3fiL4RuoxsRYBNg



On 31/10/24 06:33, Jan Kara wrote:
> On Fri 25-10-24 13:32:58, Gustavo A. R. Silva wrote:
>> -Wflex-array-member-not-at-end was introduced in GCC-14, and we
>> are getting ready to enable it, globally.
>>
>> Use the `DEFINE_RAW_FLEX()` helper for an on-stack definition of
>> a flexible structure (`struct shash_desc`) where the size of the
>> flexible-array member (`__ctx`) is known at compile-time, and
>> refactor the rest of the code, accordingly.
>>
>> So, with this, fix 77 of the following warnings:
>>
>> include/linux/jbd2.h:1800:35: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>>   include/linux/jbd2.h | 13 +++++--------
>>   1 file changed, 5 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
>> index 8aef9bb6ad57..ce4560e62d3b 100644
>> --- a/include/linux/jbd2.h
>> +++ b/include/linux/jbd2.h
>> @@ -1796,22 +1796,19 @@ static inline unsigned long jbd2_log_space_left(journal_t *journal)
>>   static inline u32 jbd2_chksum(journal_t *journal, u32 crc,
>>   			      const void *address, unsigned int length)
>>   {
>> -	struct {
>> -		struct shash_desc shash;
>> -		char ctx[JBD_MAX_CHECKSUM_SIZE];
>> -	} desc;
>> +	DEFINE_RAW_FLEX(struct shash_desc, desc, __ctx, 1);
> 
> Am I missing some magic here or the 1 above should be
> JBD_MAX_CHECKSUM_SIZE?

This seems to be 32-bit code, and the element type of the flex-array
member `__ctx` is `void *`. Therefore, we have:

`sizeof(ctx) == 4` when `char ctx[JBD_MAX_CHECKSUM_SIZE];`

To maintain the same size, we tell `DEFINE_RAW_FLEX()` to allocate `1`
element for the flex array, as in 32-bit `sizeof(void *) == 4`.

--
Gustavo



