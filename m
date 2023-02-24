Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869A36A15F9
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Feb 2023 05:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjBXElM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Feb 2023 23:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBXElL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Feb 2023 23:41:11 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1266951935
        for <linux-ext4@vger.kernel.org>; Thu, 23 Feb 2023 20:41:07 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id cp7-20020a17090afb8700b0023756229427so1600266pjb.1
        for <linux-ext4@vger.kernel.org>; Thu, 23 Feb 2023 20:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:subject:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AFUYps0HUMG3OmxfJ+WXl5vumveFSsw4B3OfY48z7wk=;
        b=ckdQLx7ODw6oWEytRBRtGG10wn2EEKUcRTQxVIKGF34cLmjZmXq8TPaKHP9JP17y7s
         F8UcObzHNQXpVk5GihvVzIITf5i1Vi3zqSbwEAEiAtMQR9UUniL1DAl8lJpc+EA9n1Rb
         EW8p5BKWj0IiRWJXlxFfWVBl8jPQ+j08RAP5JlL2fqrsRvIN97bM1m5ueCVJjOVagcYw
         Nw9nvRK8jLNjVLMD2X+9daUtdIKPQ/j12dqC/yOw7C9bt2dD7zZWS7c+4kLUN8LyAvJv
         pi/gO2d41eEHhdlASPRkJcUgVUq3ZdFztkQwE1kFS6lrt57csXJkafdHAnjEWeAtvOjd
         +M2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:subject:to:from:message-id:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AFUYps0HUMG3OmxfJ+WXl5vumveFSsw4B3OfY48z7wk=;
        b=opKxcKul426poJIuGlwM44drYdldFDfuSLY0uc6q3KQj3rhGFlp3s/+sFkVM1y1Zm5
         QeyEyKiWwP8ruooUKZzjpx0G0JtkfkY7okc8w9ONtSv96Rnr/49trYrx8CXZsGfIjNwx
         JLm8j5N8kc/ReWqYYwPZVx+tEh63M5Z2kLKedWvPsfXtx5FhzNjUhET7kIEuQs4U64pR
         MYgrIIwkGuGwcZUky+hRth4Xmdqp+Tx3YMBxLOHDs78Td3NLYfARCnd5HWrMhtra2Xxf
         U3eBVRsuJ9qtcV1Lki2KNClqoCuGb0GmBak4PtWj3EnpLi9UC81ymqwub/dblN6khxH8
         RptQ==
X-Gm-Message-State: AO0yUKWuEqtX5Gg2rvFuLh/WhZO8iratryQTN4z/90Px09VlnNFszr9H
        Mf3iXp79SL8+rvlmYVVsBkBEUItMKEo=
X-Google-Smtp-Source: AK7set/yXrLtgyNWI4DJruiNqv0kCX43IU+3lrKzgdbhS+N6MsVHemlX8P/TDe6iiwbQiyD7b2GXaA==
X-Received: by 2002:a17:902:820a:b0:19c:a866:6a76 with SMTP id x10-20020a170902820a00b0019ca8666a76mr6786309pln.42.1677213666193;
        Thu, 23 Feb 2023 20:41:06 -0800 (PST)
Received: from rh-tp ([129.41.58.22])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902b10c00b00192a8b35fa3sm4832052plr.122.2023.02.23.20.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 20:41:05 -0800 (PST)
Date:   Fri, 24 Feb 2023 10:10:40 +0530
Message-Id: <87v8jrekvr.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Brian Foster <bfoster@redhat.com>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: allow concurrent unaligned dio overwrites
In-Reply-To: <20230223191626.263331-1-bfoster@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Brian Foster <bfoster@redhat.com> writes:

> We've had reports of significant performance regression of sub-block
> (unaligned) direct writes due to the added exclusivity restrictions
> in ext4. The purpose of the exclusivity requirement for unaligned
> direct writes is to avoid data corruption caused by unserialized
> partial block zeroing in the iomap dio layer across overlapping
> writes.
>
> XFS has similar requirements for the same underlying reasons, yet
> doesn't suffer the extreme performance regression that ext4 does.
> The reason for this is that XFS utilizes IOMAP_DIO_OVERWRITE_ONLY
> mode, which allows for optimistic submission of concurrent unaligned
> I/O and kicks back writes that require partial block zeroing such
> that they can be submitted in a safe, exclusive context. Since ext4
> already performs most of these checks pre-submission, it can support
> something similar without necessarily relying on the iomap flag and
> associated retry mechanism.
>
> Update the dio write submission path to allow concurrent submission
> of unaligned direct writes that are purely overwrite and so will not
> require block zeroing. To improve readability of the various related
> checks, move the unaligned I/O handling down into
> ext4_dio_write_checks(), where the dio draining and force wait logic
> can immediately follow the locking requirement checks. Finally, the
> IOMAP_DIO_OVERWRITE_ONLY flag is set to enable a warning check as a
> precaution should the ext4 overwrite logic ever become inconsistent
> with the zeroing expectations of iomap dio.
>
> The performance improvement of sub-block direct write I/O is shown
> in the following fio test on a 64xcpu guest vm:
>
> Test: fio --name=test --ioengine=libaio --direct=1 --group_reporting
> --overwrite=1 --thread --size=10G --filename=/mnt/fio
> --readwrite=write --ramp_time=10s --runtime=60s --numjobs=8
> --blocksize=2k --iodepth=256 --allow_file_create=0
>
> v6.2:		write: IOPS=4328, BW=8724KiB/s
> v6.2 (patched):	write: IOPS=801k, BW=1565MiB/s
>
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> ---
>
> Hi all,
>
> This survives a couple fstests regression runs (with 4k and 2k block
> sizes) and cleans up the code a bit from the RFC, taking a suggestion
> from Ritesh to move some of the checks into ext4_dio_write_checks().

Thanks for working on the suggestion and rebasing on top.
I liked the way this patch has turned out to be. It's very clear now.

Thanks again for the optimization!!
Looks good to me. Please feel free to add -

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
