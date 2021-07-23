Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B75703D3C72
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Jul 2021 17:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235581AbhGWOuO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 23 Jul 2021 10:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235553AbhGWOtv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 23 Jul 2021 10:49:51 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E67C061796
        for <linux-ext4@vger.kernel.org>; Fri, 23 Jul 2021 08:30:16 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id f18so2676302lfu.10
        for <linux-ext4@vger.kernel.org>; Fri, 23 Jul 2021 08:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:disposition-notification-to:date
         :mime-version:content-language:content-transfer-encoding;
        bh=f1HXgkNudjR8TWcttz5Zgp5fCvdMS58yvnzoYpcs8FU=;
        b=aCSa91TgW+jvp0ThzbasLvoKINB9hfXwNcQiAn4ofPNcFX5NVCN54CH2Q0CZZ13C9I
         jr1ypi1QwOE8iAGRvQZeEntbekurjoqf52hfDXRhUroL0LHS99jJorMnXR3flP2iehb+
         YlMdzTRhgAvi3zMczIDoI9FhlUS4PI36yXj5UVHmVcTQ8AwWGyLticECTnA8DTytF4qZ
         XqLKraQfFK0utvENMnIfabkfg8uQ2wBQ+tZsQ3i5sfq1w94YNYWur+PzGoPwOmMw+gpl
         Mmnj8PAxi7yUjpyx19UxBJdpl7aLLpGM9sfRmfyKFqBOSQO4uXC7rMk17FiR4jOu+zPx
         E0sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id
         :disposition-notification-to:date:mime-version:content-language
         :content-transfer-encoding;
        bh=f1HXgkNudjR8TWcttz5Zgp5fCvdMS58yvnzoYpcs8FU=;
        b=Uv5V2KU2pENeeeS21r9BC7mQbrxDt3k+r4IpotB9zQ5Lc4lNURC0VPxr2exd4uIHn6
         aN0Wq1fbS5xExKABEHlkW7VkiOqwDRrnwXce7sos5oMD+/Hy0oLTzHUYnGqbE5h3fAtY
         jB1NQ2M4lte6EyztbHSe75vQIYjacdZ9pnec0+2nk7BCmHd8kc923rYAGD0icamFDz4g
         B9TCp3l9e4aTwlwxGKbhn1TLJzSZqpHyFXp0ZRP4UYC+BI9cjY75feLn1egYwdiH/kQt
         vG1qsrhegDSi1x633Hu3K861iSTvLXwhRNGdZgX/lc9kxHAjaKmbBVQdpKQGC7m7DXki
         CPcw==
X-Gm-Message-State: AOAM530c5ao0gwvG7HYyN1LryUHd1M0ev8HOXpRLPVNcA7x/A9P3wf6n
        h+wLzsH2oNXk2vahDsYSbmpoX+Lkhz7bqw==
X-Google-Smtp-Source: ABdhPJwAedOO7hply2aKHxM+McICBikFjBooZ9NCAu6wUPx48Z/XFFvlKXh6cBd+y+JTbSwrALUGJg==
X-Received: by 2002:ac2:5337:: with SMTP id f23mr3308762lfh.289.1627054215187;
        Fri, 23 Jul 2021 08:30:15 -0700 (PDT)
Received: from localhost (public-gprs549192.centertel.pl. [37.225.8.137])
        by smtp.gmail.com with ESMTPSA id j16sm1875595lfh.258.2021.07.23.08.30.14
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jul 2021 08:30:14 -0700 (PDT)
To:     linux-ext4@vger.kernel.org
From:   Mikhail Morfikov <mmorfikov@gmail.com>
Subject: Is it safe to use the bigalloc feature in the case of ext4
 filesystem?
Message-ID: <0dc45cbd-b3b0-97ab-66a9-f68331cb483e@gmail.com>
Date:   Fri, 23 Jul 2021 17:30:13 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In the man ext4(5) we can read the following:

    Warning: The bigalloc feature is still under development, 
    and may not be fully supported with your kernel or may 
    have various bugs. Please see the web page 
    http://ext4.wiki.kernel.org/index.php/Bigalloc for details. 
    May clash with delayed allocation (see nodelalloc mount 
    option).

According to the link above, the info is dated back to 2013, 
which is a little bit ancient.

What's the current status of the feature? Is it safe to use 
bigalloc on several TiB hard disks where only big files will be 
stored?
