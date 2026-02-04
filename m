Return-Path: <linux-ext4+bounces-13521-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DdED1ctg2kwjAMAu9opvQ
	(envelope-from <linux-ext4+bounces-13521-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 04 Feb 2026 12:28:23 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4C4E51CB
	for <lists+linux-ext4@lfdr.de>; Wed, 04 Feb 2026 12:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EACE300EAAE
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Feb 2026 11:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4503B8BCB;
	Wed,  4 Feb 2026 11:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rocketmail.com header.i=@rocketmail.com header.b="PIB63o/x"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sonic311-23.consmr.mail.ne1.yahoo.com (sonic311-23.consmr.mail.ne1.yahoo.com [66.163.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E803E9F61
	for <linux-ext4@vger.kernel.org>; Wed,  4 Feb 2026 11:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770204500; cv=none; b=ncXy9ZZ4rUsNVIj2Pyke3i0qkkzFMgT6LPm2y7JYI922oOoZ+r2uzyd7BB1nxcRp431f7Gk+vewdWHG7S5e/Ls2XmVGTuy3Fe1Ethg8aUwTfRmGJ0Ttb1+iSZCuckcyFyfRxMsIO/6S09jqbEFJocM1KU+YVdWQw/eTq3l2FAfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770204500; c=relaxed/simple;
	bh=XlK10AUDGe4WqvjNhruSkBCPSUbiKw/xlBa+wje2R34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SQ0eu/d6FmtJglSyQomnC0s1IKBi1tPICTLDFaVe6v1XtWwcCDsi6mR4MLyWde0JEivQwHIntgmRwtMUjyEA3fLn3AtlK96v/7Hm+IHJsUERKj+iMT8wboiVfUCEvhaadrbRAgcP6S3N9fU5OkU8zdV7Qvd5TsNkQdHhUQrcJE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rocketmail.com; spf=pass smtp.mailfrom=rocketmail.com; dkim=pass (2048-bit key) header.d=rocketmail.com header.i=@rocketmail.com header.b=PIB63o/x; arc=none smtp.client-ip=66.163.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rocketmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rocketmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1770204499; bh=OQUIANMr5mnkK8DzlxbBMhwSWq8uNjI5nxH+86vkKBM=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=PIB63o/x18jzzAVAay9GS5qi9ByeOfEK58tpEWpt7lxHUJC8lHvTpjWro5zJtGo5VAAJrpcgDqbz1HrSzJ+93yAgwJ5g49duWFGTjuxUTwZ7QHn0F1LNJOCQWIwPl0kCc6ISFqnazVXGduHhcQvtQfKhZDyea1bw/UWOBCEw95fe25dHfKnNlImFqnzv9Xbm6jznKofPM0lqfdL3WqMBdM/vceHighrR4QCI3mFxV1uBQ64LE0HkI02LOzg51s8MXRcn1qL+X7HsXwNgIhLScouWl/5WwcZaxVYVdZFVc7VNhoCyN82ZvDqQB27vjm2Y4O1SXzoY5GlJtV5b0yDjbg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1770204499; bh=SF2cQmJzoi9Z1G8XO0yvo+rZ26DpDIQwRoI4iB68Fkh=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=sCkbprarIPE/ZFA5zMFUHrR/hNTzqgAhoEmbTBvu6qivg7VfsVzqL0s8x6AlUYVt+lIf2oKGd1I2nTGATsNN+M9DEAEP8vDmEnM4s4GQgZ4evdkC0XeWTzL0z0oK70rwP+gyOxartd7syHvvH9GMR+Kkk9PxsVGaKw8ZcbXbVhsHt0QsAUXwJSUJwdCKvuhQv2vqD40EOWkFpfZF3jfbY6kZS+wPV8rQtu9SbxhTt/mbbdZfc+323NKQrQWN7kjrRVY71oa9GF3LKWFIg0IGv3P/xHVg0jC2aKicEd4/3AABWXyWN6T/Xe8arlEioI5cOlRe8bw1l5LAjL96cES/Kg==
X-YMail-OSG: IyLXC1cVM1lc.YabXAiNPSiezVEF8ivj3rt5WVw0gsMK0M2uQRtkIhUVCl0LHh8
 hJVPcmTUgOp9t0t0tSOKzoDmf3_MrCOzeqdDYYgxKRp7WvLQ_wlPKzb1vD6PUV2Cpy1yQqo8LrRU
 HplNO7z8Z32bkVWcGXNIlv36fDTHTomYEINgnlfxQJamVpuBFt7DEa2aSjRyVnTrrqjkL84fM3Eb
 8ArnjmPWQsq1PdxEFlS2xnqnpLZfxrdGCiNTvMfQD572FXjk9LDV3LHHMDcb8J5IU8GrlYVRoCnn
 GaLrtCEKidrFYA89NeBDjlKchemw_GvSJ2IR6GrsdP3Q_Ef6JR0RF_qR_PrLMPPkpLtuMhD9j_pf
 nzhmMOP2AYi0Uxpk3FDVrQKHamIUywuX9LNv5c8z4i1AuMbk80Ha7SFEMMeirFtzqgmN6Bx0587c
 R4LFr5Uivs.Gx0ce.UbBQGEPPIM4gYVhdb5adHghdNdFqWMAZgB7lzjzqjaqYEQTMslHc8789jcm
 P63rxnUKHVOTvQWFZbG9J2TePgY6pvRSZXj65oynn5UqY48FgfrjwhcMpl9SPGEytQ.MveEzRjBJ
 3zGh2aJueFf3YGTt0i_zkwj59bKjEKfSTxz1XlCLK_yvV_9cOvlHfjhS8FDf2s8MYPefLH_JJpF_
 Ol3pkEqJFE2R6f2X2buRZ49RUkG72pXyMlRjKVee7YqRaHmS2sPf1RooceyuV80sphWF54DzpQY6
 hqxFkBEPoMicurz2t8CmUqyPZGc1SZgW6aUF_vdI.Ol99_At6HvgskB60BJZWH2aVOaYMsripuW6
 mTxBbBhREHrYJHlsLjDipnSB6EioRH6sGB6hgG8v1UpLTCUwEWmcVdTo28_SnUb8SskYhqZ8ogj.
 o7IFJPEApPxuX2C5.XPCsXvupSQt6ghIq08b6cbFEaI1OlrgkT9J.Nyu2L2ukPvdR.89WDpmh5IT
 qmQkhEubKGm.yVp7CwdRsCdHpkOG6CzjV9B4fGVq9Eea_SMpg.waJNWeSYpY4wsQt.vUB_AGzvE.
 tlMKxRrl7h0FZLodFQsjd.5gcWtQOMIcTHEnyOwHGA1PX4KIFfHI6kZ0NXDNhNz8rqnQvUkQPMwY
 cClBU1mwof6gnpW.jRRRJGpNNdu_fPLCLzFlgi5uEK7l.frijMbeImp75egny5tffwWoEOlwtANY
 nuoM4vBqjTDdhODbUvuF3e2D6rZxsc0qQi53NJ_zCnEHe6T871UK.lMdjENJT1Cu4Hed80zrP4eR
 eH_CaPtURBUMsFV5ohN5I8vQzwNaQliockml3UJLamxrh4SiSaKeGVRFSptlufbR2coeHS4G8b_q
 5HvMXirlOFl45BhMPsNY.RI3z7g6.ahYeceSEujPgd8sarud7m6Ox8yfEagFtLhopIcxCJWuC5I5
 dA7RMqNO3CwcRxXM5MjiJ6w5WGdNIG9P5bYJUmuPAGj5vcX1XGH3E6LrWIAVJCT5ekbNJAdqAn56
 E4PncUp5jUi8YqzQFAPd7Vyp7AOlpLNmyjPcohECTJM6YhMtmsTbNWXMwgmTBjzIUMAHiDNyYK2o
 UdRreOr3UMXMr45lx0qhocH1DxcDQHGNEsT38KWIrCBrLecrOqd4JRZmtWrrTeAcuXR3EgfMPX8f
 aVdQND5RqcEwemhluaVNYsfr_pGAizTz8180212gupCPXOZff3v3OEK3YhUpojrz391m1z5xNysZ
 Dwwas65jGbGQC7BLJGdbU9dLNsAH5KcDuVKDzwpcie.Ci8m_1S5NZc_yc5pAtwJFWYkT5hmAPqRj
 DANRM91hrXggyU7q7gTwf1slE6iGH9akDVJTBqG34AmciF8TSObwi08CAOueb_cqMuqPygH.JHkL
 c89s87H0od3D6FB_Snd9LyUOMLDQwnAd3zx2zkiwQ_CPtU5jOZvmJByeS8DM2mdQuomkUaZuMqR3
 ORAVltjDE6YHlcP_Cm_mvkUx5XD.d7XrZetqym.0f8nDfScakK8Zz.TvcVSjCpFmU.u5PLnAjfY9
 Kgyp2KV7vs9Hf0E72VacEhvXX9TUvKzAsK4231AhD7Fc5ZmR5ZGAwJkGxHvPiVO9PjNoDLVl1Ibv
 PP9gUROz7jNxwkMpKp5UWaSPGwWyq3Jt9xv30f4E1p7slcCwUU3wAEMn5leKJ9T72cvKQ5GstWZK
 Xdp_ErhtdfuJE8rXvbp1e68ciLUIwID5MLdUSRtvp9PiPJSXy6Pugq76Rm5TSVbSCIZYJxvc3HaS
 oR7e1stSBxVA6pRo-
X-Sonic-MF: <mario_lohajner@rocketmail.com>
X-Sonic-ID: 27cab2aa-cf9b-45c9-9ccd-e697cabbf065
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Wed, 4 Feb 2026 11:28:19 +0000
Received: by hermes--production-ir2-6fcf857f6f-pxlwd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 32fbc587afef595e15878218e5e4ac8c;
          Wed, 04 Feb 2026 11:07:59 +0000 (UTC)
Message-ID: <c00064e6-a3d4-4f91-a50b-053db07c7d33@rocketmail.com>
Date: Wed, 4 Feb 2026 12:07:57 +0100
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: add optional rotating block allocation policy
Content-Language: hr
To: Andreas Dilger <adilger@dilger.ca>
Cc: tytso@mit.edu, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260204033112.406079-1-mario_lohajner.ref@rocketmail.com>
 <20260204033112.406079-1-mario_lohajner@rocketmail.com>
 <C3DAF83A-CE88-4348-BCE2-237960F3CD9D@dilger.ca>
From: Mario Lohajner <mario_lohajner@rocketmail.com>
In-Reply-To: <C3DAF83A-CE88-4348-BCE2-237960F3CD9D@dilger.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13521-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[rocketmail.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[rocketmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mario_lohajner@rocketmail.com,linux-ext4@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-ext4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rocketmail.com:email,rocketmail.com:dkim,rocketmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7F4C4E51CB
X-Rspamd-Action: no action

Hello Andreas,

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

On 04. 02. 2026. 04:53, Andreas Dilger wrote:
> On Feb 3, 2026, at 20:31, Mario Lohajner <mario_lohajner@rocketmail.com> wrote:
>> Add support for the rotalloc allocation policy as a new mount
>> option. Policy rotates the starting block group for new allocations.
>>
>> Changes:
>> - fs/ext4/ext4.h
>> rotalloc policy dedlared, extend sb with cursor, vector & lock
>>
>> - fs/ext4/mballoc.h
>> expose allocator functions for vectoring in super.c
>>
>> - fs/ext4/super.c
>> parse rotalloc mnt opt, init cursor, lock and allocator vector
>>
>> - fs/ext4/mballoc.c
>> add rotalloc allocator, vectored allocator call in new_blocks
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
> Hi Mario,
> can you please provide some background/reasoning behind this allocator?
> I suspect there are good reasons/workloads that could benefit from it
> (e.g. flash wear leveling), but that should be stated in the commit
> message, and preferably with some benchmarks/measurements that show
> some benefit from adding this feature.
>
> Cheers, Andreas
>
>> Signed-off-by: Mario Lohajner <mario_lohajner@rocketmail.com>
>> ---
>> fs/ext4/ext4.h    |   8 +++
>> fs/ext4/mballoc.c | 152 ++++++++++++++++++++++++++++++++++++++++++++--
>> fs/ext4/mballoc.h |   3 +
>> fs/ext4/super.c   |  18 +++++-
>> 4 files changed, 175 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
>> index 56112f201cac..cbbb7c05d7a2 100644
>> --- a/fs/ext4/ext4.h
>> +++ b/fs/ext4/ext4.h
>> @@ -229,6 +229,9 @@ struct ext4_allocation_request {
>> unsigned int flags;
>> };
>>
>> +/* expose rotalloc allocator argument pointer type */
>> +struct ext4_allocation_context;
>> +
>> /*
>>   * Logical to physical block mapping, used by ext4_map_blocks()
>>   *
>> @@ -1230,6 +1233,7 @@ struct ext4_inode_info {
>>   * Mount flags set via mount options or defaults
>>   */
>> #define EXT4_MOUNT_NO_MBCACHE 0x00001 /* Do not use mbcache */
>> +#define EXT4_MOUNT_ROTALLOC 0x00002 /* Use rotalloc policy/allocator */
>> #define EXT4_MOUNT_GRPID 0x00004 /* Create files with directory's group */
>> #define EXT4_MOUNT_DEBUG 0x00008 /* Some debugging messages */
>> #define EXT4_MOUNT_ERRORS_CONT 0x00010 /* Continue on errors */
>> @@ -1559,6 +1563,10 @@ struct ext4_sb_info {
>> unsigned long s_mount_flags;
>> unsigned int s_def_mount_opt;
>> unsigned int s_def_mount_opt2;
>> + /* Rotalloc cursor, lock & new_blocks allocator vector */
>> + unsigned int s_rotalloc_cursor;
>> + spinlock_t s_rotalloc_lock;
>> + int (*s_mb_new_blocks)(struct ext4_allocation_context *ac);
>> ext4_fsblk_t s_sb_block;
>> atomic64_t s_resv_clusters;
>> kuid_t s_resuid;
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index 56d50fd3310b..74f79652c674 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -2314,11 +2314,11 @@ static void ext4_mb_check_limits(struct ext4_allocation_context *ac,
>>   *   stop the scan and use it immediately
>>   *
>>   * * If free extent found is smaller than goal, then keep retrying
>> - *   upto a max of sbi->s_mb_max_to_scan times (default 200). After
>> + *   up to a max of sbi->s_mb_max_to_scan times (default 200). After
>>   *   that stop scanning and use whatever we have.
>>   *
>>   * * If free extent found is bigger than goal, then keep retrying
>> - *   upto a max of sbi->s_mb_min_to_scan times (default 10) before
>> + *   up to a max of sbi->s_mb_min_to_scan times (default 10) before
>>   *   stopping the scan and using the extent.
>>   *
>>   *
>> @@ -2981,7 +2981,7 @@ static int ext4_mb_scan_group(struct ext4_allocation_context *ac,
>> return ret;
>> }
>>
>> -static noinline_for_stack int
>> +noinline_for_stack int
>> ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
>> {
>> ext4_group_t i;
>> @@ -3012,7 +3012,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
>> * is greater than equal to the sbi_s_mb_order2_reqs
>> * You can tune it via /sys/fs/ext4/<partition>/mb_order2_req
>> * We also support searching for power-of-two requests only for
>> - * requests upto maximum buddy size we have constructed.
>> + * requests up to maximum buddy size we have constructed.
>> */
>> if (i >= sbi->s_mb_order2_reqs && i <= MB_NUM_ORDERS(sb)) {
>> if (is_power_of_2(ac->ac_g_ex.fe_len))
>> @@ -3101,6 +3101,144 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
>> return err;
>> }
>>
>> +/* Rotating allocator (rotalloc mount option) */
>> +noinline_for_stack int
>> +ext4_mb_rotating_allocator(struct ext4_allocation_context *ac)
>> +{
>> + ext4_group_t i, goal;
>> + int err = 0;
>> + struct super_block *sb = ac->ac_sb;
>> + struct ext4_sb_info *sbi = EXT4_SB(sb);
>> + struct ext4_buddy e4b;
>> +
>> + BUG_ON(ac->ac_status == AC_STATUS_FOUND);
>> +
>> + /* Set the goal from s_rotalloc_cursor */
>> + spin_lock(&sbi->s_rotalloc_lock);
>> + goal = sbi->s_rotalloc_cursor;
>> + spin_unlock(&sbi->s_rotalloc_lock);
>> + ac->ac_g_ex.fe_group = goal;
>> +
>> + /* first, try the goal */
>> + err = ext4_mb_find_by_goal(ac, &e4b);
>> + if (err || ac->ac_status == AC_STATUS_FOUND)
>> + goto out;
>> +
>> + if (unlikely(ac->ac_flags & EXT4_MB_HINT_GOAL_ONLY))
>> + goto out;
>> +
>> + /*
>> + * ac->ac_2order is set only if the fe_len is a power of 2
>> + * if ac->ac_2order is set we also set criteria to CR_POWER2_ALIGNED
>> + * so that we try exact allocation using buddy.
>> + */
>> + i = fls(ac->ac_g_ex.fe_len);
>> + ac->ac_2order = 0;
>> + /*
>> + * We search using buddy data only if the order of the request
>> + * is greater than equal to the sbi_s_mb_order2_reqs
>> + * You can tune it via /sys/fs/ext4/<partition>/mb_order2_req
>> + * We also support searching for power-of-two requests only for
>> + * requests up to maximum buddy size we have constructed.
>> + */
>> + if (i >= sbi->s_mb_order2_reqs && i <= MB_NUM_ORDERS(sb)) {
>> + if (is_power_of_2(ac->ac_g_ex.fe_len))
>> + ac->ac_2order = array_index_nospec(i - 1,
>> +   MB_NUM_ORDERS(sb));
>> + }
>> +
>> + /* if stream allocation is enabled, use global goal */
>> + if (ac->ac_flags & EXT4_MB_STREAM_ALLOC) {
>> + int hash = ac->ac_inode->i_ino % sbi->s_mb_nr_global_goals;
>> +
>> + ac->ac_g_ex.fe_group = READ_ONCE(sbi->s_mb_last_groups[hash]);
>> + ac->ac_g_ex.fe_start = -1;
>> + ac->ac_flags &= ~EXT4_MB_HINT_TRY_GOAL;
>> + }
>> +
>> + /*
>> + * Let's just scan groups to find more-less suitable blocks We
>> + * start with CR_GOAL_LEN_FAST, unless it is power of 2
>> + * aligned, in which case let's do that faster approach first.
>> + */
>> + ac->ac_criteria = CR_GOAL_LEN_FAST;
>> + if (ac->ac_2order)
>> + ac->ac_criteria = CR_POWER2_ALIGNED;
>> +
>> + ac->ac_e4b = &e4b;
>> + ac->ac_prefetch_ios = 0;
>> + ac->ac_first_err = 0;
>> +
>> + /* Be sure to start scanning with goal from s_rotalloc_cursor! */
>> + ac->ac_g_ex.fe_group = goal;
>> +repeat:
>> + while (ac->ac_criteria < EXT4_MB_NUM_CRS) {
>> + err = ext4_mb_scan_groups(ac);
>> + if (err)
>> + goto out;
>> +
>> + if (ac->ac_status != AC_STATUS_CONTINUE)
>> + break;
>> + }
>> +
>> + if (ac->ac_b_ex.fe_len > 0 && ac->ac_status != AC_STATUS_FOUND &&
>> +    !(ac->ac_flags & EXT4_MB_HINT_FIRST)) {
>> + /*
>> + * We've been searching too long. Let's try to allocate
>> + * the best chunk we've found so far
>> + */
>> + ext4_mb_try_best_found(ac, &e4b);
>> + if (ac->ac_status != AC_STATUS_FOUND) {
>> + int lost;
>> +
>> + /*
>> + * Someone more lucky has already allocated it.
>> + * The only thing we can do is just take first
>> + * found block(s)
>> + */
>> + lost = atomic_inc_return(&sbi->s_mb_lost_chunks);
>> + mb_debug(sb, "lost chunk, group: %u, start: %d, len: %d, lost: %d\n",
>> + ac->ac_b_ex.fe_group, ac->ac_b_ex.fe_start,
>> + ac->ac_b_ex.fe_len, lost);
>> +
>> + ac->ac_b_ex.fe_group = 0;
>> + ac->ac_b_ex.fe_start = 0;
>> + ac->ac_b_ex.fe_len = 0;
>> + ac->ac_status = AC_STATUS_CONTINUE;
>> + ac->ac_flags |= EXT4_MB_HINT_FIRST;
>> + ac->ac_criteria = CR_ANY_FREE;
>> + goto repeat;
>> + }
>> + }
>> +
>> + if (sbi->s_mb_stats && ac->ac_status == AC_STATUS_FOUND) {
>> + atomic64_inc(&sbi->s_bal_cX_hits[ac->ac_criteria]);
>> + if (ac->ac_flags & EXT4_MB_STREAM_ALLOC &&
>> +    ac->ac_b_ex.fe_group == ac->ac_g_ex.fe_group)
>> + atomic_inc(&sbi->s_bal_stream_goals);
>> + }
>> +out:
>> + if (!err && ac->ac_status != AC_STATUS_FOUND && ac->ac_first_err)
>> + err = ac->ac_first_err;
>> +
>> + mb_debug(sb, "Best len %d, origin len %d, ac_status %u, ac_flags 0x%x, cr %d ret %d\n",
>> + ac->ac_b_ex.fe_len, ac->ac_o_ex.fe_len, ac->ac_status,
>> + ac->ac_flags, ac->ac_criteria, err);
>> +
>> + if (ac->ac_prefetch_nr)
>> + ext4_mb_prefetch_fini(sb, ac->ac_prefetch_grp, ac->ac_prefetch_nr);
>> +
>> + if (!err) {
>> + /* Finally, if no errors, set the currsor to best group! */
>> + goal = ac->ac_b_ex.fe_group;
>> + spin_lock(&sbi->s_rotalloc_lock);
>> + sbi->s_rotalloc_cursor = goal;
>> + spin_unlock(&sbi->s_rotalloc_lock);
>> + }
>> +
>> + return err;
>> +}
>> +
>> static void *ext4_mb_seq_groups_start(struct seq_file *seq, loff_t *pos)
>> {
>> struct super_block *sb = pde_data(file_inode(seq->file));
>> @@ -6314,7 +6452,11 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
>> goto errout;
>> repeat:
>> /* allocate space in core */
>> - *errp = ext4_mb_regular_allocator(ac);
>> + /*
>> + * Use vectored allocator insead of fixed
>> + * ext4_mb_regular_allocator(ac) function
>> + */
>> + *errp = sbi->s_mb_new_blocks(ac);
>> /*
>> * pa allocated above is added to grp->bb_prealloc_list only
>> * when we were able to allocate some block i.e. when
>> diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
>> index 15a049f05d04..309190ce05ae 100644
>> --- a/fs/ext4/mballoc.h
>> +++ b/fs/ext4/mballoc.h
>> @@ -270,4 +270,7 @@ ext4_mballoc_query_range(
>> ext4_mballoc_query_range_fn formatter,
>> void *priv);
>>
>> +/* Expose rotating & regular allocators for vectoring */
>> +int ext4_mb_rotating_allocator(struct ext4_allocation_context *ac);
>> +int ext4_mb_regular_allocator(struct ext4_allocation_context *ac);
>> #endif
>> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>> index 87205660c5d0..f53501bbfb4b 100644
>> --- a/fs/ext4/super.c
>> +++ b/fs/ext4/super.c
>> @@ -1673,7 +1673,7 @@ enum {
>> Opt_nomblk_io_submit, Opt_block_validity, Opt_noblock_validity,
>> Opt_inode_readahead_blks, Opt_journal_ioprio,
>> Opt_dioread_nolock, Opt_dioread_lock,
>> - Opt_discard, Opt_nodiscard, Opt_init_itable, Opt_noinit_itable,
>> + Opt_discard, Opt_nodiscard, Opt_init_itable, Opt_noinit_itable, Opt_rotalloc,
>> Opt_max_dir_size_kb, Opt_nojournal_checksum, Opt_nombcache,
>> Opt_no_prefetch_block_bitmaps, Opt_mb_optimize_scan,
>> Opt_errors, Opt_data, Opt_data_err, Opt_jqfmt, Opt_dax_type,
>> @@ -1797,6 +1797,7 @@ static const struct fs_parameter_spec ext4_param_specs[] = {
>> fsparam_u32 ("init_itable", Opt_init_itable),
>> fsparam_flag ("init_itable", Opt_init_itable),
>> fsparam_flag ("noinit_itable", Opt_noinit_itable),
>> + fsparam_flag ("rotalloc", Opt_rotalloc),
>> #ifdef CONFIG_EXT4_DEBUG
>> fsparam_flag ("fc_debug_force", Opt_fc_debug_force),
>> fsparam_u32 ("fc_debug_max_replay", Opt_fc_debug_max_replay),
>> @@ -1878,6 +1879,7 @@ static const struct mount_opts {
>> {Opt_noauto_da_alloc, EXT4_MOUNT_NO_AUTO_DA_ALLOC, MOPT_SET},
>> {Opt_auto_da_alloc, EXT4_MOUNT_NO_AUTO_DA_ALLOC, MOPT_CLEAR},
>> {Opt_noinit_itable, EXT4_MOUNT_INIT_INODE_TABLE, MOPT_CLEAR},
>> + {Opt_rotalloc, EXT4_MOUNT_ROTALLOC, MOPT_SET},
>> {Opt_dax_type, 0, MOPT_EXT4_ONLY},
>> {Opt_journal_dev, 0, MOPT_NO_EXT2},
>> {Opt_journal_path, 0, MOPT_NO_EXT2},
>> @@ -2264,6 +2266,9 @@ static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param)
>> ctx->s_li_wait_mult = result.uint_32;
>> ctx->spec |= EXT4_SPEC_s_li_wait_mult;
>> return 0;
>> + case Opt_rotalloc:
>> + ctx_set_mount_opt(ctx, EXT4_MOUNT_ROTALLOC);
>> + return 0;
>> case Opt_max_dir_size_kb:
>> ctx->s_max_dir_size_kb = result.uint_32;
>> ctx->spec |= EXT4_SPEC_s_max_dir_size_kb;
>> @@ -5512,6 +5517,17 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>> }
>> }
>>
>> + /*
>> + * Initialize rotalloc cursor, lock and
>> + * vector new_blocks to rotating^regular allocator
>> + */
>> + sbi->s_rotalloc_cursor = 0;
>> + spin_lock_init(&sbi->s_rotalloc_lock);
>> + if (test_opt(sb, ROTALLOC))
>> + sbi->s_mb_new_blocks = ext4_mb_rotating_allocator;
>> + else
>> + sbi->s_mb_new_blocks = ext4_mb_regular_allocator;
>> +
>> /*
>> * Get the # of file system overhead blocks from the
>> * superblock if present.
>> -- 
>> 2.52.0
>>
>
> Cheers, Andreas
>
>
>
>
>

