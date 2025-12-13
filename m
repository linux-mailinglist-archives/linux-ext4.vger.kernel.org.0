Return-Path: <linux-ext4+bounces-12342-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A112BCBA2B6
	for <lists+linux-ext4@lfdr.de>; Sat, 13 Dec 2025 02:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EDCB23003127
	for <lists+linux-ext4@lfdr.de>; Sat, 13 Dec 2025 01:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B42319309C;
	Sat, 13 Dec 2025 01:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="J4fHKVJw"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCE52CCC0
	for <linux-ext4@vger.kernel.org>; Sat, 13 Dec 2025 01:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765590396; cv=none; b=cMf/Zm6YSwzg2rMrepCn4KRrCCy3uYuW3AcbqsTAubeVSTdby3QM/gCLg003TVNzfqBhCEuoDu9SwxFCUPqXcD1tsYVfQtl1Hx35uWfWdMq+OpqAGGgYQPDLqJncfsygDXdpT8xlwrT2Sm3dwtYLT350NfI4o3/np2Hzn2F1I8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765590396; c=relaxed/simple;
	bh=u/FtnDLqlhBbtnoc1Fd3PBRJ9iITJpLV7dAGFUWo+QM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:CC:
	 In-Reply-To:Content-Type; b=R52tQBU49m3aFFDwHDOVFN9W4qzZGzROLDcFlLNBez+GfLJdSM//cj46ZbqZX56y1oawWCeuGzlrVHUk5zVGOuyymvIXjNduqI5Z77xtByGxvdpbKNtAvr38RvJF20LHrBT8/uc1HEWv74ewEarDBhOApNd5dp3Zh4YPqeutGOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=J4fHKVJw; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=LC96HhzCyqhs5Xph9eZ12VC9ShVmnkZf9Pn2o4LER/c=;
	b=J4fHKVJwwSUPAQCMZ/b/xuFMFjBgmPIrK61r39ZEyDbANGIo73OclLjU3eKP4xjQuCkfuncV3
	cAXBOYTmiEM9OymLwUXmThae/VU7/zLbB063/TZ3SsR9DdRTMhjJLpsOHY79RoVSIDSOl1/y0Do
	vvQYu4mIC7RBOtgr7saqjqE=
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4dSpyD33DzzpSvc;
	Sat, 13 Dec 2025 09:43:48 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id EA3711804F5;
	Sat, 13 Dec 2025 09:46:24 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 13 Dec
 2025 09:46:24 +0800
Message-ID: <ef906e19-04b9-4793-998e-81c34ebf9126@huawei.com>
Date: Sat, 13 Dec 2025 09:46:23 +0800
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
References: <20251212154735.512651-1-bfoster@redhat.com>
From: Baokun Li <libaokun1@huawei.com>
CC: <linux-ext4@vger.kernel.org>
In-Reply-To: <20251212154735.512651-1-bfoster@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500013.china.huawei.com (7.185.36.188)

Hi Brian,

Thanks for the patch.

On 2025-12-12 23:47, Brian Foster wrote:
> fstests test generic/388 occasionally reproduces a warning in
> ext4_put_super() associated with the dirty clusters count:
>
>   WARNING: CPU: 7 PID: 76064 at fs/ext4/super.c:1324 ext4_put_super+0x48c/0x590 [ext4]
>
> Tracing the failure shows that the warning fires due to an
> s_dirtyclusters_counter value of -1. IOW, this appears to be a
> spurious decrement as opposed to some sort of leak. Further tracing
> of the dirty cluster count deltas and an LLM scan of the resulting
> output identified the cause as a double decrement in the error path
> between ext4_mb_mark_diskspace_used() and the caller
> ext4_mb_new_blocks().
>
> First, note that generic/388 is a shutdown vs. fsstress test and so
> produces a random set of operations and shutdown injections. In the
> problematic case, the shutdown triggers an error return from the
> ext4_handle_dirty_metadata() call(s) made from
> ext4_mb_mark_context(). The changed value is non-zero at this point,
> so ext4_mb_mark_diskspace_used() does not exit after the error
> bubbles up from ext4_mb_mark_context(). Instead, the former
> decrements both cluster counters and returns the error up to
> ext4_mb_new_blocks(). The latter falls into the !ar->len out path
> which decrements the dirty clusters counter a second time, creating
> the inconsistency.
>
> AFAICT the solution here is to exit immediately from
> ext4_mb_mark_diskspace_used() on error, regardless of the changed
> value. This leaves the caller responsible for clearing the block
> reservation at the same level it is acquired. This also skips the
> free clusters update, but the caller also calls into
> ext4_discard_allocated_blocks() to free the blocks back into the
> group. This survives an overnight loop test of generic/388 on an
> otherwise reproducing system and survives a local regression run.
>
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> ---
>
> Hi all,
>
> I've thrown some testing at this and poked around the area enough that I
> _think_ it is reasonably sane, but the error paths are hairy and I could
> certainly be missing some details. I'm happy to try a different approach
> if there are any thoughts around that.. thanks.
>
> Brian
>
>  fs/ext4/mballoc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 56d50fd3310b..224abfd6a42b 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -4234,7 +4234,7 @@ ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
>  				   ac->ac_b_ex.fe_start, ac->ac_b_ex.fe_len,
>  				   flags, &changed);
>  
> -	if (err && changed == 0)
> +	if (err)
>  		return err;
>  
>  #ifdef AGGRESSIVE_CHECK

I think we might need to swap that && for an ||.

Basically, we should only proceed with the following logic if there's
no error and the bitmap was actually changed. If we hit an error or
if the section we intended to modify was already fully handled,
we should just bail out early. Otherwise, the err could get quietly
ignored unless we hit a duplicate allocation that happens to result in
'changed' being zero.

By the way, I spotted two other spots with similar error logic:
ext4_mb_clear_bb() and ext4_group_add_blocks().

Since this issue popped up in the last couple of years, we should
probably add a Fixes: tag to make backporting easier.


Cheers,
Baokun


