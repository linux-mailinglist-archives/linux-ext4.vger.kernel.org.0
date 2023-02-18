Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF18369B7D3
	for <lists+linux-ext4@lfdr.de>; Sat, 18 Feb 2023 03:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjBRC4I (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Feb 2023 21:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBRC4H (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Feb 2023 21:56:07 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6C469296
        for <linux-ext4@vger.kernel.org>; Fri, 17 Feb 2023 18:56:03 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id o3so1469606pga.1
        for <linux-ext4@vger.kernel.org>; Fri, 17 Feb 2023 18:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tD30A3D0TbwSF1oJZbHS1ulezSBPsZM0IXbYwmoBkis=;
        b=KWsJWiEt+huqL7Auf/gv3gSe6hPu83i1mpt2ctCy5l3k/065p0xsqFcv6z/XRmNcEg
         vjUcQgIp/2sic3YL9MXaXlZuLQy6rsIE796f2ACIAVXrZ2QEtidYGZwh22YZlQizWPkT
         eSs09bQnW0JjWtQ2ccl1f8hflP5UKc9dqKLLtZtoSihylJEb9yNehMk8jlTnxafGbKf5
         C03sOR6LHssG7rdXNQ/vzdPRtYvxbyhnjMADM/liwCyaH7hTuMW8/fVbV/Md3LqRtzAk
         O8hiSLpxLxaj0HpLZdhqG2LwDt5tGAYjXDJwz7SmGIg/pN76TxQk8qukogdjFnG1xqd8
         wbZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tD30A3D0TbwSF1oJZbHS1ulezSBPsZM0IXbYwmoBkis=;
        b=boE2l0xNMdghgZ/+aXUd3JP/0LVLjljj0X6OpIk88OwW1VX5qE/Om//TOr7G870r3e
         ZlOnd/dQKuhU5gRivV35JMrIg+bH/9DAfyFBmPjfw5DY+KoeZ5E2py0VpgjLNF6SoxCP
         J0eEoM3Sil4KT5atcv2wIs9HNncNslWGRR8P5FJ//shtwb2W+E31XGCJai9L8yCDRQv8
         kHAE2AHnkD+wiZHmRsIqQksDJgpjGSz8jzRjHjXhY1a8NZOq/xM8Lg9lNC7QUrHTiGq1
         dqPREQMyYk5YiAxX/Dss9kkHQS5vgfmuxSf3C7qTiTLQX98IIGYM+yjBmvKfakGw4sR5
         cJ0Q==
X-Gm-Message-State: AO0yUKU/ifOfkwIQMQk3WwYYsDVFNSZlwYp+IGWW1cYH53Q3wZ0h8tmP
        zdGfg4TiJpyrRJoDp7lLzs60EFyg01JRuQ==
X-Google-Smtp-Source: AK7set+mFwODXFmB1G3MOas8vgRPzEl/yf3ECMAG8qYCro5YWjyNddqhoB5QP0DIUBNKdyJO6xB1Rw==
X-Received: by 2002:aa7:8bcd:0:b0:5a9:d676:ae58 with SMTP id s13-20020aa78bcd000000b005a9d676ae58mr4020162pfd.13.1676688962499;
        Fri, 17 Feb 2023 18:56:02 -0800 (PST)
Received: from rh-tp ([2406:7400:63:5056:148f:873b:4bc8:1e77])
        by smtp.gmail.com with ESMTPSA id k10-20020aa790ca000000b005accb31201fsm363425pfk.26.2023.02.17.18.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 18:56:01 -0800 (PST)
Date:   Sat, 18 Feb 2023 13:43:25 +0530
Message-Id: <873573z90a.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Zhang Yi <yi.zhang@huaweicloud.com>, linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yukuai3@huawei.com,
        Brian Foster <bfoster@redhat.com>
Subject: Re: [RFC PATCH v2] ext4: dio take shared inode lock when overwriting preallocated blocks
In-Reply-To: <ed78744f-5494-a5aa-0ebb-e66c6588edb0@huaweicloud.com>
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Zhang Yi <yi.zhang@huaweicloud.com> writes:

> Hello.
>
> On 2023/2/17 1:41, Ritesh Harjani (IBM) wrote:
>> Zhang Yi <yi.zhang@huaweicloud.com> writes:
>>
>>> From: Zhang Yi <yi.zhang@huawei.com>
>>>
>>> In the dio write path, we only take shared inode lock for the case of
>>> aligned overwriting initialized blocks inside EOF. But for overwriting
>>> preallocated blocks, it may only need to split unwritten extents, this
>>> procedure has been protected under i_data_sem lock, it's safe to
>>> release the exclusive inode lock and take shared inode lock.
>>
>> Ok. One question though. Should we be passing IOMAP_DIO_FORCE_WAIT
>> (in this case as well) which will wait for the completion of dio
>> request even if the submitted IO is not synchronous. Like how it's being
>> done for unaligned overwrites case [1].
>> What I am mostly curious to know about is, how do we take care of
>> unwritten
>> to written conversion without racing which can happen in a
>> seperate workqueue context and/or are there any zeroing of extents
>> involved in this scenario which can race with one another?
>>
>> So, I think in case of a non-aligned write it make sense [1] because it
>> might involve zeroing of the partial blocks. But in this case as you
>> said this already happens within i_data_sem lock context, so it won't be
>> necessary. I still thought it will be worth while to confirm it's indeed
>> the case or not.
>>
>
> I'm not quite get your question, do you mean passing IOMAP_DIO_FORCE_WAIT
> for the case of unaligned writing to pre-allocated(unwritten) blocks?
> IIUC, That's how it's done now if you only merge my patch. And it should be
> cautious to slove the conflict if you also want to merge [1] together.
>
> After looking at [1], I think it should be:
>
>            |  pure overwrite       |  write to pre-allocated |
> -------------------------------------------------------------|
> aligned    | share lock, nowait (1)| share lock, nowait  (3) |
> unaligned  | share lock, nowait (2)| excl lock, wait     (4) |
>
> In case(3), each AIO-DIO's unwritten->written conversion do not disturb each
> other because of the i_data_sem lock, and the potential zeroing extents(e.g.
> ext4_zero_range()) also call inode_dio_wait() to wait DIO complete. So I don't
> find any race problem.

aah yes. Looks like we don't need IOMAP_DIO_FORCE_WAIT then for aligned
unwritten overwrite.
Because as you said conversion will be synchronized with i_data_sem lock
and other's (e.g. ext4_zero_range()) will synchronize using inode_dio_wait().

Make sense. Thanks for confirming it!!

Looks good to me. Feel free to add -

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

-ritesh

>
> Am I missing something? or which case you want to confirm?
>
> Thanks,
> Yi.
>
>> [1]:
>> https://lore.kernel.org/linux-ext4/20230210145954.277611-1-bfoster@redhat.com/
>>
>> Oh, one of the patch might run into some patch conflict depending upon
>> which one gets picked first...
>>
>> -ritesh
>>
>>
>>>
>>> This could give a significant speed up for multi-threaded writes. Test
>>> on Intel Xeon Gold 6140 and nvme SSD with below fio parameters.
>>>
>>>  direct=1
>>>  ioengine=libaio
>>>  iodepth=10
>>>  numjobs=10
>>>  runtime=60
>>>  rw=randwrite
>>>  size=100G
>>>
>>> And the test result are:
>>> Before:
>>>  bs=4k       IOPS=11.1k, BW=43.2MiB/s
>>>  bs=16k      IOPS=11.1k, BW=173MiB/s
>>>  bs=64k      IOPS=11.2k, BW=697MiB/s
>>>
>>> After:
>>>  bs=4k       IOPS=41.4k, BW=162MiB/s
>>>  bs=16k      IOPS=41.3k, BW=646MiB/s
>>>  bs=64k      IOPS=13.5k, BW=843MiB/s
>>>
>>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>>> ---
>>> v2->v1:
>>>  - Negate the 'inited' related arguments to 'unwritten'.
>>>
>>>  fs/ext4/file.c | 34 ++++++++++++++++++++++------------
>>>  1 file changed, 22 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
>>> index a7a597c727e6..21abe95a0ee7 100644
>>> --- a/fs/ext4/file.c
>>> +++ b/fs/ext4/file.c
>>> @@ -202,8 +202,9 @@ ext4_extending_io(struct inode *inode, loff_t offset, size_t len)
>>>  	return false;
>>>  }
>>>
>>> -/* Is IO overwriting allocated and initialized blocks? */
>>> -static bool ext4_overwrite_io(struct inode *inode, loff_t pos, loff_t len)
>>> +/* Is IO overwriting allocated or initialized blocks? */
>>> +static bool ext4_overwrite_io(struct inode *inode,
>>> +			      loff_t pos, loff_t len, bool *unwritten)
>>>  {
>>>  	struct ext4_map_blocks map;
>>>  	unsigned int blkbits = inode->i_blkbits;
>>> @@ -217,12 +218,15 @@ static bool ext4_overwrite_io(struct inode *inode, loff_t pos, loff_t len)
>>>  	blklen = map.m_len;
>>>
>>>  	err = ext4_map_blocks(NULL, inode, &map, 0);
>>> +	if (err != blklen)
>>> +		return false;
>>>  	/*
>>>  	 * 'err==len' means that all of the blocks have been preallocated,
>>> -	 * regardless of whether they have been initialized or not. To exclude
>>> -	 * unwritten extents, we need to check m_flags.
>>> +	 * regardless of whether they have been initialized or not. We need to
>>> +	 * check m_flags to distinguish the unwritten extents.
>>>  	 */
>>> -	return err == blklen && (map.m_flags & EXT4_MAP_MAPPED);
>>> +	*unwritten = !(map.m_flags & EXT4_MAP_MAPPED);
>>> +	return true;
>>>  }
>>>
>>>  static ssize_t ext4_generic_write_checks(struct kiocb *iocb,
>>> @@ -431,11 +435,16 @@ static const struct iomap_dio_ops ext4_dio_write_ops = {
>>>   * - For extending writes case we don't take the shared lock, since it requires
>>>   *   updating inode i_disksize and/or orphan handling with exclusive lock.
>>>   *
>>> - * - shared locking will only be true mostly with overwrites. Otherwise we will
>>> - *   switch to exclusive i_rwsem lock.
>>> + * - shared locking will only be true mostly with overwrites, including
>>> + *   initialized blocks and unwritten blocks. For overwrite unwritten blocks
>>> + *   we protect splitting extents by i_data_sem in ext4_inode_info, so we can
>>> + *   also release exclusive i_rwsem lock.
>>> + *
>>> + * - Otherwise we will switch to exclusive i_rwsem lock.
>>>   */
>>>  static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
>>> -				     bool *ilock_shared, bool *extend)
>>> +				     bool *ilock_shared, bool *extend,
>>> +				     bool *unwritten)
>>>  {
>>>  	struct file *file = iocb->ki_filp;
>>>  	struct inode *inode = file_inode(file);
>>> @@ -459,7 +468,7 @@ static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
>>>  	 * in file_modified().
>>>  	 */
>>>  	if (*ilock_shared && (!IS_NOSEC(inode) || *extend ||
>>> -	     !ext4_overwrite_io(inode, offset, count))) {
>>> +	     !ext4_overwrite_io(inode, offset, count, unwritten))) {
>>>  		if (iocb->ki_flags & IOCB_NOWAIT) {
>>>  			ret = -EAGAIN;
>>>  			goto out;
>>> @@ -491,7 +500,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>>>  	loff_t offset = iocb->ki_pos;
>>>  	size_t count = iov_iter_count(from);
>>>  	const struct iomap_ops *iomap_ops = &ext4_iomap_ops;
>>> -	bool extend = false, unaligned_io = false;
>>> +	bool extend = false, unaligned_io = false, unwritten = false;
>>>  	bool ilock_shared = true;
>>>
>>>  	/*
>>> @@ -534,7 +543,8 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>>>  		return ext4_buffered_write_iter(iocb, from);
>>>  	}
>>>
>>> -	ret = ext4_dio_write_checks(iocb, from, &ilock_shared, &extend);
>>> +	ret = ext4_dio_write_checks(iocb, from,
>>> +				    &ilock_shared, &extend, &unwritten);
>>>  	if (ret <= 0)
>>>  		return ret;
>>>
>>> @@ -582,7 +592,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>>>  		ext4_journal_stop(handle);
>>>  	}
>>>
>>> -	if (ilock_shared)
>>> +	if (ilock_shared && !unwritten)
>>>  		iomap_ops = &ext4_iomap_overwrite_ops;
>>>  	ret = iomap_dio_rw(iocb, from, iomap_ops, &ext4_dio_write_ops,
>>>  			   (unaligned_io || extend) ? IOMAP_DIO_FORCE_WAIT : 0,
>>> --
>>> 2.31.1
