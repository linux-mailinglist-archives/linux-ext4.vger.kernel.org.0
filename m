Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 766832D58CD
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Dec 2020 12:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732986AbgLJLBi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Dec 2020 06:01:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732895AbgLJLB0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Dec 2020 06:01:26 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4D5C0613CF
        for <linux-ext4@vger.kernel.org>; Thu, 10 Dec 2020 03:00:46 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id v3so2571580plz.13
        for <linux-ext4@vger.kernel.org>; Thu, 10 Dec 2020 03:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A/B/TMC4m/KOiElN1kAnJ1ZdckJKUitgHTM8C8zOfSY=;
        b=OtJysURBebZYAlh1rxkhwBVmNJ5G/EAYg+EAjQmdwszTd7MH7NhlvI99jHJa/VOPKt
         qVN9P7HNucIgPrcu52RM/ZTXdPU+2ZkV5RfuzwVPNUkfE12cEPmQsmd87XZypDxfAPZx
         73RZnxJ7Rk6iDwHXWhyKH5nKMC5CWy7HPSRdmVPUFLNIvTGXdfMiMrLJUSWdm3scObTc
         08tdjFe1Do4SI11VRyjDexSN4hOFajtFpMRCNliGVE296C8VzOvZ+M1kCW3HFvFU4oqk
         JZy5+7I1RebqGVkBjUULQ/FXtAP60sI96WsikkWPr7XFXq8KenWgJH2yJVHRN9V5RoOB
         9j7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A/B/TMC4m/KOiElN1kAnJ1ZdckJKUitgHTM8C8zOfSY=;
        b=hMzBDj8/1GS0zpCkx4Mq09NvY1zOfbmudxEcz80QSci/K5cs8MWoDbtA6xWz+Sai6U
         VAnWTjv9f3dFjN5Qc9w6Ud+2q4u0R8LJJNySvAyMowdR5DVgUy29PVRgmQortbvgobox
         ZtPA9Em515eMPlpKE6xMfu8dwuD54v4dmIrYOgdfUuyIgq6weLd3EdaUCC49lK7keUc2
         qS/TH2stL9Nz0CsfAp8G/H0fSIAVea8cgWEuIwZUEKjFrb7OHUPZISfq6n9LZpkeqZ7g
         ROmx+jOwwJ7ey2bbkMhbx9dTO0l7l3nh17G6obvZ6QLsjJWi9xFgr+zPgj2HLpf11ifn
         0hEQ==
X-Gm-Message-State: AOAM531+jRM03st/sFptwUUxvbaSc/3+y4k6JU69KcW7MN4RfSK0xEzK
        QEVXoFukpTXgwONswnAKTca1MUTrkVo=
X-Google-Smtp-Source: ABdhPJztetQZc1LZdGVg7rd3mlS1Xai3icQ8BmgxQStQ6+QwDO//CyMSY3OU/FsyuDOQXqTcQFJuEQ==
X-Received: by 2002:a17:902:854b:b029:db:c725:edcd with SMTP id d11-20020a170902854bb02900dbc725edcdmr5905005plo.64.1607598045629;
        Thu, 10 Dec 2020 03:00:45 -0800 (PST)
Received: from [127.0.0.1] ([203.205.141.49])
        by smtp.gmail.com with ESMTPSA id a1sm5710874pfo.56.2020.12.10.03.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 03:00:45 -0800 (PST)
Subject: Re: [PATCH RESEND 4/8] ext4: add the gdt block of meta_bg to
 system_zone
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
References: <1604764698-4269-1-git-send-email-brookxu@tencent.com>
 <1604764698-4269-4-git-send-email-brookxu@tencent.com>
 <20201203150841.GM441757@mit.edu>
 <4770d6b2-bb9f-7bc5-4fbd-2104bfeba7c2@gmail.com>
 <20201209043415.GG52960@mit.edu>
 <dd6c2921-1397-4b1a-5a20-23956f9cf956@gmail.com>
 <20201209193935.GO52960@mit.edu>
From:   brookxu <brookxu.cn@gmail.com>
Message-ID: <87352ab8-b57d-d4bc-6e3d-d4823ab4a38d@gmail.com>
Date:   Thu, 10 Dec 2020 19:00:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201209193935.GO52960@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



Theodore Y. Ts'o wrote on 2020/12/10 3:39:
> On Wed, Dec 09, 2020 at 07:48:09PM +0800, brookxu wrote:
>>
>> Maybe I missed something. If i% meta_bg_size is used instead, if
>> flex_size <64, then we will miss some flex_bg. There seems to be
>> a contradiction here. In the scenario where only flex_bg is
>> enabled, it may not be appropriate to use meta_bg_size. In the
>> scenario where only meta_bg is enabled, it may not be appropriate
>> to use flex_size.
>>
>> As you said before, it maybe better to remove
>>
>> 	if ((i <5) || ((i% flex_size) == 0))
>>
>> and do it for all groups.
> 
> I don't think the original (i % flex_size) made any sense in the first
> place.
> 
> What flex_bg does is that it collects the allocation bitmaps and inode
> tables for each block group and locates them within the first block
> group in a flex_bg.  It doesn't have anything to do with whether or
> not a particular block group has a backup copy of the superblock and
> block group descriptor table --- in non-meta_bg file systems and the
> meta_bg file systems where the block group is less than
> s_first_meta_bg * EXT4_DESC_PER_BLOCK(sb).  And the condition in
> question is only about whether or not to add the backup superblock and
> backup block group descriptors.  So checking for i % flex_size made no
> sense, and I'm not sure that check was there in the first place.

I think we should add backup sb and gdt to system_zone, because
these blocks should not be used by applications. In fact, I
think we may have done some work.

>> In this way weh won't miss some flex_bg, meta_bg, and sparse_bg.
>> I tested it on an 80T disk and found that the performance loss
>> was small:
>>
>>  unpatched kernel:
>>  ext4_setup_system_zone() takes 524ms, 
>>
>>  patched kernel:
>>  ext4_setup_system_zone() takes 552ms, 
> 
> I don't really care that much about the time it takes to execute
> ext4_setup_system_zone().
> 
> The really interesting question is how large is the rb_tree
> constructed by that function, and what is the percentage increase of
> time that the ext4_inode_block_valid() function takes.  (e.g., how
> much additional memory is the system_blks tree taking, and how deep is
> that tree, since ext4_inode_block_valid() gets called every time we
> allocate or free a block, and every time we need to validate an extent
> tree node.

During detailed analysis, I found that when the current logic
calls ext4_setup_system_zone(), s_log_groups_per_flex has not
been initialized, and flex_size is always 1, which seems to
be a mistake. therefore

if (ext4_bg_has_super(sb, i) &&
                    ((i <5) || ((i% flex_size) == 0)))

Degenerate to

if (ext4_bg_has_super(sb, i))

So, the existing implementation just adds the backup super
block in sparse_group to system_zone. Due to this mistake,
the behavior of the system in the flex_bg scenario happens to
be correct?

I tested it in three scenarios: only meta_bg, only flex_bg,
both flex_bg and meta_bg were enabled. The test results are as
follows:

Meta_bg only
 unpacthed kernel:
 ext4_setup_system_zone time 866 count 1309087
 
 pacthed kernel:
 ext4_setup_system_zone time 841 count 1309087

Since the backup gdt of meta_bg and BB are connected, they can
be merged, so no additional nodes are added.

Flex_bg only
 unpacthed kernel:
 ext4_setup_system_zone time 529 count 41016

 pacthed kernel:
 ext4_setup_system_zone time 553 count 41016

The system behavior has not changed. All sparse_group backup sb
and gdt are still added, so no additional nodes are added.

Meta_bg & Flex_bg only
 unpacthed kernel:
 ext4_setup_system_zone time 535 count 41016
 
 pacthed kernel:
 ext4_setup_system_zone time 571 count 61508

In addition to sparse_group, the system needs to add the backup
gdt of meta_bg to the system. Set

	N=max(flex_bg_size / meta_bg_size, 1)

then every N meta_bg has a gdt block that can be merged into 
the node corresponding to flex_bg, such as flex_bg_size < meta_bg_size,
then the number of new nodes is 2 * nr_meta_bg. On this 80T
disk, the maximum depth of rbtree is 2log(n+1). According to
this calculation, in this test case, the depth of rbtree is
not increased. Thus, there is no major performance overhead.

Maybe we can deal with it in the same way as discussed before?

> Cheers,
> 
> 						- Ted
> 
