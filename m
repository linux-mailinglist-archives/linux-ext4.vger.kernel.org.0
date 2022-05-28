Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3255F536D6A
	for <lists+linux-ext4@lfdr.de>; Sat, 28 May 2022 17:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237062AbiE1PJM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 28 May 2022 11:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237036AbiE1PJM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 28 May 2022 11:09:12 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEAC13D0E;
        Sat, 28 May 2022 08:09:11 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id x143so6763937pfc.11;
        Sat, 28 May 2022 08:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KxOUzRPdHfmqhVFZWZtKpTW5G7+zALfF9V0WgVk+JWM=;
        b=A2PJvudbmyp7OErcJVR1n4AD9W+AKFQaQSXY/I8VBTzc7HFZb8L9fen+6C1UkloHfG
         Lxqo6sfKgcGDjh2nv9vdGdxXdAX9sgTNv7vckI2gr+MB6aQ+yfAlLpHm5hqi2DJff/c+
         lg8IN/XA9fNB8q6SFzJGUwLnvgG5Tuj3CCAmz1LXLJcC3t9m9h4TKVE6FlaeWHYDjSfD
         i5RqCyMtjs2BHYZq+SIPWevlI+is+kqoAbTjwTtKRUPD3HhyienOcC33XpqUaQSerfeW
         etMo2zF0hGEOICZTbE+TnaXcjpWQ4ZLBkaq5KkKkedBihsw/JYx5bUmdlxCTko9euzEu
         eT5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KxOUzRPdHfmqhVFZWZtKpTW5G7+zALfF9V0WgVk+JWM=;
        b=CkSe8rOUlaObwD9WfgL+r8fdWeAHsGPgweHnDh6IxAjIFA1E/07mjJAMq/gw785Nmj
         2VHnfK7ouDub58OnZJf/s6VZu5NXCVenjKBZ8hW4/XUv1r/+kKl7yP8wrgzWYL8OlvtZ
         Vnm9ayt7ogksGT0nHjWJjwMSnAUfkHcjV0P1OsbIvpWlKJKq4JDHdgts2Eckcfuz/IMq
         wY9xDeleTILVQi0/5VxbqVUOHeFq2Tp3WuVUI6yrtc21JIf3fxiWHDR/apZ46o9mKEDQ
         plP3QmHf0xP7wcBP+aksTrTJ7hbX7m2lW+mneXSpLksd+DS6YUkb3eDCFVdjyE0kdYsB
         YC2Q==
X-Gm-Message-State: AOAM533UhJAWSzSRJGictOrSzHStpY4Svmx46WmAm/Fn3sGuTOdhrBFb
        jmFYbuDejjp0C9JGZXFO1P8pKN64TLw=
X-Google-Smtp-Source: ABdhPJw/9bS32/jhzBqjG7sXydXQinxaEwrWPDrkXOos+fD6/CM7KWsNUj7P6aYEcriBnSVF9kUVcA==
X-Received: by 2002:a65:6bce:0:b0:3f2:5f88:6f7d with SMTP id e14-20020a656bce000000b003f25f886f7dmr41983552pgw.253.1653750550915;
        Sat, 28 May 2022 08:09:10 -0700 (PDT)
Received: from localhost ([2406:7400:63:4576:a782:286b:de51:79ce])
        by smtp.gmail.com with ESMTPSA id z22-20020aa78896000000b005182e39038csm5772642pfe.38.2022.05.28.08.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 May 2022 08:09:10 -0700 (PDT)
Date:   Sat, 28 May 2022 20:39:06 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, lczerner@redhat.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yebin10@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v3 3/3] ext4: support flex_bg in ext4_mb_normalize_request
Message-ID: <20220528150906.om746qfxoxu7svzx@riteshh-domain>
References: <20220528110017.354175-1-libaokun1@huawei.com>
 <20220528110017.354175-4-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220528110017.354175-4-libaokun1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/05/28 07:00PM, Baokun Li wrote:
> In ext4_mb_normalize_request, the size of the allocation request is
> limited to no more than EXT4_BLOCKS_PER_GROUP. Ritesh mentions that this
> does not take into account the case of flex_bg groups. So we should add
> support for flex_bg to make the physical blocks of large files contiguous.

My only concern here was that what if we are at the flex group end boundary and
decide to take the size as of flex group size. How are we detecting that case.

But, I haven't yet looked at this patch of yours (as I am on travel for next few days),
but if this requires further discussion, we can work on this seperately and let
the other two patches go in as those are part of the bug fixes which you
identified (just my thoughts).

-ritesh
