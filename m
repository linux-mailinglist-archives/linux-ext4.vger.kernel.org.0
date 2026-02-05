Return-Path: <linux-ext4+bounces-13542-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uG7NJMWMhGl43QMAu9opvQ
	(envelope-from <linux-ext4+bounces-13542-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 05 Feb 2026 13:27:49 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F038FF277D
	for <lists+linux-ext4@lfdr.de>; Thu, 05 Feb 2026 13:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1586A301F99B
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Feb 2026 12:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33ED83D3488;
	Thu,  5 Feb 2026 12:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rocketmail.com header.i=@rocketmail.com header.b="XkLI4ze7"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sonic307-56.consmr.mail.ne1.yahoo.com (sonic307-56.consmr.mail.ne1.yahoo.com [66.163.190.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0633624CA
	for <linux-ext4@vger.kernel.org>; Thu,  5 Feb 2026 12:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770294210; cv=none; b=Q77O+PPgznfTGUUIaGLA3b25BNfZnc1JdKjwzgiNiP5kaFTVSg3Tp9EgDqOUpcLMdvcz6ILelfEtKtbSzz77LgsuqrDqdVaaWqxu7IRHJzsYYTGOjtY6kN5nkdH7aODE+kfioel0lwmrWhlcMxd/LKStZvqssGKTVeBqbGYGNFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770294210; c=relaxed/simple;
	bh=k7HqKinOV38aoACjyr6iOG/vKCrquZRFM60/X/Zhpdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ChDL//skBXu8FcQMkPxoadfOyjtZL4fz3nzyL04cKDAmPMQEtmLpisvcvyWQqYkLVqxDWnT7G6WezgAV3LozF8G5jH/UvokFLW+apdZ695MSrYiMsDoQaLleKJhInX5wY2HIxk2q3WFjoRBKG737RMOU6I6nviWNIksay2oKbf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rocketmail.com; spf=pass smtp.mailfrom=rocketmail.com; dkim=pass (2048-bit key) header.d=rocketmail.com header.i=@rocketmail.com header.b=XkLI4ze7; arc=none smtp.client-ip=66.163.190.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rocketmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rocketmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1770294203; bh=Zi0jqwHg0jqSE0/DboHtZf1q9HAYdfzemJHoS3ECJP0=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=XkLI4ze7BBSqDEnAySRltpGzGZDt9r5ybkA0W4wXDkYNDuTOs4okCsJi/l7qs3e6IxhQkA42VhqBFfGCP7RAzmClzxJwq92Z8nxp8joM1YnFBcfGC89HapqNO23/JNGU+AlhnxBcZNN2vvEsvaPm+kjSClKIXRJdJ1V2mV7Iig5ZgOgRwl9qzSgLemUH65SULQelubXjfcmfHvomzCQGvz45OHXjVxRAbA2uQzE3+9XQU8pD5SaSSO0ACAteEZ9fc+JoqgxLgcF1M3XekSK5grljy7l8LFPBaX0Z5ArptgNWgtYoRDAGjADUxlzBkwDkjc45LIKnYqoAhdy7IpX9rQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1770294203; bh=2QVaEMWb2RPb9ok928r1A+rfCAlV6OVP9KDyGISlVW7=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=QzlExt8CTX1SRVXRSfWBuXqejK2CAcni/MKCGitl3518fPHSuFYOjEmF1rKkvPiZl+RVbplBFwIdP35RpUeXPN5WnWFUwftecq4y3oWQ/B/htB8CgZUGXAxlRfhU4lTnfEx2d6+IKCEJL/nluiLh+CjnhwRveslhRuL+1+42341GHEXVpxtLbdVNjS7Zz0TLlVeBbe5Tz0glQV94/NBHrsXYcydR8MdbkR2OpDIPtcfbQj8x9ZQhDGqaUCS5YYkahxUrsn44g0DmiPsy3HGla9IB8zP+LN5OhVzexdCJPCS0tW+iEw/WBytSrY7hMrldBGNCjVRlouyVyPSUcLAf5w==
X-YMail-OSG: kRFvhxUVM1lh7HR1AYz4EBcSOfwr5hYJnCY6O4jXO96515.6588agvkVVGra6D.
 nz80SgQd8jqelD4fsu28AwogxrbuDbjCZlFM7j3d7.NGDu9dCevWgYeP8BoPLDiiav67WFPQCURF
 D.b5BqGbEPvTDuN93DiDcEVorIsgm5Mc2Cm1xiS8GTza8IyR1dAg7bbMZHR5xdo0st2jlL2bKXbK
 pRI.oxf_Tbp8KUf1odiudyDUW4_SUomzejTBk7BJLdEuMAcbWBrKEb6e7KmbT22cba7FhG7rQ9lf
 5Ldn_Y9T4hiZql9UVMAbRn95nxrxYWuo40EUrCzq90wAWedVr2YmAT5PyryzUousTC2c46BJWZ5P
 KhXup4kwuvDWvTGOp8oCeZUei8F7kjQY0.35xHuTb7P25mHt2YwpgFgQXb._hAHhMyNWYEptPPV0
 5.NbDDWxNwMg6k4Ub4MhcZejaRtkGY8vSeR6t6JitwebGJQ57cZMBW0EfbfLUn.Lkx9iIsn7MH1t
 KjXBamFRgjcuIZLPurU0pLPkXix7FVB6zmBuU4uNOL8_cOg2LGkxpzhgrFWXy3s8CRsLRWXfSDMp
 A7Fn8c0tfIq.jYfD0sBv9L4D_.DkEfBWCveqUjpT5jtpKqMcnA_ZxqvBn7y4y0OOJ.qixdEplXfT
 ByU1rpXTFNpxifgPDxV8GRh5_rmvnysjUkyqmFde7NKs__Bv3PVtDvHzUragRitYQecZJkKx0cFu
 r.ux02XU_O4KZeWA8BAPgOyohFrC5sQlseF2WzEJ6x0OyXSzcda7zuW1ldf2mkMhdFY4og7CrMfc
 njZhkqhSC1t.LE9oGa41zpvaFb4H.7BaDsndp4kFDm4baA_2fyM3TrZJAK94AnB2cUa4b.7jhejE
 KS6ZNQnkE3_7uGhlvdPhyLnAAvQQ.QJ2DVPJ21qqon4CgE8KeTwXHsCaFxpnxrnp7YhNtzZaB3iG
 T4VfiWMupFCWD3EIvQNgrx3m7LZTCoPRaQPwGmyl_caaEWvm43WgXWqpez5yQy.CiVUE_qJD77xn
 ZhlZl9iK2lu8eHh2IUShh8pfOfu5JxzRN3jmvaSbXs4lgIzAZwWL4F48tSkkvdBZwp_2M5FX6aFN
 _l8MvPsp5E_GNqwMD68xGenZIab1YMwMiPGTOWWg3C911iJtbr4wV7bQEHjy9OGc.TZOMsPvClxP
 wQVNRyvKG54gFzwbaH6jSXgHFUPvHMTOPzgr6N.A_TvI6HVIepqwo8isyNbYSIRajZwpX2iFZAVo
 zS.0vapgNwVWPURBXINXdnAYM_sWRIYLiB7_ViHxm5Tfn0ei2b9LLGckbobsH.e69q7.U8D2VBwg
 eDNmv9AFM1izevp7Ppv80rot45BfFGOQ6PmME57CUAb2aJri48bFsAtTDoWs9mVncatNx_kLiWm3
 0v6WZZxvk8Q2loFDj5Ux5Hvc0cqVp523jQBPp0l_XbAE3pDy6uv_Nh5QiWpzS5KIcWHa5vPtQLa6
 vBSmwu.hguREiYtGx2j5zcOEkmvxrVka8Kgj7jlqdwtZP288P0ro74B.yAJp59q8wqSQT9_rFFAx
 .XWzKzvreRGyqQ6jMqIFZpVMEF3wf1lEC69vwS37uY9HgrxLkjdzKJ1xKe8NnrlZZTdW3fjETs0F
 mPDK_Nt6r8dcVniRUHILGCj3EiHZSJvG8Qu6d4pL5KdpodhDT8otNt6FG_R83NUSQk7Otq7XI9Z3
 khkG_tdEEcVDC.KiRnzMa_wI6hCpf3TMeyidLGrPJ9Qb0AgT66Cc.v8hcosCIiILx0BCRxYFAN_v
 bXYrXJt1uff_J10Z04ov6tL9YW16INknQWFUbG4mXWGVFFEAB6vYaO6MNfrY4G88zmTFfiQq4qPo
 jkHPghk4dXjEcOQbjbllgfyrV4J_2gzEgjfbbpnE7uCFDhSxfVFmOlXMO9.3bHRTEBm9H4AV4gRK
 _heOGGI80YdkubDgTeZ6_zwHiJOGRE_Ha__UV33jok6vAMcny7LkW1wmcCVRUaeS6EIWFTQSjrvp
 kzXeQvpom2nBAC4ctD7ap8khjzgBL9fhqn5aKyi8xiB5U9wZQHWrLhISI3bqDlUdJeXOwW3dp4mi
 LU5.fYz78fC4PrlqL8nmiizR3T3iSVvX7pOiEL0ehDE3u56_wDt9yce3qtgxGM7RKApAxOLBAQnf
 i9cHArjmihuji_STOe.W5.XTeLA4POJJ.3uiV7ninjrXeXK0GsGL57LGN.r2o8ti5EMUmtA0SAYF
 tWIwIXqwo.AWEqBbq80iAY1Nj
X-Sonic-MF: <mario_lohajner@rocketmail.com>
X-Sonic-ID: b1e49b95-8941-4e9c-bea7-f96e87a67adf
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Thu, 5 Feb 2026 12:23:23 +0000
Received: by hermes--production-ir2-6fcf857f6f-9ndng (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 76856bc1b7ca391695d5fb833eed748e;
          Thu, 05 Feb 2026 12:23:20 +0000 (UTC)
Message-ID: <606941c7-2a0d-44c7-a848-188212686a78@rocketmail.com>
Date: Thu, 5 Feb 2026 13:23:18 +0100
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: add optional rotating block allocation policy
To: Baokun Li <libaokun1@huawei.com>, tytso@mit.edu
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yang Erkun <yangerkun@huawei.com>,
 libaokun9@gmail.com
References: <20260204033112.406079-1-mario_lohajner.ref@rocketmail.com>
 <20260204033112.406079-1-mario_lohajner@rocketmail.com>
 <c6a3faa7-299a-4f10-981d-693cdf55b930@huawei.com>
 <069704a4-2417-470a-bf32-0ee3afd1be6a@rocketmail.com>
 <9fc3443b-0eea-4917-909b-709113f5e706@huawei.com>
Content-Language: hr
From: Mario Lohajner <mario_lohajner@rocketmail.com>
In-Reply-To: <9fc3443b-0eea-4917-909b-709113f5e706@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.25116 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rocketmail.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[rocketmail.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[dilger.ca,vger.kernel.org,huawei.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-13542-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[rocketmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[rocketmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mario_lohajner@rocketmail.com,linux-ext4@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rocketmail.com:email,rocketmail.com:dkim,rocketmail.com:mid]
X-Rspamd-Queue-Id: F038FF277D
X-Rspamd-Action: no action

Let me briefly restate the intent, focusing on the fundamentals.

Rotalloc is not wear leveling (and is intentionally not named as such).
It is a allocation policy whose goal is to reduce allocation hotspots by
enforcing mount-wide sequential allocation. Wear leveling, if any,
remains a device/firmware concern and is explicitly out of scope.
While WL motivated part of this work,

the main added value of this patch is allocator separation.
The policy indirection (aka vectored allocator) allows allocation
strategies that are orthogonal to the regular allocator to operate
outside the hot path, preserving existing heuristics and improving
maintainability. Rotalloc is one such case; when disabled (by default),
there is literally no behavioral change.

The cursor is global because the policy is global (KSS applied here :-).
It operates at the mount level, not per inode, stream, or CPU.
Splitting the cursor would still require keeping all cursors in sync;
once any allocator diverges, it either has to scan more blocks or
sequentiality collapses back into locality and hotspots reappear.
A single cursor is therefore intentional.

The rotating allocator itself is a working prototype.
It was written with minimal diff and clarity in mind to make the policy
reviewable. Refinements and simplifications are expected and welcome.

Regarding discard/trim: while discard prepares blocks for reuse and
signals that a block is free, it does not implement wear leveling by
itself. Rotalloc operates at a higher layer; by promoting sequentiality,
it reduces block/group allocation hotspots regardless of underlying
device behavior.
Since it is not in line with the current allocator goals, it is
implemented as an optional policy.

Best regards,
Mario

PS: thank you for acknowledging that there are workloads and scenarios
where this method is worthwhile :-).

On 05. 02. 2026. 04:52, Baokun Li wrote:
> On 2026-02-04 19:06, Mario Lohajner wrote:
>> Hello Baokun Li,
>>
>> This response was originally intended for Andreas.
>> I'm sending you the full copy to provide context for your query,
>> rather than writing a separate response.
>>
>> Yes, the main motive for this allocator is flash wear leveling,
>> but it is not strictly a wear leveling mechanism, and it is not named
>> as such for a reason.
>> Wear leveling may (or may not) exist at the device/hardware level.
>> The goal of this policy is not to "fix" that.
>>
> As Ted mentioned in another thread, wear leveling is media-dependent.
> Most drivers can handle wear leveling effectively enough just via the
> discard command.
>
> If you are using UFS, F2FS might be a solid choice. However, for raw
> NAND flash, UBIFS (via UBI) or JFFS2 would be more appropriate.
>
> A single global goal would cause severe contention in multi-CPU
> scenarios, which is precisely why the stream allocation goal was split
> into multiple ones.
>
> Furthermore, constantly overriding the inode goal leads to significant
> file fragmentation, as it often misses opportunities for extent merging.
>
> If we truly want to implement ext4_mb_rotating_allocator, we should strip
> out inode goal, stream allocation, and optimize_scan, rather than simply
> cloning ext4_mb_regular_allocator and forcing a goal setting.
>
>
> Cheers,
> Baokun
>
>> This policy helps avoid allocation hotspots at mount start by
>> distributing allocations sequentially across the entire mount,
>> not just a file or allocation stream.
>>
>> At the block/group allocation level, the file system is fairly stochastic
>> and timing-sensitive. Rather than providing raw benchmark data, I prefer
>> to explain the design analytically:
>> The vectored separation of the new allocator ensures that the performance
>> of the regular allocator is maintained (literally unchanged).
>> The overhead of the new rotating allocator is minimal and occurs outside
>> of the "hot loop":
>> the cursor is retrieved early at the start, updated upon successful
>> allocation,
>> and is negligible with respect to IO latency.
>> Because allocations proceed sequentially, latency is comparable to
>> or better than the regular allocator.
>> Having separated allocators increases maintainability and independence
>> with minimal (virtually no) overhead.
>>
>> This policy benefits workloads with frequent large or small allocations,
>> while keeping file fragmentation and slack space minimal.
>> It is a conscious trade-off: sacrificing locality in favor of reinforced
>> sequentiality.
>> Of course, this is not optimal for classic HDDs, but NVMe drives behave
>> differently.
>> For this reason, the policy is optional per mount, turned off by default,
>> and can be toggled at mount time.
>>
>> Best regards,
>> Mario
>>
>> On 04. 02. 2026. 07:29, Baokun Li wrote:
>>> On 2026-02-04 11:31, Mario Lohajner wrote:
>>>> Add support for the rotalloc allocation policy as a new mount
>>>> option. Policy rotates the starting block group for new allocations.
>>>>
>>>> Changes:
>>>> - fs/ext4/ext4.h
>>>>      rotalloc policy dedlared, extend sb with cursor, vector & lock
>>>>
>>>> - fs/ext4/mballoc.h
>>>>      expose allocator functions for vectoring in super.c
>>>>
>>>> - fs/ext4/super.c
>>>>      parse rotalloc mnt opt, init cursor, lock and allocator vector
>>>>
>>>> - fs/ext4/mballoc.c
>>>>      add rotalloc allocator, vectored allocator call in new_blocks
>>>>
>>>> The policy is selected via a mount option and does not change the
>>>> on-disk format or default allocation behavior. It preserves existing
>>>> allocation heuristics within a block group while distributing
>>>> allocations across block groups in a deterministic sequential manner.
>>>>
>>>> The rotating allocator is implemented as a separate allocation path
>>>> selected at mount time. This avoids conditional branches in the regular
>>>> allocator and keeps allocation policies isolated.
>>>> This also allows the rotating allocator to evolve independently in the
>>>> future without increasing complexity in the regular allocator.
>>>>
>>>> The policy was tested using v6.18.6 stable locally with the new mount
>>>> option "rotalloc" enabled, confirmed working as desribed!
>>>>
>>>> Signed-off-by: Mario Lohajner <mario_lohajner@rocketmail.com>
>>>> ---
>>>>    fs/ext4/ext4.h    |   8 +++
>>>>    fs/ext4/mballoc.c | 152 ++++++++++++++++++++++++++++++++++++++++++++--
>>>>    fs/ext4/mballoc.h |   3 +
>>>>    fs/ext4/super.c   |  18 +++++-
>>>>    4 files changed, 175 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
>>>> index 56112f201cac..cbbb7c05d7a2 100644
>>>> --- a/fs/ext4/ext4.h
>>>> +++ b/fs/ext4/ext4.h
>>>> @@ -229,6 +229,9 @@ struct ext4_allocation_request {
>>>>        unsigned int flags;
>>>>    };
>>>>    +/* expose rotalloc allocator argument pointer type */
>>>> +struct ext4_allocation_context;
>>>> +
>>>>    /*
>>>>     * Logical to physical block mapping, used by ext4_map_blocks()
>>>>     *
>>>> @@ -1230,6 +1233,7 @@ struct ext4_inode_info {
>>>>     * Mount flags set via mount options or defaults
>>>>     */
>>>>    #define EXT4_MOUNT_NO_MBCACHE        0x00001 /* Do not use mbcache */
>>>> +#define EXT4_MOUNT_ROTALLOC            0x00002 /* Use rotalloc
>>>> policy/allocator */
>>>>    #define EXT4_MOUNT_GRPID        0x00004    /* Create files with
>>>> directory's group */
>>>>    #define EXT4_MOUNT_DEBUG        0x00008    /* Some debugging messages */
>>>>    #define EXT4_MOUNT_ERRORS_CONT        0x00010    /* Continue on
>>>> errors */
>>>> @@ -1559,6 +1563,10 @@ struct ext4_sb_info {
>>>>        unsigned long s_mount_flags;
>>>>        unsigned int s_def_mount_opt;
>>>>        unsigned int s_def_mount_opt2;
>>>> +    /* Rotalloc cursor, lock & new_blocks allocator vector */
>>>> +    unsigned int s_rotalloc_cursor;
>>>> +    spinlock_t s_rotalloc_lock;
>>>> +    int (*s_mb_new_blocks)(struct ext4_allocation_context *ac);
>>>>        ext4_fsblk_t s_sb_block;
>>>>        atomic64_t s_resv_clusters;
>>>>        kuid_t s_resuid;
>>>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>>>> index 56d50fd3310b..74f79652c674 100644
>>>> --- a/fs/ext4/mballoc.c
>>>> +++ b/fs/ext4/mballoc.c
>>>> @@ -2314,11 +2314,11 @@ static void ext4_mb_check_limits(struct
>>>> ext4_allocation_context *ac,
>>>>     *   stop the scan and use it immediately
>>>>     *
>>>>     * * If free extent found is smaller than goal, then keep retrying
>>>> - *   upto a max of sbi->s_mb_max_to_scan times (default 200). After
>>>> + *   up to a max of sbi->s_mb_max_to_scan times (default 200). After
>>>>     *   that stop scanning and use whatever we have.
>>>>     *
>>>>     * * If free extent found is bigger than goal, then keep retrying
>>>> - *   upto a max of sbi->s_mb_min_to_scan times (default 10) before
>>>> + *   up to a max of sbi->s_mb_min_to_scan times (default 10) before
>>>>     *   stopping the scan and using the extent.
>>>>     *
>>>>     *
>>>> @@ -2981,7 +2981,7 @@ static int ext4_mb_scan_group(struct
>>>> ext4_allocation_context *ac,
>>>>        return ret;
>>>>    }
>>>>    -static noinline_for_stack int
>>>> +noinline_for_stack int
>>>>    ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
>>>>    {
>>>>        ext4_group_t i;
>>>> @@ -3012,7 +3012,7 @@ ext4_mb_regular_allocator(struct
>>>> ext4_allocation_context *ac)
>>>>         * is greater than equal to the sbi_s_mb_order2_reqs
>>>>         * You can tune it via /sys/fs/ext4/<partition>/mb_order2_req
>>>>         * We also support searching for power-of-two requests only for
>>>> -     * requests upto maximum buddy size we have constructed.
>>>> +     * requests up to maximum buddy size we have constructed.
>>>>         */
>>>>        if (i >= sbi->s_mb_order2_reqs && i <= MB_NUM_ORDERS(sb)) {
>>>>            if (is_power_of_2(ac->ac_g_ex.fe_len))
>>>> @@ -3101,6 +3101,144 @@ ext4_mb_regular_allocator(struct
>>>> ext4_allocation_context *ac)
>>>>        return err;
>>>>    }
>>>>    +/* Rotating allocator (rotalloc mount option) */
>>>> +noinline_for_stack int
>>>> +ext4_mb_rotating_allocator(struct ext4_allocation_context *ac)
>>>> +{
>>>> +    ext4_group_t i, goal;
>>>> +    int err = 0;
>>>> +    struct super_block *sb = ac->ac_sb;
>>>> +    struct ext4_sb_info *sbi = EXT4_SB(sb);
>>>> +    struct ext4_buddy e4b;
>>>> +
>>>> +    BUG_ON(ac->ac_status == AC_STATUS_FOUND);
>>>> +
>>>> +    /* Set the goal from s_rotalloc_cursor */
>>>> +    spin_lock(&sbi->s_rotalloc_lock);
>>>> +    goal = sbi->s_rotalloc_cursor;
>>>> +    spin_unlock(&sbi->s_rotalloc_lock);
>>>> +    ac->ac_g_ex.fe_group = goal;
>>>> +
>>>> +    /* first, try the goal */
>>>> +    err = ext4_mb_find_by_goal(ac, &e4b);
>>>> +    if (err || ac->ac_status == AC_STATUS_FOUND)
>>>> +        goto out;
>>>> +
>>>> +    if (unlikely(ac->ac_flags & EXT4_MB_HINT_GOAL_ONLY))
>>>> +        goto out;
>>>> +
>>>> +    /*
>>>> +     * ac->ac_2order is set only if the fe_len is a power of 2
>>>> +     * if ac->ac_2order is set we also set criteria to CR_POWER2_ALIGNED
>>>> +     * so that we try exact allocation using buddy.
>>>> +     */
>>>> +    i = fls(ac->ac_g_ex.fe_len);
>>>> +    ac->ac_2order = 0;
>>>> +    /*
>>>> +     * We search using buddy data only if the order of the request
>>>> +     * is greater than equal to the sbi_s_mb_order2_reqs
>>>> +     * You can tune it via /sys/fs/ext4/<partition>/mb_order2_req
>>>> +     * We also support searching for power-of-two requests only for
>>>> +     * requests up to maximum buddy size we have constructed.
>>>> +     */
>>>> +    if (i >= sbi->s_mb_order2_reqs && i <= MB_NUM_ORDERS(sb)) {
>>>> +        if (is_power_of_2(ac->ac_g_ex.fe_len))
>>>> +            ac->ac_2order = array_index_nospec(i - 1,
>>>> +                               MB_NUM_ORDERS(sb));
>>>> +    }
>>>> +
>>>> +    /* if stream allocation is enabled, use global goal */
>>>> +    if (ac->ac_flags & EXT4_MB_STREAM_ALLOC) {
>>>> +        int hash = ac->ac_inode->i_ino % sbi->s_mb_nr_global_goals;
>>>> +
>>>> +        ac->ac_g_ex.fe_group = READ_ONCE(sbi->s_mb_last_groups[hash]);
>>>> +        ac->ac_g_ex.fe_start = -1;
>>>> +        ac->ac_flags &= ~EXT4_MB_HINT_TRY_GOAL;
>>> Rotating block allocation looks a lot like stream allocation—they both
>>> pick up from where the last successful allocation left off.
>>>
>>> I noticed that the stream allocation's global goal is now split up.
>>> Is there an advantage to keeping it as a single goal?
>>> Alternatively, do you see any downsides to this split in your use case?
>>>
>>>

