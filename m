Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCD66C5270
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Mar 2023 18:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjCVR1W (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 22 Mar 2023 13:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjCVR1V (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 22 Mar 2023 13:27:21 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E384AFEC;
        Wed, 22 Mar 2023 10:27:20 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id s20so12542595ljp.1;
        Wed, 22 Mar 2023 10:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679506038; x=1682098038;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZJP3mA1N4qF5Kw86SxStXRq+7tB5BmUkuhCWnMdCRHQ=;
        b=VwHNSNQJiMpcoSFj+q/06EUjF1UVKz8k4D3lt4JqIwXCM8BCePwBR3MVvk7TKc8Gmj
         BJcD9LytKDciE94i9R4EgLuxO6wbtaNM7yAU5oSFlyccFfWztxMSGTYSS0iSAGZQOhWT
         Myl5rmPDS5lAJU71/GCJXwQHjqoZmE+LxQI7q6fAKVxPClHOI5Wd5tpxfZjV20Jvr4lB
         s+GIXZ2BX8thcFbdL6BBU4MV8J6cxeXUYNYUIbBqQJehzaioq33rrBG7GmfbB1BKrWj6
         HdaV1epFGsHjtCdhPSkMuHaCOROQUnyaUGTidWiEgh4KcguiNhinuyYGmprrTS1WlvUf
         9aqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679506038; x=1682098038;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJP3mA1N4qF5Kw86SxStXRq+7tB5BmUkuhCWnMdCRHQ=;
        b=izp7+Jnh3SXktAo25xsizEU6XQ7XotSIXqZwoqpTQeLda7SLuvCp3f21il0hAJ0Mui
         yynp5Jr219DodbbZU0yRFiWzTR2143SQaETIZrhQWjkQopzc3EO4bl+JLQ1BtylkMegX
         NKZEMmNsq8Fsys+SvQJnSIe9Mbcg4iVWD2t0XqxXhph/PCpZmtOJRzVD/T61YwhhDc2l
         hjpUycTGp+eoBQXC1wBjg+ckWLucT2lWk1KgT/QToEZ0IrL2ZThyd1B+LNS5WyHtxcHw
         2/U9nO5nHySDTV6b+dyq6fIYEUOGLOkxRNF8h/Qxs7Yw3EfaTmlgQmi9/9KtQR/aUH59
         ha/w==
X-Gm-Message-State: AO0yUKVkwNvi8k29Uiq+qcxeb5Ya95yW+TDo8v6tM27Q/P5sc3RNu7Ru
        h4+fBnesQK3gZN18yG0Hzz5sUnBvza8=
X-Google-Smtp-Source: AK7set/2xDyaUZKtAHQquRnidpNmdEtc6L18U+06co46lYPcoVnhnmVKNEDVj0PcroyF7FBDHMsa+g==
X-Received: by 2002:a05:651c:545:b0:29b:9e76:6ca3 with SMTP id q5-20020a05651c054500b0029b9e766ca3mr2812781ljp.4.1679506038170;
        Wed, 22 Mar 2023 10:27:18 -0700 (PDT)
Received: from ?IPV6:2a00:1370:8182:2677:3d56:cefd:fe23:69dd? ([2a00:1370:8182:2677:3d56:cefd:fe23:69dd])
        by smtp.gmail.com with ESMTPSA id s26-20020a2e9c1a000000b00298dc945e9bsm2669910lji.125.2023.03.22.10.27.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 10:27:17 -0700 (PDT)
Message-ID: <6cde43c8-3300-9269-7a8a-8ff6e8b1e287@gmail.com>
Date:   Wed, 22 Mar 2023 20:27:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: A new special orphan inode 12 in ext4 only?
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Ext4 <linux-ext4@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <4034e634-59d3-e9a5-a1c5-1f275d8e2832@gmx.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <4034e634-59d3-e9a5-a1c5-1f275d8e2832@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22.03.2023 12:09, Qu Wenruo wrote:
> Hi,
> 
> Recently I observed newer mkfs.ext4 seems to create a new orphan inode
> 12, with some file extents.
> 
> Which seems to have no direct parent directory, thus tools like
> btrfs-convert would also follow the ext4 inodes by creating an orphan
> inode too.
> 
> On the other hand, if I go mkfs.ext3, the mysterious inode seems to be gone.
> 
> Is this inode 12 a known special inode?

This is orphan file. It is normal file; mke2fs creates first normal 
inode for lost+found (11) and if enabled creates orphan file next which 
gets next inode number (12). Inode number is recorded in superblock as 
s_orphan_file_num.

/*27c*/ __le16  s_encoding;             /* Filename charset encoding */
         __le16  s_encoding_flags;       /* Filename charset encoding 
flags */
         __le32  s_orphan_file_inum;     /* Inode for tracking orphan 
inodes */


> If so, how can we avoid such special inode?
> (s_special_ino is still 11, thus checking against that value doesn't
> seem to help).
> 
> 
> Some details of btrfs-convert:
> 
> It goes with ext2fs_open_inode_scan() to iterate all inodes of an ext4.
> 
> And if we hit an directory inode, we iterate the directory by using
> ext2fs_dir_iterate2() to insert the dir entries between parent and child
> inodes.
> 
> So if we hit an inode without any parent dir, an equivalent btrfs inode
> would still be created, but btrfs-check would complain about such orphan
> inode.
> 
> Thanks,
> Qu

