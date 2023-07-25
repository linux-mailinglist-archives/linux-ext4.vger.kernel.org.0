Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC09762031
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Jul 2023 19:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbjGYRav (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 25 Jul 2023 13:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbjGYRau (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 25 Jul 2023 13:30:50 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA7EE3;
        Tue, 25 Jul 2023 10:30:48 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-686b9920362so308510b3a.1;
        Tue, 25 Jul 2023 10:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690306248; x=1690911048;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+nloVmxs0M2sNFQEN8k6CsE0eaoEHVBJeSVDFD7qrqk=;
        b=CAIqniHn9UDooLjnBH6VhtQwveTvWHMPlB9nZvudVvT4odqN9kUUzJ5r5+9b0aoRAB
         zGfNZOYoddYqCkewbBVYOAs7iIzh/jt2z5TglpPd+JJdnc+a6kKgotxpLhdyDEgApn20
         HDyFH4Szuwlgmqukv5VTyyE2I26p4FXEKZwyQWN/yNqiZVcC0o3EC8Vw2xxXeVY97k1z
         oYxsnl9M0cKxec8r58q8BT3/wqisllGT+V5OxZJkWx7fOG2ZTunFQgzrkUMW0u2bJ6Ia
         HBwNJc8UPjimXEW60FRJiDskQ+OZxnqe2ZM5rLo/MR4pWOV4SymEZBvNz0dJAtKLQ6gg
         bwvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690306248; x=1690911048;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+nloVmxs0M2sNFQEN8k6CsE0eaoEHVBJeSVDFD7qrqk=;
        b=INbuuV/BD+KblR15czUgztrIVNgMQlkoCPFJ87LhLS45qc9cd5zsOesyIhV9NlpIZy
         fFik7o+emxUKmjuzOkMKImWeKjqKKVRXVRDbGXXJo43sjXf8RMCkRwtrnPZHo3px+Be6
         ml5TgJLKAPTn44cXMj6RSu7rufyEFs+HyJ4L3gPoR0OAjCKLPTzjAjK2GJ4M8G7rGkq+
         scUujNKn8na2XihlW1niIccmWQtN1idFH+77qFiXl4CR6qPfX+wA4cFLP5uidtdFsdY3
         ErnxrAvA5V5JCQ16wfRWr2g5Pa8qrWSo0LRmHoxslHhSi9dHHY100xSiwrot+Yl7FJ4C
         u87Q==
X-Gm-Message-State: ABy/qLbOEe5SB59qtF58J9BflMxOiyXAg/IOU6e9sAd/k4ahiETvmo10
        Hfmr7VJ3PrH3ytJeakbx1aU=
X-Google-Smtp-Source: APBJJlGNRff1oOkzSMTyiRXU+7jw101au4w5hAp1Su0x5WotIcenkyy9c+E9Clz8Y1rP9Kq81aYMHA==
X-Received: by 2002:a05:6a20:12d3:b0:12f:8755:96ba with SMTP id v19-20020a056a2012d300b0012f875596bamr12326131pzg.28.1690306248031;
        Tue, 25 Jul 2023 10:30:48 -0700 (PDT)
Received: from dw-tp ([49.207.232.207])
        by smtp.gmail.com with ESMTPSA id f9-20020aa782c9000000b00679d3fb2f92sm9854139pfn.154.2023.07.25.10.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 10:30:47 -0700 (PDT)
Date:   Tue, 25 Jul 2023 23:00:43 +0530
Message-Id: <87v8e7c30c.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Baokun Li <libaokun1@huawei.com>, linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        ojaswin@linux.ibm.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com,
        libaokun1@huawei.com
Subject: Re: [PATCH v2 3/3] ext4: avoid overlapping preallocations due to overflow
In-Reply-To: <20230724121059.11834-4-libaokun1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Baokun Li <libaokun1@huawei.com> writes:

> Let's say we want to allocate 2 blocks starting from 4294966386, after
> predicting the file size, start is aligned to 4294965248, len is changed
> to 2048, then end = start + size = 0x100000000. Since end is of
> type ext4_lblk_t, i.e. uint, end is truncated to 0.
>
> This causes (pa->pa_lstart >= end) to always hold when checking if the
> current extent to be allocated crosses already preallocated blocks, so the
> resulting ac_g_ex may cross already preallocated blocks. Hence we convert
> the end type to loff_t and use pa_logical_end() to avoid overflow.
>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>  fs/ext4/mballoc.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)

Looks good to me. Feel free to add:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

-ritesh
