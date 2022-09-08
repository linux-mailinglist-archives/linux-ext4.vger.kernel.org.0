Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5545B182C
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Sep 2022 11:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiIHJNj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Sep 2022 05:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiIHJNi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Sep 2022 05:13:38 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE100FF514
        for <linux-ext4@vger.kernel.org>; Thu,  8 Sep 2022 02:13:37 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id c198so7420765pfc.13
        for <linux-ext4@vger.kernel.org>; Thu, 08 Sep 2022 02:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=hnBPIcuBbiTJ6T38MqUXTmFHiX7vavyzIU2NCuu61RU=;
        b=IM2MUcyeIPudii/nEByJXHG7P/xBWWz321xVy4k7h+Gl7P6pQvjSSMP2dn2RDwgrCq
         kASfhgYNhsGX/WKfATRkEBOcDBWPBcewQYccZswx0dm2mkCOXn8MVUyK8EFgdiDV8Jql
         xhJCGiAVesroQhBQyUzPeKHs7iiy5Dugti7MHr27K6EwIWtN+GPq6hVqkcAI65vrLYki
         69xOWkHEgQY2agsn/WCNQm69/rruS48zBJQtcQv39DNAF4YkMeCuvAJZJVA6SRiDVkLz
         HNWi1Wxpavu77E0e/8LLnophVd1SAB9trjDrur4ap+eakZd9HaXuQAGVw6h78zfQF3jS
         93wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=hnBPIcuBbiTJ6T38MqUXTmFHiX7vavyzIU2NCuu61RU=;
        b=rsFRO1Hw7UWz3YFqQcfW8qHz5bWmuKZq9hylIgVQ7birbB2jEsj6GSLtjjXsW/l9ij
         +svUchOUw1q63FJ90E9AlN+XvsWjmWXsyJnxyTCaHjXDZfiHRO8xUwSS0arUVRF4+7vn
         TSq7FFPAwey+WT4d5St8/UsB8IDtlKI9xxKVNfy86rfxbNdLewAEYWANUNOto77k4in5
         at9YDDufRMuaxft1ZlhHagNJmZ/KChXLFuvY4d7OgfNTnexYGewXhZSL6w9/XSy68d2Z
         XeHuao8+eUCM6sqVIx7qQId+CredzvY0JdToBQFMgBq8AID9KSAvb8O0hVz2jQEGTqUC
         ZJjQ==
X-Gm-Message-State: ACgBeo19Q7qsdiVEbPzZA1vb13kM9czm9K5CImrHOq+jkUTBXeFg0FGz
        0yIplsUOz+wt0Msr3QRgtdg=
X-Google-Smtp-Source: AA6agR4pj/WlN+8MJ5jCU36iu+RlA0gwT/KadYHOY3CTGd8by6O+RONBu8hoUGWSY8V4CWpN7w9NoA==
X-Received: by 2002:a63:8a4a:0:b0:434:c99c:6fd4 with SMTP id y71-20020a638a4a000000b00434c99c6fd4mr6862822pgd.24.1662628417331;
        Thu, 08 Sep 2022 02:13:37 -0700 (PDT)
Received: from localhost ([2406:7400:63:83c4:f166:555c:90a1:a48d])
        by smtp.gmail.com with ESMTPSA id ay6-20020a17090b030600b00200b12f2bf3sm1196833pjb.51.2022.09.08.02.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 02:13:36 -0700 (PDT)
Date:   Thu, 8 Sep 2022 14:43:32 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Alexey Lyashkov <alexey.lyashkov@gmail.com>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger@dilger.ca>,
        Artem Blagodarenko <artem.blagodarenko@gmail.com>,
        Andrew Perepechko <anserper@ya.ru>
Subject: Re: [PATCH] jbd2: wake up journal waiters in FIFO order, not  LIFO
Message-ID: <20220908091332.lowhekyxcs23kgtu@riteshh-domain>
References: <20220907165959.1137482-1-alexey.lyashkov@gmail.com>
 <20220908054611.vjcb27wmq4dggqmv@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908054611.vjcb27wmq4dggqmv@riteshh-domain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/09/08 11:16AM, Ritesh Harjani (IBM) wrote:
> On 22/09/07 07:59PM, Alexey Lyashkov wrote:
> > From: Andrew Perepechko <anserper@ya.ru>
> > 
> > LIFO wakeup order is unfair and sometimes leads to a journal
> > user not being able to get a journal handle for hundreds of
> > transactions in a row.
> > 
> > FIFO wakeup can make things more fair.
> 
> prepare_to_wait() will always add the task to the head of the list.
> While prepare_to_wait_exclusive() will add the task to the tail since all of the
> exclusive tasks are added to the tail.
> wake_up() function will wake up all non-exclusive and single exclusive task 
> v/s
> wake_up_all() function will wake up all tasks irrespective.
> 
> So your change does makes the ordering to FIFO, in which the task which came in 
> first will be woken up first. 

With all other details which got discussed in other threads. 
This looks like the right thing to do.

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
