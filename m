Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 465173E4D20
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Aug 2021 21:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbhHITfG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 Aug 2021 15:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233199AbhHITfF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 9 Aug 2021 15:35:05 -0400
Received: from mail.valdk.tel (mail.valdk.tel [IPv6:2a02:e00:ffe7:c::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4893C0613D3
        for <linux-ext4@vger.kernel.org>; Mon,  9 Aug 2021 12:34:44 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F088924E1EC;
        Mon,  9 Aug 2021 22:34:40 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valdikss.org.ru;
        s=msrv; t=1628537681;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=4WLxoTicCWmeHcsRgKKME7jDv5P9mRQnHt7gJAVEses=;
        b=2LDaHBTNOD/H3R36zm9yVheCa+QMp9NNKxf0f+aYJbCzALMBDlGpz1yEi3oK/LbM65e9KV
        2bnIt6J7fwuJUhAXvT/fl316pPtLCAw1bekWEw6GnTO9eFej9lyEQ45lfJqOK241/b9DKD
        eq5l8vlHsuRrXqRAk2fkXQr252kWpcbO0Io+Hm39X4ifM0laimmRUbFvYkxTQB6vk0oXJH
        YPHF4SGQrH9NL2jqy66Se8PoMKSgQnG9nXQvH4YrzFNq3WoArThblHuPPRMn0F3tD0nIlh
        XdMneCGsDzhqlf/WJ/9YbNLOyzEOyoX4bqKSQ01fgzYsisYMUSPsPB45/FFNMA==
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
References: <015c7506-7f33-3967-772a-1285b0f1052f@valdikss.org.ru>
 <YRCKG1V/OBuble40@mit.edu>
 <c984528b-03ce-f9e5-2cf2-4ae92e812367@valdikss.org.ru>
 <YRFzWGkBOHcugxGD@mit.edu>
From:   ValdikSS <iam@valdikss.org.ru>
Subject: Re: ext4lazyinit reads HDD data on mount since 5.13
Message-ID: <80f2ab1e-affb-5f31-e367-3f92b61d8ad9@valdikss.org.ru>
Date:   Mon, 9 Aug 2021 22:34:37 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.5.0) Gecko/20100101,
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <YRFzWGkBOHcugxGD@mit.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 09.08.2021 21:26, Theodore Ts'o wrote:
> 
> It's not been tested, but it should be safe in terms that it shouldn't
> lead to any file system corruption or data loss.  However, it may
> result in non-optional block placement that might cause more file or
> free-space fragmentation that might otherwise be the case.  (This was
> true even before the latest optimizations, but it's more the case with
> the new optimizations.)
> 
> Can you say something about why you want to disable to block
> allocation prefetch?  How is it causing problems for you?

My old HDDs are now screeching their heads for 20 seconds after mount. 
That's secondary disks (internal and external drives) which are not 
fragmented, mostly idle and have plenty of free space. It's a bit 
annoying to hear the sounds and see strange load right after mounting, 
so I'd prefer old behavior.
Just aesthetics, not a technical issue per se.
