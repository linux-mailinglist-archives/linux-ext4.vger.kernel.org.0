Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD46B4001C9
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Sep 2021 17:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236367AbhICPM2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 3 Sep 2021 11:12:28 -0400
Received: from ms.lwn.net ([45.79.88.28]:46748 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229789AbhICPM1 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 3 Sep 2021 11:12:27 -0400
X-Greylist: delayed 61319 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 Sep 2021 11:12:27 EDT
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 4D2C5663B;
        Fri,  3 Sep 2021 15:11:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4D2C5663B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1630681887; bh=I7eHpaDCMcn+gV/Go7uz+qvINtjF5jC2bNVhtMJtDN0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=p6w3uIRTp7YZD/LBsZ1EruHgD6tJFHamUaUv8UelNcPQz32KefofopmreGzFM5xf5
         ZLJZgbQjMEoOgBt1iUux4MbXjEsOU/MjE+7bFZO28z5QIWVUtq96t4OHkjvum0SYGs
         ffXXBq6uVgnuk7PdlkWjbAcbxbhlRA6RpMjTAHf1Kek8Ck9FJFI0JaZz4UlVkzrKqj
         lrXSthYiEN6oi+z0on3n7gTwt8I0ssWaVNec6+vvght4/8+rHTyWmBZ8S6gJ3iivBN
         EDqOr01NNs0DMRGnifT7kQPWGPN9zxwvNt7VS1qJjVEQItvEQoCZTmTvMF/zn+zXAU
         0yJbSUDV5oNvQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     jack@suse.cz, linux-doc@vger.kernel.org,
        linux-ext4@vger.kernel.org, tytso@mit.edu,
        Akira Yokosawa <akiyks@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH 1/2] ext4: docs: switch away from list-table
In-Reply-To: <b1909f4c-9e07-abd7-89ee-c2e551f9dc5b@gmail.com>
References: <20210902220854.198850-2-corbet@lwn.net>
 <b1909f4c-9e07-abd7-89ee-c2e551f9dc5b@gmail.com>
Date:   Fri, 03 Sep 2021 09:11:26 -0600
Message-ID: <871r65zobl.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Akira Yokosawa <akiyks@gmail.com> writes:

[Adding Mauro]

> On Thu,  2 Sep 2021 16:08:53 -0600, Jonathan Corbet wrote:
>
>> Commit 3a6541e97c03 (Add documentation about the orphan file feature) added
>> a new document on orphan files, which is great.  But the use of
>> "list-table" results in documents that are absolutely unreadable in their
>> plain-text form.  Switch this file to the regular RST table format instead;
>> the rendered (HTML) output is identical.
>
> In the "list tables" section of doc-guide/sphinx.rst, the first paragraph
> starts with the sentence:
>
>     We recommend the use of list table formats.
>
> Yes, the disadvantage of list tables is mentioned later in the paragraph:
>
>     Compared to the ASCII-art they might not be as comfortable for readers
>     of the text files.
>
> , but I still see list-table is meant as the preferred format.

Interesting...that is not at all my memory of the discussions we had at
that time.  There was a lot of pushback against anything that makes the
RST files less readable - still is, if certain people join the
conversation.  Tables were one of the early flash points.  

Mauro, you added that text; do you remember things differently?  Do you
feel we should retain that recommendation?

Thanks,

jon
