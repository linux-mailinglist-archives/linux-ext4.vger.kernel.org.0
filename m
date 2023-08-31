Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A4B78F556
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Sep 2023 00:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbjHaWWQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 31 Aug 2023 18:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjHaWWQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 31 Aug 2023 18:22:16 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E68F9C
        for <linux-ext4@vger.kernel.org>; Thu, 31 Aug 2023 15:22:13 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-500b66f8b27so2554374e87.3
        for <linux-ext4@vger.kernel.org>; Thu, 31 Aug 2023 15:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693520531; x=1694125331; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R6PBikJYb7xQXhgePqx77WnTwF8snc03B9lP8paS8tQ=;
        b=QaHAjkyelskzK7Bhd3DooPVVfBxxPEXCeY3mNrWbMgEck1HgVrfU4IdkSf1dw+k5Qz
         3qVeNvnXxAV590zFIHkGHwrbDdva0pppiEoJlGAYl5cs707i7GJFK9I0dOMJw3xNs/S4
         pm916RIWuLLxLmOcq5WCxae02y03wnXDUVPHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693520531; x=1694125331;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R6PBikJYb7xQXhgePqx77WnTwF8snc03B9lP8paS8tQ=;
        b=iRaGGGFKOdLs31eisZI5/uPhaaaDQsiwsr74Jw0kM/VFYRZodswA6Dkuc1v96Fbsdf
         R0dWhojKpA8T/YNu6F5fGikjF6LZQ9Jd+pbwoV7rAmZn/7WjK7hE/j0+7hAxM1xr4qer
         gIRjv0utlGxTGsNDqlEIby9g4A51hBYK5Uv1c0ylYtTjPKDU+UjDXgQyc/8BjbtmiwGd
         I91tqQlEWyYHR2vtaAAIyIcMSsefC+9Bqx1ypoG0JgRtHpEz1N2ScdmVQEDIb9L/gS9I
         sXGjE9MdDDgnkj51gtvUgHw6dKkemkWMHotldaVYl+zymVqhfQBYFuPmMWJ8QishVrBp
         zJJA==
X-Gm-Message-State: AOJu0Yy5l1AWkVy0PJQQyI/PmGYy5ZgOOu1k6+XGjsnHFFhCxsadO9mH
        FU3aXsbAbk1Vwgpo6gpDzCZE6MefqPLLzl3oxBfZuG0w
X-Google-Smtp-Source: AGHT+IFVH6EBrWBQVz/mSDW3WlV0DFM+2jTjXrcfy+fj66WtGv6e4z7AcFNwkaSDH6Ak28AK0+I8Zg==
X-Received: by 2002:a05:6512:2210:b0:500:7e70:ddee with SMTP id h16-20020a056512221000b005007e70ddeemr451200lfu.8.1693520531277;
        Thu, 31 Aug 2023 15:22:11 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id l15-20020ac2554f000000b005009f7d9401sm434691lfk.64.2023.08.31.15.22.10
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 15:22:10 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-500913779f5so2552708e87.2
        for <linux-ext4@vger.kernel.org>; Thu, 31 Aug 2023 15:22:10 -0700 (PDT)
X-Received: by 2002:a05:6512:3c85:b0:500:be7e:e84d with SMTP id
 h5-20020a0565123c8500b00500be7ee84dmr450789lfv.61.1693520530153; Thu, 31 Aug
 2023 15:22:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230831150155.GA364946@mit.edu>
In-Reply-To: <20230831150155.GA364946@mit.edu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 31 Aug 2023 15:21:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgD-QfNUxqbvg5wLBnBCd4aBCR-Z7uuNSDHa+seNm4--Q@mail.gmail.com>
Message-ID: <CAHk-=wgD-QfNUxqbvg5wLBnBCd4aBCR-Z7uuNSDHa+seNm4--Q@mail.gmail.com>
Subject: Re: [GIT PULL] Ext4 updates for 6.6
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Linux Kernel Developers List <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, 31 Aug 2023 at 08:02, Theodore Ts'o <tytso@mit.edu> wrote:
>
>   * Miscenallenous syzbot and other bug fixes

.. and this is why we write that word as just "Misc". Because pretty
much everybody gets it wrong after the first four or five letters.

             Linus
