Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0245B17F1
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Sep 2022 11:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbiIHJEU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Sep 2022 05:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiIHJET (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Sep 2022 05:04:19 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E578DA1D63
        for <linux-ext4@vger.kernel.org>; Thu,  8 Sep 2022 02:04:18 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id b21so4280933plz.7
        for <linux-ext4@vger.kernel.org>; Thu, 08 Sep 2022 02:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=5PBMC8z/6Tz3mXIGjPF05+XKUfMAu0zi8vI88NzwGVY=;
        b=FpeKxVHIpb2osRLLDbrd3jZxLa0/arHtW2GjLv+3pX6L60J+UUPs+t77n44QgSuAGf
         mmB2on/HbhFfsn29UGLUJQyCapRleojDShFcBrqjRTtg9hHDOxTzhkY4QMpQfp7cteEj
         h2Pi/dg4I+CwL0W7ZBIYYXONBjW+P++6+1ptWxjxUsInZus07mC6aHlMb38nAh7HbbwX
         7KDMNNwmV+OZaUBALJgFfGmmoCRVhRYjIyRHUdWiW5bBGv8+TqJN7mDQpR866KZeklfh
         FxLcmZgyauSjH1b5cK5BHr1sbjcjyewYVJyv3tkNsXyxgLpSLOLa7/q+C75HPmCZu07q
         kC1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=5PBMC8z/6Tz3mXIGjPF05+XKUfMAu0zi8vI88NzwGVY=;
        b=NrJN8iJz7yoK/iBXZxtMfPSe8yXI1eoci3BKTBKkfMagVl1nsGz/fp5IuhmVPtY0wP
         WQj9RXJA+l74k64n7Vre48vNrcfdqo9WBTUoBvFWvXthoInJJaQmIwRrNV0t+d8xNZYJ
         7KO2eaP/nEd53QS1wrBQy7rKNz3ZmFOqR1+7ch2QzfnHq9I+M+auWsXl8RF20XCW1TiQ
         9mihbWmJDsib0aPeAFUthnxOFqXiP4HxfIvgNEmGr01UyrZFeRHD3Drz3lD+RVpzniP9
         0ipXpegbSzmn/8FeL0WSHXDlqBGs8+wQxqXS1Q3wOfVrTYNOH3bzAXMbRtlqqgg7JooW
         +oCg==
X-Gm-Message-State: ACgBeo1dUn9Oxc0h40UdI6zpszMdDn/YJ3BrFijT0+qSVkifEafyHj3F
        WH4mF5biHaBCY3cDBg22q/g=
X-Google-Smtp-Source: AA6agR7g9aXq/WTcVdPXLXYY0vQ7UhrP3tdetax9pj9H858hMLYSLFk5kuzKGPSkbbYEO4W9st7Emw==
X-Received: by 2002:a17:902:f549:b0:176:c033:db03 with SMTP id h9-20020a170902f54900b00176c033db03mr7955682plf.109.1662627858475;
        Thu, 08 Sep 2022 02:04:18 -0700 (PDT)
Received: from localhost ([2406:7400:63:83c4:f166:555c:90a1:a48d])
        by smtp.gmail.com with ESMTPSA id y9-20020aa79e09000000b0053e84617fe7sm3022641pfq.106.2022.09.08.02.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 02:04:18 -0700 (PDT)
Date:   Thu, 8 Sep 2022 14:34:13 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        lczerner@redhat.com, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 12/13] ext4: factor out ext4_load_and_init_journal()
Message-ID: <20220908090413.o2hxjjfrjbadtbqo@riteshh-domain>
References: <20220903030156.770313-1-yanaijie@huawei.com>
 <20220903030156.770313-13-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220903030156.770313-13-yanaijie@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/09/03 11:01AM, Jason Yan wrote:
> This patch group the journal load and initialize code together and
> factor out ext4_load_and_init_journal(). This patch also removes the
> lable 'no_journal' which is not needed after refactor.
 
Clever cleanup.


> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/super.c | 157 +++++++++++++++++++++++++++---------------------
>  1 file changed, 88 insertions(+), 69 deletions(-)

Looks good.
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
