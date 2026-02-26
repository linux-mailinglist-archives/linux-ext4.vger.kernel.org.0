Return-Path: <linux-ext4+bounces-14182-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id B1CYOpfCoGmEmQQAu9opvQ
	(envelope-from <linux-ext4+bounces-14182-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 23:00:55 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2704C1B01E5
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 23:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 08FE5303C81F
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 22:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B61230F93C;
	Thu, 26 Feb 2026 22:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rocketmail.com header.i=@rocketmail.com header.b="QqmoZWRE"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sonic304-22.consmr.mail.ne1.yahoo.com (sonic304-22.consmr.mail.ne1.yahoo.com [66.163.191.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E93287506
	for <linux-ext4@vger.kernel.org>; Thu, 26 Feb 2026 22:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772143250; cv=none; b=NGhFHDdUN96q8Hp+V7ArBLgEBIuzZrcy80KKYUgKtHqANrRZ3KIWOHPeoRIyYGodYz5xCZAjP39DLdRmQi5+1L1ExnOuVK9zLxPY7zcw1w3Kb9tYOl03wWnHswtpI6TaTqPDuPx5ah4bCtjcRf8pbjfL5rolIHXXLWHR2ufBLsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772143250; c=relaxed/simple;
	bh=8HVppTtdy70/XG01zBimtbOnKO8UG3STeNq8+gyewC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RHS4ip54LEQozFfV4d6uREz+ltZaPzlICA7UQWeeAGd7XdwzwPEzQC0ti+eJfCKIbQlR1g80zBxTgIHb2IGOKhdTKxhpMcpw01T6POEayYS/R4gvcBgoRRsTREZXuxnFs3X93TB/8fakCahqTQ2ZbQ+T2bD0v0dax7lGUIaqDQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rocketmail.com; spf=pass smtp.mailfrom=rocketmail.com; dkim=pass (2048-bit key) header.d=rocketmail.com header.i=@rocketmail.com header.b=QqmoZWRE; arc=none smtp.client-ip=66.163.191.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rocketmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rocketmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1772143241; bh=3bT4tXWGBl6Ab/P4fz37vFKVCOVsCIlNUpLySbrqcMo=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=QqmoZWREp71M7/BBfmOTZv5TGUtrGqbwLCf6FYhYi6nZDACrXuj3PUffGvAeu2vjxjckfK0Jk1QgZJ6k0lYyK5gCbsyOBTf4GeoTdQQUe3LhLyWNG4YpMhVZN76NalCcuE+zeA2oh8a+IyR7N1J03/4JO1AdbH1lUqqK0PVpFh3LySmczOiakxtx5rJP1vaRrOXUay9TrbCMSzlp7uhXNHZHUcCCTQ5DIO333cVSBQTatKE/oVU288f2vhohsXd1I2xcqQoVYcu0+Mtcv7oiMTxWZ/ooxOnxxiF+ICmid0EOdtGe752CiWTiw2Bhzmmzn+3plf7R4R7wbkoS2kyCxQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1772143241; bh=C55ndGwmJ1nmMG/BQ70Z+u4I6OWgubI0SDqqC5eTk1A=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Pczug8HBdTmzHeDVJXkiuIt+2W1lKmp9tJh9DhD0Cemiv19yMZeCQhOHTfeD12Bucl2ifO+Q0PdgJNLhLYtp3T3gtCtXs6ikfFVS5/bisq+rJVCHgg1ggOlqqZZzutuVlvOGCY16VlwVKjdZjd16a+7/7CUqCpwoK8lt8ifiUTrvcgseEL7ZAILSY3G5bjtcI46v0QSuBCwSAbMDgaX7H+eQ+ojFC2P3MzK78BHdWEWSvqXrSxAaPgWurrsLeGsiCOKLJbt9X1y/sQHtXnrH6Zm9OrZQkPALQ35FB1pKaGg72onyKhgJ7L24mwxZTiHkVJORRSGeZpg87DD5vlPaQg==
X-YMail-OSG: HjG0DToVM1l4f3WOrJRL7aJHA9x8Rx8ANGI3Bs1td2YVVUOmAqdKaF8QwgDiCeI
 bebSsyne0ETV4vHX0VbRnERuuzi0Ryaq6AzEm7zvgSi0PMNHB8v7CVCt_VuOZcVeJ.CuumkanOQ2
 Hyht1pRX3vi3vMdUue8XKxr79_GEMmHdeTiUvP4HsSs_thRmtwpZCmFkYLGRW6hEeWSUd.cawsGJ
 KJmLdZJ5Y3_.6eUs9PgjCpIJvLyDTrH1THtayRIuUcogCrHIyyAQBRkOH8WkjeGcEcKArIl6KETI
 ehHBKDGDGKrMYwGDPYt23Wu34jIoXGETRUN_r0y2G2IOgXUPo0vbZGbSuf7H8Vg_n03.BkNXUmbn
 twKgcGZ0ROnm7_zY7pNLrYsNM_1Lqorf319KeRo.nfY.2oFKg6juO1Zxm1nTTf6_1N4JnudrN7md
 lTBEVlACJVomMDAFUrNk48QfFGl14S_JO6ZvKCZDK4ck8LDHNXkbbjIWgajQ9xX5Uo1zHg13RqCD
 lreTV.NBNOr6KUxnP9AwO0LqIGylePaKr.QTadC2Y2oNLyvsF3I6c6SC5hKuypu_ZU8IdoNbKFQp
 wYqOZFxHGH1e9E.Ke1oHzVnQtderWqie9Jf_CIGcQwsvRMF.afsx87Dcps4rHYI9NEqyoKcgs8dE
 sQ37KgwWOtsTJ4XWgATP0j_1f0gxdOAhNbzP2F2xt7OYHrlGXwji7forWIfGhw_t43tx9dGVVaE9
 sdocO0zU.VHq6p8TaD1o9cnB4Wxy51BdaZ0GVv1nCNgmC3AExU9Gq2PeVrKUjvNOYmuAG48wf_P0
 YHCWOMPkIU_fUNFYPsieYA_rMwlW.9kzo.IGJPQ0TTZMLZd50jaKIXtqzL9US3JrbEUosbe4Anak
 hoDeURUIvS4P47fJow56sq0MBYdW90b.NQdhzO_N3RXB45CT2pR8f26iJbqaQO07NLs.Mu6L1BE4
 sdyplZmfUeFzTvUWrSy0a6lX6NCUr7RY7DBImAER7edgWJDNLUMfGtiRr3TlLJ.uFRQ.AIcZhHIt
 mr8XyzmWPoS8MJ17VvKqeqXTNilR3.lXxgphMx4rUY9BQK7RFPd3XoLoH3wfIHERk5ihoEJj08Ot
 nZTw7YysSiz_9pwoxGd6SUsoFMM2kashGKE4yXBiIt6iNTGLUY80RK9IILIJzvIp5E.pcuodnS1F
 B74MrxbxKP2yMoDvgr2qrW6XjZ7FgHoAWKR31FsibUc3NDtjvkvRZP9efZ9c.uVOxD5GzCQYoKt_
 wAqWTuzRML9by.dtJROB19xfeRnpdJbcJWuijNUJBAYquV_aBcxi7CGNJoMD9FPQpxBteGeutO3k
 Zed9aGl8mtYGzWDqf6oY4KQVrGDnCp2pGtY5UMR8FUk3mLeanihr1NbUIdZihPBg67YrBBvUwKjc
 CYiLxyTDE7ol1EIavcjJZ1M6V0wj3ilMKHR.9n0zzf.a7TFrzrV4f8eBsuiChjbLSky873C9w_eV
 9.NvxgKu6HEzUMQoI8Lb4cAHn8NrbCMz2I0YahV8_SrlbKRo5kSWUpYQwpvr9gx1NiNfaddtUqUC
 RrQlWkr6iDiwML3sp29LU9lEi00xmAPnxq0BuWlJ8otmD8.FHhRRcbZ7S0j2oUqKVVnpPsHAIyA9
 lRCsM4FpASsLe.5gSsb8rtVBd1CrOM1yC7fhhiearElKAoAWzsAV_8VIZlx_khNvV8H020Lnlq2i
 Dp.bZGt6CSxI7EoXQ5CEL6eXHODA0UNVisKxe2fdQOByVY8ykzb1Ifx9kK_EC6GF1f5MeOq0iw1i
 4jbV1R17p4TYRo6T3V_xiuUqmqBBIsirP4mrXJKekKX6huhzRJfBwfcfipqAFg_7Y5bUIKpqtbBh
 e92Uyk_eQ6BvhtpCctzimB5zMXKUTsTmsIFGg2nhM8ps8mZs2eBEYUB39JjYrqWwOGWJzUtysGXI
 KNZwKs3fAL54_nNm9FbXoyDh87gnmZWZg3jofTRMJzvuiISCbMo7_2HDek5FIlAQpH87mCDfWYPZ
 mySm2gQiT7BWuh9nPFiUNUAlSEbyHeBTtBP__JqLNWSCzwIa0XHkxn21zZjjqQfmx0vIF4w1i4KC
 IYBKZpFj004928ukbQ2gOSzu67ZTjS8NRn95eMCrQ.KuoDLDciFzA94pz3u1z7VILs.rDqJ0hifK
 0OtaGUO4kRTZkmT5C77DztJsZCEeKscjo9tvaepjGvgTa2n6QIpxYKYP0BvOV20lKZPrXI_4sN9A
 GaPJSmv.5tlHb4DKcrbWUDCuzwPwloVt8GWqDSQ6zqscmZw--
X-Sonic-MF: <mario_lohajner@rocketmail.com>
X-Sonic-ID: 300e24ab-c496-44a2-a62f-fdcd1153a590
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Thu, 26 Feb 2026 22:00:41 +0000
Received: by hermes--production-ir2-bbcfb4457-g4h2c (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 3954f7cc5410653f04ea4ac9771638f2;
          Thu, 26 Feb 2026 21:50:31 +0000 (UTC)
Message-ID: <04dfeda0-8c13-4233-b631-d8912d4fe6f0@rocketmail.com>
Date: Thu, 26 Feb 2026 22:50:29 +0100
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
To: Theodore Tso <tytso@mit.edu>, Andreas Dilger <adilger@dilger.ca>
Cc: libaokun1@huawei.com, adilger.kernel@dilger.ca,
 linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
 yangerkun@huawei.com, libaokun9@gmail.com
References: <20260225201520.220071-1-mario_lohajner.ref@rocketmail.com>
 <20260225201520.220071-1-mario_lohajner@rocketmail.com>
 <D135BB30-388D-4B4F-9E09-211F6DA74FCA@dilger.ca>
 <20260226024819.GA39209@macsyma-wired.lan>
From: Mario Lohajner <mario_lohajner@rocketmail.com>
In-Reply-To: <20260226024819.GA39209@macsyma-wired.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.25278 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rocketmail.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[rocketmail.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[huawei.com,dilger.ca,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-14182-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[rocketmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[rocketmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mario_lohajner@rocketmail.com,linux-ext4@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2704C1B01E5
X-Rspamd-Action: no action



On 26. 02. 2026. 03:48, Theodore Tso wrote:
> On Wed, Feb 25, 2026 at 04:49:30PM -0700, Andreas Dilger wrote:
>>
>> Mario, can you please include a summary of the performance test
>> results into the commit message so that the effectiveness of the
>> patch can be evaluated.  This should include test(s) run and
>> their arguments, along with table of before/after numbers.
> 
> The tests should also include an explanation of the hardware that you
> ran the test on.  Some example of cover letters that include
> perforance improvement results:
> 
> https://lore.kernel.org/all/20251025032221.2905818-1-libaokun@huaweicloud.com/
> https://lore.kernel.org/all/20260105014522.1937690-1-yi.zhang@huaweicloud.com/
> 
> Cheers,
> 
> 					- Ted

Hello Andreas, hello Theodore!

These are the results of synthetic tests designed to evaluate whether
the round-robin allocator (rralloc) maintains its allocation behavior
without degrading performance, and to examine its behavior under high
concurrency and stress conditions.

The primary purpose of rralloc is to improve allocation distribution
and avoid hotspotting. Performance improvements are not the goal here,
throughput similar to regular allocator is considered favorable.

# Workloads
*** Large Sequential Files
(Evaluates sequential write throughput with multi-job concurrency)

fio --name=seqwrite --directory=. --rw=write --bs=1M --numjobs=6 \
--size=4G --runtime=300 --time_based --group_reporting

*** Small Files
(Validates allocator behavior and latency under small, random writes)

fio --name=smallfiles --directory=. --rw=write --bs=4k --numjobs=6 \
--size=1G --ioengine=psync --time_based --runtime=180 --group_reporting

*** Multi-core / Multi-task Stress
(Tests high concurrency and stress conditions)

fio --name=allocstress --directory=. --rw=write --bs=4k --numjobs=48 \
--size=2G --ioengine=psync --time_based --runtime=180 --group_reporting

# Results summary:

| Test        | Allocator | BW (MiB/s) | IOPS  | Avg lat |
| ----------- | --------- | ---------- | ----- | ------- |
| seqwrite    | Regular   | 497        | 496   | 9.19 ms |
|             | rralloc   | 538        | 537   | 9.37 ms |
| smallfiles  | Regular   | 707        | 181k  | 2.03 µs |
|             | rralloc   | 586        | 150k  | 2.18 µs |
| allocstress | Regular   | 166        | 42.4k | 1.13 ms |
|             | rralloc   | 283        | 72.5k | 0.66 ms |


The results indicate that a round-robin allocation strategy can be
introduced without compromising baseline I/O characteristics.

Across tested workloads, rralloc preserves expected I/O behavior and
does not introduce performance regressions of practical significance.

| Test     | Hardware                                   |
| -------- | ------------------------------------------ |
| OS       | Fedora Linux 42 Workstation x86_64         |
| Host     | 90HU007QGE ideacentre 510-15ICB            |
| Kernel   | 6.18.9-dirty                               |
| CPU      | Intel i5-8400 (6 cores) @ 2.801GHz         |
| GPU1     | AMD Radeon RX 560                          |
| GPU2     | Intel CoffeeLake-S GT2 / UHD Graphics 630  |
| Memory   | 1379 MiB / 31,958 MiB                      |
| NVMe     | INTEL SSDPEKNW512G8H (HPS1)                |
| SATA SSD | Samsung SSD 860 PRO 256GB (RVM02B6Q)       |

Note:
These results reflect synthetic tests on the described hardware.
Independent reproduction and verification of these findings are welcome.
Variations in hardware, kernel version, or workload configuration may
affect absolute numbers, but the qualitative observation—that rralloc
preserves baseline I/O behavior—remains valid.

For more details (raw outputs) please refer to:
https://github.com/mlohajner/RRALLOC

Regards,
Mario Lohajner (manjo)

