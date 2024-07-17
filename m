Return-Path: <linux-ext4+bounces-3299-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE899336AF
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Jul 2024 08:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC686B233F2
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Jul 2024 06:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC017125DE;
	Wed, 17 Jul 2024 06:11:38 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC2EBA4B;
	Wed, 17 Jul 2024 06:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721196698; cv=none; b=dveKlGucfbjXiOGMDUfHzaubazs5ot2fk8O2NsbUUV032nrq9bOrIL3l7vJsZ7WM/Z1coKmsOoBfVO4Eewi623OEveOUehJIudGTm93UdOfWZznjsGD7aRk31oVoN7WY2LfJQToyxc7mIned6Nb+ZJYOSLq6B3CkX5tdfcrNv6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721196698; c=relaxed/simple;
	bh=2dcUv3tyf6mtFvGXAxBAoA9pa+e4PYCgHafzcH1Ps8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AnQGK/VEGuwWSjsdlgcA/dL5LDfPWXeuQ1iEcIVCbjhAVlTDKsWIrPyMPZ2mNyzpvR9SoSKxdlTnTelNXkw76u5R50xSsjx9HO8mvlbVgpJDxi0vXEH5dvwIwl8uYpbSLAoG0Yy/0a25vdh2TZ3YvcrjgcMNXvPf7jQZMEmnS6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WP5DC6b8Sz4f3jYb;
	Wed, 17 Jul 2024 14:11:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E17251A0DD3;
	Wed, 17 Jul 2024 14:11:31 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP4 (Coremail) with SMTP id gCh0CgDXuTePYJdmtHx0AQ--.45764S3;
	Wed, 17 Jul 2024 14:11:31 +0800 (CST)
Message-ID: <9fcb1d52-520f-425f-8b83-debeda423483@huaweicloud.com>
Date: Wed, 17 Jul 2024 14:11:27 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/20] ext4: prevent partial update of the extents path
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, Baokun Li <libaokun1@huawei.com>,
 zhanchengbin <zhanchengbin1@huawei.com>, Baokun Li <libaokun@huaweicloud.com>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
 <20240710040654.1714672-3-libaokun@huaweicloud.com>
 <ZpPx3kuO36lp9/Um@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <9fd554c7-dc0c-4969-9f2a-1c99356fccce@huaweicloud.com>
 <d33cfec3-4d72-41dc-b020-f17f726ba719@huaweicloud.com>
 <ZpZDSMFbziWq5xOK@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <9ef38162-2eeb-4cf6-aee4-02d6a5952757@huaweicloud.com>
 <ZpdR4pN8IJajB9xc@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Content-Language: en-US
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <ZpdR4pN8IJajB9xc@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXuTePYJdmtHx0AQ--.45764S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWr1rArWDXrWUAw43KFyfZwb_yoW5Gr43pr
	yvk3WqkrZ0krn5KFs2yF4jqFyjkw1fG3sFqrZ5CasrJ390vr1agryIqa1q9F9rArWkJa15
	JrW8X3sxur1DtFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgAHBWaWL5RQyAAAsT

On 2024/7/17 13:29, Ojaswin Mujoo wrote:
> On Tue, Jul 16, 2024 at 07:54:43PM +0800, Baokun Li wrote:
>> Hi Ojaswin,
>>
>> On 2024/7/16 17:54, Ojaswin Mujoo wrote:
>>>>> But the journal will ensure the consistency of the extents path after
>>>>> this patch.
>>>>>
>>>>> When ext4_ext_get_access() or ext4_ext_dirty() returns an error in
>>>>> ext4_ext_rm_idx() and ext4_ext_correct_indexes(), this may cause
>>>>> the extents tree to be inconsistent. But the inconsistency just
>>>>> exists in memory and doesn't land on disk.
>>>>>
>>>>> For ext4_ext_get_access(), the handle must have been aborted
>>>>> when it returned an error, as follows:
>>>> ext4_ext_get_access
>>>>    ext4_journal_get_write_access
>>>>     __ext4_journal_get_write_access
>>>>      err = jbd2_journal_get_write_access
>>>>      if (err)
>>>>        ext4_journal_abort_handle
>>>>> For ext4_ext_dirty(), since path->p_bh must not be null and handle
>>>>> must be valid, handle is aborted anyway when an error is returned:
>>>> ext4_ext_dirty
>>>>    __ext4_ext_dirty
>>>>     if (path->p_bh)
>>>>       __ext4_handle_dirty_metadata
>>>>        if (ext4_handle_valid(handle))
>>>>          err = jbd2_journal_dirty_metadata
>>>>           if (!is_handle_aborted(handle) && WARN_ON_ONCE(err))
>>>>             ext4_journal_abort_handle
>>>>> Thus the extents tree will only be inconsistent in memory, so only
>>>>> the verified bit of the modified buffer needs to be cleared to avoid
>>>>> these inconsistent data being used in memory.
>>>>>
>>>> Regards,
>>>> Baokun
>>> Thanks for the explanation Baokun, so basically we only have the
>>> inconsitency in the memory.
>>>
>>> I do have a followup questions:
>>>
>>> So in the above example, after we have the error, we'll have the buffer
>>> for depth=0 marked as valid but pointing to the wrong ei_block.
>> It looks wrong here. When there is an error, the ei_block of the
>> unmodified buffer with depth=0 is the correct one, it is indeed
>> 'valid' and it is consistent with the disk. Only buffers that were
> Hey Baokun,
>
> Ahh I see now, I was looking at it the wrong way. So basically since
> depth 1 to 4 is inconsistent to the disk we mark then non verified so
> then subsequent lookups can act accordingly.
>
> Thanks for the explanation! I am in the middle of testing this patchset
> with xfstests on a POWERPC system with 64k page size. I'll let you know
> how that goes!
>
> Regards,
> Ojaswin

Hi Ojaswin,

Thank you for the test and feedback!

Cheers,
Baokun


