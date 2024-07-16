Return-Path: <linux-ext4+bounces-3291-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A24B29325F3
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Jul 2024 13:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E3BC283D05
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Jul 2024 11:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EDC199E94;
	Tue, 16 Jul 2024 11:54:55 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D5E1993B8;
	Tue, 16 Jul 2024 11:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721130895; cv=none; b=fFEXRi4q7T99MQFezZUxEklxSqu54o0T3FmaCl1o0ybSEfsTRbCluvC6UjxVskq4xT66RftEE6x8+1D742HhkWxCUUxmdklBc/67ygwbVUWnYFl4EINKlLnoqaBZzQGgZeIsHiFw7bSO9m1Y0y7w95exB4Xq+9C4+Dh7ODANnAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721130895; c=relaxed/simple;
	bh=mkUC/AeIAo+acsMPc1NXzSEBBE+nCCQhyyWeOvfJhuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GIj7pOI52j0TIEEU1zbVfOlS0Okdq0V+WWej7rX1Gn8sd6DmfpWBKTC7pH1rrH9mfv/oNeDagZhYhLksGdgV6JNow2BzMIBz/qp+denFl5kdpRfl2W84dQ/JlJ9Ed00zoaDNc2pmSk20W6oCmsh4FNE7zI6lAyEz7wEahbvok8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WNctg4w1Nz4f3jMs;
	Tue, 16 Jul 2024 19:54:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A3A4B1A058E;
	Tue, 16 Jul 2024 19:54:47 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP4 (Coremail) with SMTP id gCh0CgCHazmDX5Zm4pgsAQ--.15645S3;
	Tue, 16 Jul 2024 19:54:47 +0800 (CST)
Message-ID: <9ef38162-2eeb-4cf6-aee4-02d6a5952757@huaweicloud.com>
Date: Tue, 16 Jul 2024 19:54:43 +0800
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
Content-Language: en-US
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <ZpZDSMFbziWq5xOK@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHazmDX5Zm4pgsAQ--.15645S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCr4UKw4UZryxCFyUJrWDArb_yoW5XrWrpr
	9ak3ZrCrWqk3Z5WFsFyF4UZFyUu3Z3J3srJrWrCas7CFW5ur1aqFWxXay09FyqyrWkGa15
	trW8X3sF9r1DtFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY
	04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQAGBWaWLvsVtAAAsG

Hi Ojaswin,

On 2024/7/16 17:54, Ojaswin Mujoo wrote:
>>> But the journal will ensure the consistency of the extents path after
>>> this patch.
>>>
>>> When ext4_ext_get_access() or ext4_ext_dirty() returns an error in
>>> ext4_ext_rm_idx() and ext4_ext_correct_indexes(), this may cause
>>> the extents tree to be inconsistent. But the inconsistency just
>>> exists in memory and doesn't land on disk.
>>>
>>> For ext4_ext_get_access(), the handle must have been aborted
>>> when it returned an error, as follows:
>> ext4_ext_get_access
>>   ext4_journal_get_write_access
>>    __ext4_journal_get_write_access
>>     err = jbd2_journal_get_write_access
>>     if (err)
>>       ext4_journal_abort_handle
>>> For ext4_ext_dirty(), since path->p_bh must not be null and handle
>>> must be valid, handle is aborted anyway when an error is returned:
>> ext4_ext_dirty
>>   __ext4_ext_dirty
>>    if (path->p_bh)
>>      __ext4_handle_dirty_metadata
>>       if (ext4_handle_valid(handle))
>>         err = jbd2_journal_dirty_metadata
>>          if (!is_handle_aborted(handle) && WARN_ON_ONCE(err))
>>            ext4_journal_abort_handle
>>> Thus the extents tree will only be inconsistent in memory, so only
>>> the verified bit of the modified buffer needs to be cleared to avoid
>>> these inconsistent data being used in memory.
>>>
>> Regards,
>> Baokun
> Thanks for the explanation Baokun, so basically we only have the
> inconsitency in the memory.
>
> I do have a followup questions:
>
> So in the above example, after we have the error, we'll have the buffer
> for depth=0 marked as valid but pointing to the wrong ei_block.
It looks wrong here. When there is an error, the ei_block of the
unmodified buffer with depth=0 is the correct one, it is indeed
'valid' and it is consistent with the disk. Only buffers that were
modified during the error process need to be checked.

Regards,
Baokun
>
> In this case, can we have something like below:
>
> -----------------
> ext4_ext_remove_space
>    err = ext4_ext_rm_idx (error, path[0].p_bh inconsistent but verified)
>    /*
>     * we release buffers of the path but path[0].p_bh is not cleaned up
>     * due to other references to it (possible?)
>     */
>
> ... at a later point...:
>
> ext4_find_extent
>    bh = read_extent_tree_block()
>      /*
>       * we get the bh that was left inconsistent previously
>       * since its verified, we dont check it again corrupting
>       * the lookup
>       */
>
> -----------------
>
> Is the above scenario possible? Or would the path[0].p_bh that was
> corrupted previously always be reread during the subsequent
> ext4_find_extent() lookup?
>
> Thanks again,
> Ojaswin


