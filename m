Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09FC0241C6F
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Aug 2020 16:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbgHKObw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 11 Aug 2020 10:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728516AbgHKObv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 11 Aug 2020 10:31:51 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E72C06174A
        for <linux-ext4@vger.kernel.org>; Tue, 11 Aug 2020 07:31:51 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ep8so1965396pjb.3
        for <linux-ext4@vger.kernel.org>; Tue, 11 Aug 2020 07:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r51ccutYVlFvv3X6Pg3FxNNeKuDnlu3S7azBa2+2k5w=;
        b=Kp1pu1SDNm0BNylNt4JINTScI+kwLHJxmm8B6OUWR2PDnK6V8MYEx/YDkzhIsBmxqC
         S9wuvYuXhffdKqsVEckE427oLfGgBS25OuN4+s0OGqZbJ7vZnCI7pMljVCiuf3y5Z/PN
         LPDV6KUxbFYVyJbNdZkFOCo1tEFCDpzdutjwclVvaD4I1Mmsy3QAa9FmkNlwQ0F+SIkn
         mirhXi/FiGEWDPo/ykYzDRgdID1FiTJRwWGtRLaWEHEgavUaPN9W5FhfDZPnw73D4Y6Y
         p7DyirZDdX7shpnzRaAWRdq3IzjAtiKOKCfPRE8wIATlVOD+wHpmOMe1Z/364sJXCXCZ
         Ry+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r51ccutYVlFvv3X6Pg3FxNNeKuDnlu3S7azBa2+2k5w=;
        b=Ymbg0oTJAoInuIyziGXp8KMgQzbrj6bekYKObKBKidwjRu40UyaKXzosHGbaS2CIUy
         TQJZ5gmlbOX11ss/yDKDlLKrl4IVZpBPaGFZ3H22gAl97n6uv1215jX7mtO7J7l4Z/qw
         iObKei9WVPx1OsC40DMdtrTDQuU/muWfkRO+s/FZSXsKcfYmTYnQPnGkZQXJTW/sZdeu
         8x7LOPWHZUWxDUdXx0C/YKXRrRTBQ92OdysXQGXVIGhAlg8DD8MCJpQdvMA7zwX3k4YN
         eaRph/qAXeRd/BwqYIMQpTGP9QEaDj5Y1TLjQsU6U0OsI4ajH5tsfR4FadPvt5GEDA4X
         82pw==
X-Gm-Message-State: AOAM531L7uMJLcUFzB3u9dwnzkq8pyJecldAPXz2UX3hXVtW8OY5qL4p
        8If035DYDxNTvZDOgC8BbGaYsA==
X-Google-Smtp-Source: ABdhPJxSKd/YCS1pOSqvXcMNR74J/k27E2Jd0I5nhrwX6W/3qRgr1pFsXx6t+AxiXggh5mmsDAxSNw==
X-Received: by 2002:a17:90a:fd81:: with SMTP id cx1mr1397254pjb.90.1597156311351;
        Tue, 11 Aug 2020 07:31:51 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id m29sm21189235pgc.55.2020.08.11.07.31.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 07:31:50 -0700 (PDT)
Subject: Re: [PATCH] ext4: flag as supporting buffered async reads
From:   Jens Axboe <axboe@kernel.dk>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <fb90cc2d-b12c-738f-21a4-dd7a8ae0556a@kernel.dk>
Message-ID: <3ca300d1-040b-fa1e-5cba-944bc9a8d158@kernel.dk>
Date:   Tue, 11 Aug 2020 08:31:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <fb90cc2d-b12c-738f-21a4-dd7a8ae0556a@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 8/3/20 5:02 PM, Jens Axboe wrote:
> ext4 uses generic_file_read_iter(), which already supports this.

Ping...


-- 
Jens Axboe

