Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C21699B6E
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Feb 2023 18:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjBPRmY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Feb 2023 12:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjBPRmY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Feb 2023 12:42:24 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11454FA84
        for <linux-ext4@vger.kernel.org>; Thu, 16 Feb 2023 09:42:20 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id d2so2595883pjd.5
        for <linux-ext4@vger.kernel.org>; Thu, 16 Feb 2023 09:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iZ0HLrrvozdJn9sj6AaOl/7JjV51P+P1/OFqWsyDRrM=;
        b=II+SgYarD6Mhph9BjJQpNXZ1BbWYev/QFBhh3+XqjjXbyZRxZm2WHNhnjmGiQRBwkz
         B7VKogy+DY3qr9ec89KXZTjxdjoY1euKb2jbL6jF3k9JP43KtvHYaFFuh0Ez8RGH4+BY
         yLk9WwMPiXLI1Ida167qTonRJ5Rv3+EjhGE+TgWijU5cRoQ1nY7xkbIuNajhGSRoLDVm
         MrU9wTMIFCDvMZ4e/k3Qeprxl7DWE5HccRxUQWEjHhzdmJELAiha9q+5onmENSfZTvAO
         zN1W4pamV1IsirNcaWXXWpTJu3gKgyp2W6Un9vDnmvgLxqPzEQyFddsMzxn2U3hbzuPB
         4vEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iZ0HLrrvozdJn9sj6AaOl/7JjV51P+P1/OFqWsyDRrM=;
        b=wINxoT0ko6ls4hdE6UDarv2+tuaFe+QZBZHNBKIkfZ3EMZUf8fkWpWUd5QmyNhDf/B
         jou8mII1xsbXGRkXg5Pg79DzecEaiLmB89QEBd5RkiOUSNt/Nr8/nWJj6HNZ0rp8xxX8
         3BttZrps5fhvCG+6IxWGBLFNRnl+Ql6dMf1rpgPUHW25NwKeA/xDtwFgbr9/3b9ZWRI/
         NxYIvq8KzOAIPkPqHI9JQDCq+robRyufy3RKX1IaIxg7tSZRhzVDTknTphAwl57jPmZO
         xcr1Rv6MtCht1rI+a9iZXahDZHiFCpwIxDZT0DHdD1uFteB9GHQfJMiWCGOI9IEO0bDo
         X/5w==
X-Gm-Message-State: AO0yUKXk8gK1AzaLyYNDQuHZ/Iqu54UnZtgR9wadO74K9SFWubiYjRT5
        pYWEhxJZYn/btSPqVICuhWpxxRlWF1JRuQ==
X-Google-Smtp-Source: AK7set8a+W0u/kd5Vz+tgSPWW1MSjbMDbav4v9GU1UTzrhVGHRS5mcd0d+TQkLyQ7seFt3CY7Uz/rw==
X-Received: by 2002:a17:902:d1cd:b0:19a:9610:b242 with SMTP id g13-20020a170902d1cd00b0019a9610b242mr5562108plb.62.1676569340033;
        Thu, 16 Feb 2023 09:42:20 -0800 (PST)
Received: from rh-tp ([2406:7400:63:5056:148f:873b:4bc8:1e77])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902e9c600b0019a87514e00sm1575998plk.177.2023.02.16.09.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 09:42:19 -0800 (PST)
Date:   Thu, 16 Feb 2023 23:11:58 +0530
Message-Id: <87cz69ld7d.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Zhang Yi <yi.zhang@huaweicloud.com>, linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yi.zhang@huaweicloud.com, yukuai3@huawei.com,
        Brian Foster <bfoster@redhat.com>
Subject: Re: [RFC PATCH v2] ext4: dio take shared inode lock when overwriting preallocated blocks
In-Reply-To: <20221226062015.3479416-1-yi.zhang@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Zhang Yi <yi.zhang@huaweicloud.com> writes:

> From: Zhang Yi <yi.zhang@huawei.com>
>
> In the dio write path, we only take shared inode lock for the case of
> aligned overwriting initialized blocks inside EOF. But for overwriting
> preallocated blocks, it may only need to split unwritten extents, this
> procedure has been protected under i_data_sem lock, it's safe to
> release the exclusive inode lock and take shared inode lock.

Ok. One question though. Should we be passing IOMAP_DIO_FORCE_WAIT
(in this case as well) which will wait for the completion of dio
request even if the submitted IO is not synchronous. Like how it's being
done for unaligned overwrites case [1].
What I am mostly curious to know about is, how do we take care of
unwritten
to written conversion without racing which can happen in a
seperate workqueue context and/or are there any zeroing of extents
involved in this scenario which can race with one another?

So, I think in case of a non-aligned write it make sense [1] because it
might involve zeroing of the partial blocks. But in this case as you
said this already happens within i_data_sem lock context, so it won't be
necessary. I still thought it will be worth while to confirm it's indeed
the case or not.

[1]:
https://lore.kernel.org/linux-ext4/20230210145954.277611-1-bfoster@redhat.com/

Oh, one of the patch might run into some patch conflict depending upon
which one gets picked first...

-ritesh


>
> This could give a significant speed up for multi-threaded writes. Test
> on Intel Xeon Gold 6140 and nvme SSD with below fio parameters.
>
>  direct=1
>  ioengine=libaio
>  iodepth=10
>  numjobs=10
>  runtime=60
>  rw=randwrite
>  size=100G
>
> And the test result are:
> Before:
>  bs=4k       IOPS=11.1k, BW=43.2MiB/s
>  bs=16k      IOPS=11.1k, BW=173MiB/s
>  bs=64k      IOPS=11.2k, BW=697MiB/s
>
> After:
>  bs=4k       IOPS=41.4k, BW=162MiB/s
>  bs=16k      IOPS=41.3k, BW=646MiB/s
>  bs=64k      IOPS=13.5k, BW=843MiB/s
>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
> v2->v1:
>  - Negate the 'inited' related arguments to 'unwritten'.
>
>  fs/ext4/file.c | 34 ++++++++++++++++++++++------------
>  1 file changed, 22 insertions(+), 12 deletions(-)
>
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index a7a597c727e6..21abe95a0ee7 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -202,8 +202,9 @@ ext4_extending_io(struct inode *inode, loff_t offset, size_t len)
>  	return false;
>  }
>
> -/* Is IO overwriting allocated and initialized blocks? */
> -static bool ext4_overwrite_io(struct inode *inode, loff_t pos, loff_t len)
> +/* Is IO overwriting allocated or initialized blocks? */
> +static bool ext4_overwrite_io(struct inode *inode,
> +			      loff_t pos, loff_t len, bool *unwritten)
>  {
>  	struct ext4_map_blocks map;
>  	unsigned int blkbits = inode->i_blkbits;
> @@ -217,12 +218,15 @@ static bool ext4_overwrite_io(struct inode *inode, loff_t pos, loff_t len)
>  	blklen = map.m_len;
>
>  	err = ext4_map_blocks(NULL, inode, &map, 0);
> +	if (err != blklen)
> +		return false;
>  	/*
>  	 * 'err==len' means that all of the blocks have been preallocated,
> -	 * regardless of whether they have been initialized or not. To exclude
> -	 * unwritten extents, we need to check m_flags.
> +	 * regardless of whether they have been initialized or not. We need to
> +	 * check m_flags to distinguish the unwritten extents.
>  	 */
> -	return err == blklen && (map.m_flags & EXT4_MAP_MAPPED);
> +	*unwritten = !(map.m_flags & EXT4_MAP_MAPPED);
> +	return true;
>  }
>
>  static ssize_t ext4_generic_write_checks(struct kiocb *iocb,
> @@ -431,11 +435,16 @@ static const struct iomap_dio_ops ext4_dio_write_ops = {
>   * - For extending writes case we don't take the shared lock, since it requires
>   *   updating inode i_disksize and/or orphan handling with exclusive lock.
>   *
> - * - shared locking will only be true mostly with overwrites. Otherwise we will
> - *   switch to exclusive i_rwsem lock.
> + * - shared locking will only be true mostly with overwrites, including
> + *   initialized blocks and unwritten blocks. For overwrite unwritten blocks
> + *   we protect splitting extents by i_data_sem in ext4_inode_info, so we can
> + *   also release exclusive i_rwsem lock.
> + *
> + * - Otherwise we will switch to exclusive i_rwsem lock.
>   */
>  static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
> -				     bool *ilock_shared, bool *extend)
> +				     bool *ilock_shared, bool *extend,
> +				     bool *unwritten)
>  {
>  	struct file *file = iocb->ki_filp;
>  	struct inode *inode = file_inode(file);
> @@ -459,7 +468,7 @@ static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
>  	 * in file_modified().
>  	 */
>  	if (*ilock_shared && (!IS_NOSEC(inode) || *extend ||
> -	     !ext4_overwrite_io(inode, offset, count))) {
> +	     !ext4_overwrite_io(inode, offset, count, unwritten))) {
>  		if (iocb->ki_flags & IOCB_NOWAIT) {
>  			ret = -EAGAIN;
>  			goto out;
> @@ -491,7 +500,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  	loff_t offset = iocb->ki_pos;
>  	size_t count = iov_iter_count(from);
>  	const struct iomap_ops *iomap_ops = &ext4_iomap_ops;
> -	bool extend = false, unaligned_io = false;
> +	bool extend = false, unaligned_io = false, unwritten = false;
>  	bool ilock_shared = true;
>
>  	/*
> @@ -534,7 +543,8 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  		return ext4_buffered_write_iter(iocb, from);
>  	}
>
> -	ret = ext4_dio_write_checks(iocb, from, &ilock_shared, &extend);
> +	ret = ext4_dio_write_checks(iocb, from,
> +				    &ilock_shared, &extend, &unwritten);
>  	if (ret <= 0)
>  		return ret;
>
> @@ -582,7 +592,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  		ext4_journal_stop(handle);
>  	}
>
> -	if (ilock_shared)
> +	if (ilock_shared && !unwritten)
>  		iomap_ops = &ext4_iomap_overwrite_ops;
>  	ret = iomap_dio_rw(iocb, from, iomap_ops, &ext4_dio_write_ops,
>  			   (unaligned_io || extend) ? IOMAP_DIO_FORCE_WAIT : 0,
> --
> 2.31.1
