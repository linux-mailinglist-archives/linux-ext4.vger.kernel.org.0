Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95AF063AB1A
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Nov 2022 15:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiK1OgA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 28 Nov 2022 09:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiK1OgA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 28 Nov 2022 09:36:00 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EA31DA7D;
        Mon, 28 Nov 2022 06:35:59 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669646156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lf6RK+eqIHb1J2ty81VlA4y2Vc4xkcP9Z5vqkCNM+LU=;
        b=gFwnuOCpQZBSuLNYLW1cOmKa8cXKKJkubkXZf7S2CgjAm8HaykgXt52jEahhsttbEqC+d6
        scSto+IoEBs9LTmxCM57PAaW5/G2uTOedvfJ2PRwgx6LTOg82K8KVkgViGbdjArCeQzdLh
        g2dm7FJtiQwq1sfbfQYPrCHwlq8fqDib03amWRo+Fr73xCqieWconC1Wh2Vu+fn60GWZvC
        VMPGX7Y1BX8LHLaWFobjUPEqPd+xWnPnbAvG/orZH23WZaoKBhBd9Nea0A7zORRtH3P9/B
        Obn3eFlJfmyK6YAnH1dzMxqUzFGLBc3oax8Sql5fSbmcMvpOyrkHTDu5MlDcEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669646156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lf6RK+eqIHb1J2ty81VlA4y2Vc4xkcP9Z5vqkCNM+LU=;
        b=rYaUqJdcCD1QSqwfyP8fyBJ9BJPNsbJe405w0GU+QqwQq6JxJEJYNqT20GdihHKgGwsSXG
        eq12MHRJfhYt9eCA==
To:     Sanan Hasanov <sanan.hasanov@Knights.ucf.edu>,
        "john.stultz@linaro.org" <john.stultz@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
        Paul Gazzillo <Paul.Gazzillo@ucf.edu>,
        linux-ext4@vger.kernel.org, Theodore Tso <tytso@google.com>
Subject: Re: Syzkaller found a bug: KASAN: slab-out-of-bounds Write in
 enqueue_timer
In-Reply-To: <BN6PR07MB3185B8E16A4AA1EE384B2375AB0C9@BN6PR07MB3185.namprd07.prod.outlook.com>
References: <BN6PR07MB3185B8E16A4AA1EE384B2375AB0C9@BN6PR07MB3185.namprd07.prod.outlook.com>
Date:   Mon, 28 Nov 2022 15:35:56 +0100
Message-ID: <875yezw3hv.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Nov 23 2022 at 18:48, Sanan Hasanov wrote:

> Good day, dear maintainers,
>
> We found a bug using a modified kernel configuration file used by syzbot.
>
> We enhanced the coverage of the configuration file using our tool, klocalizer.
>
> Kernel branch: linux-next 5.11.0+ (HEAD detached at a68aa48d4ed8)

This is a random linux-next commit from Feb 26 2021.

How is this useful and relevant?

Thanks,

        tglx
