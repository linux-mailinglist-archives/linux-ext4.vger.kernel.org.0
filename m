Return-Path: <linux-ext4+bounces-3929-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C68E5961D0E
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Aug 2024 05:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F23B283116
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Aug 2024 03:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4D713DDD3;
	Wed, 28 Aug 2024 03:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="h/wzvOCq"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A22112EBE9
	for <linux-ext4@vger.kernel.org>; Wed, 28 Aug 2024 03:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724815975; cv=none; b=ALfDA7w7vU2575aWf9pyRcBxNoh99eYE46LSYHNj2JpkVNjZxMqc7Uh7ZI7tuOyC6l6dCkxD9+kMhDUfNa5nederpkigdelzWckgUvBGlINAyLOxAl8AtLi1j+h/FbBfNuVzZTxRZhsUl4KHjqMSUPESU4q0/7H/dpHzi+M2mQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724815975; c=relaxed/simple;
	bh=uMOnVI+fVhgzJh0LUCONCuBM9OMo4GP9YT0STANrR1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r/41sMVqsyJh9VlB8ABUdAJW4xjXYEYhwXpKg28D2/gk6HhNzZhKvveAqep9gCdPxxlkdJTK5w96/0I/IbGhKkkbisQZ/HsGH37D3fbHoEs5Jtqgne+GF+nj++uG+wP1hq7VcVGWB5DDPyitMzW32RJ8blV4G/KLVx3Y/jol+8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=h/wzvOCq; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-70941cb73e9so3676683a34.2
        for <linux-ext4@vger.kernel.org>; Tue, 27 Aug 2024 20:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1724815972; x=1725420772; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKHzPFzYGLV7zu3oVIo7a5VimNAJDnJhonptycqIDOY=;
        b=h/wzvOCq8H2xfQg58tsMNxk86KAYEV9Moxqkek5EeDAXDDguIq4405BvjhFk+GkznK
         00KVe25T/9xQTNKd43lncn+RkMmIX7nH+0kGtbOvTqIStyyApjWCYvd+Tc2c9usIuLAZ
         l4/GjXn6ROBEaBoLMYOyQBFv4B/fxYEkd4D6pzS2SY9ljrkFlvuR17a34ZBI89+XhiLr
         vjFo+pNhYRm0gCG5OLIVwI5gF32sjTK5yp8N3V/zrgFKSmNI7V3LTHZu0dqwblGnFb/q
         /1hQHUnm1LcI9YyK3/rc/uP383eCFvEi0MkrOKu2rqVsWhfSwB6KtpVplN+ChBoCKb97
         4S3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724815972; x=1725420772;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EKHzPFzYGLV7zu3oVIo7a5VimNAJDnJhonptycqIDOY=;
        b=GP1mSCKBnvqvsEpO44cD21CDDJ0j6FaDjNNJAKe9PPy7LI9WVJSEl2Omj6lnL6oVL1
         7epWojERzxMb76gcbtj/H9D4wRb5ZC0E7j6nYbltPFmGEBdYFcgJSjCwMuQUnWi7ti0X
         AK2zS0yVH9y9bPDWGmqlW0podsndskFJynLjt1QWIFiOKLt+vfGOrGpk5J9pkDYv1bFt
         lBuW1chqTvbOx9J4Y8539YeIDiR4Ylmk7cyL8bfbOCGhvMWQRCv9IIbjGaGe6/TjVMUY
         DC1hIblEM1iEbogsDzMsZuPHfwLm39RyJoOEMQ3khduHJlgjDrQvseyDVRdSZFuQsjn0
         mtpA==
X-Forwarded-Encrypted: i=1; AJvYcCUl0KQhZOAu8fU+2gkvDgRA6zg8orwZs12JnH84s+1yV98CIZPrrMo7fhDhm8bOyK8vkrhuLgo7GRs/@vger.kernel.org
X-Gm-Message-State: AOJu0YxibdzzMivdSvQmUXnxFpuB9rqAMzl4tZC/rMTvY7XfaDjSu/0x
	ysdv+RBVp1VFit8cC9C4p94/dUX90gNjphwxZr9Xp5O6tgcvuwdhBmzzFIwu15DMAt37vLnlhSe
	ruiE=
X-Google-Smtp-Source: AGHT+IHr4NoL+NCWDvR7BxwfUmqPC5t7crQ6tympn4yZlPZEHMNfdfZilzFv6MO1qbtl0SMhm/hArg==
X-Received: by 2002:a05:6830:3989:b0:70b:39f4:a90a with SMTP id 46e09a7af769-70e0ebd02camr17274575a34.25.1724815972489;
        Tue, 27 Aug 2024 20:32:52 -0700 (PDT)
Received: from [10.54.24.59] (static-ip-148-99-134-202.rev.dyxnet.com. [202.134.99.148])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714342e4417sm9493559b3a.97.2024.08.27.20.32.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 20:32:52 -0700 (PDT)
Message-ID: <f4c16dc5-c12a-40f0-afdc-15a637688620@shopee.com>
Date: Wed, 28 Aug 2024 11:32:46 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: jbd2: io throttle for metadata buffers
To: Yu Kuai <yukuai1@huaweicloud.com>, Zhang Yi <yi.zhang@huaweicloud.com>
Cc: tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org, hanjinke.666@bytedance.com,
 Tejun Heo <tj@kernel.org>, linux-block <linux-block@vger.kernel.org>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <9914a4b4-eb4d-44de-a48c-8ae08eedebe8@shopee.com>
 <b85e49c6-588e-63c7-b153-a273183f810e@huaweicloud.com>
 <97fc38e6-a226-5e22-efc2-4405beb6d75b@huaweicloud.com>
From: Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <97fc38e6-a226-5e22-efc2-4405beb6d75b@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024/8/19 21:38, Yu Kuai wrote:
> +CC Tejun
> +CC block
> 
> 在 2024/08/19 20:49, Zhang Yi 写道:
>> Hello, Haifeng.
>>
>> On 2024/8/19 18:19, Haifeng Xu wrote:
>>> Hi, matsers!
>>>
>>>
>>> We encountered high load issuses in our production environment recently. And the kernel version is stable-5.15.39
>>> the filesystem is ext4(ordered).
>>>
>>>
>>> After digging into it, we found the problem is due to io.max
>>>
>>>
>>> thread 1:
>>>
>>> PID: 189529  TASK: ffff92ab51e5c080  CPU: 34  COMMAND: "mc"
>>>   #0 [ffffa638db807800] __schedule at ffffffff83b19898
>>>   #1 [ffffa638db807888] schedule at ffffffff83b19e9e
>>>   #2 [ffffa638db8078a8] io_schedule at ffffffff83b1a316
>>>   #3 [ffffa638db8078c0] bit_wait_io at ffffffff83b1a751
>>>   #4 [ffffa638db8078d8] __wait_on_bit at ffffffff83b1a373
>>>   #5 [ffffa638db807918] out_of_line_wait_on_bit at ffffffff83b1a46d
>>>   #6 [ffffa638db807970] __wait_on_buffer at ffffffff831b9c64
>>>   #7 [ffffa638db807988] jbd2_log_do_checkpoint at ffffffff832b556e
>>>   #8 [ffffa638db8079e8] __jbd2_log_wait_for_space at ffffffff832b55dc
>>>   #9 [ffffa638db807a30] add_transaction_credits at ffffffff832af369
>>> #10 [ffffa638db807a98] start_this_handle at ffffffff832af50f
>>> #11 [ffffa638db807b20] jbd2__journal_start at ffffffff832afe1f
>>> #12 [ffffa638db807b60] __ext4_journal_start_sb at ffffffff83241af3
>>> #13 [ffffa638db807ba8] __ext4_new_inode at ffffffff83253be6
>>> #14 [ffffa638db807c80] ext4_mkdir at ffffffff8327ec9e
>>> #15 [ffffa638db807d10] vfs_mkdir at ffffffff83182a92
>>> #16 [ffffa638db807d50] ovl_mkdir_real at ffffffffc0965c9f [overlay]
>>> #17 [ffffa638db807d80] ovl_create_real at ffffffffc0965e8b [overlay]
>>> #18 [ffffa638db807db8] ovl_create_or_link at ffffffffc09677cc [overlay]
>>> #19 [ffffa638db807e10] ovl_create_object at ffffffffc0967a48 [overlay]
>>> #20 [ffffa638db807e60] ovl_mkdir at ffffffffc0967ad3 [overlay]
>>> #21 [ffffa638db807e70] vfs_mkdir at ffffffff83182a92
>>> #22 [ffffa638db807eb0] do_mkdirat at ffffffff83184305
>>> #23 [ffffa638db807f08] __x64_sys_mkdirat at ffffffff831843df
>>> #24 [ffffa638db807f28] do_syscall_64 at ffffffff83b0bf1c
>>> #25 [ffffa638db807f50] entry_SYSCALL_64_after_hwframe at ffffffff83c0007c
>>>
>>> other threads:
>>>
>>>
>>> PID: 21125  TASK: ffff929f5b9a0000  CPU: 44  COMMAND: "task_server"
>>>   #0 [ffffa638aff9b900] __schedule at ffffffff83b19898
>>>   #1 [ffffa638aff9b988] schedule at ffffffff83b19e9e
>>>   #2 [ffffa638aff9b9a8] schedule_preempt_disabled at ffffffff83b1a24e
>>>   #3 [ffffa638aff9b9b8] __mutex_lock at ffffffff83b1af28
>>>   #4 [ffffa638aff9ba38] __mutex_lock_slowpath at ffffffff83b1b1a3
>>>   #5 [ffffa638aff9ba48] mutex_lock at ffffffff83b1b1e2
>>>   #6 [ffffa638aff9ba60] mutex_lock_io at ffffffff83b1b210
>>>   #7 [ffffa638aff9ba80] __jbd2_log_wait_for_space at ffffffff832b563b
>>>   #8 [ffffa638aff9bac8] add_transaction_credits at ffffffff832af369
>>>   #9 [ffffa638aff9bb30] start_this_handle at ffffffff832af50f
>>> #10 [ffffa638aff9bbb8] jbd2__journal_start at ffffffff832afe1f
>>> #11 [ffffa638aff9bbf8] __ext4_journal_start_sb at ffffffff83241af3
>>> #12 [ffffa638aff9bc40] ext4_dirty_inode at ffffffff83266d0a
>>> #13 [ffffa638aff9bc60] __mark_inode_dirty at ffffffff831ab423
>>> #14 [ffffa638aff9bca0] generic_update_time at ffffffff8319169d
>>> #15 [ffffa638aff9bcb0] inode_update_time at ffffffff831916e5
>>> #16 [ffffa638aff9bcc0] file_update_time at ffffffff83191b01
>>> #17 [ffffa638aff9bd08] file_modified at ffffffff83191d47
>>> #18 [ffffa638aff9bd20] ext4_write_checks at ffffffff8324e6e4
>>> #19 [ffffa638aff9bd40] ext4_buffered_write_iter at ffffffff8324edfb
>>> #20 [ffffa638aff9bd78] ext4_file_write_iter at ffffffff8324f553
>>> #21 [ffffa638aff9bdf8] ext4_file_write_iter at ffffffff8324f505
>>> #22 [ffffa638aff9be00] new_sync_write at ffffffff8316dfca
>>> #23 [ffffa638aff9be90] vfs_write at ffffffff8316e975
>>> #24 [ffffa638aff9bec8] ksys_write at ffffffff83170a97
>>> #25 [ffffa638aff9bf08] __x64_sys_write at ffffffff83170b2a
>>> #26 [ffffa638aff9bf18] do_syscall_64 at ffffffff83b0bf1c
>>> #27 [ffffa638aff9bf38] asm_common_interrupt at ffffffff83c00cc8
>>> #28 [ffffa638aff9bf50] entry_SYSCALL_64_after_hwframe at ffffffff83c0007c
>>>
>>>
>>> The cgroup of thread1 has set io.max, so the j_checkpoint_mutex can't be released and many threads must wait for it.
>>> I have some questions about the throttle for the metadata buffers.
>>>
>>> 1) writeback
>>>
>>> jbd2 converts the buffer head from jbddirty to buffer_dirty and trigger the write back in __jbd2_journal_temp_unlink_buffer().
>>> By default, the blkcg in bdi_writeback attached to block device inode is blkcg_root which has no io throttle rules. But there may be other
>>> threads which invoke sync_filesystem, such as umount overlayfs. This operation will write out all dirty data associated with the block
>>> device. In this case, the bdi_writeback attached to block device inode may changed due to Boyer-Moore majority vote algorithm.
>>> And the blkcg in bdi_writeback attached to block device inode is the group where the thread allocate the buffer head and dev page.
>>>
>>> So the writeback process of metadata buffers can also be throttled, right?
>>>
>>>
>>> 2) checkpoint
>>>
>>> If the free log space is not suffcient, we will do checkpoint to update log tail. During the process, if the buffer head hasn't been
>>> written out by wirteback. we will lock the buffer head and submit bio in current context.
>>>
>>> So the throttle rules may be different from writeback?
>>>
>>>
>>> 3）j_checkpoint_mutex
>>> If we can't make any progress in checkpoint due to io throttle, the j_checkpoint_mutex can'be release and block many others threads.
>>>
>>> So can we cancel the throttle rules for metadata buffers and keep it in blkcg_root?
>>>
>>
>> It seems that iocost have already act as blkcg_root if bios have
>> REQ_META set(ext4's metadata bh should've set this flag), but
>> blk-thottle doesn't, Jinke had submitted a patch to improve this
>> case, maybe it could help, please take a look at this patch. Or
>> maybe we could add some similar logic in blk-throttle like iocost
>> does for REQ_META.
>>
>> https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_linux-2Dblock_20230228085935.71465-2D1-2Dhanjinke.666-40bytedance.com_&d=DwIDaQ&c=R1GFtfTqKXCFH-lgEPXWwic6stQkW4U7uVq33mt-crw&r=3uoFsejk1jN2oga47MZfph01lLGODc93n4Zqe7b0NRk&m=I10U3kY903GhU0KzI5jaD-b32oD9-hze3jR6HzQ2AjBsqb3p-kAZDuf1NBdEksEN&s=ni839CUzZlgImTP9SuMZeW37o2v5WzvrcPmudeRdDII&e= 
> 
> Hi, Tejun
> 
> This patch can solve the priority inversion problem, however, I just
> come up with a new idea:
> 
> For meta IO, just issue the IO directly like iocost, and then try to
> pay debt. Fortunately, we already have 'carryover_bytes/ios' that
> already do this for the case that limit changes, and it'll be easy
> to do this for meta IO, just update 'carryover_bytes/ios' and dispatch
> directly.
> 

If there are many meta io, this solution may break the io throttle rules.

In this case, the blkcg associated with the buffer page doesn't set any io throttle conf.
So for meta io, maybe we can associate a bio with a blkg found from buffer page instead of
current thread context.

> BTW, this is another reason that we should add a new module in iocost to
> replace blk-throtl.
> 
> Thanks,
> Kuai
> 
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index dc6140fa3de0..38ffe0f95682 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -1595,6 +1595,32 @@ void blk_throtl_cancel_bios(struct gendisk *disk)
>         spin_unlock_irq(&q->queue_lock);
>  }
> 
> +static bool tg_within_limit(struct throtl_grp *tg, struct bio *bio, bool rw)
> +{
> +       struct throtl_service_queue *sq = &tg->service_queue;
> +
> +       /* throtl is FIFO - if bios are already queued, should queue */
> +       if (sq->nr_queued[rw])
> +               return false;
> +
> +       /* within limits, let's charge and dispatch directly */
> +       if (!tg_may_dispatch(tg, bio, NULL))
> +               return false;
> +
> +       return true;
> +}
> +
> +static void throtl_dispatch_bio_in_debt(struct throtl_grp *tg, struct bio *bio,
> +                                       bool rw)
> +{
> +       unsigned int bio_size = throtl_bio_data_size(bio);
> +
> +       if (!bio_flagged(bio, BIO_BPS_THROTTLED))
> +               tg->carryover_bytes[rw] -= bio_size;
> +
> +       tg->carryover_ios[rw]--;
> +}
> +
>  bool __blk_throtl_bio(struct bio *bio)
>  {
>         struct request_queue *q = bdev_get_queue(bio->bi_bdev);
> @@ -1611,34 +1637,28 @@ bool __blk_throtl_bio(struct bio *bio)
>         sq = &tg->service_queue;
> 
>         while (true) {
> -               if (tg->last_low_overflow_time[rw] == 0)
> -                       tg->last_low_overflow_time[rw] = jiffies;
> -               /* throtl is FIFO - if bios are already queued, should queue */
> -               if (sq->nr_queued[rw])
> -                       break;
> -
> -               /* if above limits, break to queue */
> -               if (!tg_may_dispatch(tg, bio, NULL)) {
> -                       tg->last_low_overflow_time[rw] = jiffies;
> +               if (tg_within_limit(tg, bio, rw)) {
> +                       /* within limits, let's charge and dispatch directly */
> +                       throtl_charge_bio(tg, bio);
> +
> +                       /*
> +                        * We need to trim slice even when bios are not being queued
> +                        * otherwise it might happen that a bio is not queued for
> +                        * a long time and slice keeps on extending and trim is not
> +                        * called for a long time. Now if limits are reduced suddenly
> +                        * we take into account all the IO dispatched so far at new
> +                        * low rate and * newly queued IO gets a really long dispatch
> +                        * time.
> +                        *
> +                        * So keep on trimming slice even if bio is not queued.
> +                        */
> +                       throtl_trim_slice(tg, rw);
> +               } else if (bio_issue_as_root_blkg(bio)) {
> +                       throtl_dispatch_bio_in_debt(tg, bio, rw);
> +               } else {
>                         break;
>                 }
> 
> -               /* within limits, let's charge and dispatch directly */
> -               throtl_charge_bio(tg, bio);
> -
> -               /*
> -                * We need to trim slice even when bios are not being queued
> -                * otherwise it might happen that a bio is not queued for
> -                * a long time and slice keeps on extending and trim is not
> -                * called for a long time. Now if limits are reduced suddenly
> -                * we take into account all the IO dispatched so far at new
> -                * low rate and * newly queued IO gets a really long dispatch
> -                * time.
> -                *
> -                * So keep on trimming slice even if bio is not queued.
> -                */
> -               throtl_trim_slice(tg, rw);
> -
>                 /*
>                  * @bio passed through this layer without being throttled.
>                  * Climb up the ladder.  If we're already at the top, it
> 
>>
>> Thanks,
>> Yi.
>>
>> .
>>
> 

