Return-Path: <linux-ext4+bounces-12371-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E683CC0E99
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Dec 2025 05:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 347CF310DD98
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Dec 2025 04:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F400E33F374;
	Tue, 16 Dec 2025 04:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="5lqSN3GK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8995332EA5
	for <linux-ext4@vger.kernel.org>; Tue, 16 Dec 2025 04:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765857721; cv=none; b=efeL0Y/zBlD5YoTUKjOzdNKg8RpiEjjSABbL1RTjJaiIlEphTXp8P5cAPDTGzZLKhEBNbGTzD8ij8KzM7VsQ6TYslSrH+YWUJ+jcK3GsuG7XwwVfygJFWbKz0jAA79TLZugu6Y9U8wwhtihIcrKjnWUOWFzTT1uAFXkpFJWuSiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765857721; c=relaxed/simple;
	bh=gkiwlV4uDcnO6QCPIDmg01UTO9MtiwgS0gYpx5pY2vM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=o9N8RUgzDoJPBlHhL9PQKiahVSv3MiGwqksjJltwuS+ECN7IckVakJKXwvSVPNaP37/bglTcZKrxVXNIDwTpj6zA0yYnuJnnh/GqEwyNRrS6D/u1v3qn1waZ8X+1ICMQg0pU6nEBZerys/rWbWoNaQWI98HDWIAZNwwPtGl5y4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=5lqSN3GK; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=TPpKszd43obxEue9/HUtFLecNzSRmYuguonalqiJ4UU=;
	b=5lqSN3GKR/e/uJjbyyKFVuDqY6Z/P+cgzhiGvBKD7/v+CDpJJN/l3eUAzPk7gBGsKQm4OUdfg
	oyP9Z90IfK/Yd49q2xazm456NcHqBELoVQXpj4mMBiLHanTVwesUpBjECWR6wJZ13wJaUEzNloA
	79TVPhc/04g3Vs8LNlKBjnA=
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4dVjqf3d3ZzmV69;
	Tue, 16 Dec 2025 11:59:42 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 9562A14011F;
	Tue, 16 Dec 2025 12:01:42 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 16 Dec
 2025 12:01:42 +0800
Message-ID: <106ba6fe-4f94-4ed4-a53a-98a1f3ad30ab@huawei.com>
Date: Tue, 16 Dec 2025 12:01:41 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: fix dirtyclusters double decrement on fs shutdown
Content-Language: en-GB
To: Brian Foster <bfoster@redhat.com>
CC: <linux-ext4@vger.kernel.org>
References: <20251212154735.512651-1-bfoster@redhat.com>
 <ef906e19-04b9-4793-998e-81c34ebf9126@huawei.com> <aUApNS_YnY2Oa_93@bfoster>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <aUApNS_YnY2Oa_93@bfoster>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025-12-15 23:28, Brian Foster wrote:
> On Sat, Dec 13, 2025 at 09:46:23AM +0800, Baokun Li wrote:
>> Hi Brian,
>>
>> Thanks for the patch.
>>
> Hi Baokun,
>
> Thanks for reviewing..
>
>> On 2025-12-12 23:47, Brian Foster wrote:
>>> fstests test generic/388 occasionally reproduces a warning in
>>> ext4_put_super() associated with the dirty clusters count:
>>>
>>>   WARNING: CPU: 7 PID: 76064 at fs/ext4/super.c:1324 ext4_put_super+0x48c/0x590 [ext4]
>>>
>>> Tracing the failure shows that the warning fires due to an
>>> s_dirtyclusters_counter value of -1. IOW, this appears to be a
>>> spurious decrement as opposed to some sort of leak. Further tracing
>>> of the dirty cluster count deltas and an LLM scan of the resulting
>>> output identified the cause as a double decrement in the error path
>>> between ext4_mb_mark_diskspace_used() and the caller
>>> ext4_mb_new_blocks().
>>>
>>> First, note that generic/388 is a shutdown vs. fsstress test and so
>>> produces a random set of operations and shutdown injections. In the
>>> problematic case, the shutdown triggers an error return from the
>>> ext4_handle_dirty_metadata() call(s) made from
>>> ext4_mb_mark_context(). The changed value is non-zero at this point,
>>> so ext4_mb_mark_diskspace_used() does not exit after the error
>>> bubbles up from ext4_mb_mark_context(). Instead, the former
>>> decrements both cluster counters and returns the error up to
>>> ext4_mb_new_blocks(). The latter falls into the !ar->len out path
>>> which decrements the dirty clusters counter a second time, creating
>>> the inconsistency.
>>>
>>> AFAICT the solution here is to exit immediately from
>>> ext4_mb_mark_diskspace_used() on error, regardless of the changed
>>> value. This leaves the caller responsible for clearing the block
>>> reservation at the same level it is acquired. This also skips the
>>> free clusters update, but the caller also calls into
>>> ext4_discard_allocated_blocks() to free the blocks back into the
>>> group. This survives an overnight loop test of generic/388 on an
>>> otherwise reproducing system and survives a local regression run.
>>>
>>> Signed-off-by: Brian Foster <bfoster@redhat.com>
>>> ---
>>>
>>> Hi all,
>>>
>>> I've thrown some testing at this and poked around the area enough that I
>>> _think_ it is reasonably sane, but the error paths are hairy and I could
>>> certainly be missing some details. I'm happy to try a different approach
>>> if there are any thoughts around that.. thanks.
>>>
>>> Brian
>>>
>>>  fs/ext4/mballoc.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>>> index 56d50fd3310b..224abfd6a42b 100644
>>> --- a/fs/ext4/mballoc.c
>>> +++ b/fs/ext4/mballoc.c
>>> @@ -4234,7 +4234,7 @@ ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
>>>  				   ac->ac_b_ex.fe_start, ac->ac_b_ex.fe_len,
>>>  				   flags, &changed);
>>>  
>>> -	if (err && changed == 0)
>>> +	if (err)
>>>  		return err;
>>>  
>>>  #ifdef AGGRESSIVE_CHECK
>> I think we might need to swap that && for an ||.
>>
>> Basically, we should only proceed with the following logic if there's
>> no error and the bitmap was actually changed. If we hit an error or
>> if the section we intended to modify was already fully handled,
>> we should just bail out early. Otherwise, the err could get quietly
>> ignored unless we hit a duplicate allocation that happens to result in
>> 'changed' being zero.
>>
> Hmm.. to make sure I understand, are you referring to an inconsistency
> case where we allocated blocks that were already marked as such in the
> group on disk..?
Yes.
> I'm a little uneasy about this because it seems to conflict with the
> surrounding code. AFAICT the only way we can hit something like !err &&
> !changed is via EXT4_MB_BITMAP_MARKED_CHECK, which causes
> _mark_context() to check the bitmap for "already modified" bits up
> front.
>
> If this scenario plays out, the caller has a BUG check just after the
> return (also under the aggressive check macro). So ISTM that this sort
> of (err || !changed) logic would bypass the aggressive checks and let
> the fs carry on when it probably shouldn't. Hm?

Regarding ext4_mb_mark_context, if the passed ret_changed pointer is
non-NULL, we initialize *ret_changed to 0. After updating the bitmap_bh,
we then update *ret_changed with the actual number of blocks modified
(changed).

Therefore, the original intention was for changed == 0 to signify that
an error occurred in ext4_mb_mark_context() before ret_changed could be
updated. However, as you pointed out, we also get changed == 0 when the
target extent has already been fully marked as allocated within bitmap_bh.

Crucially, we only genuinely check the bitmap to modify changed when
EXT4_MB_BITMAP_MARKED_CHECK is set (i.e., when AGGRESSIVE_CHECK is defined,
or during fast commit or resize operations). Otherwise, changed is always
set to the target length. This means that, in the general case, errors
returned after the point where ret_changed is updated (e.g., the error
from ext4_handle_dirty_metadata()) are usually ignored.

In summary:

 * (err && changed == 0) only concerns errors that occur before ret_changed
   is updated.
 * (err || changed == 0) concerns whether there was an error OR if any
   modification actually took place.

If we only care about err, we could move the update of ret_changed inside
ext4_mb_mark_context() to just before the successful return.

>> By the way, I spotted two other spots with similar error logic:
>> ext4_mb_clear_bb() and ext4_group_add_blocks().
>>
> Yeah, I saw those as well but didn't think they needed changing. My high
> level understanding of the alloc case is that ext4_mb_new_blocks()
> acquires res (!delalloc), allocs blocks out of in-core structures, then
> calls down into _mark_diskspace_used() to update/journal on-disk
> structures with the pending alloc. If the latter fails, we release res
> and feed blocks back into the in-core structures. So IOW, if we return
> directly from _mark_diskspace_used() the counters/state end up
> consistent afaict.
>
> For the ext4_free_blocks() case, we call _mark_context() and if it fails
> with changed != 0 (and don't otherwise BUG), we still go ahead and free
> the blocks in the e4b and return the error. It does look like the
> discard code can clobber the error though, so perhaps that should be
> fixed. But otherwise it's not clear to me why we might want to exit
> early there. Am I missing something else?

The core issue is that they risk ignoring certain errors, which can
result in inconsistency.

>
>> Since this issue popped up in the last couple of years, we should
>> probably add a Fixes: tag to make backporting easier.
>>
> Do you have a target patch in mind? I made a pass through historical
> changes and it looked like this was a longer standing issue through
> various bits of refactoring..
>
No, I haven't, but I suspect it was introduced when
(err && changed == 0) was added.


Cheers,
Baokun


