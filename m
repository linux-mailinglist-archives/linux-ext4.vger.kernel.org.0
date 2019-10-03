Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92D02CB132
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Oct 2019 23:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733197AbfJCVeD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Oct 2019 17:34:03 -0400
Received: from edison.jonmasters.org ([173.255.233.168]:45010 "EHLO
        edison.jonmasters.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731694AbfJCVeD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Oct 2019 17:34:03 -0400
X-Greylist: delayed 1394 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Oct 2019 17:34:03 EDT
Received: from boston.jonmasters.org ([50.195.43.97] helo=tonnant.bos.jonmasters.org)
        by edison.jonmasters.org with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.71)
        (envelope-from <jcm@jonmasters.org>)
        id 1iG8N4-0002a7-GX; Thu, 03 Oct 2019 21:10:46 +0000
To:     "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jan Kara <jack@suse.cz>, zhangjs <zachary@baishancloud.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190910042107.GA1517@darwi-home-pc>
From:   Jon Masters <jcm@jonmasters.org>
Message-ID: <60fc1d03-314a-6b0a-2c8f-100394b05969@jonmasters.org>
Date:   Thu, 3 Oct 2019 17:10:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190910042107.GA1517@darwi-home-pc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 50.195.43.97
X-SA-Exim-Mail-From: jcm@jonmasters.org
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
        edison.jonmasters.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham version=3.3.1
Subject: Re: Linux 5.3-rc8
X-SA-Exim-Version: 4.2.1 (built Sun, 08 Nov 2009 07:31:22 +0000)
X-SA-Exim-Scanned: Yes (on edison.jonmasters.org)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 9/10/19 12:21 AM, Ahmed S. Darwish wrote:

> Can this even be considered a user-space breakage? I'm honestly not
> sure. On my modern RDRAND-capable x86, just running rng-tools rngd(8)
> early-on fixes the problem. I'm not sure about the status of older
> CPUs though.

Tangent: I asked aloud on Twitter last night if anyone had exploited
Rowhammer-like effects to generate entropy...and sure enough, the usual
suspects have: https://arxiv.org/pdf/1808.04286.pdf

While this requires low level access to a memory controller, it's
perhaps an example of something a platform designer could look at as a
source to introduce boot-time entropy for e.g. EFI_RNG_PROTOCOL even on
an existing platform without dedicated hardware for the purpose.

Just a thought.

Jon.
