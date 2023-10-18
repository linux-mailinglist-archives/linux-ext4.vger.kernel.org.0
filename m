Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64CF87CD49F
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Oct 2023 08:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjJRGp6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Oct 2023 02:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjJRGp5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Oct 2023 02:45:57 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C0793
        for <linux-ext4@vger.kernel.org>; Tue, 17 Oct 2023 23:45:55 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-27d2b814912so3732477a91.0
        for <linux-ext4@vger.kernel.org>; Tue, 17 Oct 2023 23:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697611554; x=1698216354; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T+mkoCOxlBnE8cdgGUySBzxZS9WRePfqdR6MBbpz2KM=;
        b=S5uXuVtBrOmDlg/7WnH4EPtgRnlUcOSmyPTdaQeomVinSoZbikRbflvA+3MlY2ezEy
         H0hRzQ6jwfY0kZbXvN9J+shac2TdSNO1zD/AIkmcIbhlvosctdqebpl64wSrldVz/BGL
         Py+X4V5t94sTIA40NDIbIo309kIsu9jEHWLQpnyMdA33D46BHqO0r3BZL+oHr9WbkVl8
         x5abh808MtEH3AHuftzfYypVBwZnYdr4dpyS2b16QhCeM8p2b29fMtP19PPoR4iVcKSA
         O3o79hi6RoeLDMRpBEqe7P8K9wa0S7t9m5x616XrGJ53y+mCBx7QqukRENKu4CJ3FDJt
         I2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697611554; x=1698216354;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T+mkoCOxlBnE8cdgGUySBzxZS9WRePfqdR6MBbpz2KM=;
        b=v5ajMQJsQJfEyJJX3hUxHqLx2qCtLDsdx1EFTdagDGsgfires+1bfakaxgm7C0UKgW
         24xJByljciwCPblEG7NibXvg2HRMeNSY2D7HO6/1CftD+s434VdfxC9SHj5/JIpth2j2
         +QDOHs9nF81eggFkZYNRpeNgdkrT9Q34nigAMJKwxbQlkj7u4tzIFQYfpPDVTpmnA3EF
         gaKG0NkFCkBrwG/jD/6fCH8UqWFowEz2O7O1psZZebpdgpapW9qB8gw/dhVYAbAOmU5Q
         oChWRSeKwj5Ma7IMlZwJsA3Z0iItxpGTlA5x9I4YnCYNsgS7bliGU3J3o20ZDwZkeWNi
         6wfQ==
X-Gm-Message-State: AOJu0Yyi5jw4YVILAe6EjEP/ZA4q8DBRyc/lXhpB3KaNeAFDxs0MP1/M
        l+th044lHcgiPbWCCNIlmO4=
X-Google-Smtp-Source: AGHT+IFTmq9Ht9r1HdODaVCV/5ziHs71uGBJqgDMz1C2SJUAty6aQTqOau6jVUGhbWheGXewt16PVg==
X-Received: by 2002:a17:90a:8041:b0:273:b0bd:343b with SMTP id e1-20020a17090a804100b00273b0bd343bmr4421701pjw.41.1697611554559;
        Tue, 17 Oct 2023 23:45:54 -0700 (PDT)
Received: from [30.221.128.109] ([47.246.101.61])
        by smtp.gmail.com with ESMTPSA id 29-20020a17090a035d00b00273744e6eccsm663032pjf.12.2023.10.17.23.45.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 23:45:54 -0700 (PDT)
Message-ID: <f04981be-5dac-c1e9-36a7-762c6bcf4d32@gmail.com>
Date:   Wed, 18 Oct 2023 14:45:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v3] ext4: Properly sync file size update after O_SYNC
 direct IO
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Dave Chinner <david@fromorbit.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
References: <20231013121350.26872-1-jack@suse.cz>
From:   Joseph Qi <jiangqi903@gmail.com>
In-Reply-To: <20231013121350.26872-1-jack@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 10/13/23 8:13 PM, Jan Kara wrote:
> Gao Xiang has reported that on ext4 O_SYNC direct IO does not properly
> sync file size update and thus if we crash at unfortunate moment, the
> file can have smaller size although O_SYNC IO has reported successful
> completion. The problem happens because update of on-disk inode size is
> handled in ext4_dio_write_iter() *after* iomap_dio_rw() (and thus
> dio_complete() in particular) has returned and generic_file_sync() gets
> called by dio_complete(). Fix the problem by handling on-disk inode size
> update directly in our ->end_io completion handler.
> 
> References: https://lore.kernel.org/all/02d18236-26ef-09b0-90ad-030c4fe3ee20@linux.alibaba.com
> Reported-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> CC: stable@vger.kernel.org
> Fixes: 378f32bab371 ("ext4: introduce direct I/O write using iomap infrastructure")
> Signed-off-by: Jan Kara <jack@suse.cz>

Tested with the reproducer after applying to 6.6-rc5,
Tested-by: Joseph Qi <joseph.qi@linux.alibaba.com>

BTW, once backported to older kernel like 5.10, it seems that it depends
on the following commit:
936e114a245b iomap: update ki_pos a little later in iomap_dio_complete

Otherwise, it will fail the following xfstests cases:
generic/091 generic/094 generic/225 generic/263 generic/311 generic/617

Thanks,
Joseph
