Return-Path: <linux-ext4+bounces-13520-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPVoJ6krg2kxigMAu9opvQ
	(envelope-from <linux-ext4+bounces-13520-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 04 Feb 2026 12:21:13 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC09E5053
	for <lists+linux-ext4@lfdr.de>; Wed, 04 Feb 2026 12:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB2FE306E80E
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Feb 2026 11:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C042E3E9F7A;
	Wed,  4 Feb 2026 11:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rocketmail.com header.i=@rocketmail.com header.b="Z+xs1FzL"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sonic310-23.consmr.mail.ne1.yahoo.com (sonic310-23.consmr.mail.ne1.yahoo.com [66.163.186.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F0A3E9F71
	for <linux-ext4@vger.kernel.org>; Wed,  4 Feb 2026 11:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770203782; cv=none; b=A4nJda7ceDIvYCs97mS1kcrfd9UpsJYLRLQcr7mEg8tN6FkoDE54qz8YApNUmKfkgpKoHYREnKZ66WdDBzoOeFe5b47hP397I9BD8/wVl1GJnBqRM4l02VVpQqEMB1XdkNMvW6Xir419SQ+Fu9jx3hB6wk+0qhhCKQBqkBfwsBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770203782; c=relaxed/simple;
	bh=2MoUNAGtYXgaGyB0/7vBy3vkEQOJPhrZJ61Qi4GP+jk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t4xC4frDrx16nlxVnw1xxvOWmkNcuWxXoBat2dERcA51GH/ndCKGIwnq4ViC2L+WnFIZ2RqRDNMC+8RfPzZPoqAdKK0mVPIZe8Ybuuv9U+rtn/5weGM4Lj+gp0bdZDqSNRvFkeJP5X3it/D8wfiEeILC0wUi1sSxqO3OE9VHIZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rocketmail.com; spf=pass smtp.mailfrom=rocketmail.com; dkim=pass (2048-bit key) header.d=rocketmail.com header.i=@rocketmail.com header.b=Z+xs1FzL; arc=none smtp.client-ip=66.163.186.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rocketmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rocketmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1770203780; bh=gHf3DRPGWXzP6lMmqKLeT8/yo+/426F0lUU0bhO2JwA=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Z+xs1FzLL0pQ6q/8mkLh9WWU+O+gM/J6UHSwESI0C466sjFgAWDOTG6PEGGQRao5U96AAIV2867Bi+StZhcL4M//4tYerlBmOkWyBcXK4+x2gXtxa/mckSevfC4M8V0IMauJnEMg+IJiqNJbe4wsBiiQgBfL6dfaCKLP5rTh0pe12V1zjmW0bP2knhTru1YWbB5WpuHFiaxUDlse7fZ+U5uGsjkA4MsTwaM8Fzggos1IyX9dzjjVKk4QEE4QIlKwGAMHw4vCo2GhK4eYtOv6wxOvw8aUp/euWVVXS+KIiLgF2TX0NYplb3G4Iy4hJX+vPcw7j4sqzQc0saTmINP49Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1770203781; bh=XTUi4s033hSX7cCKAJK7S/bb2Rw+GFtoXe0khHbormC=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=scRptlmpAvKnYzqaFJbNK2Xn/327sIZiZ33mgdno++gi9ZEk7Ky6TYA5Vq2JG5HbKb3GORDbkCCknoXbViKBJQUqVyNhJnWDlG5oxrxw9BNVU7QHAVfimbYBfedw/BkZri93womX2+GWWCBvjgvyVyeUP51RexpRJcc6nt6NEegGHKrAuTjJ1dapSo9IJWK03rgWhRRk3Naxa7mzZAJF0dPO0nl79TIa+opl52AxIFEGSVoDMSFxqJwS7xeVn3J82jeV86kgS/U/nfBiTJzHqd6Fuzd9ZFuX9ZHvj01QhaBfvZnY1ywua+Y8o5S1qJLCVP0MNsIPDBW/GOHbn7rZcQ==
X-YMail-OSG: dACNlR0VM1m.XaOR.Eoo1oa8cB8fqrb5xVYnsSjYiST0MPt6KQpgnRCuz4lefZt
 LGz8MxvMUs2NXVQVKgkptgnTMOFmrQ0wkI68m67zW4ZAHWHiDMdgH5Xdv4FyvMk0LAC4TmSzGkUw
 W3cymiYXoOYJk7gPIjnzYqmjGSri5yTEMPfCxJzv8r6wCeTgQPy7j.8O4Z1xN8ONlp0dTTufPJl9
 HsIk8YhL3DNaS6Gy3gI5yoIgT4Ok6wut9c0JZDKi_n6wz8.YxykuUXMAkY5.MfyLWaBCq8OzxbTX
 1ZZvzBIrBRtu4E7531EU.S7AxgATnzBMB6ELI0dM3shI8MAPFCvWw5Bfqe0fCmZ_8I8_SHMV1CFB
 yxMhzEfmgaKGZOovCpo9Dy7eomshxYu2oZPa9SREkG5CEvk1gFpE1bTBMrsvo7i8OHjQ0vq4BgAI
 A.DYpTwZZVBYCkGtbsRX0rMnOin2Q2WPLtwk4aeJTePOKsuGAIQo2RbCTsTpatuQto8F4sf9H9Rb
 erQmbMoe5FhzvI9x.pbHHIrMkuO4hhdSeq6mw5cUptrnksxQIbwbew0BAE_XQF1QqQ8K5urngw9B
 C3S69AKGCneNXkJO_w4RmskKrDLtZ13RDi4lwiLDPcyu4CaLEg.XEGQ4Qkz5L9rF4fjegMwk6AAy
 cdSlg9HudbclSd.RsyQwE3sXv.eEtviKggnRZUpfql6t5AZsgzINbjyey.4Ivg.sAoWR19JiowBO
 JuNgNgLetjcfjj6rLkfJM51V1anBgbXt4h35DZWvGxldPu_CVwHwmgcXJaJpYXd72nZhRQLQDb2E
 pM8_5tkDsFNt_kCUznfNG80WieCrwOmy3TfwK2AM32fLXBXoKJARWQXbXwOFNukz1bzHr9z7XyVI
 8nJ03WfDYUkdVKGlI6ftYtemLy3iRGVLhCF627OZQ8Nm2Nw8FEWdXGBqKtXx3cpYkBmq2xV95w6K
 htrlZ6sIdpZ1Xc1SBJg01_xp7PqNATQrGKwWqxlJTjyfDKrrDkHD.M7pTBIsXkNbcmkCQ3uUbEX8
 u6z_2P2WSxURnjNCj.UDXKFMphZg521Rrk2DdnOu_tt8MHr.irEeE2a_junnsBTe4MDoaMEuywz1
 .7WeOSyTLGuRD.DHmufWv9ZenuzGQ9wLnLil7.tHbP5EareU5Rv_aXnXI.ffhJ.Uo6tl2NS38N_A
 lAaWmuO6rguoQfFQlnXpIDl4RGmfKo9YuWzkqOccVSQKAkmho3ygCV.V6l36l0.pPgDbGFgzRAWs
 AqRcaMFB2ojH6oBWGBbIrN8r3k42hh8w0yxND7y.QHKczsGg911tDoqb9MMi_ocedtyEt3QiUP70
 .aULdqYB.vh2boluF7o8aqofGemTL0awhJ7R.dIr8H1ZnQ9q6CdPYoXP5PEsP0Rbj26oXBmQ9I0K
 bePWRBvMIW_5qWbk8ULut1hZrMStELxs2Um0WBSEiBbx9wr_VXJCVzLLOHXY2dyPXOw5Zys77J1W
 aECBeXdWHhGcd_ypt2_n6WNFBio660NbdP4smNizCUpaxQK5gJt96o1xHeiwLUjTP8zsz6y6tMLL
 e_ORUxMIt4ZtX6lCDkLl2gu1ciu2REfm5Z5AWag6uo_i5qo4q4GDft47MQtkrBTpr8r4ZZUvnMid
 acYRLl0alF3dDAVu2L2heMoo1_fziA3SHj7hsW4NtV.mR.Ff.KfBltrOfwa7VD_Ba1IN6lELdJJz
 U6_Mhdz2UnAhuDCD7tLR5TosC0f35eV0Y.AK5q6zp2lN6J2YUsfMYuw0IUsDPJ06ld9F1GL8az5n
 EDQVoXIAEGFt0Iczq5hrlMGwEr5aiJ2TKRcTSfxpUrAX40ZM1sDa5mR_YlCoXy.LyjCTeizUvbjf
 yjp83vU1cxTW9SC1Z5QEsNkwXLeR1nLRfS2KAFnXfLPiSoBlt92ytVIej60ziIMUxfdtyjjCud21
 ISotQ3Gslv.p6YoJ4DhkQBUPBXRdRDm9pEGEdBE2nxmqv4WQ.TLiwbx3oJM5ZzA91Toh.B.FuySR
 Y6LN6WUMb51tbk57lvWGH6SS9j3ZINT2JJ5gQsJwHOnDEzBtnjY_CUjnt3yyyerziv90XpeYZGxg
 9shaMgv1pKU9kxihoEpbozf91mlw5HmXg_atT5Yw.Zh4oo_aBo.JN4en8E6zt5thNACiuKxUmR45
 7FmiYpDPvlYZfZMewevBOfqoG_lJWt_CacUsLH0X2qtWV0RaheOFumMvNPjdW_Be27PQrmJCdu.T
 L4sDMBDOBLVlprXqB.f7ZXI0-
X-Sonic-MF: <mario_lohajner@rocketmail.com>
X-Sonic-ID: e3a48ab8-24ac-46c7-94fd-7d46b6fa9b4c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Wed, 4 Feb 2026 11:16:20 +0000
Received: by hermes--production-ir2-6fcf857f6f-7nlzs (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 3a385038dd1f8e7df3cc695c5e9d85a3;
          Wed, 04 Feb 2026 11:06:11 +0000 (UTC)
Message-ID: <069704a4-2417-470a-bf32-0ee3afd1be6a@rocketmail.com>
Date: Wed, 4 Feb 2026 12:06:09 +0100
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
Content-Language: hr
From: Mario Lohajner <mario_lohajner@rocketmail.com>
In-Reply-To: <c6a3faa7-299a-4f10-981d-693cdf55b930@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.25116 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
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
	FREEMAIL_CC(0.00)[dilger.ca,vger.kernel.org,huawei.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-13520-lists,linux-ext4=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rocketmail.com:email,rocketmail.com:dkim,rocketmail.com:mid]
X-Rspamd-Queue-Id: DCC09E5053
X-Rspamd-Action: no action

Hello Baokun Li,

This response was originally intended for Andreas.
I'm sending you the full copy to provide context for your query,
rather than writing a separate response.

Yes, the main motive for this allocator is flash wear leveling,
but it is not strictly a wear leveling mechanism, and it is not named
as such for a reason.
Wear leveling may (or may not) exist at the device/hardware level.
The goal of this policy is not to "fix" that.

This policy helps avoid allocation hotspots at mount start by
distributing allocations sequentially across the entire mount,
not just a file or allocation stream.

At the block/group allocation level, the file system is fairly stochastic
and timing-sensitive. Rather than providing raw benchmark data, I prefer
to explain the design analytically:
The vectored separation of the new allocator ensures that the performance
of the regular allocator is maintained (literally unchanged).
The overhead of the new rotating allocator is minimal and occurs outside
of the "hot loop":
the cursor is retrieved early at the start, updated upon successful 
allocation,
and is negligible with respect to IO latency.
Because allocations proceed sequentially, latency is comparable to
or better than the regular allocator.
Having separated allocators increases maintainability and independence
with minimal (virtually no) overhead.

This policy benefits workloads with frequent large or small allocations,
while keeping file fragmentation and slack space minimal.
It is a conscious trade-off: sacrificing locality in favor of reinforced 
sequentiality.
Of course, this is not optimal for classic HDDs, but NVMe drives behave 
differently.
For this reason, the policy is optional per mount, turned off by default,
and can be toggled at mount time.

Best regards,
Mario

On 04. 02. 2026. 07:29, Baokun Li wrote:
> On 2026-02-04 11:31, Mario Lohajner wrote:
>> Add support for the rotalloc allocation policy as a new mount
>> option. Policy rotates the starting block group for new allocations.
>>
>> Changes:
>> - fs/ext4/ext4.h
>> 	rotalloc policy dedlared, extend sb with cursor, vector & lock
>>
>> - fs/ext4/mballoc.h
>> 	expose allocator functions for vectoring in super.c
>>
>> - fs/ext4/super.c
>> 	parse rotalloc mnt opt, init cursor, lock and allocator vector
>>
>> - fs/ext4/mballoc.c
>> 	add rotalloc allocator, vectored allocator call in new_blocks
>>
>> The policy is selected via a mount option and does not change the
>> on-disk format or default allocation behavior. It preserves existing
>> allocation heuristics within a block group while distributing
>> allocations across block groups in a deterministic sequential manner.
>>
>> The rotating allocator is implemented as a separate allocation path
>> selected at mount time. This avoids conditional branches in the regular
>> allocator and keeps allocation policies isolated.
>> This also allows the rotating allocator to evolve independently in the
>> future without increasing complexity in the regular allocator.
>>
>> The policy was tested using v6.18.6 stable locally with the new mount
>> option "rotalloc" enabled, confirmed working as desribed!
>>
>> Signed-off-by: Mario Lohajner <mario_lohajner@rocketmail.com>
>> ---
>>   fs/ext4/ext4.h    |   8 +++
>>   fs/ext4/mballoc.c | 152 ++++++++++++++++++++++++++++++++++++++++++++--
>>   fs/ext4/mballoc.h |   3 +
>>   fs/ext4/super.c   |  18 +++++-
>>   4 files changed, 175 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
>> index 56112f201cac..cbbb7c05d7a2 100644
>> --- a/fs/ext4/ext4.h
>> +++ b/fs/ext4/ext4.h
>> @@ -229,6 +229,9 @@ struct ext4_allocation_request {
>>   	unsigned int flags;
>>   };
>>   
>> +/* expose rotalloc allocator argument pointer type */
>> +struct ext4_allocation_context;
>> +
>>   /*
>>    * Logical to physical block mapping, used by ext4_map_blocks()
>>    *
>> @@ -1230,6 +1233,7 @@ struct ext4_inode_info {
>>    * Mount flags set via mount options or defaults
>>    */
>>   #define EXT4_MOUNT_NO_MBCACHE		0x00001 /* Do not use mbcache */
>> +#define EXT4_MOUNT_ROTALLOC			0x00002 /* Use rotalloc policy/allocator */
>>   #define EXT4_MOUNT_GRPID		0x00004	/* Create files with directory's group */
>>   #define EXT4_MOUNT_DEBUG		0x00008	/* Some debugging messages */
>>   #define EXT4_MOUNT_ERRORS_CONT		0x00010	/* Continue on errors */
>> @@ -1559,6 +1563,10 @@ struct ext4_sb_info {
>>   	unsigned long s_mount_flags;
>>   	unsigned int s_def_mount_opt;
>>   	unsigned int s_def_mount_opt2;
>> +	/* Rotalloc cursor, lock & new_blocks allocator vector */
>> +	unsigned int s_rotalloc_cursor;
>> +	spinlock_t s_rotalloc_lock;
>> +	int (*s_mb_new_blocks)(struct ext4_allocation_context *ac);
>>   	ext4_fsblk_t s_sb_block;
>>   	atomic64_t s_resv_clusters;
>>   	kuid_t s_resuid;
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index 56d50fd3310b..74f79652c674 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -2314,11 +2314,11 @@ static void ext4_mb_check_limits(struct ext4_allocation_context *ac,
>>    *   stop the scan and use it immediately
>>    *
>>    * * If free extent found is smaller than goal, then keep retrying
>> - *   upto a max of sbi->s_mb_max_to_scan times (default 200). After
>> + *   up to a max of sbi->s_mb_max_to_scan times (default 200). After
>>    *   that stop scanning and use whatever we have.
>>    *
>>    * * If free extent found is bigger than goal, then keep retrying
>> - *   upto a max of sbi->s_mb_min_to_scan times (default 10) before
>> + *   up to a max of sbi->s_mb_min_to_scan times (default 10) before
>>    *   stopping the scan and using the extent.
>>    *
>>    *
>> @@ -2981,7 +2981,7 @@ static int ext4_mb_scan_group(struct ext4_allocation_context *ac,
>>   	return ret;
>>   }
>>   
>> -static noinline_for_stack int
>> +noinline_for_stack int
>>   ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
>>   {
>>   	ext4_group_t i;
>> @@ -3012,7 +3012,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
>>   	 * is greater than equal to the sbi_s_mb_order2_reqs
>>   	 * You can tune it via /sys/fs/ext4/<partition>/mb_order2_req
>>   	 * We also support searching for power-of-two requests only for
>> -	 * requests upto maximum buddy size we have constructed.
>> +	 * requests up to maximum buddy size we have constructed.
>>   	 */
>>   	if (i >= sbi->s_mb_order2_reqs && i <= MB_NUM_ORDERS(sb)) {
>>   		if (is_power_of_2(ac->ac_g_ex.fe_len))
>> @@ -3101,6 +3101,144 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
>>   	return err;
>>   }
>>   
>> +/* Rotating allocator (rotalloc mount option) */
>> +noinline_for_stack int
>> +ext4_mb_rotating_allocator(struct ext4_allocation_context *ac)
>> +{
>> +	ext4_group_t i, goal;
>> +	int err = 0;
>> +	struct super_block *sb = ac->ac_sb;
>> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
>> +	struct ext4_buddy e4b;
>> +
>> +	BUG_ON(ac->ac_status == AC_STATUS_FOUND);
>> +
>> +	/* Set the goal from s_rotalloc_cursor */
>> +	spin_lock(&sbi->s_rotalloc_lock);
>> +	goal = sbi->s_rotalloc_cursor;
>> +	spin_unlock(&sbi->s_rotalloc_lock);
>> +	ac->ac_g_ex.fe_group = goal;
>> +
>> +	/* first, try the goal */
>> +	err = ext4_mb_find_by_goal(ac, &e4b);
>> +	if (err || ac->ac_status == AC_STATUS_FOUND)
>> +		goto out;
>> +
>> +	if (unlikely(ac->ac_flags & EXT4_MB_HINT_GOAL_ONLY))
>> +		goto out;
>> +
>> +	/*
>> +	 * ac->ac_2order is set only if the fe_len is a power of 2
>> +	 * if ac->ac_2order is set we also set criteria to CR_POWER2_ALIGNED
>> +	 * so that we try exact allocation using buddy.
>> +	 */
>> +	i = fls(ac->ac_g_ex.fe_len);
>> +	ac->ac_2order = 0;
>> +	/*
>> +	 * We search using buddy data only if the order of the request
>> +	 * is greater than equal to the sbi_s_mb_order2_reqs
>> +	 * You can tune it via /sys/fs/ext4/<partition>/mb_order2_req
>> +	 * We also support searching for power-of-two requests only for
>> +	 * requests up to maximum buddy size we have constructed.
>> +	 */
>> +	if (i >= sbi->s_mb_order2_reqs && i <= MB_NUM_ORDERS(sb)) {
>> +		if (is_power_of_2(ac->ac_g_ex.fe_len))
>> +			ac->ac_2order = array_index_nospec(i - 1,
>> +							   MB_NUM_ORDERS(sb));
>> +	}
>> +
>> +	/* if stream allocation is enabled, use global goal */
>> +	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC) {
>> +		int hash = ac->ac_inode->i_ino % sbi->s_mb_nr_global_goals;
>> +
>> +		ac->ac_g_ex.fe_group = READ_ONCE(sbi->s_mb_last_groups[hash]);
>> +		ac->ac_g_ex.fe_start = -1;
>> +		ac->ac_flags &= ~EXT4_MB_HINT_TRY_GOAL;
> Rotating block allocation looks a lot like stream allocation—they both
> pick up from where the last successful allocation left off.
>
> I noticed that the stream allocation's global goal is now split up.
> Is there an advantage to keeping it as a single goal?
> Alternatively, do you see any downsides to this split in your use case?
>
>

