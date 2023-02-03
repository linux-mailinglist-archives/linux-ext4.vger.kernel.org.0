Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3B968A12A
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Feb 2023 19:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbjBCSHW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 3 Feb 2023 13:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjBCSHW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 3 Feb 2023 13:07:22 -0500
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1FD1F4AB;
        Fri,  3 Feb 2023 10:07:21 -0800 (PST)
Received: by mail-pj1-f42.google.com with SMTP id cl23-20020a17090af69700b0022c745bfdc3so5663334pjb.3;
        Fri, 03 Feb 2023 10:07:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nj/kqx8wU5hGioR+ILT8KGaRzW4W5cV2FumlVSJq/aU=;
        b=b16VDLnS88B+AKkNaCmIzMBJ6rZSDaemT0Mp8iBEW8p8I/Flqb2t0tkchWtT3pBG3H
         8ZEYT6G3TpXcCk3W2NGhM4aQlXP0FPkplKyadBxtTSOedTZxPOM+DjSWVOrh3tYTQkfG
         YGkqCsKRZ4nhbzgZqrP/D6I0/aoCyCSyLc94TY9b142vgEmyK4XxWC+bVN0TC31s7YK8
         J9M81Q9BZ/eyuUB34IgzeW6+e+nXM9HcE1hBhvk7P9TzwU6BE28j333VYBsApbfT4TXv
         uxGf1kU7vLomTZ+ciatD6/VRQf2b0O1z1koI5JL6I3F4mLWAnTX9ivFvojLXuOFJEDGp
         4wqg==
X-Gm-Message-State: AO0yUKV/W83sewXx+8c66BRjZiGOEMhDhKdiDg+Clnm0kPcAuLk/m3To
        5tLSlbDU+eOI1HoHTG/eMHdsTZO5TFrvGw==
X-Google-Smtp-Source: AK7set+iP2N3huMFRj7+hUS2vWCM1sydq3uE8KyrXFnykY+b+RATpJjZO+xn3p0DMWixpVNE4lqEOQ==
X-Received: by 2002:a17:902:e844:b0:196:15a6:7332 with SMTP id t4-20020a170902e84400b0019615a67332mr12234662plg.31.1675447640827;
        Fri, 03 Feb 2023 10:07:20 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:b752:5d03:ec5e:7be5? ([2620:15c:211:201:b752:5d03:ec5e:7be5])
        by smtp.gmail.com with ESMTPSA id y9-20020a170902ed4900b0019655211783sm1867292plb.306.2023.02.03.10.07.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 10:07:19 -0800 (PST)
Message-ID: <8e13233a-2eb6-6d92-e94f-b94db8b518ed@acm.org>
Date:   Fri, 3 Feb 2023 10:07:17 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [syzbot] [ext4?] INFO: task hung in ext4_evict_ea_inode
Content-Language: en-US
To:     syzbot <syzbot+38e6635a03c83c76297a@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, alim.akhtar@samsung.com,
        avri.altman@wdc.com, beanhuo@micron.com, hdanton@sina.com,
        jejb@linux.ibm.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu, wsa+renesas@sang-engineering.com
References: <00000000000039fb2d05f3c7d0ed@google.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <00000000000039fb2d05f3c7d0ed@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2/3/23 00:53, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit 82ede9c19839079e7953a47895729852a440080c
> Author: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Date:   Tue Jun 21 14:46:53 2022 +0000
> 
>      scsi: ufs: core: Fix typos in error messages

To the syzbot maintainers: I think this is a good example of a bisection 
result that is wrong. It is unlikely that fixing typos in kernel 
messages would affect whether or not the kernel hangs. Additionally, as 
far as I know, the systems used by syzbot (Google Compute Engine virtual 
machines) do trigger any code in the UFS driver.

Bart.

