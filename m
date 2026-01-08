Return-Path: <linux-ext4+bounces-12619-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE34D00C1C
	for <lists+linux-ext4@lfdr.de>; Thu, 08 Jan 2026 04:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1213F301F8FC
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Jan 2026 03:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABCD27EC7C;
	Thu,  8 Jan 2026 03:00:49 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2551227E7F0;
	Thu,  8 Jan 2026 03:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767841248; cv=none; b=JR2qSQyNvMYROURRTpEMi/2YtPVTHVFPOq54u2vX+ibb6lbR4mzrqOQKRpAj3Na5G3Q6g0Iqxgaf9reIdv1pZR+w2w/bG45YS4N9GEtqBo9R3vAUlJyc64e2z5Q955DA0IrCP7AHbTUSDH0PfjZ+Y2EV0bKpU47pzvan9AmGGxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767841248; c=relaxed/simple;
	bh=O7VIQBvgZhz41kt4iXTJ2z0M5IxxLnHsImG8cGSQeVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i5onJE24g2/jmUo++LwHEhuEXpkgsUw9+gecqAcm9626xOcWsgvKVHOl+ynFYRTh5iuJnZYGbXhw8wcuMaeCUB/sz5t2GlGW1INAWx32K7d7Nl0izk23nV+6nmzrZzJkGeLEDtZ3XvAZ0MvXSpm7mZc02iBocwfLVJEOfvhrL2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dmqQ65KJwzKHLy2;
	Thu,  8 Jan 2026 10:59:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id EA51E4058F;
	Thu,  8 Jan 2026 11:00:40 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP4 (Coremail) with SMTP id gCh0CgD3WPnXHV9pSZoYDA--.47337S3;
	Thu, 08 Jan 2026 11:00:40 +0800 (CST)
Message-ID: <e947ad33-afdb-40e6-9f8f-46cc5ea951ee@huaweicloud.com>
Date: Thu, 8 Jan 2026 11:00:38 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 1/2] ext4: fast_commit: assert i_data_sem only before
 sleep
To: Li Chen <me@linux.beauty>
Cc: linux-ext4 <linux-ext4@vger.kernel.org>, Theodore Ts'o <tytso@mit.edu>,
 Andreas Dilger <adilger.kernel@dilger.ca>,
 linux-kernel <linux-kernel@vger.kernel.org>
References: <20251224032943.134063-1-me@linux.beauty>
 <20251224032943.134063-2-me@linux.beauty>
 <e3465e09-0b6f-419c-9af5-00e750448e53@huaweicloud.com>
 <19b933e4928.7e19f7474492475.8810694155148118128@linux.beauty>
 <a507a2ce-a2ae-4592-b171-63974034fc1b@huaweicloud.com>
 <19b98ddd118.2300666e5265102.1629777029508214951@linux.beauty>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <19b98ddd118.2300666e5265102.1629777029508214951@linux.beauty>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3WPnXHV9pSZoYDA--.47337S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCryrArWkKw1fGr1kur13XFb_yoW7JryDpF
	WxCa1xGF4kJry0kw4xtry8WFy2k3s5Jr47XF9xKFyxurs0ka4fKF47KFyfWa4qkr4kAw1q
	qF4Fq39xX3Wqya7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7IJmUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 1/7/2026 10:30 PM, Li Chen wrote:
> Hi Zhang,
> 
> Thanks a lot for your detailed review!
> 
>  ---- On Wed, 07 Jan 2026 10:00:23 +0800  Zhang Yi <yi.zhang@huaweicloud.com> wrote --- 
>  > On 1/6/2026 8:18 PM, Li Chen wrote:
>  > > Hi Zhang Yi,
>  > > 
>  > >  ---- On Mon, 05 Jan 2026 20:18:42 +0800  Zhang Yi <yi.zhang@huaweicloud.com> wrote --- 
>  > >  > Hi Li,
>  > >  > 
>  > >  > On 12/24/2025 11:29 AM, Li Chen wrote:
>  > >  > > ext4_fc_track_inode() can return without sleeping when
>  > >  > > EXT4_STATE_FC_COMMITTING is already clear. The lockdep assertion for
>  > >  > > ei->i_data_sem was done unconditionally before the wait loop, which can
>  > >  > > WARN in call paths that hold i_data_sem even though we never block. Move
>  > >  > > lockdep_assert_not_held(&ei->i_data_sem) into the actual sleep path,
>  > >  > > right before schedule().
>  > >  > > 
>  > >  > > Signed-off-by: Li Chen <me@linux.beauty>
>  > >  > 
>  > >  > Thank you for the fix patch! However, the solution does not seem to fix
>  > >  > the issue. IIUC, the root cause of this issue is the following race
>  > >  > condition (show only one case), and it may cause a real ABBA dead lock
>  > >  > issue.
>  > >  > 
>  > >  > ext4_map_blocks()
>  > >  >  hold i_data_sem // <- A
>  > >  >  ext4_mb_new_blocks()
>  > >  >   ext4_dirty_inode()
>  > >  >                                  ext4_fc_commit()
>  > >  >                                   ext4_fc_perform_commit()
>  > >  >                                    set EXT4_STATE_FC_COMMITTING  <-B
>  > >  >                                    ext4_fc_write_inode_data()
>  > >  >                                    ext4_map_blocks()
>  > >  >                                     hold i_data_sem  // <- A
>  > >  >    ext4_fc_track_inode()
>  > >  >     wait EXT4_STATE_FC_COMMITTING  <- B
>  > >  >                                   jbd2_fc_end_commit()
>  > >  >                                    ext4_fc_cleanup()
>  > >  >                                     clear EXT4_STATE_FC_COMMITTING()
>  > >  > 
>  
> I think the ABBA reasoning is plausible: if a caller violates the ordering
> contract and enters ext4_fc_track_inode() while holding i_data_sem, and the
> recheck still finds EXT4_STATE_FC_COMMITTING set (so we actually schedule()),
> then we can get A -> wait(B). If the commit task, while holding the inode
> in COMMITTING, still needs i_data_sem (e.g. via mapping/log writing), that
> gives B -> wait(A), forming a cycle.
> 
>  > >  > Postponing the lockdep assertion to the point where sleeping is actually
>  > >  > necessary does not resolve this deadlock issue, it merely masks the
>  > >  > problem, right?
>  > >  > 
>  > >  > I currently don't quite understand why only ext4_fc_track_inode() needs
>  > >  > to wait for the inode being fast committed to be completed, instead of
>  > >  > adding it to the FC_Q_STAGING list like other tracking operations.
>  > 
>  > It seems that the inode metadata of the tracked inode was not recorded
>  > during the __track_inode(), so the inode metadata committed at commit
>  > time reflects real-time data. However, the current
>  > ext4_fc_perform_commit() lacks concurrency control, allowing other
>  > processes to simultaneously initiate new handles that modify the inode
>  > metadata while the previous metadata is being fast committed. Therefore,
>  > to prevent recording newly changed inode metadata during the old commit
>  > phase, the ext4_fc_track_inode() function must wait for the ongoing
>  > commit process to complete before modifying.
>  > 
>  > >  > So
>  > >  > now I don't have a good idea to fix this problem either.  Perhaps we
>  > >  > need to rethink the necessity of this waiting, or find a way to avoid
>  > >  > acquiring i_data_sem during fast commit.
>  > 
>  > Ha, the solution seems to have already been listed in the TODOs in
>  > fast_commit.c.
>  > 
>  >   Change ext4_fc_commit() to lookup logical to physical mapping using extent
>  >   status tree. This would get rid of the need to call ext4_fc_track_inode()
>  >   before acquiring i_data_sem. To do that we would need to ensure that
>  >   modified extents from the extent status tree are not evicted from memory.
>  > 
>  > Alternatively, recording the mapped range of tracking might also be
>  > feasible.
> 
> Thanks a lot for your insights!
> 
> For the next revesion, I plan to follow the "Alternatively" way firstly:
> record the mapped ranges (and relvant inode metadata) at commit time in a
> snapshot, when journal updates are locked/handles are drained, and then
> consume only the snapshot during log writing. This avoids doing
> logical-to-physical mapping (and thus avoids taking i_data_sem) in the log
> writing phase, and removes the need for ext4_fc_track_inode() to wait for
> EXT4_STATE_FC_COMMITTING.
> 
> I did not pick the extent status tree approach because it would require
> additional work to guarantee the needed mappings are resident and not
> evicted under memory pressure, which seems like a larger correctness
> surface(Please correct me if I'm wrong). If you believe the extent stats tree
> approach is better, please let me know, and I will do my best to implement it.
> 
> Thanks again for the guidance. I'll post an RFC v3 later.

Yes, in my opinion, I also prefer the solution of recording the mapped ranges,
as it should not incur too much overhead. Please give it a try.

Cheers,
Yi.

> 
> Regards,
> Li​
> 


