Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63EE25A5A79
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Aug 2022 05:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiH3DxW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 29 Aug 2022 23:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiH3DxV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 29 Aug 2022 23:53:21 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293854BD1D
        for <linux-ext4@vger.kernel.org>; Mon, 29 Aug 2022 20:53:20 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-11ee4649dfcso7577599fac.1
        for <linux-ext4@vger.kernel.org>; Mon, 29 Aug 2022 20:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc;
        bh=kTnWqPCQ7JZ842fbaIQWezAeKboDsupaMXi3CH+q7qQ=;
        b=l4X62etHXSEjI9IYdrX6IxjCj4CMK9WxMMzharCxB/t9mHerRIbNBGBh7ynqum/uMA
         Iw34YtmeoAvsLE1B7hrXkwsNVqmUvbmfafz6LbSGr3dPgcNRR64MH9XjXtK0XxpGGceP
         NImvUGY+Mvd0m+t+G7RxaWaEsh7QZyhizsph7VCEaECeK+EZnFqoKS4LScFyfJvnPME4
         3yT4TPqpKVpWJ3qjGhzAemv4MAgIY9KD3MAJQYptOcak5HY5hY70VYpTvo3gfrWsyZZH
         EgG3jXkS87My6f7mKQ0F6EDs4ozhw+Ei1f8XW+UHasFNVE2UukCJ8L7WxGMdNZggrjPD
         zWEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc;
        bh=kTnWqPCQ7JZ842fbaIQWezAeKboDsupaMXi3CH+q7qQ=;
        b=qXDO9XF+BTCUs4yfldzosq36Di1t+CXC4kRMJ7MZrRUiAUmnC4zNwV/nJ1D+HBRoBf
         C1erSu2+qdPV4zWJiw/VG1f0RsuRuXPqqaCmFX8O8tw0MByGQrUoWhYlQ3Ykp58GNQdX
         iI923NvQKVRB6gUWvs/nyu3KpEyoZmWXA4LvZ5GSQ4osqOK+j9B3MzHYETbqADgsCRhb
         B64IKywUS0OatQFzfwaSj6PyCtC5mD9MyH4k3J0qE58GFEtqL0UcQG/yC0PgvV4DfPn6
         I6bud50bBQJ+GBLuQvGkPCs4eqBPJqAC2RI2BZhMLURbMjBZYPrGpiy6LcbHgjM/nlPy
         J+oQ==
X-Gm-Message-State: ACgBeo3hm/qFoga8csOo7X9VA6WMPtNWVXCb5fVWId1AOotG8NbIo8Vy
        5NvyOUHP9CmQhBtwp++qBJcLv+RtnbcgA6j5Gp8=
X-Google-Smtp-Source: AA6agR5y836guwWEtw4tr/PsdZTq0dDGExqg8iq9+dEz1vB2bsq+H5dgFeulh5I+q3ykeTQR5UMZbLbn7IRZZDHOXnA=
X-Received: by 2002:a05:6870:5702:b0:11e:dd17:d4b6 with SMTP id
 k2-20020a056870570200b0011edd17d4b6mr4644817oap.112.1661831599509; Mon, 29
 Aug 2022 20:53:19 -0700 (PDT)
MIME-Version: 1.0
Sender: military8welfare.dpt@gmail.com
Received: by 2002:a4a:e713:0:0:0:0:0 with HTTP; Mon, 29 Aug 2022 20:53:18
 -0700 (PDT)
From:   Al muharraq group <al.muharraqgrp@gmail.com>
Date:   Tue, 30 Aug 2022 04:53:18 +0100
X-Google-Sender-Auth: mGWLVclzidUgKLjaCQXes26pXeQ
Message-ID: <CAOKsmcf-wxGn-F85CSgrD4zBz29MMAU4-QbLD_wVKo4Xdz8FJg@mail.gmail.com>
Subject: Re: Al-Muharraq Project funding
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

-- 
Greetings from Al-Muharraq Group Ltd.

I have contacted you to consult you for a funding resolution for your business.

My Name is Saif Yusuf. Do you have projects that require funding? We
facilitate the funding needs of private project owners around the
world covering infrastructure, housing, real estate development, IT
parks, industrial parks, film studios, food parks, agricultural
projects, health & wellness, hospitality, education, electronics &
telecommunication, power & electricity and oil and gas sectors.

If you have any queries regarding funding please revert back to me and
find the solution to your financial needs.


Sincerely,


Saif Yusuf
Business Consultant

Al-MUHARRAQ Group.
#sblcproviders #bankguarantee #mortgageloans #unsecuredloan
#projectfinance #startuploan #tradefund
