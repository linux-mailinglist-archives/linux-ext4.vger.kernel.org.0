Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DADF84F371E
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Apr 2022 16:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349643AbiDELKE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 5 Apr 2022 07:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353399AbiDEKGG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 5 Apr 2022 06:06:06 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFAFBF94B
        for <linux-ext4@vger.kernel.org>; Tue,  5 Apr 2022 02:54:56 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id h23-20020a17090a051700b001c9c1dd3acbso2108338pjh.3
        for <linux-ext4@vger.kernel.org>; Tue, 05 Apr 2022 02:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0s741zjxNxdppgULWe9R0/zRKs1xe7Q7zVh156iDVKw=;
        b=eb/33kP+s5z5M25fWDG+bkLTISik/2kQBUDJnOqigEe4EjAg6xwfuwS28xjLqTWJCR
         /sYyWlpHk1l89WHAXBfguoudlza+9V66/hCYePvurC32dljLuSpfXzkxkwu2wxLmiqfl
         6usAIkC6jF3uBIU0Qk8OCRMEl2Zyr39aKUSsYop1gpJq+rR43JgED8+v/RXDECPqLmx1
         fWwgFs59CE60Q/QqMJzY0aoYvWZD6qCFNTs96ppiq9wGpgQUhecDsX+b34DYnv0QWb+P
         IYkt8cPhrQsCrwKoTAIAYNDy6t6z5k3WtEYjqS4EFg9zWd3KU3l/d5XLWv/DMUFqkZxY
         +aig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0s741zjxNxdppgULWe9R0/zRKs1xe7Q7zVh156iDVKw=;
        b=ZAQAt9HYaaSRIt2tUla5mJK6dmYYd/G21Kw8UTA7P1n6/6FbZSCirQEHH/2BrVc1tL
         ewLPF8nRYUIdg262wiG+url+6UVh+KNkC79tMR770mRlniupIGzKwXvocjhwr2kWs/bb
         v06THYbAxS+CiWg4TK0MDTLQjdjybJZprhfbpB2pq0GeCT7g39HelKWGzQpEw0nM8vh5
         1o3pHFdeigCm9iUiZDLjR6uzoMgZ6dUmQdw7NT688yZccKIrZwOaElq+5Q/91hjo6Ami
         PUqyALVR2mYhiXMGR0s27gJK0kJS1Iq5BVboUMsq2CvWe/cqKEAr2FGTFEu39thEWWTP
         /OgA==
X-Gm-Message-State: AOAM532nnyP08YSeuKXqRKZYHD97J5A2MgP63oK0oYoS4FM2c6ZCPZ5a
        KxIeK9jWm2cvTVY6G6D0hik=
X-Google-Smtp-Source: ABdhPJzofHOTHlAutQJ6vLXfzgN/g24DN24UY1l53vZB4H/dBMo4LPuLiSBVqMrKkniUEhg8tP0i5Q==
X-Received: by 2002:a17:90b:3ec8:b0:1c6:bf6a:19bc with SMTP id rm8-20020a17090b3ec800b001c6bf6a19bcmr3097126pjb.79.1649152496441;
        Tue, 05 Apr 2022 02:54:56 -0700 (PDT)
Received: from localhost ([2406:7400:63:792d:bde9:ddd5:53e9:ed83])
        by smtp.gmail.com with ESMTPSA id mi18-20020a17090b4b5200b001c9a9b60489sm1981575pjb.7.2022.04.05.02.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 02:54:56 -0700 (PDT)
Date:   Tue, 5 Apr 2022 15:24:51 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     anserper@ya.ru
Cc:     linux-ext4@vger.kernel.org,
        Andrew Perepechko <andrew.perepechko@hpe.com>
Subject: Re: [PATCH v3] ext4: truncate during setxattr leads to kernel panic
Message-ID: <20220405095451.kx43cdu2ureywgcq@riteshh-domain>
References: <20220402084023.1841375-1-anserper@ya.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220402084023.1841375-1-anserper@ya.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/04/02 11:40AM, anserper@ya.ru wrote:
> From: Andrew Perepechko <andrew.perepechko@hpe.com>
>
> When changing a large xattr value to a different large xattr value,
> the old xattr inode is freed. Truncate during the final iput causes
> current transaction restart. Eventually, parent inode bh is marked
> dirty and kernel panic happens when jbd2 figures out that this bh
> belongs to the committed transaction.
>
> A possible fix is to call this final iput in a separate thread.
> This way, setxattr transactions will never be split into two.
> Since the setxattr code adds xattr inodes with nlink=0 into the
> orphan list, old xattr inodes will be properly cleaned up in
> any case.

Ok, I think there is a lot happening in above description. I think part of the
problem I am unable to understand it easily is because I haven't spend much time
with xattr code. But I think below 2 requests will be good to have -

1. Do we have the call stack for this problem handy. I think it will be good to
mention it in the commit message itself. It is sometimes easy to look at the
call stack if someone else encounters a similar problem. That also gives more
idea about where the problem is occuring.

2. Do we have a easy reproducer for this problem? I think it will be a good
   addition to fstests given that this adds another context in calling iput on
   old_ea_inode.

>
> Signed-off-by: Andrew Perepechko <andrew.perepechko@hpe.com>
> HPE-bug-id: LUS-10534

^^^ I think above can be dropped. Any fixes tag instead?

-ritesh
