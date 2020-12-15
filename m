Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C48F2DA577
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Dec 2020 02:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgLOBOv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 14 Dec 2020 20:14:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbgLOBOq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 14 Dec 2020 20:14:46 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36F4C061793
        for <linux-ext4@vger.kernel.org>; Mon, 14 Dec 2020 17:14:05 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id h186so2966400pfe.0
        for <linux-ext4@vger.kernel.org>; Mon, 14 Dec 2020 17:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vTvDNWdEA4hZKsryJgBlw03/sVfatrcozcTg5ftj3hs=;
        b=O2cK33pEOjWVCyRNZON4p77SrGQKiarakeB/l1QGUronujoYGDOsELDiCKgP7u6It0
         +2TCAtrPBY1VR4whLANmTko0Te8o32IgvMZIu+77jHeVRJviWIwTyrFgCzd03p/b/7iA
         YZVWGFNPjsK37iQ4fAorHBLdi6jqZZFK6caZCwuw1uqgLf87rSJIjlwTtTf94bPTyhF8
         fjQjzF6CpY51PR1Sui8yCR2vab1jG8skbJMSRwxGypCeuI1qfcU7bLf6D9GZ9gACHJK7
         xbORG4C7dpgbPRdkxSL06x7qmkXrWK9SwvDHF9P+dPK4pJWnhoywA4QdhEzZ4DREHDnP
         zUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vTvDNWdEA4hZKsryJgBlw03/sVfatrcozcTg5ftj3hs=;
        b=Qytc0Wcn6R7844bayKAmZPKB9P0HGDL5PYYR7G8jq2ufw1b15httGvUZcbqLK/PXYX
         baCMsnt44DrPWF1ixQXeYvFkSuSPmUO586TVNLkGhTwzDuWPZU0fw2yNxI9I6WDbyhqO
         /fPvK1ni5gOk+rjFcKUQxqeCkjxmM45fGxmn1CV/onTSio9evOMNWto9mImDLZaJ4eWE
         eI7rDC1FSafaUcPon1qUmkDLnf35iKTQy8YcwM1bZNFddAYBnczmf1mYRdsDmJzukH7O
         8MyYSNBjij+ejDTokFVAeToUph8C2ARCIwKfqstY2LY6yHzOC6/NobFY6xpOpCqx5669
         igUg==
X-Gm-Message-State: AOAM533Ce/GVtoe3Kav12AlEvGSCyKwSKH7+soTOvhFnCdjbUi2x54uN
        XYN1JmyU1PhSZst2dq8OyPE+XTr+d1A=
X-Google-Smtp-Source: ABdhPJwCUa0SQyqDMFKcbxWbh+KqAIfJuPCHJDu3CNzNGYKMzG3xFPOyPVlHpGdAUhZXulpVwkEQlw==
X-Received: by 2002:a65:6109:: with SMTP id z9mr27007222pgu.190.1607994844835;
        Mon, 14 Dec 2020 17:14:04 -0800 (PST)
Received: from [192.168.255.10] ([203.205.141.47])
        by smtp.gmail.com with ESMTPSA id h16sm21901064pgd.62.2020.12.14.17.14.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Dec 2020 17:14:03 -0800 (PST)
From:   brookxu <brookxu.cn@gmail.com>
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
Message-ID: <1704f274-fe41-4215-8e6e-ff09d080cdd5@gmail.com>
Date:   Tue, 15 Dec 2020 09:14:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201209193935.GO52960@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi, Ted, how do you think of this, should we need to go ahead? Thanks.

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

So, the existing implementation just adds the backup sb and gdt
in sparse_group to system_zone. Due to this mistake, the behavior
of the system in the flex_bg scenario happens to be correct?

I tested it in three scenarios: only meta_bg, only flex_bg,
both flex_bg and meta_bg were enabled. The test results are as
follows:

Meta_bg only
 unpacthed kernel:
 ext4_setup_system_zone time 866ms count 1309087(number of nodes inside rbtree)
 
 pacthed kernel:
 ext4_setup_system_zone time 841ms count 1309087(number of nodes inside rbtree)

Since the backup gdt of meta_bg and BB are connected, they can
be merged, so no additional nodes are added.

Flex_bg only
 unpacthed kernel:
 ext4_setup_system_zone time 529ms count 41016(number of nodes inside rbtree)

 pacthed kernel:
 ext4_setup_system_zone time 553ms count 41016(number of nodes inside rbtree)

The system behavior has not changed. All sparse_group backup sb
and gdt are still added, so no additional nodes are added.

Meta_bg & Flex_bg only
 unpacthed kernel:
 ext4_setup_system_zone time 535ms count 41016(number of nodes inside rbtree)
 
 pacthed kernel:
 ext4_setup_system_zone time 571ms count 61508(number of nodes inside rbtree)

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
